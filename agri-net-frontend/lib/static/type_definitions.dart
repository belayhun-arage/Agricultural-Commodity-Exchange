import 'package:agri_net_frontend/libs.dart';
import "package:flutter/material.dart";

enum AdminActionType {
  registration,
  approval,
}

enum PaymentStatus {
  PaymentStatusNotSent,
  PaymentStatusSent,
  PaymentStatusSeen,
  PaymentStatusAccepted,
  PaymentStatusRejected,
}

List<String> paymentStatusMessages = [
  "Created",
  "Sent",
  "Seen",
  "Accepted",
  "Rejected",
];

List<Color> paymentStatusColors = [
  Colors.grey,
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.red,
];

List<IconData> paymentStatusIcons = [
  Icons.create,
  Icons.send,
  Icons.double_arrow,
  Icons.check,
  Icons.wrong_location_outlined,
];

// SIDE BAR ITEMS
class NavigationModel {
  String title;
  IconData icon;
  String? path;

  NavigationModel(this.title, this.icon, {this.path}) {}
}

List<NavigationModel> superAdminSideBarItems = [
  NavigationModel("Products", Icons.home, path: ProductScreen.RouteName),
  NavigationModel("Admins", Icons.people, path: AdminsScreen.RouteName),
  NavigationModel("Search", Icons.search),
  NavigationModel(
    "Notifications",
    Icons.notifications,
  ),
  NavigationModel("Sttings", Icons.settings),
  NavigationModel("Log Out", Icons.logout, path: AuthScreen.RouteName),
];

List<NavigationModel> adminSideBarItems = [
  NavigationModel("Products", Icons.home, path: ProductScreen.RouteName),
  NavigationModel("Merchants", Icons.store,
      path: RegisteredMerchantsScreen.RouteName),
  NavigationModel("Agents", Icons.person),
  NavigationModel("Search", Icons.search),
  NavigationModel(
    "Notifications",
    Icons.notifications,
  ),
  NavigationModel("Sttings", Icons.settings),
  NavigationModel("Log Out", Icons.logout),
];

List<NavigationModel> merchantSideBarItems = [
  NavigationModel("Products", Icons.home, path: ProductScreen.RouteName),
  NavigationModel("My Stores", Icons.store),
  NavigationModel("My Produts", Icons.store),
  NavigationModel(
    "Contracts",
    Icons.person,
  ),
  NavigationModel("Search", Icons.search),
  NavigationModel("Notifications", Icons.notifications),
  NavigationModel("Sttings", Icons.settings),
  NavigationModel("Log Out", Icons.logout),
];

List<NavigationModel> agentSideBarItems = [
  NavigationModel("Products", Icons.home, path: ProductScreen.RouteName),
  NavigationModel("My Produts", Icons.store),
  NavigationModel(
    "Contracts",
    Icons.person,
  ),
  NavigationModel("Search", Icons.search),
  NavigationModel("Notifications", Icons.notifications),
  NavigationModel("Sttings", Icons.settings),
  NavigationModel("Log Out", Icons.logout),
];
