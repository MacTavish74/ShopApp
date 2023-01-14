import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/LoginModel.dart';
import 'package:shopapp/categorie_model.dart';
import 'package:shopapp/categories.dart';
import 'package:shopapp/class_home_model.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/dio_helper.dart';
import 'package:shopapp/end_points.dart';
import 'package:shopapp/favourites.dart';
import 'package:shopapp/products.dart';
import 'package:shopapp/settings.dart';
import 'package:shopapp/shopStates.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> buttonitems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: ('Categories')),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ('favourites')),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: ('Settings'))
  ];
  List<Widget> screens = [Products(), Categories(), Favourites(), Settings()];
  void onchanged(int index) {
    currentIndex = index;
    emit(ShopButNavState());
  }

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    try {
      emit(ShopLoadingState());
      final value = await DioHelper.getData(url: HOME);

      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(ShopErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(ShopErrorState(e.toString()));
      }
    } catch (error) {
      emit(ShopErrorState(error.toString()));
      print('test$error');
    }
  }

  CategorieModel? categorieModel;
  Future<void> getCategories() async {
    try {
      emit(CategorieLoadingState());
      final value = await DioHelper.getData(url: GET_CATEGORIES, token: token);
      categorieModel = CategorieModel.fromJson(value.data);
      emit(CategorieSuccessState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(ShopErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(ShopErrorState(e.toString()));
      }
    } catch (error) {
      emit(ShopErrorState(error.toString()));
      print('test$error');
    }
  }

  LoginModel? usermodel;
  Future<void> getUserData() async {
    try {
      emit(ShopUserDataLoadingState());
      final value = await DioHelper.getData(url: PROFILE, token: token);
      usermodel = LoginModel.fromJson(value.data);
      print(usermodel!.data!.name);
      emit(ShopUserDataSuccessState(usermodel));
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(ShopErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(ShopErrorState(e.toString()));
      }
    } catch (error) {
      emit(ShopErrorState(error.toString()));
      print('test$error');
    }
  }
}
