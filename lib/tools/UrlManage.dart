String _host = "http://106.12.116.150/AppServer/";

String getFoodsByTypeUrl(int type){
  return _host + "php/get_foods_by_type.php?type=$type";
}

String addAddressUrl(){
  return _host + "php/add_address.php";
}

String getAddressTypeUrl(){
  return _host + "php/get_address_type.php";
}

String updateSelectedUrl(int userId,int addressId){
  return _host + "php/update_address_select.php?user_id=$userId&address_id=$addressId";
}

String getAddressListUrl(int userId){
  return _host + "php/get_address_list.php?user_id=$userId";
}

String getCuisineByIdUrl(int id){
  return _host + "php/get_cuisine_by_id.php?cuisine_id=$id";
}

String checkLoginUserUrl(String userName,String password){
  return _host + "php/check_login_user.php?user_name=$userName&password=$password";
}

String getCommendSearchUrl(){
  return _host + "php/get_commend_search.php";
}

String searchCuisineUrl(String keyword){
  return _host + "php/search_cuisine.php?keyword=$keyword";
}

String checkUserNameExistUrl(String userName){
  return _host + "php/check_user_register_state.php?user_name=$userName";
}

String registerUrl(){
  return _host + "php/user_register.php";
}

