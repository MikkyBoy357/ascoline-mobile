import 'package:ascolin/model/product_order_model.dart';
import 'package:ascolin/view_model/product_view_model.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/custom_text_field.dart';
import 'package:ascolin/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPaymentDialog extends StatefulWidget {
  const ProductPaymentDialog({super.key, required this.productOrder});

  final ProductOrderModel productOrder;

  @override
  State<ProductPaymentDialog> createState() => _ProductPaymentDialogState();
}

class _ProductPaymentDialogState extends State<ProductPaymentDialog> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, productViewModel, _) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        color: Colors.grey.shade50,
        child: productViewModel.paymentStep == 1
            ? FirstScreen(
                phoneController: phoneController,
                productOrder: widget.productOrder,
              )
            : SecondScreen(
                productOrder: widget.productOrder,
              ),
      );
    });
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen(
      {super.key, required this.phoneController, required this.productOrder});

  final TextEditingController phoneController;
  final ProductOrderModel productOrder;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, productViewModel, _) {
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
                  onChange: (value) => productViewModel.setPaymentPhone(value),
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
                      productViewModel.setPaymentNetwork("MTN");
                    },
                    child: Center(
                      child: AnimatedContainer(
                        width: 70,
                        height: 50,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          borderRadius: productViewModel.paymentNetwork == "MTN"
                              ? BorderRadius.circular(9)
                              : BorderRadius.circular(0),
                          border: Border.all(
                            color: productViewModel.paymentNetwork == "MTN"
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                          /*borderRadius: BorderRadius.circular(5)*/
                        ),
                        child: ClipRRect(
                          borderRadius: productViewModel.paymentNetwork == "MTN"
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
                      productViewModel.setPaymentNetwork("MOOV");
                    },
                    child: Center(
                      child: AnimatedContainer(
                        width: 70,
                        height: 50,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              productViewModel.paymentNetwork == "MOOV"
                                  ? BorderRadius.circular(9)
                                  : BorderRadius.circular(0),
                          border: Border.all(
                            color: productViewModel.paymentNetwork == "MOOV"
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                          /*borderRadius: BorderRadius.circular(5)*/
                        ),
                        child: ClipRRect(
                          borderRadius:
                              productViewModel.paymentNetwork == "MOOV"
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
                  String phoneNumber = productViewModel.paymentPhone;

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
                    productViewModel.setPaymentStep(2);
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
  const SecondScreen({super.key, required this.productOrder});

  final ProductOrderModel productOrder;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, productViewModel, _) {
      return productViewModel.paymentLoading
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
                      productViewModel.paymentPhone ?? "-",
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
                      productViewModel.paymentNetwork ?? "-",
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
                      'Quantité',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.productOrder.quantity}" ?? "-",
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
                      'Prix du produit',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.productOrder.price}" ?? "-",
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
                      "${(widget.productOrder.price ?? 0) * (widget.productOrder.quantity ?? 0)} F CFA",
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
                        productViewModel.setPaymentStep(1);
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
                        productViewModel.payProductOrder(
                            context, widget.productOrder);
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
