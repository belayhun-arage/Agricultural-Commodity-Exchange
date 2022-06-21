import "../../libs.dart";

class MerchantsEvent {}

class MerchantsLoadEvent extends MerchantsEvent {}

class MerchantAddEvent extends MerchantsEvent {
  Merchant merchant;
  MerchantAddEvent(this.merchant);
}