import 'package:equatable/equatable.dart';
import '../../data/models/inspection_model.dart';

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
