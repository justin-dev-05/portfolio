import 'package:equatable/equatable.dart';

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
