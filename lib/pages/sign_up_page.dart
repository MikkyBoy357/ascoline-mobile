import 'package:ascolin/pages/sign_in_page.dart';
import 'package:ascolin/utils/reusable_signup_container.dart';
import 'package:ascolin/view_model/auth_view_model.dart';
import 'package:ascolin/widgets/email_text_field.dart';
import 'package:ascolin/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../widgets/password_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isChecked = false;
  bool _visibilitySecure = false;

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(debugLabel: "signup");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 81,
                ),
                Container(
                  child: const Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: width * 0.25),
                  child: const Text(
                    "Terminez le processus d'inscription pour commencer",
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
                  key: signupFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      NameTextField(
                        title: 'Prénoms',
                        hintText: 'John',
                        controller: firstNameController,
                        onChanged: (value) => authViewModel.setFirstName(value),
                      ),
                      const SizedBox(height: 10),
                      NameTextField(
                        title: 'Nom',
                        hintText: 'Doe',
                        controller: lastNameController,
                        onChanged: (value) => authViewModel.setLastName(value),
                      ),
                      const SizedBox(height: 10),
/*                      PhoneTextField(
                        controller: phoneController,
                        onChanged: (value) =>
                            authViewModel.setPhoneNumber(value),
                      ),*/
                      IntlPhoneField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        initialCountryCode: 'BJ',
                        onChanged: (phone) {
                          authViewModel.setPhoneNumber(phone.completeNumber);
                        },
                      ),
                      const SizedBox(height: 10),
                      EmailTextField(
                        hintText: '***********@mail.com',
                        controller: emailController,
                        onChanged: (value) =>
                            authViewModel.setEmailAddress(value),
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        controller: passwordController,
                        onChanged: (value) => authViewModel.setPassword(value),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _isChecked = !_isChecked;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: _isChecked
                                    ? Color(0xff006CEC)
                                    : Colors.white,
                                border: Border.all(
                                  color: const Color(0xff006CEC),
                                ),
                              ),
                              child: Visibility(
                                visible: _isChecked,
                                child: Icon(
                                  Icons.check,
                                  color:
                                      _isChecked ? Colors.white : Colors.black,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            flex: 5,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'En cochant cette case, vous acceptez nos ',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Termes et conditions et politique privée',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          authViewModel.signUp(context, signupFormKey);
                        },
                        child: ReusableSignUpContainer(
                          onTap: () =>
                              authViewModel.signUp(context, signupFormKey),
                          text: "S'inscrire",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Avez-vous un compte? ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignInPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff0560fa),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/fb.png',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage(
                            'assets/google.png',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage(
                            'assets/apple.png',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
