import 'package:ascolin/model/transaction_model.dart';
import 'package:ascolin/view_model/transaction_view_model.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TransactionViewModel>(context, listen: false).getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<TransactionViewModel>(
      builder: (context, transactionViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Liste des transactions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  NameTextField(
                    controller: searchController,
                    title: "Recherche",
                    hintText: "Recherche ...",
                    onChanged: (val) => transactionViewModel.setKeyword(val),
                  ),
                  SizedBox(height: 20),
                  Builder(builder: (context) {
                    if (transactionViewModel.transactionsLoading) {
                      return CustomLoading();
                    } else if (transactionViewModel.keyword.isEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transactionViewModel.transactionList.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final TransactionModel currentTransaction =
                              transactionViewModel.transactionList[index];

                          return TransactionCard(
                            transaction: currentTransaction,
                          );
                        },
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transactionViewModel.searchList.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final TransactionModel currentTransaction =
                              transactionViewModel.searchList[index];

                          return TransactionCard(
                            transaction: currentTransaction,
                          );
                        },
                      );
                    }
                  }),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 300,
      width: size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${transaction.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // Add other desired styles for the first text here
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${DateFormat.yMd('fr').format(DateTime.parse(transaction.updatedAt ?? ""))}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // Add other desired styles for the first text here
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Référence: ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        // Add other desired styles for the first text here
                      ),
                    ),
                    TextSpan(
                      text: '${transaction.reference}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        // Add other desired styles for the second text here
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantité',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${transaction.transactionType == "product" ? ((transaction.amount ?? 1) / (transaction.item.price ?? 1)) : ((transaction.amount ?? 1) / (transaction.item.pricing?.price ?? 1))}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prix',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${transaction.transactionType == "product" ? (transaction.item?.price ?? "-") : (transaction.item?.pricing?.price ?? "-")} F CFA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Montant Total',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${transaction.amount ?? "-"} F CFA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: transaction.status == "success"
                      ? Colors.green
                      : transaction.status == "pending"
                          ? Colors.orangeAccent
                          : Colors.redAccent,
                ),
                child: Text(
                  "${transaction.status == "success" ? "Réussie" : transaction.status == "pending" ? "En attente" : "Echouée"}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      transaction.step == "2" ? Colors.green : Colors.redAccent,
                ),
                child: Text(
                  "${transaction.step == "2" ? "Momo validé" : " Momo échoué"}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
