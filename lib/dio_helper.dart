// ignore_for_file: invalid_required_positional_param

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/dio_helper.dart';
import 'package:shopapp/end_points.dart';
import 'package:shopapp/login_states.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',

      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url, query, String lang = 'en',  String? token}) async {
    dio!.options.headers = {'lang': lang, 'authorization': token };

    return await dio!.get(url, queryParameters: query, );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic>? data}) async {
    return await dio!.post(url, queryParameters: query, data: data);
  }
}
