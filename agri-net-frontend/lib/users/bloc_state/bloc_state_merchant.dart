import '../../libs.dart';

class MerchantsState {}

class MerchantsInItState extends MerchantsState {}

class MerchantsLoadedState extends MerchantsState {
  List<Merchant> merchants;
  MerchantsLoadedState({required this.merchants});
}

class MerchantsLoadingState extends MerchantsState {}

class MerchantsLoadingFailedState extends MerchantsState {
  int statusCode;
  String msg;
  MerchantsLoadingFailedState({required this.statusCode, required this.msg});
}

class MerchaneDeleteSuccess extends MerchantsState {
  int statusCode;
  String msg;
  MerchaneDeleteSuccess({required this.statusCode, required this.msg});
}

class DeletingMerchantOnProgress extends MerchantsState {}

class MerchantDeleteFailed extends MerchantsState {
  int statusCode;
  String msg;
  MerchantDeleteFailed({required this.statusCode, required this.msg});
}
