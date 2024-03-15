import 'package:ascolin/base/constant.dart';
import 'package:ascolin/model/product_model.dart';
import 'package:ascolin/model/product_order_model.dart';
import 'package:ascolin/pages/product_order_detail_screen.dart';
import 'package:ascolin/view_model/product_view_model.dart';
import 'package:ascolin/widgets/custom_loading.dart';
import 'package:ascolin/widgets/name_text_field.dart';
import 'package:ascolin/widgets/product_order_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<ProductViewModel>(context, listen: false).getProducts();
    Provider.of<ProductViewModel>(context, listen: false).getProductOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ProductViewModel>(
      builder: (context, productViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Liste des produits",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  NameTextField(
                    controller: searchController,
                    hintText: "Recherche ...",
                    onChanged: (val) => productViewModel.setKeyword(val),
                  ),
                  SizedBox(height: 10),
                  TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF309D9E),
                    ),
                    labelColor: const Color(0xFF309D9E),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF309D9E),
                    ),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF309D9E),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return const Color(0xFF309D9E).withOpacity(0.1);
                      },
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1,
                    tabs: const [
                      Tab(
                        text: 'Disponibles',
                      ),
                      Tab(
                        text: 'Commandes',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      Builder(builder: (context) {
                        if (productViewModel.productsLoading) {
                          return CustomLoading();
                        } else if (productViewModel.keyword.isEmpty) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: productViewModel.productList.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              final ProductModel currentProduct =
                                  productViewModel.productList[index];

                              return ProductCard(
                                product: currentProduct,
                              );
                            },
                          );
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: productViewModel.searchList.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              final ProductModel currentProduct =
                                  productViewModel.searchList[index];

                              return ProductCard(
                                product: currentProduct,
                              );
                            },
                          );
                        }
                      }),
                      Builder(builder: (context) {
                        if (productViewModel.productOrdersLoading) {
                          return CustomLoading();
                        } else if (productViewModel.keyword.isEmpty) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: productViewModel.productOrderList.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              final ProductOrderModel currentProductOrder =
                                  productViewModel.productOrderList[index];

                              return ProductOrderCard(
                                productOrder: currentProductOrder,
                              );
                            },
                          );
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                productViewModel.productOrderSearchList.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              final ProductOrderModel currentProductOrder =
                                  productViewModel
                                      .productOrderSearchList[index];

                              return ProductOrderCard(
                                productOrder: currentProductOrder,
                              );
                            },
                          );
                        }
                      }),
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 300,
      //width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.12,
                child: (product.images ?? []).isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Image.network(
                              product.images?[index] ?? '',
                              //height: 70,
                              //width: 120,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                child: Icon(Icons.image_not_supported_outlined),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Icon(Icons.image_not_supported_outlined),
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // Add other desired styles for the second text here
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '${product.description}',
                        style: TextStyle(
                          //overflow: TextOverflow.ellipsis,
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${product.quantity} en stock',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${product.price} F CFA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )),
              /*Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Nom du produit: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                // Add other desired styles for the first text here
                              ),
                            ),
                            TextSpan(
                              text: '${product.name}',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          '${product.description}',
                          style: TextStyle(
                            //overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantité disponible:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${product.quantity}',
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
                      Text(
                        'Prix:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${product.price} F CFA',
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: (product.quantity ?? 0) > 0,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: ProductOrderCreateDialog(
                                    product: product,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF04009A),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    'Acheter',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),*/
            ],
          ),
          Divider(),
          Visibility(
            visible: (product.quantity ?? 0) > 0,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: ProductOrderCreateDialog(
                        product: product,
                      ),
                    );
                  },
                );
              },
              child: Container(
                //width: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF04009A),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    'Acheter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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

class ProductOrderCard extends StatelessWidget {
  final ProductOrderModel productOrder;

  const ProductOrderCard({super.key, required this.productOrder});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Reférence ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        // Add other desired styles for the first text here
                      ),
                    ),
                    TextSpan(
                      text: '${productOrder.reference}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nom du produit :',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${productOrder.product?.name ?? '-'}',
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
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantité :',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${productOrder.quantity}',
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
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prix:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${productOrder.price} F CFA',
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Constant.navigatePush(
                    context,
                    ProductOrderDetailScreen(
                      productOrder: productOrder,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF04009A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Voir détails',
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
