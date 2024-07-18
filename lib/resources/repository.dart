import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';
import 'package:gymmerator/models/api_response/ForgetPasswordApiResponse.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdatePasswordApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdateUserInfoApiResponse.dart';
import 'package:gymmerator/models/api_response/VerifyOTPApiResponse.dart';
import 'package:gymmerator/resources/api_providers/featured_product_get_api.dart';
import 'package:gymmerator/resources/api_providers/forget_password_post_api.dart';
import 'package:gymmerator/resources/api_providers/product_detail_get_api.dart';
import 'package:gymmerator/resources/api_providers/update_password_put_api.dart';
import 'package:gymmerator/resources/api_providers/update_user_info_put_api.dart';
import 'package:gymmerator/resources/api_providers/verify_Otp_get_api.dart';

import '../models/api_response/SignInApiResponse.dart';
import '../models/api_response/SignupApiResponse.dart';
import 'api_providers/sign_in_post_api.dart';
import 'api_providers/signup_post_api.dart';

class Repository {
  Future<SignupApiResponse> signUp(Map data) {
    final signUpPost = SignUpPostApi();
    return signUpPost.signUpRequest(data);
  }

  Future<SignInApiResponse> signIn(Map data) {
    final signInPost = SignInPostApi();
    return signInPost.signInRequest(data);
  }

  Future<ForgetPasswordApiResponse> forgetRequest(Map data) {
    final request = ForgetPasswordPostApi();
    return request.forgetRequest(data);
  }

  Future<VerifyOtpApiResponse> verifyRequest(String email, int code) {
    final request = VerifyOtpGetApi();
    return request.verifyRequest(email, code);
  }

  Future<UpdatePasswordApiResponse> updateRequest(Map data) {
    final request = UpdatePasswordPutApi();
    return request.updateRequest(data);
  }

  Future<UpdateUserInfoApiResponse> updateUserInfoRequest(Map data) {
    final request = UpdateUserInfoPutApi();
    return request.updateRequest(data);
  }


  Future<FeaturedProductApiResponse> getFeaturedProductRequest() {
    final request = FeaturedProductGetApi();
    return request.featuredRequest();
  }

  Future<ProductDetailApiResponse> getDetailProductRequest(String id) {
    final request = ProductDetailGetApi();
    return request.detailRequest(id);
  }
}
