import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isPasswordHidden = true.obs;
  final _isLoading = false.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isLoading => _isLoading.value;

  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  void onPasswordSuffixTapped() {
    _isPasswordHidden.value = !(_isPasswordHidden.value);
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? isEmailTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (!GetUtils.isEmail(value!)) {
        return 'Format email salah';
      }
      return null;
    } else {
      return 'Email tidak boleh kosong';
    }
  }

  String? isPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Password tidak boleh kosong';
    }
  }

  void onTapLoginButton() async {
    try {
      if (formGlobalKey.currentState!.validate()) {
        _isLoading.value = true;
        await Future.delayed(Duration(seconds: 1));
        _isLoading.value = false;
        // var user = await _authDatasource.login(emailTextEditingController.text,
        //     passwordTextEditingController.text);
        // _authDatasource.saveUserInfo(user);
        // Get.offNamed(HomePage.routeName);
      }
    } catch (error) {
      _isLoading.value = false;
      // if (error is InvalidCredentialException) {
      //   showMessage('Email atau password salah', 'Silakan coba lagi');
      // } else if (error is UserNotFoundException) {
      //   showMessage('Akun tidak ditemukan',
      //       'Silakan lakukan registrasi terlebih dahulu');
      // } else {
      //   showMessage('Terdapat kesalahan pada aplikasi', 'Silakan coba lagi');
      // }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
