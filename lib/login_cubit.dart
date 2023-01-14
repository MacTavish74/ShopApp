import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/LoginModel.dart';
import 'package:shopapp/class_model.dart';
import 'package:shopapp/dio_helper.dart';
import 'package:shopapp/end_points.dart';
import 'package:shopapp/login_states.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(LoginInitiateState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  // void userLogin({required String email, required String password}) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(url: LOGIN, data: {
  //     'email': email,
  //     'password': password,
  //   }).then((value) {
  //     print(value.data);
  //     emit(LoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
  LoginModel? loginModell;
  Future<void> userLogin(
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final value = await DioHelper.postData(url: LOGIN, data: {
        'email': email,
        'password': password,
      });
      loginModell = LoginModel.fromJson(value.data);
      print(loginModell);
      emit(LoginSuccessState(loginModell));
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(LoginErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(LoginErrorState(e.toString()));
      }
    } catch (error) {
      emit(LoginErrorState(error.toString()));
      print('test$error');
    }
  }
}
