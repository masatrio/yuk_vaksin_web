import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';
import 'package:yuk_vaksin_web/features/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  Widget emailTextField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: 400,
            child: TextFormField(
              style: GoogleFonts.poppins(fontSize: 14),
              controller: controller.emailTextEditingController,
              validator: controller.isEmailTextFormValid,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue),
                ),
              ),
            ),
          ),
        ],
      );

  Widget passwordTextField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: 400,
            child: Obx(
              () => TextFormField(
                style: GoogleFonts.poppins(fontSize: 14),
                controller: controller.passwordTextEditingController,
                validator: controller.isPasswordTextFormValid,
                obscureText: controller.isPasswordHidden,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  suffixIcon: IconButton(
                      splashRadius: 24,
                      icon: Icon(
                          controller.isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: blue),
                      onPressed: controller.onPasswordSuffixTapped),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: blue),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget loginButton() => SizedBox(
        width: 400,
        height: 40,
        child: Obx(
          () => TextButton(
              onPressed:
                  controller.isLoading ? null : controller.onTapLoginButton,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 55, vertical: 4),
                child: controller.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Masuk',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    controller.isLoading ? Colors.grey[300] : blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              )),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: blue,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/yuk_vaksin_logo.png'),
            const SizedBox(
              height: 65,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: controller.formGlobalKey,
                  child: Column(
                    children: [
                      emailTextField(),
                      const SizedBox(height: 18),
                      passwordTextField(),
                      const SizedBox(
                        height: 18,
                      ),
                      loginButton()
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
