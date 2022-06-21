import "../../libs.dart";

class IndexBloc extends Bloc<int, int> {
  IndexBloc() : super(0) {
    on<int>((event, emit) {
      emit(event);
    });
  }
}
