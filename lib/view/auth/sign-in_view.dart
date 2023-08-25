import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parking/controller/auth/auth_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/view/auth/sign-up_view.dart';
import 'package:parking/view/widget/custom_text_from_filed.dart';
class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  final AuthController _controller = Get.put(AuthController());
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
              ),
              const Text(
                "Login to your Account",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!_controller.isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                controller: _controller.emailController,
                hintText: "Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                controller: _controller.passwordController,
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: deepdarkblue,
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black
                      );
                     await _controller.signInWithEmailAndPassword();
                      _controller.emailController.clear();
                      _controller.passwordController.clear();
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: lightgreen,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Forget the password?",
                  style: TextStyle(
                    color: darkblue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "or continue with",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    scale: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Google",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      color: deepdarkblue,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account?",
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(SignUpView());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: darkblue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
