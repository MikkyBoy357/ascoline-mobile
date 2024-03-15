import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/view_model/order_provider.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/custom_text_field.dart';
import 'package:ascolin/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPaymentDialog extends StatefulWidget {
  const OrderPaymentDialog({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderPaymentDialog> createState() => _OrderPaymentDialogState();
}

class _OrderPaymentDialogState extends State<OrderPaymentDialog> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, _) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        color: Colors.grey.shade50,
        child: orderProvider.paymentStep == 1
            ? FirstScreen(
                phoneController: phoneController,
              )
            : SecondScreen(
                order: widget.order,
              ),
      );
    });
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Numéro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                  prefixIcon: Text(
                    "+229 ",
                    //textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  maxLines: null,
                  minLines: null,
                  textInputType: TextInputType.number,
                  height: 40,
                  width: 180,
                  hintText: "",
                  controller: widget.phoneController,
                  onChange: (value) => orderProvider.setPaymentPhone(value),
                  validateFunction: (value) {
                    return value;
                  })
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Réseau',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      orderProvider.setPaymentNetwork("MTN");
                    },
                    child: Center(
                      child: AnimatedContainer(
                        width: 70,
                        height: 50,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          borderRadius: orderProvider.paymentNetwork == "MTN"
                              ? BorderRadius.circular(9)
                              : BorderRadius.circular(0),
                          border: Border.all(
                            color: orderProvider.paymentNetwork == "MTN"
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                          /*borderRadius: BorderRadius.circular(5)*/
                        ),
                        child: ClipRRect(
                          borderRadius: orderProvider.paymentNetwork == "MTN"
                              ? BorderRadius.circular(7)
                              : BorderRadius.zero,
                          child: Image.asset(
                            'assets/mtn-momo.jpeg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      orderProvider.setPaymentNetwork("MOOV");
                    },
                    child: Center(
                      child: AnimatedContainer(
                        width: 70,
                        height: 50,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: orderProvider.paymentNetwork == "MOOV"
                              ? BorderRadius.circular(9)
                              : BorderRadius.circular(0),
                          border: Border.all(
                            color: orderProvider.paymentNetwork == "MOOV"
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                          /*borderRadius: BorderRadius.circular(5)*/
                        ),
                        child: ClipRRect(
                          borderRadius: orderProvider.paymentNetwork == "MOOV"
                              ? BorderRadius.circular(7)
                              : BorderRadius.zero,
                          child: Image.asset(
                            'assets/moov-money.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 80,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Retour",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTap: () {
                  String phoneNumber = orderProvider.paymentPhone;

                  if (phoneNumber.length != 8) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorDialog(
                          text: 'Le numéro de paiement est incorrect',
                        );
                      },
                    );
                  } else {
                    orderProvider.setPaymentStep(2);
                  }
                },
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Suivant",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, _) {
      return orderProvider.paymentLoading
          ? CustomLoading()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Numéro de Paiement',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderProvider.paymentPhone ?? "-",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Réseau',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderProvider.paymentNetwork ?? "-",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Total à payer',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${(widget.order.pricing?.price ?? 0) * (widget.order.quantity ?? 0)} F CFA",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        orderProvider.setPaymentStep(1);
                      },
                      child: Container(
                        width: 80,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Retour",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        orderProvider.payOrder(context, widget.order);
                      },
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Suivant",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
    });
  }
}
