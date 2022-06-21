import 'package:agri_net_frontend/libs.dart';

class StoreState {}

class MyStoresInit extends StoreState {}

class LoadingMyStoresState extends StoreState {}

class MyStoresLoadedState extends StoreState {
  Map<int, List<Store>> myStores;
  MyStoresLoadedState({required this.myStores});
}

class LoadingStoresFailedState extends StoreState {
  int statusCode;
  String msg;
  LoadingStoresFailedState({required this.statusCode, required this.msg});
}
