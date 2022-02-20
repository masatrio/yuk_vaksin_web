import 'dart:io';

import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/adapter.dart';

const baseUrl = 'https://go-vaksin-be-5b54mztdkq-as.a.run.app/';

class MainBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.put<Dio>(provideDio())];
  }

  Dio provideDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    dio.httpClientAdapter = BrowserHttpClientAdapter();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
      final baseUrl = option.baseUrl;
      final path = option.path;
      debugPrint('Request [${baseUrl + path}] : '
          '${option.queryParameters.toString()}');
      debugPrint('header [${option.headers.toString()}] ');
      return handler.next(option);
    }, onResponse: (response, handler) {
      debugPrint('Response body: ${response.toString()}');
      return handler.next(response);
    }, onError: (error, handler) {
      debugPrint(error.response.toString());
      return handler.next(error);
    }));
    return dio;
  }
}
