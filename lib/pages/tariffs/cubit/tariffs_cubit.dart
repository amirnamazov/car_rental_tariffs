import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tariff_app/model/common_state.dart';
import 'package:tariff_app/model/tariff_model.dart';
import 'package:tariff_app/services/request.dart';
import 'package:tariff_app/services/request_api.dart';
import 'package:tariff_app/utils/internet_connection.dart';

class TariffsCubit extends Cubit<CommonState> {
  TariffsCubit() : super(LoadingState());

  List<TariffModel> tariffs = [];

  getData() {
    InternetConnection.check().then((available) {
      if (available) {
        fetchTariffs();
      } else {
        emit(InternetErrorState());
      }
    });
  }

  fetchTariffs() {
    RequestClient().get(
      endPoint: RequestApi.tariffs,
      onSuccess: (statusCode, response) async {

        tariffs.clear();
        List<dynamic> list = json.decode(response!);
        list.forEach((tariff) {
          tariffs.add(TariffModel.fromJson(tariff));
        });
        tariffs.shuffle();
        print("onSuccess");
        emit(ContentState());
      },
      onFailure: (statusCode, response) {
        print("onFailure");
        emit(ErrorState());
      },
      onError: (response) {
        print("onError");
        emit(ErrorState());
      },
      onComplete: () {
        print("onComplete");
      }
    );
  }
}