import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/auth/auth_controller.dart';
import 'package:parking/view/auth/continue_info_view.dart';
import 'package:parking/view/auth/sign-in_view.dart';
import '../../helper/constant.dart';
import '../widget/custom_text_from_filed.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
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
                "Create your Account",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
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
              const SizedBox(height: 12),
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
                  onPressed: () {
                    if (formstate.currentState!.validate()) {
                      Get.to(ContinueView(
                        emailController: _controller.email,
                        passwordController: _controller.password,
                      ));
                    }
                  },
                  child: Text(
                    "Continue",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
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
                    "Already have an account?",
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(SignInView());
                    },
                    child: Text(
                      "Sign In",
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
