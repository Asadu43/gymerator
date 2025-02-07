import 'dart:convert';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/metamask_cubit/metamask_cubit.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';
import 'package:walletconnect_flutter_v2/apis/web3app/web3app.dart';

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

  String get deepLinkUrl => 'metamask://wc?uri=$_url';

  Future<void> _initWalletConnect() async {
    _walletConnect = await Web3App.createInstance(
      projectId: 'b8ff9c52a3433ab288836f7402d5d323',
      metadata: const PairingMetadata(
        name: 'Flutter WalletConnect',
        description: 'Flutter WalletConnect Dapp',
        url: 'https://walletconnect.com/',
        icons: [
          'https://walletconnect.com/walletconnect-logo.png',
        ],
      ),
    );
  }

  Future<String?> createSessionAndSignMessage(int nonce) async {
    // 1) Check if MetaMask is installed
    final bool isInstalled = await metamaskIsInstalled();
    if (!isInstalled) {
      // Attempt to open or redirect the user to install MetaMask
      await LaunchApp.openApp(
        iosUrlScheme: 'metamask://',
        androidPackageName: 'io.metamask',
      );
      return null;
    }

    // 2) Initialize WalletConnect if it's null
    if (_walletConnect == null) {
      await _initWalletConnect(); // Your custom init function
    }

    // 3) Connect with required namespaces (include 'personal_sign')
    final ConnectResponse connectResponse = await _walletConnect!.connect(
      requiredNamespaces: {
        kShortChainId: const RequiredNamespace(
          chains: ['eip155:1'], // Ethereum mainnet
          methods: [
            'eth_sign',
            'eth_signTransaction',
            'eth_sendTransaction',
            'personal_sign', // Must include for signing
          ],
          events: [
            'chainChanged',
            'accountsChanged',
          ],
        ),
      },
    );

    // If we have a WC URI, open MetaMask so user can approve
    final Uri? uri = connectResponse.uri;
    if (uri != null) {
      final String encodedUrl = Uri.encodeComponent('$uri');
      _url = encodedUrl; // optional: store it for reference

      // First deep link: open MetaMask to connect
      // Adjust deepLinkUrl to something like: 'metamask://wc?uri=$encodedUrl'
      await launchUrlString(
        deepLinkUrl,
        mode: LaunchMode.externalApplication,
      );
    }

    // 4) Wait for the user to approve the connection in MetaMask
    _sessionData = await connectResponse.session.future;

    // "eip155:1:0xABCD123..." => we only need the last part
    final String accountWithPrefix =
        _sessionData!.namespaces.values.first.accounts.first;
    final String address = accountWithPrefix.split(':').last;

    setState(() {
      account = address; // store the connected address
    });

    debugPrint("User connected with address: $address");

    // ------------------------------------
    // 5) Automatically sign a message
    // ------------------------------------
    final String message = "This message verifies your wallet: $nonce";
    final String hexMessage =
        '0x${utf8.encode(message).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('')}';

    // Depending on your library, the request(...) may or may NOT automatically open MetaMask again.
    // If it does NOT open automatically, you can manually open it via the same deep link:
    await Future.delayed(const Duration(milliseconds: 1000)); // short delay
    await launchUrlString(
      deepLinkUrl, // same or similar link as above
      mode: LaunchMode.externalApplication,
    );

    try {
      final String _signature = await _walletConnect!.request(
        topic: _sessionData!.topic,
        chainId: 'eip155:1', // mainnet
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [
            hexMessage, // [0] => hex-encoded message
            address, // [1] => address
          ],
        ),
      );

      setState(() {
        signature = _signature;
      });
      debugPrint("\n\nMessage signed with signature: $_signature\n\n");
      return _signature; // Return signature if needed
    } catch (e) {
      debugPrint("Error signing message: $e");
      // You can handle the error or return null
      return null;
    }
  }

  Future metamaskIsInstalled() async {
    return await LaunchApp.isAppInstalled(
      androidPackageName: 'io.metamask',
      iosUrlScheme: 'metamask://',
      // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
      // openStore: false
    );
  }

  // Future<void> _onSignInButtonPressed(BuildContext context) async {
  //   if (account == null) {
  //     showSnackBar(context, "Wallet address not valid");
  //   } else {
  //     context.read<SignInCubit>().signInWithAddress(address: account!);
  //   }
  // }
  GetNonceApiResponse? response;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => MetamaskCubit(),
      child: BlocConsumer<MetamaskCubit, MetamaskState>(
        listener: (context, state) {
          if (state is FailedToGetNonce) {
            showSnackBar(context, state.response!);
          }
          if (state is NonceGetSuccessfully) {
            response = state.response;

            print(response?.data?.nonce);
            createSessionAndSignMessage(response?.data?.nonce ?? 0);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 6,
                ),
                Center(
                    child: SizedBox(
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.3,
                  child: Image.asset("assets/images/metamask.png",
                      fit: BoxFit.cover),
                )),
                SizedBox(
                  height: screenHeight / 3,
                ),
                Center(
                  child: Text("Welcome to Matamask",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black)),
                ),
                Center(
                  child: Text("Connect your metamask wallet",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14, color: Colors.black38),
                      textAlign: TextAlign.center),
                ),
                account == null
                    ? const SizedBox()
                    : Center(
                        child: Text(account!,
                            style: GoogleFonts.vazirmatn(
                                fontSize: 12, color: Colors.black38),
                            textAlign: TextAlign.center),
                      ),
                const Spacer(),
                account == null
                    ? AppButton(
                        text: "Connect",
                        onPressed: () async {
                          await context.read<MetamaskCubit>().getNonceRequest();
                        },
                      )
                    : AppButton(
                        text: "Connected",
                        onPressed: () async {
                          // if (response?.data?.nonce != null &&
                          //     account != null &&
                          //     signature != null) {
                          //   await context.read<MetamaskCubit>().verifyRequest(
                          //       nonce: response!.data!.nonce!,
                          //       address: account!,
                          //       signature: signature!);
                          // }
                        },
                      )
              ],
            ),
          ));
        },
      ),
    );
  }
}
