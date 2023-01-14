import 'package:shopapp/LoginModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopButNavState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String error;
  ShopErrorState(this.error);
}

class CategorieSuccessState extends ShopStates {}

class CategorieLoadingState extends ShopStates {}

class CategorieErrorState extends ShopStates {}

class ShopUserDataSuccessState extends ShopStates {
  final LoginModel? loginModell;

  ShopUserDataSuccessState(this.loginModell);

}

class ShopUserDataLoadingState extends ShopStates {}

class ShopUserDataErrorState extends ShopStates {}
