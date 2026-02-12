import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
  @override
  List<Object?> get props => [];
}

class TabChangedEvent extends BottomNavEvent {
  final int index;
  const TabChangedEvent(this.index);
  @override
  List<Object?> get props => [index];
}

// States
class BottomNavState extends Equatable {
  final int currentIndex;
  const BottomNavState(this.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}

// Bloc
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState(0)) {
    on<TabChangedEvent>((event, emit) {
      emit(BottomNavState(event.index));
    });
  }
}
