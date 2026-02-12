import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/inspection_model.dart';

// Events
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchHomeData extends HomeEvent {}

class LoadMoreInspections extends HomeEvent {}

// States
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<InspectionModel> inspections;
  const HomeLoaded(this.inspections);
  @override
  List<Object?> get props => [inspections];
}

class HomePaginationLoading extends HomeLoaded {
  const HomePaginationLoading(super.inspections);
}

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      await Future.delayed(const Duration(seconds: 1));
      final dummyData = List.generate(
        10,
        (index) => InspectionModel(
          customerName: "Customer ${index + 1}",
          address: "Address ${index + 1}, City",
          date: "2024-02-11",
          status: index % 3 == 0
              ? "Pending"
              : index % 3 == 1
                  ? "Completed"
                  : "Upcoming",
          vehicleNumber: "MH 12 AB ${1000 + index}",
          vehicleModel: index % 2 == 0 ? "Swift VXI" : "Creta SX",
          phone: "987654321${index % 10}",
          inspectionType: index % 2 == 0 ? "PDI" : "Stock",
        ),
      );
      emit(HomeLoaded(dummyData));
    });

    on<LoadMoreInspections>((event, emit) async {
      if (state is HomeLoaded && state is! HomePaginationLoading) {
        final currentInspections = (state as HomeLoaded).inspections;
        emit(HomePaginationLoading(currentInspections));

        await Future.delayed(const Duration(seconds: 1));

        final moreData = List.generate(
          10,
          (index) => InspectionModel(
            customerName: "Customer ${currentInspections.length + index + 1}",
            address: "Address ${currentInspections.length + index + 1}, City",
            date: "2024-02-12",
            status: index % 3 == 0
                ? "Pending"
                : index % 3 == 1
                    ? "Completed"
                    : "Upcoming",
            vehicleNumber: "MH 12 AB ${2000 + index}",
            vehicleModel: index % 2 == 0 ? "Verna S+" : "XUV 700",
            phone: "987654322${index % 10}",
            inspectionType: index % 2 == 0 ? "PDI" : "Stock",
          ),
        );
        
        emit(HomeLoaded(currentInspections + moreData));
      }
    });
  }
}
