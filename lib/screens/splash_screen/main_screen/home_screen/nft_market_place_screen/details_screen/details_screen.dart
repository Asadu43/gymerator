import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../ui_component/app_button.dart';
import '../../../../../../ui_component/app_dialog_box.dart';
import '../../../../../../utils/nav/nav.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  const DetailsScreen({super.key, required this.name, required this.image});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  Text(widget.name,
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Center(child: Image.asset("assets/images/nft_image.png")),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "Created by",
                  style: GoogleFonts.vazirmatn(),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/traning.png"),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text("@Tawwkan",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp, color: Colors.blue)),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "Description",
                  style: GoogleFonts.vazirmatn(color: Colors.grey),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Container(
                  child: Text(
                    "6th digital art of beautiful mind collection.Do you also believe that real talk save lives? or it just made up my mind !!??",
                    style: GoogleFonts.vazirmatn(),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "Attributes",
                  style: GoogleFonts.vazirmatn(color: Colors.grey),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("graffiti",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp, color: Colors.black)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("NFT",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp, color: Colors.black)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("digital art",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.20,
              ),
              AppButton(
                text: "Purchase",
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) => PlaceholderDialog(
                      icon: Image.asset(
                        "assets/icons/success.png",
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.1,
                      ),
                      title: 'Success',
                      message: 'You have successfully Purchased the item',
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: AppButton(
                              text: "Back",
                              onPressed: () async {
                                Nav.pop(context);
                              }),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
