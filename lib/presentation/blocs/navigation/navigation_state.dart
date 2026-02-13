part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int selectedIndex;
  final bool isMobileMenuOpen;

  const NavigationState({
    this.selectedIndex = 0,
    this.isMobileMenuOpen = false,
  });

  NavigationState copyWith({
    int? selectedIndex,
    bool? isMobileMenuOpen,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isMobileMenuOpen: isMobileMenuOpen ?? this.isMobileMenuOpen,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, isMobileMenuOpen];
}
