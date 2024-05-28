import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/metamask_screen/account_setup/account_setup.dart';
import 'package:gymmerator/utils/nav/nav.dart';

import '../../../ui_component/app_button.dart';
import '../../../utils/app_colors/appColors.dart';

class MetaMaskScreen extends StatefulWidget {
  const MetaMaskScreen({Key? key}) : super(key: key);

  @override
  State<MetaMaskScreen> createState() => _MetaMaskScreenState();
}

class _MetaMaskScreenState extends State<MetaMaskScreen>
    with SingleTickerProviderStateMixin {
  // static Web3App? _walletConnect;
  static String? _url;
  // static SessionData? _sessionData;
  String? account;

  static const String kShortChainId = 'eip155';
  static const String kFullChainId = 'eip155:80001';
  static const String launchError = 'Metamask wallet not installed';

  String get deepLinkUrl => 'metamask://wc?uri=$_url';

  // Future<void> _initWalletConnect() async {
  //   _walletConnect = await Web3App.createInstance(
  //     projectId: 'b8ff9c52a3433ab288836f7402d5d323',
  //     metadata: const PairingMetadata(
  //       name: 'Flutter WalletConnect',
  //       description: 'Flutter WalletConnect Dapp',
  //       url: 'https://walletconnect.com/',
  //       icons: [
  //         'https://walletconnect.com/walletconnect-logo.png',
  //       ],
  //     ),
  //   );
  // }
  //
  // Future createSession() async {
  //   final bool isInstalled = await metamaskIsInstalled();
  //
  //   if (!isInstalled) {
  //     return await LaunchApp.openApp(
  //       iosUrlScheme: 'metamask://',
  //       androidPackageName: 'io.metamask',
  //     );
  //   }
  //
  //   if (_walletConnect == null) {
  //     await _initWalletConnect();
  //   }
  //
  //   final ConnectResponse connectResponse = await _walletConnect!.connect(
  //     requiredNamespaces: {
  //       kShortChainId: const RequiredNamespace(
  //         chains: [kFullChainId],
  //         methods: [
  //           'eth_sign',
  //           'eth_signTransaction',
  //           'eth_sendTransaction',
  //         ],
  //         events: [
  //           'chainChanged',
  //           'accountsChanged',
  //         ],
  //       ),
  //     },
  //   );
  //
  //   final Uri? uri = connectResponse.uri;
  //   if (uri != null) {
  //     final String encodedUrl = Uri.encodeComponent('$uri');
  //
  //     _url = encodedUrl;
  //
  //     await launchUrlString(
  //       deepLinkUrl,
  //       mode: LaunchMode.externalApplication,
  //     );
  //     _sessionData = await connectResponse.session.future;
  //
  //     final String _account = NamespaceUtils.getAccount(
  //       _sessionData!.namespaces.values.first.accounts.first,
  //     );
  //     setState(() {
  //       account = _account;
  //     });
  //     return _account;
  //   }
  //
  //   return null;
  // }
  //
  // Future metamaskIsInstalled() async {
  //   return await LaunchApp.isAppInstalled(
  //     androidPackageName: 'io.metamask',
  //     iosUrlScheme: 'metamask://',
  //     // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //     // openStore: false
  //   );
  // }
  //
  // Future<void> _onSignInButtonPressed(BuildContext context) async {
  //   if (account == null) {
  //     showSnackBar(context, "Wallet address not valid");
  //   } else {
  //     context.read<SignInCubit>().signInWithAddress(address: account!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            child: Image.asset("assets/images/metamask.png", fit: BoxFit.cover),
          )),
          SizedBox(
            height: screenHeight / 3,
          ),
          Center(
            child: Text("Welcome to Matamask",
                style: GoogleFonts.barlow(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black)),
          ),
          Center(
            child: Text("Connect your metamask wallet",
                style: GoogleFonts.barlow(fontSize: 14, color: Colors.black38),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: screenHeight / 6,
          ),
          AppButton(
            text: "Connect",
            onPressed: () async {},
          )
        ],
      ),
    ));
  }
}
