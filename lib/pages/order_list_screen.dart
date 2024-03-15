import 'package:ascolin/base/constant.dart';
import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/view_model/order_provider.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_detail_screen.dart';
import 'send_a_package_page.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<OrderProvider>(context, listen: false).getOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Liste des commandes"),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Mes commandes",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: NameTextField(
                          controller: searchController,
                          hintText: "Recherche ...",
                          onChanged: (val) => orderProvider.setKeyword(val),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Constant.navigatePush(context, SendAPackagePage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: Color(0xFF0560FA),
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (orderProvider.ordersLoading) {
                        return CustomLoading();
                      } else if (orderProvider.keyword.isEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: orderProvider.orderList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final OrderModel currentOrder =
                                orderProvider.orderList[index];

                            return OrderCard(
                              order: currentOrder,
                            );
                          },
                        );
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderProvider.searchList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final OrderModel currentOrder =
                                orderProvider.searchList[index];

                            return OrderCard(
                              order: currentOrder,
                            );
                          },
                        );
                      }
                    }),
                  ),
                  /*Builder(builder: (context) {
                    if (orderProvider.ordersLoading) {
                      return CustomLoading();
                    } else if (orderProvider.keyword.isEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderProvider.orderList.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final OrderModel currentOrder =
                              orderProvider.orderList[index];

                          return OrderCard(
                            order: currentOrder,
                          );
                        },
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderProvider.searchList.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final OrderModel currentOrder =
                              orderProvider.searchList[index];

                          return OrderCard(
                            order: currentOrder,
                          );
                        },
                      );
                    }
                  }),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 300,
      width: size.width,
      //padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tracking: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          // Add other desired styles for the first text here
                        ),
                      ),
                      TextSpan(
                        text: '${order.trackingId}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          // Add other desired styles for the second text here
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: (order.status == 'Réceptionnée' ||
                            order.status == 'Arrivée' ||
                            order.status == 'Livrée')
                        ? Colors.green
                        : Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      '${order.status}',
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
          ),
          Divider(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bénin',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        'assets/earth-plane.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${order.pays}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${order.ville}',
                          style: TextStyle(
                            color: Colors.black, // Text color
                            fontSize: 14, // Adjust the font size as needed
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Transport par ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          '${order.transportType?.label}',
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
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(
              15,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {
                  Constant.navigatePush(
                    context,
                    OrderDetailScreen(
                      order: order,
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  decoration: BoxDecoration(
                    color: Color(0xFF04009A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Voir details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
