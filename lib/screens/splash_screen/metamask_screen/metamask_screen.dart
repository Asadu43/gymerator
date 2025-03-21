import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/metamask_cubit/metamask_cubit.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';
import 'package:gymmerator/models/api_response/GetRewardSignatureApiResponse.dart';
import 'package:gymmerator/models/api_response/VerifySignatureApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/main_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

import '../../../models/EthereumTransaction.dart';
import '../../../ui_component/app_button.dart';
import '../../../ui_component/show_snackbar.dart';
import '../../../utils/app_colors/app_colors.dart';

class MetaMaskScreen extends StatefulWidget {
  const MetaMaskScreen({super.key});

  @override
  State<MetaMaskScreen> createState() => _MetaMaskScreenState();
}

class _MetaMaskScreenState extends State<MetaMaskScreen>
    with SingleTickerProviderStateMixin {
  static Web3App? _walletConnect;
  static String? _url;
  static SessionData? _sessionData;
  String? account;
  String? signature;

  static const String kShortChainId = 'eip155';
  static const String kFullChainId = 'eip155:1';
  static const String launchError = 'Metamask wallet not installed';
  String contractAddress =
      "0x1A366d65C4f0Cc30A7c987E5Cf51Cd434e4B309d"; // Testnet address

  String get deepLinkUrl => 'metamask://wc?uri=$_url';
  late Web3Client web3client;
  late DeployedContract contract;
  late Client client;

  final rpcUrl = "https://ethereum-sepolia-rpc.publicnode.com";

  Future<void> _initWalletConnect() async {
    _walletConnect = await Web3App.createInstance(
      projectId: 'b8ff9c52a3433ab288836f7402d5d323',
      metadata: const PairingMetadata(
        name: 'Flutter WalletConnect',
        description: 'Flutter WalletConnect Dapp',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );
  }

  Future<String?> createSessionAndSignMessage(int nonce) async {
    final bool isInstalled = await metamaskIsInstalled();
    if (!isInstalled) {
      await LaunchApp.openApp(
        iosUrlScheme: 'metamask://',
        androidPackageName: 'io.metamask',
      );
      return null;
    }

    if (_walletConnect == null) {
      await _initWalletConnect();
    }

    final ConnectResponse connectResponse = await _walletConnect!.connect(
      requiredNamespaces: {
        kShortChainId: const RequiredNamespace(
          chains: ['eip155:11155111'],
          methods: [
            'eth_sign',
            'eth_signTransaction',
            'eth_sendTransaction',
            'personal_sign'
          ],
          events: ['chainChanged', 'accountsChanged'],
        ),
      },
    );

    final Uri? uri = connectResponse.uri;
    if (uri != null) {
      final String encodedUrl = Uri.encodeComponent('$uri');
      _url = encodedUrl;
      await launchUrlString(deepLinkUrl, mode: LaunchMode.externalApplication);
    }

    _sessionData = await connectResponse.session.future;
    final String accountWithPrefix =
        _sessionData!.namespaces.values.first.accounts.first;
    final String address = accountWithPrefix.split(':').last;

    setState(() {
      account = address;
    });

    print("User connected with address: $address");
    print("Nonce: $nonce");

    final String message = "This message verifies your wallet: $nonce";
    final String hexMessage =
        '0x${utf8.encode(message).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('')}';

    await Future.delayed(const Duration(milliseconds: 1000));
    await launchUrlString(deepLinkUrl, mode: LaunchMode.externalApplication);

    try {
      final String _signature = await _walletConnect!.request(
        topic: _sessionData!.topic,
        chainId: 'eip155:11155111',
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [hexMessage, address],
        ),
      );

      setState(() {
        signature = _signature;
      });
      debugPrint("Message signed with signature: $_signature");
      return _signature;
    } catch (e) {
      debugPrint("Error signing message: $e");
      return null;
    }
  }

  Future<bool> metamaskIsInstalled() async {
    return await LaunchApp.isAppInstalled(
      androidPackageName: 'io.metamask',
      iosUrlScheme: 'metamask://',
    );
  }

  Future<DeployedContract> loadRewardContract() async {
    String abi = await rootBundle.loadString("assets/abi/abi.json");
    return DeployedContract(
      ContractAbi.fromJson(abi, "GymeratorReward"),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  Future<dynamic> claimReward(BuildContext context) async {
    final contract = await loadRewardContract();

    if (signatureResponse?.data != null) {
      print(signatureResponse?.data?.rewardAmount);

      String message = signatureResponse?.data?.message ?? "";
      Uint8List signatureData = hexToBytes(signatureResponse!.data!.signature!);

      final receiverAddress = EthereumAddress.fromHex(NamespaceUtils.getAccount(
          _sessionData!.namespaces.values.first.accounts.first));
      print(BigInt.parse(response!.data!.nonce.toString()));
      Transaction transaction = Transaction.callContract(
        from: EthereumAddress.fromHex(NamespaceUtils.getAccount(
            _sessionData!.namespaces.values.first.accounts.first)),
        contract: contract,
        function: contract.function('claimReward'),
        parameters: [
          receiverAddress,
          BigInt.parse(signatureResponse?.data?.rewardAmount.toString() ?? "0"),
          signatureData,
          message,
          BigInt.parse(signatureResponse!.data!.nonce.toString())
        ],
      );

      EthereumTransaction ethereumTransaction = EthereumTransaction(
        from: NamespaceUtils.getAccount(
            _sessionData!.namespaces.values.first.accounts.first),
        to: contractAddress,
        value: "0x0",
        gas: BigInt.from(2000000).toRadixString(16),
        data: hex.encode(List<int>.from(transaction.data!)),
      );

      await launchUrlString(deepLinkUrl, mode: LaunchMode.externalApplication);

      final signResponse = await _walletConnect?.request(
        topic: _sessionData!.topic,
        chainId: "eip155:11155111",
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [ethereumTransaction.toJson()],
        ),
      );

      // Check if the transaction was signed successfully and navigate back
      if (signResponse != null) {
        print("Transaction signed successfully: $signResponse");
        Nav.push(context,
            const MainScreen()); // Navigate back to the previous screen
      }

      return signResponse;
    }
  }

  Uint8List hexToBytes(String hexString) {
    hexString = hexString.replaceAll('0x', ''); // Remove '0x' prefix if present
    return Uint8List.fromList(List.generate(hexString.length ~/ 2,
        (i) => int.parse(hexString.substring(i * 2, i * 2 + 2), radix: 16)));
  }

  @override
  void initState() {
    super.initState();
    loadRewardContract();
    client = Client();
    web3client = Web3Client(rpcUrl, client);
  }

  GetNonceApiResponse? response;
  VerifySignatureApiResponse? verifySignatureApiResponse;
  GetAllFavoriteProductApiResponse? userInfoResponse;
  GetRewardSignatureApiResponse? signatureResponse;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => MetamaskCubit()..featuredRequest(),
      child: BlocConsumer<MetamaskCubit, MetamaskState>(
        listener: (context, state) {
          if (state is FailedToGetProduct) {}
          if (state is AllFavoriteProductGetSuccessfully) {
            userInfoResponse = state.response;
          }
          if (state is FailedToGetNonce) {
            showSnackBar(context, state.response!);
          }
          if (state is NonceGetSuccessfully) {
            response = state.response;
            print("Nonce: ${response?.data?.nonce}");
            createSessionAndSignMessage(response?.data?.nonce ?? 0);
          }
          if (state is FailedToVerifySignature) {
            showSnackBar(context, state.response?.message ?? "Something Wrong");
          }
          if (state is VerifySignatureSuccessfully) {
            verifySignatureApiResponse = state.response;
            print(verifySignatureApiResponse?.data);
          }
          if (state is FailedToGetSignature) {}
          if (state is GetSignatureRewardSuccessfully) {
            signatureResponse = state.response;
            print(signatureResponse?.data);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 6),
                    Center(
                      child: SizedBox(
                        height: screenHeight * 0.18,
                        width: screenWidth * 0.3,
                        child: Image.asset("assets/images/metamask.png",
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: screenHeight / 3),
                    Center(
                      child: Text(
                        "${userInfoResponse?.data?.rewardAmount?.toStringAsFixed(6)} GYM",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 20,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Welcome to Metamask",
                        style: GoogleFonts.vazirmatn(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Connect your metamask wallet",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14, color: Colors.black38),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    account == null
                        ? const SizedBox()
                        : Center(
                            child: Text(
                              account!,
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 12, color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    const Spacer(),
                    account == null
                        ? AppButton(
                            text: "Connect",
                            onPressed: () async {
                              await context
                                  .read<MetamaskCubit>()
                                  .getNonceRequest();
                            },
                          )
                        : (verifySignatureApiResponse?.data != null)
                            ? AppButton(
                                text: "Claim Your reward",
                                onPressed: () async {
                                  try {
                                    await context
                                        .read<MetamaskCubit>()
                                        .getSignatureRequest();
                                    await claimReward(context);
                                  } catch (e) {
                                    showSnackBar(
                                        context, "Error claiming reward: $e");
                                  }
                                },
                              )
                            : AppButton(
                                text: "Verify Your Signature",
                                onPressed: () async {
                                  if (response?.data?.nonce != null &&
                                      account != null &&
                                      signature != null) {
                                    await context
                                        .read<MetamaskCubit>()
                                        .verifyRequest(
                                          nonce: response!.data!.nonce!,
                                          address: account!,
                                          signature: signature!,
                                        );
                                  }
                                },
                              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
