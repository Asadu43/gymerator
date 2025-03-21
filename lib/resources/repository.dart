import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/AcceptWorkoutPlanApiResponse.dart';
import 'package:gymmerator/models/api_response/AddFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/AddToCartProductApiResponse.dart';
import 'package:gymmerator/models/api_response/AddWorkoutMetricsApiResponse.dart';
import 'package:gymmerator/models/api_response/ChatAiApiResponse.dart';
import 'package:gymmerator/models/api_response/CreateOrderApiResponse.dart';
import 'package:gymmerator/models/api_response/DeleteWorkoutMetricsApiResponse.dart';
import 'package:gymmerator/models/api_response/DeviceRegisterApiResponse.dart';
import 'package:gymmerator/models/api_response/DeviceRemoveApiResponse.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';
import 'package:gymmerator/models/api_response/ForgetPasswordApiResponse.dart';
import 'package:gymmerator/models/api_response/GenerateWorkoutPlanApiResponse.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/GetAllProductApiResponse.dart';
import 'package:gymmerator/models/api_response/GetAllUserOrdersApiResponse.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';
import 'package:gymmerator/models/api_response/GetNotificationsApiResponse.dart';
import 'package:gymmerator/models/api_response/GetRewardSignatureApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByDateApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByExersiceApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutSummaryApiResponse.dart';
import 'package:gymmerator/models/api_response/LoginWithGoogleApiResponse.dart';
import 'package:gymmerator/models/api_response/MarkAsReadApiResponse.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';
import 'package:gymmerator/models/api_response/RemoveCartItemApiResponse.dart';
import 'package:gymmerator/models/api_response/RemoveFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/SearchProductApiResponse.dart';
import 'package:gymmerator/models/api_response/TotalBurnedCaloriesApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdateCartItemApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdatePasswordApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdateUserInfoApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdateWorkoutPlanApiResponse.dart';
import 'package:gymmerator/models/api_response/UserOrderDetailsApiResponse.dart';
import 'package:gymmerator/models/api_response/VerifyOTPApiResponse.dart';
import 'package:gymmerator/resources/api_providers/add_favorite_product_post_api.dart';
import 'package:gymmerator/resources/api_providers/add_to_cart_post_api.dart';
import 'package:gymmerator/resources/api_providers/add_workout_metrics_post_api.dart';
import 'package:gymmerator/resources/api_providers/all_favorite_product_get_api.dart';
import 'package:gymmerator/resources/api_providers/all_product_get_api.dart';
import 'package:gymmerator/resources/api_providers/chat_bot_post_api.dart';
import 'package:gymmerator/resources/api_providers/create_order_post_api.dart';
import 'package:gymmerator/resources/api_providers/device_register_post_api.dart';
import 'package:gymmerator/resources/api_providers/device_remove_delete_api.dart';
import 'package:gymmerator/resources/api_providers/featured_product_get_api.dart';
import 'package:gymmerator/resources/api_providers/forget_password_post_api.dart';
import 'package:gymmerator/resources/api_providers/generate_work_plan_get_api.dart';
import 'package:gymmerator/resources/api_providers/marked_as_read_put_api.dart';
import 'package:gymmerator/resources/api_providers/nonce_get_api.dart';
import 'package:gymmerator/resources/api_providers/order_details_get_api.dart';
import 'package:gymmerator/resources/api_providers/product_detail_get_api.dart';
import 'package:gymmerator/resources/api_providers/remove_cart_item_put_api.dart';
import 'package:gymmerator/resources/api_providers/remove_favorite_put_api.dart';
import 'package:gymmerator/resources/api_providers/reward_signature_get_api.dart';
import 'package:gymmerator/resources/api_providers/search_product_get_api.dart';
import 'package:gymmerator/resources/api_providers/total_burned_calories_get_api.dart';
import 'package:gymmerator/resources/api_providers/update_cart_item_put_api.dart';
import 'package:gymmerator/resources/api_providers/update_password_put_api.dart';
import 'package:gymmerator/resources/api_providers/update_user_info_post_api.dart';
import 'package:gymmerator/resources/api_providers/update_user_profile_post_api.dart';
import 'package:gymmerator/resources/api_providers/update_work_out_put_api.dart';
import 'package:gymmerator/resources/api_providers/user_cart_products_get_api.dart';
import 'package:gymmerator/resources/api_providers/user_notifications_get_api.dart';
import 'package:gymmerator/resources/api_providers/user_orders_get_api.dart';
import 'package:gymmerator/resources/api_providers/verify_Otp_get_api.dart';
import 'package:gymmerator/resources/api_providers/verify_signature_put_api.dart';
import 'package:gymmerator/resources/api_providers/workout_metrics_by_exercise_get_api.dart';
import 'package:gymmerator/resources/api_providers/workout_metrics_delete_api.dart';
import 'package:gymmerator/resources/api_providers/workout_metrics_get_api.dart';
import 'package:gymmerator/resources/api_providers/workout_metrics_summary_get_api.dart';
import 'package:gymmerator/resources/api_providers/workout_plan_get_api.dart';

import '../models/api_response/SignInApiResponse.dart';
import '../models/api_response/SignupApiResponse.dart';
import '../models/api_response/VerifySignatureApiResponse.dart';
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

  Future<LoginWithGoogleApiResponse> loginWithGoogle(Map data) {
    final signInPost = SignInPostApi();
    return signInPost.loginWithGoogleRequest(data);
  }

  Future<GetAllFavoriteProductApiResponse> updateUserProfile(FormData data) {
    final model = UpdateUserProfilePostApi();
    return model.updateRequest(data);
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

  Future<UpdateUserInfoApiResponse> updateUserInfoRequest(FormData data) {
    final request = UpdateUserInfoPostApi();
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

  Future<AddToCartProductApiResponse> cartRequest(Map data) {
    final request = AddToCartPostApi();
    return request.cartRequest(data);
  }

  Future<GetAllUserProductApiResponse> getCartProductRequest() {
    final request = UserCartProductsGetApi();
    return request.getCartRequest();
  }

  Future<AddFavoriteProductApiResponse> addFavoriteProductRequest(String id) {
    final request = AddFavoriteProductPostApi();
    return request.addFavoriteRequest(id);
  }

  Future<RemoveFavoriteProductApiResponse> removeFavoriteRequest(String id) {
    final request = RemoveFavoritePutApi();
    return request.removeFavoriteRequest(id);
  }

  Future<GetAllFavoriteProductApiResponse> getFavoriteProductRequest() {
    final request = AllFavoriteProductGetApi();
    return request.getFavoriteRequest();
  }

  Future<UpdateCartItemApiResponse> updateItemRequest(String id, int quantity) {
    final request = UpdateCartItemPutApi();
    return request.updateRequest(id, quantity);
  }

  Future<RemoveCartItemApiResponse> removeRequest(String id) {
    final request = RemoveCartItemPutApi();
    return request.removeRequest(id);
  }

  Future<CreateOrderApiResponse> createRequest(Map data) {
    final request = CreateOrderPostApi();
    return request.createRequest(data);
  }

  Future<GetAllProductApiResponse> getProductRequest() {
    final request = AllProductGetApi();
    return request.getProductRequest();
  }

  Future<GetAllUserOrdersApiResponse> getAllOrdersRequest() {
    final request = UserOrdersGetApi();
    return request.getAllOrdersRequest();
  }

  Future<UserOrderDetailsApiResponse> detailsRequest(String id) {
    final request = OrderDetailsGetApi();
    return request.detailRequest(id);
  }

  Future<SearchProductApiResponse> searchRequest(String id) {
    final request = SearchProductGetApi();
    return request.searchRequest(id);
  }

  Future<GenerateWorkoutPlanApiResponse> generateRequest() {
    final request = GenerateWorkPlanGetApi();
    return request.generatePlanRequest();
  }

  Future<GetWorkoutPlanApiResponse> getWorkoutRequest() {
    final request = WorkoutPlanGetApi();
    return request.getPlanRequest();
  }

  Future<AcceptWorkoutPlanApiResponse> acceptWorkoutRequest() {
    final request = GenerateWorkPlanGetApi();
    return request.acceptRequest();
  }

  Future<ChatAiApiResponse> chatRequest(Map data) {
    final request = ChatBotPostApi();
    return request.chatRequest(data);
  }

  Future<UpdateWorkoutPlanApiResponse> updateWorkoutRequest() {
    final request = UpdateWorkOutPutApi();
    return request.updateRequest();
  }

  Future<AddWorkoutMetricsApiResponse> addWorkoutMetricRequest(var data) {
    final request = AddWorkoutMetricsPostApi();
    return request.addRequest(data);
  }

  Future<GetWorkoutMetricsApiResponse> getWorkoutMetricRequest() {
    final request = WorkoutMetricsGetApi();
    return request.getRequest();
  }

  Future<GetWorkoutMetricsByDateApiResponse> getWorkoutByDateMetricsRequest(
      String date) {
    final request = WorkoutMetricsGetApi();
    return request.getWorkoutByDateRequest(date);
  }

  Future<DeleteWorkoutMetricsApiResponse> deleteWorkoutMetricRequest(
      String id) {
    final request = WorkoutMetricsDeleteApi();
    return request.deleteRequest(id);
  }

  Future<GetWorkoutSummaryApiResponse> getWorkoutSummaryRequest() {
    final request = WorkoutMetricsSummaryGetApi();
    return request.getRequest();
  }

  Future<TotalBurnedCaloriesApiResponse> getWorkoutCaloriesRequest() {
    final request = TotalBurnedCaloriesGetApi();
    return request.getRequest();
  }

  Future<GetWorkoutMetricsByExersiceApiResponse> getWorkoutByExerciseRequest(
      String exercise) {
    final request = WorkoutMetricsByExerciseGetApi();
    return request.getRequest(exercise);
  }

  Future<GetNonceApiResponse> getNonceRequest() {
    final request = NonceGetApi();
    return request.getNonceRequest();
  }

  Future<VerifySignatureApiResponse> verifySignatureRequest(Map data) {
    final request = VerifySignaturePutApi();
    return request.verifySignatureRequest(data);
  }

  Future<GetRewardSignatureApiResponse> getSignatureRequest() {
    final request = RewardSignatureGetApi();
    return request.getRequest();
  }

  Future<DeviceRegisterApiResponse> deviceRegisterRequest(Map data) {
    final request = DeviceRegisterPostApi();
    return request.registerRequest(data);
  }

  Future<DeviceRemoveApiResponse> deleteRequest() {
    final request = DeviceRemoveDeleteApi();
    return request.deleteRequest();
  }

  Future<GetNotificationsApiResponse> getNotificationRequest() {
    final request = UserNotificationsGetApi();
    return request.getUserNotificationRequest();
  }


  Future<MarkAsReadApiResponse> markAsReadRequest(String id) {
    final request = MarkedAsReadPutApi();
    return request.readRequest(id);
  }
}
