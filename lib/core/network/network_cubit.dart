import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// States
abstract class NetworkState extends Equatable {
  const NetworkState();
  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}
class NetworkConnected extends NetworkState {}
class NetworkDisconnected extends NetworkState {}

// Cubit
class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  NetworkCubit() : super(NetworkInitial()) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.none)) {
        emit(NetworkDisconnected());
      } else {
        emit(NetworkConnected());
      }
    });
  }

  Future<void> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) {
      emit(NetworkDisconnected());
    } else {
      emit(NetworkConnected());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
