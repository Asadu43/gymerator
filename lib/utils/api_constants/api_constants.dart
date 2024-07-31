class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "http://3.64.190.185:5100";
  static const String signUp = "$baseUrl/api/user/signup";
  static const String signIn = "$baseUrl/api/user/login";
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
}
