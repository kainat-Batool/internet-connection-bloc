import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_in_flutter/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_in_flutter/blocs/internet_bloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            add(InternetGainedEvent());
          } else {
            add(InternetLostEvent());
          }
        });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
