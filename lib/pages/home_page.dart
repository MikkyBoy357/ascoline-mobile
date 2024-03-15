import 'package:ascolin/base/constant.dart';
import 'package:ascolin/model/action_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model/auth_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff0560FA),
                  ),
                  width: width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bienvenue, ${authViewModel.userData.firstName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              'Nous espérons que vous passez un bon moment',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: const Text(
                    "Qu'est-ce que tu aimerais faire?",
                    style: TextStyle(
                      color: Color(0xff0560FA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: actionItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return ActionCard(
                      actionItem: actionItems[index],
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ActionCard extends StatelessWidget {
  final ActionModel actionItem;
  const ActionCard({
    super.key,
    required this.actionItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (actionItem.nextPage is Widget) {
          Widget widget = actionItem.nextPage as Widget;
          Constant.navigatePush(context, widget);
        } else if (actionItem.nextPage is String) {
          String string = actionItem.nextPage as String;
          launchUrl(Uri.parse(string));
        }
      },
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.3), // Adjust the shadow color and opacity here
              spreadRadius: 0.75,
              blurRadius: 1,
              offset: Offset(0, 0), // Adjust the position of the shadow
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          // height: height * 0.2,
          // width: width * 0.4,
          child: Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage(actionItem.icon),
                  color: Color(0xFF04009A),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  actionItem.label,
                  style: TextStyle(
                    color: Color(0xFF04009A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  actionItem.description,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
