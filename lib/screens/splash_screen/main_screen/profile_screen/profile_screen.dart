import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/account_edit_screen/account_edit_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/profile_edit_screen/profile_edit_screen.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/login_screen/login_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/app_dialog_box.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';

import '../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/api_constants/api_constants.dart';
import '../../../../utils/nav/nav.dart';
import 'orders_screen/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetAllFavoriteProductApiResponse? response;

  @override
  void initState() {
    context.read<AllFavoriteProductsCubit>().featuredRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllFavoriteProductsCubit, AllFavoriteProductsState>(
      listener: (context, state) {
        if (state is FailedToGetProduct) {
          showSnackBar(context, state.response.error);
        }
        if (state is AllFavoriteProductGetSuccessfully) {
          response = state.response;
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
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
                          image: AssetImage(
                              'assets/images/profile_background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: response?.data?.profile == null
                                ? null
                                : NetworkImage(
                                    '${ApiConstants.baseUrl}/profile/${response?.data?.profile}',
                                  ),
                            child: response?.data?.profile == null
                                ? Text(
                                    response?.data?.firstName?[0]
                                            .toUpperCase() ??
                                        "",
                                    style: const TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${response?.data?.firstName ?? " "} ${response?.data?.lastName ?? " "}",
                            style: const TextStyle(
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              onTap: () {
                                Nav.push(
                                    context,
                                    ProfileEditScreen(
                                      age: response?.data?.age ?? 0,
                                      goal: response?.data?.goal ?? "",
                                      weight:
                                          response?.data?.weight?.unit ?? "",
                                      height:
                                          response?.data?.height?.unit ?? "",
                                      weightValue:
                                          response?.data?.weight?.value ?? 0.0,
                                      heightValue:
                                          response?.data?.height?.value ?? 0.0,
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
                                  child: const Icon(Icons.person_outline)),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                              title: const Text('Account Edit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              onTap: () {
                                Nav.push(
                                    context,
                                    AccountEditScreen(
                                        firstName:
                                            response?.data?.firstName ?? "",
                                        lastName:
                                            response?.data?.lastName ?? "",
                                        address1:
                                            response?.data?.address?.address1 ??
                                                " ",
                                        address2:
                                            response?.data?.address?.address2 ??
                                                " ",
                                        city: response?.data?.address?.city ??
                                            " ",
                                        state: response?.data?.address?.state ??
                                            " ",
                                        country:
                                            response?.data?.address?.country ??
                                                " ",
                                        response?.data?.profile));
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
                              title: const Text('Orders',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              onTap: () {
                                Nav.push(context, const OrdersScreen());
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
                                                    GetStorage()
                                                        .write('token', null);
                                                    Nav.pushAndRemoveAllRoute(
                                                        context,
                                                        const LoginScreen());
                                                  },
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
            ),
          ),
        );
      },
    );
  }
}
