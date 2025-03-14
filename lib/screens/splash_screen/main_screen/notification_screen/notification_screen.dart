import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/notification_cubit/user_notification_cubit.dart';
import 'package:gymmerator/models/api_response/GetNotificationsApiResponse.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../utils/nav/nav.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  GetNotificationsApiResponse? response;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UserNotificationCubit()..getNotificationRequest(),
      child: BlocConsumer<UserNotificationCubit, UserNotificationState>(
        listener: (context, state) {
          if(state is FailedToGetNotifications){

          }if(state is AllNotificationGetSuccessfully){
            response = state.response;
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Nav.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                            SizedBox(width: screenWidth * 0.2),
                            Text("Notifications",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        ListView.builder(
                          itemCount: response?.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/dumb.png",
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                                response?.data?[index].tittle ?? "",
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 12.sp,
                                                    color: Colors.black)),
                                          ),
                                          Text(response?.data?[index].message ?? "",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.vazirmatn(
                                                  fontSize: 11.sp,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
