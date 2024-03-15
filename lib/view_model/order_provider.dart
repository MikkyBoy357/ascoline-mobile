import 'package:ascolin/base/api_service.dart';
import 'package:ascolin/base/token.dart';
import 'package:ascolin/model/country_model.dart';
import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/package_model.dart';
import '../model/transport_model.dart';
import '../model/unit_model.dart';
import '../widgets/error_dialog.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];
  List<OrderModel> searchList = [];

  List<UnitModel> measureUnits = [UnitModel(label: "A")];
  List<CountryModel> countries = [];
  List<TransportModel> transportTypes = [];
  List<PackageModel> packageTypes = [];

  bool ordersLoading = false;
  bool paymentLoading = false;

  String paymentNetwork = "MTN";
  String paymentPhone = "";
  num paymentStep = 1;

  var api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // DropDown
  // String selectedUnit =

  GlobalKey<FormState> orderFormKey = GlobalKey<FormState>(debugLabel: "order");

  // Search order
  String keyword = '';

  void setKeyword(String val) {
    keyword = val;
    if (keyword.isNotEmpty) {
      searchComande();
    }
    notifyListeners();
  }

  void setPaymentNetwork(String val) {
    paymentNetwork = val;
    notifyListeners();
  }

  void setPaymentStep(num val) {
    paymentStep = val;
    notifyListeners();
  }

  void setPaymentPhone(String val) {
    paymentPhone = val;
    notifyListeners();
  }

  void searchComande() {
    ordersLoading = true;
    String lowercaseKeyword = keyword.toLowerCase();

    List<OrderModel> searchResult = orderList
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

    searchList = searchResult;
    ordersLoading = false;
    notifyListeners();
  }

  // Create Order variables
  String description = '';
  String tracking = '';
  UnitModel? unite;
  String quantite = '';
  String? pays;
  String ville = '';
  TransportModel? typeTransport;
  PackageModel? typeColis;
  String specialNote = '';
  // ... add more variables as needed

  void setDescription(String val) {
    description = val;
    notifyListeners();
  }

  void setTracking(String val) {
    tracking = val;
    notifyListeners();
  }

  void setUnite(UnitModel val) {
    unite = val;
    notifyListeners();
  }

  void setQuantite(String val) {
    quantite = val;
    notifyListeners();
  }

  void setPays(String val) {
    pays = val;
    notifyListeners();
  }

  void setVille(String val) {
    ville = val;
    notifyListeners();
  }

  void setTypeTransport(TransportModel val) {
    typeTransport = val;
    notifyListeners();
  }

  void setTypeColis(PackageModel val) {
    typeColis = val;
    notifyListeners();
  }

  void setSpecialNote(String val) {
    specialNote = val;
    notifyListeners();
  }

  Future<void> getOrders() async {
    final String endpointUrl = '/commandes/my';

    try {
      // Set loading orders to true
      ordersLoading = true;

      final dio = Dio();
      final response = await api.dio.get(
        endpointUrl,
      );

      if (response.statusCode == 200) {
        // Clear the existing orderList
        orderList.clear();

        // Process the JSON response and add data to orderList
        List<dynamic> data = response.data;
        orderList
            .addAll(data.map((json) => OrderModel.fromJson(json)).toList());

        // Notify listeners about the changes in orderList
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load orders: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          print("401 ");
        }
      }
      print('Error occurred while fetching orders: $error');
    } finally {
      // Set loading orders to false
      ordersLoading = false;
    }
  }

  Future<void> createOrder(BuildContext context) async {
    if ((orderFormKey.currentState?.validate() ?? false) == false) {
      print("Invalid Fields");
      return showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'Invalid Text Fields',
          );
        },
      );
    }

    try {
      print("=====> Create Order <=====");

      final UserModel? userData = await checkAndGetUser();
      final String endpointUrl = '/commandes';

/*      UserModel userData =
          Provider.of<AuthViewModel>(context, listen: false).userData;*/

      final Map<String, dynamic> data = {
        'trackingId': tracking,
        'typeColis': typeColis?.id,
        'transportType': typeTransport?.id,

        'client': userData?.id,
        'description': description,
        'unit': unite?.id,
        'pays': pays,
        'quantity': quantite,
        'ville': ville,
        'status': 'En attente de confirmation',
        'specialNote': specialNote,
        // Add more fields here as needed
      };

      print("== JSON Body ==> ${data}");

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
              text: "Order created successfully",
            );
          },
        );
        getOrders();
      } else {
        print('Failed to create order: ${response.statusCode}');
        // Handle failure or other status codes here
      }
    } on DioException catch (error) {
      print('Error occurred: $error');
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: "${error.response!.data['message']}",
          );
        },
      );
    }
  }

  Future<void> getMeasureUnits() async {
    final String endpointUrl = '/measureUnits?limit=0';

    try {
      final TokenModel? tokenModel = await checkAndGetToken();

      final response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing measureUnits list
        measureUnits.clear();

        // Parse the JSON response and add units to measureUnits list
        List<dynamic> data = response.data['measureUnits'];
        measureUnits
            .addAll(data.map((json) => UnitModel.fromJson(json)).toList());

        // Notify listeners about the changes in measureUnits
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load measure units: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching measure units: $error');
    }
  }

  Future<void> getCountries() async {
    final String endpointUrl = '/countries?limit=0';

    try {
      final TokenModel? tokenModel = await checkAndGetToken();

      final Response response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing countries list
        countries.clear();

        // Process the JSON response and add data to countries list
        List<dynamic> data = response.data['countries'];
        countries
            .addAll(data.map((json) => CountryModel.fromJson(json)).toList());

        // Notify listeners about the changes in countries list
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load countries: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching countries: $error');
    }
  }

  Future<void> getTransportTypes() async {
    final String endpointUrl = '/transportTypes?limit=0';

    try {
      final TokenModel? tokenModel = await checkAndGetToken();
      final Response response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing transportTypes list
        transportTypes.clear();

        // Process the JSON response and add data to transportTypes list
        List<dynamic> data = response.data["transportTypes"];
        transportTypes
            .addAll(data.map((json) => TransportModel.fromJson(json)).toList());

        // Notify listeners about the changes in transportTypes list
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load transport types: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching transport types: $error');
    }
  }

  Future<void> getPackageTypes() async {
    final String endpointUrl = '/packageTypes?limit=0';

    try {
      final TokenModel? tokenModel = await checkAndGetToken();
      final Response response = await api.dio.get(
        endpointUrl,
        options:
            Options(headers: {'Authorization': 'Bearer ${tokenModel?.token}'}),
      );

      if (response.statusCode == 200) {
        // Clear the existing packageTypes list
        packageTypes.clear();

        // Process the JSON response and add data to packageTypes list
        List<dynamic> data = response.data['packageTypes'];
        packageTypes
            .addAll(data.map((json) => PackageModel.fromJson(json)).toList());

        // Notify listeners about the changes in packageTypes list
        notifyListeners();
      } else {
        // Handle other status codes or errors here
        print('Failed to load package types: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or errors here
      print('Error occurred while fetching package types: $error');
    }
  }

  void getDropLists() async {
    print("========> Init Dropdowns <=========");
    await getMeasureUnits();
    await getTransportTypes();
    await getPackageTypes();
    await getCountries();
    print("========> Init Dropdowns <==DONE==");
  }

  Future<void> payOrder(BuildContext context, OrderModel order) async {
    try {
      print("=====> Make Payment <=====");
      final TokenModel? tokenModel = await checkAndGetToken();
      final UserModel? userData = await checkAndGetUser();
      final String endpointUrl = '/commandes/pay';

      final Map<String, dynamic> data = {
        'amount': (order.pricing?.price ?? 0) * (order.quantity ?? 0),
        'phoneNumber': "229$paymentPhone",
        'network': paymentNetwork,
        'orderId': order.sId,
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
              text: "Paiement commande ${order.trackingId} validé",
            );
          },
        );

        getOrders();
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
