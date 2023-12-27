import 'package:ascolin/pages/order_list_screen.dart';

class ActionModel {
  final String icon;
  final String label;
  final String description;
  final dynamic nextPage; // Widget or String

  ActionModel({
    required this.icon,
    required this.label,
    required this.description,
    required this.nextPage,
  });
}

List<ActionModel> actionItems = [
  ActionModel(
    icon: 'assets/home1.png',
    label: "Service client",
    description:
        "Notre ligne de service client est disponible 24h/7j. Appuyez pour nous écrire sur Whatsapp",
    nextPage: 'https://wa.me/22963000751',
  ),
  ActionModel(
    icon: 'assets/home2.png',
    label: "Mes commandes",
    description:
        "Demande d'un chauffeur pour récupérer ou livrer votre colis à votre place",
    nextPage: OrderListScreen(),
  ),
  // ActionModel(
  //   icon: 'assets/home3.png',
  //   label: "Fund your wallet",
  //   description:
  //       "To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today",
  //   nextPage: DeliverySuccessful(),
  // ),
  // ActionModel(
  //   icon: 'assets/home4.png',
  //   label: "Book a Rider",
  //   description: "Search for available driver within your area",
  //   nextPage: Placeholder(),
  // ),
];
