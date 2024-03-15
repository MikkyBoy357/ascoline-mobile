import 'package:ascolin/model/product_model.dart';
import 'package:ascolin/view_model/product_view_model.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOrderCreateDialog extends StatefulWidget {
  const ProductOrderCreateDialog({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductOrderCreateDialog> createState() =>
      _ProductOrderCreateDialogState();
}

class _ProductOrderCreateDialogState extends State<ProductOrderCreateDialog> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, productViewModel, _) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        color: Colors.grey.shade50,
        child: SingleChildScrollView(
          child: FirstScreen(
            product: widget.product,
          ),
        ),
      );
    });
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController specialNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, productViewModel, _) {
      return productViewModel.paymentLoading
          ? CustomLoading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantité',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: productViewModel.quantity == 1
                                ? null
                                : () {
                                    productViewModel.setPaymentQuantity(
                                        productViewModel.quantity - 1);
                                  },
                            child: Container(
                              color: Colors.grey.shade200,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.remove,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Text(
                            "${productViewModel.quantity}",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          InkWell(
                            onTap: productViewModel.quantity ==
                                    widget.product.quantity
                                ? null
                                : () {
                                    productViewModel.setPaymentQuantity(
                                        productViewModel.quantity + 1);
                                  },
                            child: Container(
                              color: Colors.grey.shade200,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Prix du produit',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.product.price}" ?? "-",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${(widget.product.price ?? 0) * (productViewModel.quantity)} F CFA",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Ajouter une note (Optionel)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxLines: null,
                          minLines: 5,
                          textInputType: TextInputType.text,
                          hintText: "",
                          controller: specialNoteController,
                          onChange: (value) =>
                              productViewModel.setSpecialNote(value),
                          validateFunction: (value) {
                            return value;
                          }),
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
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Retour",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await productViewModel.createProductOrder(
                              context, widget.product);
                        },
                        child: Container(
                          //width: 80,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Commander",
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
              ),
            );
    });
  }
}
