import 'package:ascolin/utils/reusable_signup_container.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'New Password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: const Text(
                'Enter new password',
                style: TextStyle(
                  color: Color(0xffA7A7A7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'New Password',
                    style: TextStyle(
                      color: Color(0xffA7A7A7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: TextStyle(),
                    obscuringCharacter: "*",
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xffCFCFCF),
                      ),
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: Color(0xffA7A7A7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: TextStyle(),
                    obscuringCharacter: "*",
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xffCFCFCF),
                      ),
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: ReusableSignUpContainer(text: 'Log In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
