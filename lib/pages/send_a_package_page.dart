import 'package:ascolin/view_model/order_provider.dart';
import 'package:ascolin/widgets/name_text_field.dart';
import 'package:ascolin/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/reusable_signup_container.dart';
import '../widgets/dropdown_text_field.dart';

class SendAPackagePage extends StatefulWidget {
  const SendAPackagePage({super.key});

  @override
  State<SendAPackagePage> createState() => _SendAPackagePageState();
}

class _SendAPackagePageState extends State<SendAPackagePage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController trackingController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController transportTypeController = TextEditingController();
  TextEditingController typeColisController = TextEditingController();
  TextEditingController specialNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<OrderProvider>(context, listen: false).getDropLists();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: height * 0.1,
            backgroundColor: Colors.white,
            title: Text(
              'Faire une commande',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: orderProvider.orderFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.call_split_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Détails du vendeur',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        NameTextField(
                          title: 'Description',
                          controller: descriptionController,
                          onChanged: (val) => orderProvider.setDescription(val),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NumberTextField(
                          title: 'Tracking',
                          controller: trackingController,
                          onChanged: (val) => orderProvider.setTracking(val),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropDownTextField(
                          title: 'Unite(kg)',
                          value: orderProvider.unite,
                          customItems: orderProvider.measureUnits.map((data) {
                            return DropdownMenuItem(
                              value: data,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.label.toString(),
                                      style: TextStyle(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          dropDownList: orderProvider.measureUnits,
                          hintText: 'Unite',
                          controller: uniteController,
                          onChanged: (dynamic val) {
                            orderProvider.setUnite(val);
                          },
                          hasPrefixImage: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NumberTextField(
                          title: 'Quantite',
                          controller: quantiteController,
                          onChanged: (val) => orderProvider.setQuantite(val),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Détails de destination',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DropDownTextField(
                          title: 'Pays',
                          value: orderProvider.pays,
                          dropDownList: orderProvider.countries
                              .map((country) => country.label)
                              .toList(),
                          hintText: 'Pays',
                          controller: paysController,
                          onChanged: (val) =>
                              orderProvider.setPays(val.toString()),
                          hasPrefixImage: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NameTextField(
                          title: 'Ville',
                          controller: villeController,
                          onChanged: (val) => orderProvider.setVille(val),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Détails du colis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        DropDownTextField(
                          title: 'Type de transport',
                          value: orderProvider.typeTransport,
                          dropDownList: orderProvider.transportTypes,
                          customItems: orderProvider.transportTypes.map((data) {
                            return DropdownMenuItem(
                              value: data,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.label.toString(),
                                      style: TextStyle(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          hintText: 'Transport',
                          controller: transportTypeController,
                          onChanged: (dynamic val) =>
                              orderProvider.setTypeTransport(val),
                          hasPrefixImage: false,
                        ),
                        SizedBox(height: 10),
                        DropDownTextField(
                          title: 'Type de colis',
                          value: orderProvider.typeColis,
                          dropDownList: orderProvider.packageTypes,
                          customItems: orderProvider.packageTypes.map((data) {
                            return DropdownMenuItem(
                              value: data,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.label.toString(),
                                      style: TextStyle(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          hintText: 'Colis',
                          controller: typeColisController,
                          onChanged: (dynamic val) =>
                              orderProvider.setTypeColis(val),
                          hasPrefixImage: false,
                        ),
                        SizedBox(height: 10),
                        NameTextField(
                          title: 'Note spéciale',
                          controller: specialNoteController,
                          onChanged: (val) => orderProvider.setSpecialNote(val),
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(left: 20),
                  //   child: Text(
                  //     'Select delivery type',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: width * 0.1,
                  //     ),
                  //     ReusableContainer(
                  //       icon: Icons.access_time,
                  //       iconColor: Colors.white,
                  //       height: height,
                  //       width: width / 1.1,
                  //       text: 'Instant Delivery',
                  //       color: Color(0xff04009A),
                  //       textColor: Colors.white,
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     ReusableContainer(
                  //       icon: Icons.calendar_month,
                  //       iconColor: Colors.grey,
                  //       height: height,
                  //       width: width / 1.1,
                  //       text: 'Scheduled Delivery',
                  //       color: Colors.white,
                  //       textColor: Colors.grey.shade300,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ReusableSignUpContainer(
                      onTap: () {
                        orderProvider.createOrder(context);
                      },
                      text: 'Crée commande',
                      margin: EdgeInsets.only(bottom: 20),
                      backgroundColor: Color(0xFF0560FA),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
