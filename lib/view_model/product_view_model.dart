import 'package:ascolin/base/api_service.dart';
import 'package:ascolin/base/token.dart';
import 'package:ascolin/model/product_model.dart';
import 'package:ascolin/model/product_order_model.dart';
import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:ascolin/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> searchList = [];
  bool productsLoading = false;

  List<ProductOrderModel> productOrderList = [];
  List<ProductOrderModel> productOrderSearchList = [];
  bool productOrdersLoading = false;

  bool paymentLoading = false;

  String paymentNetwork = "MTN";
  String paymentPhone = "";
  num quantity = 1;
  num paymentStep = 1;

  // For createProductOrder
  String specialNote = "";

  var api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void setPaymentNetwork(String val) {
    paymentNetwork = val;
    notifyListeners();
  }

  void setPaymentStep(num val) {
    paymentStep = val;
    notifyListeners();
  }

  void setPaymentQuantity(num val) {
    quantity = val;
    notifyListeners();
  }

  void setPaymentPhone(String val) {
    paymentPhone = val;
    notifyListeners();
  }

  void setSpecialNote(String val) {
    specialNote = val;
    notifyListeners();
  }

  // Search order
  String keyword = '';

  void setKeyword(String val) {
    keyword = val;
    if (keyword.isNotEmpty) {
      searchProduct();
      searchProductOrders();
    }
    notifyListeners();
  }

  void searchProduct() {
    // Set products loading to true
    productsLoading = true;

    String lowercaseKeyword = keyword.toLowerCase();

    List<ProductModel> searchResult = productList
        .where((item) =>
            (item.name?.toLowerCase().contains(lowercaseKeyword) == true ||
                item.description?.toLowerCase().contains(lowercaseKeyword) ==
                    true ||
                item.price == num.tryParse(lowercaseKeyword) ||
                item.quantity == num.tryParse(lowercaseKeyword)))
        .toList();

    searchList = searchResult;

    // Set products loading to false
    productsLoading = false;

    notifyListeners();
  }

  void searchProductOrders() {
    productOrdersLoading = true;
    String lowercaseKeyword = keyword.toLowerCase();

    List<ProductOrderModel> searchResult = productOrderList
        .where((item) =>
            item.client != null &&
            (item.client!.id?.toLowerCase().contains(lowercaseKeyword) ==
                    true ||
                item.client!.firstName
                        ?.toLowerCase()
                        .contains(lowercaseKeyword) ==
                    true ||
                item.client!.lastName
                        ?.toLowerCase()
                        .contains(lowercaseKeyword) ==
                    true ||
                item.client!.email?.toLowerCase().contains(lowercaseKeyword) ==
                    true ||
                item.client!.phone?.toLowerCase().contains(lowercaseKeyword) ==
                    true ||
                item.client!.address
                        ?.toLowerCase()
                        .contains(lowercaseKeyword) ==
                    true))
        .toList();

    productOrderSearchList = searchResult;
    productOrdersLoading = false;
    notifyListeners();
  }

  Future<void> getProducts() async {
    final String endpointUrl = '/products?limit=0';

    try {
      // Set products loading to true
      productsLoading = true;

      final TokenModel? tokenModel = await checkAndGetToken();

      final response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing orderList
        productList.clear();

        // Process the JSON response and add data to orderList
        List<dynamic> data = response.data["products"];
        productList
            .addAll(data.map((json) => ProductModel.fromJson(json)).toList());

        // Notify listeners about the changes in productList
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching products: $error');
    } finally {
      // Set products loading to false
      productsLoading = false;
    }
  }

  Future<void> getProductOrders() async {
    final String endpointUrl = '/productOrders/my';

    try {
      // Set loading orders to true
      productOrdersLoading = true;

      final dio = Dio();
      final response = await api.dio.get(
        endpointUrl,
      );

      if (response.statusCode == 200) {
        // Clear the existing orderList
        productOrderList.clear();

        // Process the JSON response and add data to orderList
        List<dynamic> data = response.data;
        productOrderList.addAll(
            data.map((json) => ProductOrderModel.fromJson(json)).toList());

        // Notify listeners about the changes in orderList
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load product orders: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          print("401 ");
        }
      }
      print('Error occurred while fetching product orders: $error');
    } finally {
      // Set loading orders to false
      productOrdersLoading = false;
    }
  }

  Future<void> createProductOrder(
      BuildContext context, ProductModel product) async {
    try {
      print("=====> Create Product Order <=====");

      final UserModel? userData = await checkAndGetUser();
      final String endpointUrl = '/productOrders';

      final Map<String, dynamic> data = {
        'product': product.sId,
        'client': userData?.id,
        'quantity': quantity,
        'price': product.price,
        'total': quantity * (product.price ?? 0),
        'status': 'Enregistrée',

        // Add more fields here as needed
      };

      if (specialNote.isNotEmpty) {
        data["specialNote"] = specialNote;
      }

      print("== JSON Body ==> ${data}");

      paymentLoading = true;
      notifyListeners();

      final Response response = await api.dio.post(
        endpointUrl,
        data: data,
      );

      if (response.statusCode == 201) {
        print('Order created successfully');

        Navigator.pop(context);
        // Handle successful order creation here
        showDialog(
          context: context,
          builder: (context) {
            return SuccessDialog(
              text: "Commande de produit réalisée avec succès",
            );
          },
        );
        getProducts();
        getProductOrders();
      } else {
        print('Failed to create product order: ${response.statusCode}');
        // Handle failure or other status codes here
      }
    } on DioException catch (error, stackTrace) {
      print('Error occurred: $error');
      print('Error occurred: ${error.response}');
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text:
                "${error.response?.data is Map ? error.response?.data['message'] : "Une erreur est survenue"}",
          );
        },
      );
    } finally {
      paymentLoading = false;
      notifyListeners();
    }
  }

  Future<void> payProductOrder(
      BuildContext context, ProductOrderModel productOrder) async {
    try {
      print("=====> Make Payment <=====");
      final TokenModel? tokenModel = await checkAndGetToken();
      final UserModel? userData = await checkAndGetUser();
      final String endpointUrl = '/productOrders/pay';

      final Map<String, dynamic> data = {
        'amount': (productOrder.price ?? 0) * (productOrder.quantity ?? 0),
        'phoneNumber': "229$paymentPhone",
        'network': paymentNetwork,
        'productOrderId': productOrder.sId,
      };

      print("== JSON Body ==> $data");

      paymentLoading = true;
      notifyListeners();
      final Response response = await api.dio.post(
        endpointUrl,
        data: data,
      );

      print(response.data);
      if (response.statusCode == 200) {
        print('Payment  success');
        Navigator.pop(context);
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return SuccessDialog(
              text: "Paiement commande ${productOrder.reference} validé",
            );
          },
        );

        getProductOrders();
      } else {
        print('Failed to make payment: ${response.statusCode}');
        // Handle failure or other status codes here
      }
    } on DioException catch (error) {
      print('Error occurred: $error');

      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text:
                "${error.response?.data['message'] ?? "Une erreur est survenue"}",
          );
        },
      );
    } finally {
      paymentLoading = false;
      notifyListeners();
    }
  }
}
