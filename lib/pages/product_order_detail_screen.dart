import 'package:ascolin/model/product_order_model.dart';
import 'package:ascolin/widgets/product_payment_dialog.dart';
import 'package:flutter/material.dart';

import '../utils/reusable_signup_container.dart';

class ProductOrderDetailScreen extends StatefulWidget {
  final ProductOrderModel productOrder;

  const ProductOrderDetailScreen({
    super.key,
    required this.productOrder,
  });

  @override
  State<ProductOrderDetailScreen> createState() =>
      _ProductOrderDetailScreenState();
}

class _ProductOrderDetailScreenState extends State<ProductOrderDetailScreen> {
  List<String> statusEnums = ["Enregistrée", "Livrée"];

  int enumIndex = 0;

  @override
  void initState() {
    super.initState();
    // Find the index of "En transit" in the statusEnums list during initialization
    enumIndex = statusEnums.indexWhere((element) =>
        element.toLowerCase() ==
        (widget.productOrder.status?.toLowerCase() ?? "enregistrée"));
    print("enumIndex => $enumIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Details de la commande",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Référence",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${widget.productOrder.reference}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF04009A),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status de la commande",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: "${widget.productOrder.status}" == 'Enregistrée'
                        ? Colors.green
                        : Colors.greenAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "${widget.productOrder.status}",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 14, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status du paiement",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: widget.productOrder.paymentStatus == 'paid'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "${widget.productOrder.paymentStatus == 'paid' ? "Payée" : "Non Payée"}",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 14, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                enumIndex + 1,
                (index) => StatusRow(
                  title: "${statusEnums[index]}",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Information de la commande",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF04009A),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nom du produit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "${widget.productOrder.product?.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEC8000),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantité",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "${widget.productOrder.quantity}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEC8000),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prix",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "${widget.productOrder.price} F CFA",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEC8000),
                  ),
                ),
              ],
            ),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Montant à payer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey[600],
                  ),
                ),
                Text(
                  "${(widget.productOrder.price ?? 0) * (widget.productOrder.quantity ?? 0)} F CFA",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEC8000),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Visibility(
              visible: (widget.productOrder.paymentStatus == "unpaid" &&
                  widget.productOrder.status == "Enregistrée"),
              child: ReusableSignUpContainer(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isDismissible: false,
                    enableDrag: false,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: ProductPaymentDialog(
                          productOrder: widget.productOrder,
                        ),
                      );
                    },
                  );
                },
                text: 'Payer la facture',
                margin: EdgeInsets.only(bottom: 30),
                backgroundColor: Color(0xFF0560FA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String title;

  const StatusRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: VerticalDivider(),
              )
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
