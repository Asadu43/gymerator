import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/nav/nav.dart';



class NftMarketPlaceScreen extends StatefulWidget {
  const NftMarketPlaceScreen({super.key});

  @override
  State<NftMarketPlaceScreen> createState() => _NftMarketPlaceScreenState();
}

class _NftMarketPlaceScreenState extends State<NftMarketPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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
                      Text("NFT Marketplace",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  
                  Container(
                    child: GridView.builder(physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 5.0,
                        // mainAxisSpacing: 5.0,
                      ),
                      itemCount: 10,itemBuilder: (context, index) {

                      return Padding(padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,bottom: 10.0),
                        child: Container(
                          height: screenHeight * 0.7,
                          width: (MediaQuery.of(context).size.width/2)-20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                ),
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: screenHeight * 0.12,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/nft_image.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: isFav ? Icon(Icons.favorite,color: Colors.red,)
                                  //         : Icon(Icons.favorite_border, color: Colors.white,),
                                  //   ),
                                  // )
                                ],
                              ),
                              const SizedBox(height: 15.0,),
                              const Padding(
                                padding:  EdgeInsets.only(left: 8.0),
                                child:  Text("NFT",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                              const SizedBox(height: 10.0,),
                               const Padding(
                                 padding: EdgeInsets.only(left: 8.0),
                                 child: Text('\$ 30 each',style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                                               ),),
                               ),
                            ],
                          ),
                        ),
                      );

                    },),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
