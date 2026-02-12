import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateToSectionEvent>(_onNavigateToSection);
    on<UpdateCurrentSectionEvent>(_onUpdateCurrentSection);
    on<ToggleMobileMenuEvent>(_onToggleMobileMenu);
  }

  void _onNavigateToSection(
    NavigateToSectionEvent event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(
      selectedIndex: event.index,
      isMobileMenuOpen: false,
    ));
  }

  void _onUpdateCurrentSection(
    UpdateCurrentSectionEvent event,
    Emitter<NavigationState> emit,
  ) {
    if (state.selectedIndex != event.index) {
      emit(state.copyWith(selectedIndex: event.index));
    }
  }

  void _onToggleMobileMenu(
    ToggleMobileMenuEvent event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(isMobileMenuOpen: !state.isMobileMenuOpen));
  }
}
