import 'package:flutter/material.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/account_edit_screen/account_edit_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/profile_edit_screen/profile_edit_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/app_dialog_box.dart';
import 'package:gymmerator/utils/app_colors/appColors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [Colors.orange, Colors.deepOrange],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Amelia Renata',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/profile_edit.png',
                            width: 24,
                            height: 24,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Profile Edit',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileEditScreen()));
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_outline)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Account Edit',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountEditScreen()));
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/profile_terms_conditions.png',
                            width: 24,
                            height: 24,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Terms & Conditions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {},
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/profile_privacy_policy.png',
                            width: 24,
                            height: 24,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Privacy Policy',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {},
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.profileEditIconsBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/icons/profile_delete_account.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Delete Account',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => PlaceholderDialog(
                                  backgroundColor: Colors.white,
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppColors
                                          .profileDeleteDialogIconBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/icons/profile_delete_account.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  message:
                                      'Are you sure you want to delete your account permanently?',
                                  actions: [
                                    Column(
                                      children: [
                                        AppButton(
                                          text: "Delete Account",
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            )),
                                      ],
                                    ),
                                  ],
                                ));
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/profile_share_app.png',
                            width: 24,
                            height: 24,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Share the app',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {},
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider()),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profileEditIconsBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/profile_logout.png',
                            width: 24,
                            height: 24,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: const Text('Logout',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => PlaceholderDialog(
                                  backgroundColor: Colors.white,
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppColors
                                          .profileDeleteDialogIconBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.logout,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  message:
                                      'Are you sure you want to logout from your account?',
                                  actions: [
                                    Column(
                                      children: [
                                        AppButton(
                                          text: "Logout",
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            )),
                                      ],
                                    ),
                                  ],
                                ));
                      },
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
