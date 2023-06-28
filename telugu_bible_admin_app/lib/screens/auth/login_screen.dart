import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/controller/authentication_controller.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen>
    with WidgetsBindingObserver {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return Container();
        },
        desktop: (BuildContext context) {
          return buildDesktopLoginScreen();
        },
      ),
    );
  }

  Widget buildDesktopLoginScreen() {
    return GetBuilder<AuthenticationController>(
      builder: (authControoler) {
        return SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome Admin",
                      style: TextStyle(fontSize: 60),
                    ),
                    const SizedBox(height: 10),
                    const Text("Login to access your account details",
                        style: TextStyle()),
                    const SizedBox(height: 30),

                    //create a new account using email and password

                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: 350,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: authControoler.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: "Your Email",
                                  prefixIcon: Icon(Icons.alternate_email)),
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Enter your name"
                                    : null;
                              },
                            ),
                            TextFormField(
                              controller: authControoler.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: "Your Password",
                                  prefixIcon: Icon(Icons.visibility)),
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Enter your password"
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //signup button
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authControoler.loginWithEmailAndPass();
                        }
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.kPrimaryColor,
                        child: authenticationController.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox(
                                height: 45,
                                width: 400,
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 80, top: 80, left: 80, right: 80),
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
