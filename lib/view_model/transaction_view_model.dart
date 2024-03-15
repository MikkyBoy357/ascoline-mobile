import 'package:ascolin/base/api_service.dart';
import 'package:ascolin/base/token.dart';
import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/transaction_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TransactionViewModel extends ChangeNotifier {
  List<TransactionModel> transactionList = [];
  List<TransactionModel> searchList = [];
  bool transactionsLoading = false;

  var api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // DropDown
  // String selectedUnit =

  // Search order
  String keyword = '';

  void setKeyword(String val) {
    keyword = val;
    if (keyword.isNotEmpty) {
      searchProduct();
    }
    notifyListeners();
  }

  void searchProduct() {
    // Set products loading to true
    transactionsLoading = true;

    String lowercaseKeyword = keyword.toLowerCase();

    List<TransactionModel> searchResult = transactionList
        .where((item) => (item.name?.toLowerCase().contains(lowercaseKeyword) ==
                true ||
            item.reference?.toLowerCase().contains(lowercaseKeyword) == true ||
            item.amount == num.tryParse(lowercaseKeyword)))
        .toList();

    searchList = searchResult;

    // Set transactions loading to false
    transactionsLoading = false;

    notifyListeners();
  }

  Future<void> getTransactions() async {
    final String endpointUrl = '/transactions/my';

    try {
      // Set transactions loading to true
      transactionsLoading = true;

      final TokenModel? tokenModel = await checkAndGetToken();

      final response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing orderList
        transactionList.clear();

        print(response.data[0]["item"]);
        // Process the JSON response and add data to transactionList
        List<dynamic> data = response.data;
        transactionList.addAll(
            data.map((json) => TransactionModel.fromJson(json)).toList());

        // Notify listeners about the changes in transactionList
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load transactions: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching transactions: $error');
    } finally {
      // Set products loading to false
      transactionsLoading = false;
    }
  }
}
