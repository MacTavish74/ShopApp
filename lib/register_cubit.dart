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
import 'package:shopapp/register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(RegisterInitiateState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

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
      {required String email, required String password,required String name, required String phone}) async {
    try {
      emit(RegisterLoadingState());
      final value = await DioHelper.postData(url: REGISTER, data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,


      });
      loginModell = LoginModel.fromJson(value.data);
      print(loginModell);
      emit(RegisterSuccessState(loginModell));
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(RegisterErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(RegisterErrorState(e.toString()));
      }
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
      print('test$error');
    }
  }
}
