import "../../libs.dart";

class TransactionEvent {}

class TransactionLoadEvent extends TransactionEvent {}

class TransactionAddEvent extends TransactionEvent {
  Transaction transaction;

  TransactionAddEvent(this.transaction);
}
