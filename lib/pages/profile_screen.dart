import 'package:ascolin/pages/sign_in_page.dart';
import 'package:ascolin/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.back),
        title: Text('Profile'),
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${authViewModel.userData.lastName?.toUpperCase()} ${authViewModel.userData.firstName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${authViewModel.userData.email}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              // RichText(
                              //   text: TextSpan(
                              //     children: [
                              //       TextSpan(
                              //         text: 'Balance: ',
                              //         style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 16,
                              //         ),
                              //       ),
                              //       TextSpan(
                              //         text: 'N10,712:00',
                              //         style: TextStyle(
                              //           color: Color(0xFF04009A),
                              //           fontSize: 16,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(CupertinoIcons.eye_slash_fill),
                      // )
                    ],
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Enable dark mode',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     CupertinoSwitch(
                  //       value: false,
                  //       onChanged: (val) {},
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20),
                  // ProfileOptionCard(
                  //   icon: Icon(
                  //     CupertinoIcons.profile_circled,
                  //     size: 30,
                  //   ),
                  //   title: "Modifier des information",
                  //   subtitle: "Nom, telephone, addresse, email ...",
                  // ),
                  // SizedBox(height: 15),
                  // ProfileOptionCard(
                  //   icon: Icon(
                  //     CupertinoIcons.calendar_circle,
                  //     size: 30,
                  //   ),
                  //   title: "Contact",
                  //   subtitle: "Name, phone no, address, email ...",
                  // ),
                  // ProfileOptionCard(
                  //   icon: Icon(
                  //     CupertinoIcons.bell,
                  //     size: 30,
                  //   ),
                  //   title: "Notification Settings",
                  //   subtitle: "Name, phone no, address, email ...",
                  // ),
                  SizedBox(height: size.height / 10),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("https://wa.me/22963000751"));
                    },
                    child: ProfileOptionCard(
                      icon: Icon(
                        Icons.image_outlined,
                        size: 30,
                      ),
                      title: "À propos",
                      subtitle: "En savoir plus sur nous, termes et conditions",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: SignInPage(),
                            );
                          },
                        ),
                      );
                    },
                    child: ProfileOptionCard(
                      icon: Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.red,
                      ),
                      title: "Log Out",
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileOptionCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String? subtitle;

  const ProfileOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Visibility(
                      visible: subtitle != null,
                      child: Container(
                        width: size.width / 2,
                        child: Text(
                          "${subtitle}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500]!,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              2, // Adjust the number of lines you want to display
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
