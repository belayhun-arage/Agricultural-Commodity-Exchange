import "../../libs.dart";

class NotificationState {}

class NotificationsInit extends NotificationState {}


class NotificationsLoadFailure extends NotificationState {}

class NotificationsLoadSuccess extends NotificationState {
  List<NotificationResponse> transactions;
  int transaction_notifications=0;
  int guarantee_notifications=0;
  int kebd_notifications=0;

  NotificationsLoadSuccess(this.transactions);


  generateCount(){
    for (final tr in this.transactions){
      if (tr.guaranteeNotification!= null ){
        this.guarantee_notifications++;
      }else if (tr.transactionRequest!= null){
        this.transaction_notifications++;
      }else if (tr.kebdRequest!= null ){
        this.kebd_notifications++;
      }
    }
  }
}
