import 'package:ascolin/model/country_model.dart';
import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:ascolin/view_model/auth_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/constant.dart';
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

  // DropDown
  // String selectedUnit =

  GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();

  // Search order
  String keyword = '';

  void setKeyword(String val) {
    keyword = val;
    if (keyword.isNotEmpty) {
      searchComande();
    }
    notifyListeners();
  }

  void searchComande() {
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
    notifyListeners();
  }

  // Create Order variables
  String description = '';
  String tracking = '';
  String? unite;
  String quantite = '';
  String? pays;
  String ville = '';
  String? typeTransport;
  String? typeColis;
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

  void setUnite(String val) {
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

  void setTypeTransport(String val) {
    typeTransport = val;
    notifyListeners();
  }

  void setTypeColis(String val) {
    typeColis = val;
    notifyListeners();
  }

  void setSpecialNote(String val) {
    specialNote = val;
    notifyListeners();
  }

  Future<void> getOrders() async {
    final String endpointUrl = '${Constant.baseUrl}/commandes';

    try {
      final dio = Dio();
      final response = await dio.get(endpointUrl);

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
      print('Error occurred while fetching orders: $error');
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
      final String endpointUrl = '${Constant.baseUrl}/commandes';
      final Dio dio = Dio();

      UserModel userData =
          Provider.of<AuthViewModel>(context, listen: false).userData;

      final Map<String, dynamic> data = {
        'trackingId': tracking,
        'typeColis': typeColis,
        'transportType': typeTransport,
        // Add more fields here by injecting variables
        'client': userData.id,
        'description': description,
        'unit': unite,
        'pays': pays,
        'quantity': quantite,
        'ville': ville,
        'status': 'Réceptionné en Chine',
        'specialNote': specialNote,
        // Add more fields here as needed
      };

      print("== JSON Body ==> ${data}");

      final Response response = await dio.post(
        endpointUrl,
        data: data,
      );

      print(response.data);
      if (response.statusCode == 201) {
        print('Order created successfully');
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
    final String endpointUrl = '${Constant.baseUrl}/measureUnits';

    try {
      final dio = Dio();
      final response = await dio.get(endpointUrl);

      if (response.statusCode == 200) {
        // Clear the existing measureUnits list
        measureUnits.clear();

        // Parse the JSON response and add units to measureUnits list
        List<dynamic> data = response.data;
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
    final String endpointUrl = '${Constant.baseUrl}/countries';

    try {
      final Dio dio = Dio();
      final Response response = await dio.get(endpointUrl);

      if (response.statusCode == 200) {
        // Clear the existing countries list
        countries.clear();

        // Process the JSON response and add data to countries list
        List<dynamic> data = response.data;
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
    final String endpointUrl = '${Constant.baseUrl}/transportTypes';

    try {
      final Dio dio = Dio();
      final Response response = await dio.get(endpointUrl);

      if (response.statusCode == 200) {
        // Clear the existing transportTypes list
        transportTypes.clear();

        // Process the JSON response and add data to transportTypes list
        List<dynamic> data = response.data;
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
    final String endpointUrl = '${Constant.baseUrl}/packageTypes';

    try {
      final Dio dio = Dio();
      final Response response = await dio.get(endpointUrl);

      if (response.statusCode == 200) {
        // Clear the existing packageTypes list
        packageTypes.clear();

        // Process the JSON response and add data to packageTypes list
        List<dynamic> data = response.data;
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
}
