part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToSectionEvent extends NavigationEvent {
  final int index;

  const NavigateToSectionEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateCurrentSectionEvent extends NavigationEvent {
  final int index;

  const UpdateCurrentSectionEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleMobileMenuEvent extends NavigationEvent {
  const ToggleMobileMenuEvent();
}
