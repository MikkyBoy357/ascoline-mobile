import 'package:ascolin/pages/sign_up_page.dart';
import 'package:ascolin/utils/reusable_signup_container.dart';
import 'package:ascolin/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/email_text_field.dart';
import '../widgets/password_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _visibilitySecure = false;
  bool _isChecked = false;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(debugLabel: "login");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Bienvenue',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Entrez votre email et votre mot de passe pour vous connectez',
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          EmailTextField(
                            hintText: '***********@mail.com',
                            controller: emailController,
                            onChanged: (value) =>
                                authViewModel.setLEmail(value),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PasswordField(
                            controller: passwordController,
                            onChanged: (value) =>
                                authViewModel.setLPassword(value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         _isChecked = !_isChecked;
                //         setState(() {});
                //       },
                //       child: Container(
                //         margin: const EdgeInsets.only(left: 20),
                //         width: 20,
                //         height: 20,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(3),
                //           color: _isChecked
                //               ? const Color(0xff006CEC)
                //               : Colors.white,
                //           border: Border.all(
                //             color: const Color(0xff006CEC),
                //           ),
                //         ),
                //         child: Visibility(
                //           visible: _isChecked,
                //           child: Icon(
                //             Icons.check,
                //             color: _isChecked ? Colors.white : Colors.black,
                //             size: 16,
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 6,
                //     ),
                //     const ReusableText(
                //       text: "Rappel moi",
                //       color: Color(0xffCFCFCF),
                //     ),
                //     Spacer(),
                //     InkWell(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) {
                //               return const ForgotPasswordPage();
                //             },
                //           ),
                //         );
                //       },
                //       child: const ReusableText(
                //         text: 'Mot de passe oublié?',
                //         color: Color(0xff0560FA),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: height * 0.25,
                ),
                ReusableSignUpContainer(
                  onTap: () => authViewModel.login(context, loginFormKey),
                  text: 'Se connecter',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff0560fa),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // const Text(
                //   "or log in using",
                //   style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.grey,
                //       fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image(
                //       image: AssetImage(
                //         'assets/fb.png',
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Image(
                //       image: AssetImage(
                //         'assets/google.png',
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Image(
                //       image: AssetImage(
                //         'assets/apple.png',
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
