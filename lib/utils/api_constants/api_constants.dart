class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://api.gymerator.fit";
  static const String signUp = "$baseUrl/api/user/signup";
  static const String signIn = "$baseUrl/api/user/login";
  static const String loginWithGoogle = "$baseUrl/api/user/auth/google";
  static const String updateUserProfile =
      "$baseUrl/api/user/updateProfileImage";
  static const String forgetPassword = "$baseUrl/api/user/forgotPassword";
  static const String verifyOTP = "$baseUrl/api/user/verifyOTP";
  static const String updatePassword = "$baseUrl/api/user/updatePassword";
  static const String updateUserInfo = "$baseUrl/api/user/updateInfo";
  static const String featuredProduct = "$baseUrl/api/products/featured";
  static const String detailProduct = "$baseUrl/api/products/details";
  static const String addToCartProduct = "$baseUrl/api/carts/addItem";
  static const String userCartProduct = "$baseUrl/api/carts/byUserID";
  static const String userFavoriteProduct = "$baseUrl/api/user";
  static const String addFavoriteProduct =
      "$baseUrl/api/user/addFavoriteProduct";
  static const String removeFavoriteProduct =
      "$baseUrl/api/user/removeFavoriteProduct";
  static const String removeCartItem = "$baseUrl/api/carts/removeItem";
  static const String updateCartItem = "$baseUrl/api/carts/updateItemQuantity";
  static const String createOrder = "$baseUrl/api/orders/";
  static const String allProduct = "$baseUrl/api/products";
  static const String allOrders = "$baseUrl/api/orders/history";
  static const String orderDetails = "$baseUrl/api/orders/";
  static const String searchProduct = "$baseUrl/api/products/search";
  static const String generatePlan = "$baseUrl/api/workout/generateplan";
  static const String acceptPlan = "$baseUrl/api/workout/accept";
  static const String getWorkoutPlan = "$baseUrl/api/workout/";
  static const String updateWorkoutPlan = "$baseUrl/api/workout";
}
