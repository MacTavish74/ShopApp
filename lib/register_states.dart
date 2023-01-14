import 'package:shopapp/LoginModel.dart';
import 'package:shopapp/class_model.dart';

abstract class ShopRegisterStates {}

class RegisterInitiateState extends ShopRegisterStates {}

class RegisterLoadingState extends ShopRegisterStates {}

class RegisterSuccessState extends ShopRegisterStates {
  final LoginModel? loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends ShopRegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
