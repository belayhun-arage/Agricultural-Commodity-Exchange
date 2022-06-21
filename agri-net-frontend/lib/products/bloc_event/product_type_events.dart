import "../../libs.dart";

class ProductTypeEvent{}

class ProductTypesLoadEvent extends ProductTypeEvent{}

class SearchProductTypeEvent extends ProductTypeEvent{
  String text;
  SearchProductTypeEvent(this.text);
}

class ProductTypeUpdateEvent extends ProductTypeEvent{
  ProductTypeUpdate update;
  ProductTypeUpdateEvent(this.update);
}