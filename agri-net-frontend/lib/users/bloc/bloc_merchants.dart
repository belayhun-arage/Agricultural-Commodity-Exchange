import 'package:agri_net_frontend/users/repository/merchant_repo.dart';

import '../../libs.dart';

class MercahntsBloc extends Bloc<MerchantsEvent, MerchantsState>
    implements Cubit<MerchantsState> {
  MerchantRepo merchantRepo;
  MercahntsBloc({required this.merchantRepo}) : super(MerchantsInItState()) {
    on<LoadMyMerchantsEvent>((event, emit) async {
      if (!(this.state is MerchantsLoadedState)) {
        emit(MerchantsLoadingState());
      }
      final response = await merchantRepo.getMerchants(event.adminID);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (this.state is MerchantsLoadedState) {
          (this.state as MerchantsLoadedState)
              .merchants
              .addAll(response.merchants);
          emit(this.state);
        } else {
          emit(MerchantsLoadedState(merchants: response.merchants));
        }
      } else {
        emit(MerchantsLoadingFailedState(
            statusCode: response.statusCode, msg: response.msg));
      }
    });
    on<AddNewMerchant>((event, emit) {
      if (this.state is MerchantsLoadedState) {
        (this.state as MerchantsLoadedState).merchants.add(event.merchant);
        emit(this.state);
      }
    });
    on<DeleteMerchantEvent>((event, emit) async {
      final response = await merchantRepo.deleteMerchant(event.userID);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var merchants = (this.state as MerchantsLoadedState).merchants;
        for (int i = 0; i < merchants.length; i++) {
          if (merchants[i].id == event.userID) {
            merchants.remove(merchants[i]);
          }
        }
        emit(MerchantsLoadedState(merchants: merchants));
      } else {
        emit(MerchantDeleteFailed(
            statusCode: response.statusCode, msg: response.msg));
      }
    });
  }

  Future<UserRegisterResponse> registerMerchant(
      CreatNewMerchantEvent creatNewMerchantEvent) async {
    final newMerchantResponce = await merchantRepo.creatNewMerchant(
        creatNewMerchantEvent.firstname,
        creatNewMerchantEvent.lastname,
        creatNewMerchantEvent.email!,
        creatNewMerchantEvent.phone,
        creatNewMerchantEvent.city,
        creatNewMerchantEvent.kebele,
        creatNewMerchantEvent.woreda,
        creatNewMerchantEvent.zone,
        creatNewMerchantEvent.region,
        creatNewMerchantEvent.unique_address,
        creatNewMerchantEvent.latitude,
        creatNewMerchantEvent.longitude);
    return newMerchantResponce;
  }
}
