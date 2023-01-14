import 'package:shopapp/LoginModel.dart';
import 'package:shopapp/class_model.dart';

abstract class ShopLoginStates {}

class LoginInitiateState extends ShopLoginStates {}

class LoginLoadingState extends ShopLoginStates {}

class LoginSuccessState extends ShopLoginStates {
  final LoginModel? loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends ShopLoginStates {
  final String error;
  LoginErrorState(this.error);
}
