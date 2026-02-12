import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PortfolioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SectionChanged extends PortfolioEvent {
  final int index;
  final bool force;
  SectionChanged(this.index, {this.force = false});

  @override
  List<Object?> get props => [index, force];
}

class ToggleThemeRequested extends PortfolioEvent {}

class ScrollToSectionRequested extends PortfolioEvent {
  final int index;
  ScrollToSectionRequested(this.index);

  @override
  List<Object?> get props => [index];
}

class ResetAutoScroll extends PortfolioEvent {}

class PortfolioState extends Equatable {
  final int activeIndex;
  final int scrollToSectionIndex; // -1 if no scroll requested
  final bool isDark;
  final bool isAutoScrolling;

  const PortfolioState({
    this.activeIndex = 0,
    this.scrollToSectionIndex = -1,
    this.isDark = true,
    this.isAutoScrolling = false,
  });

  PortfolioState copyWith({
    int? activeIndex,
    int? scrollToSectionIndex,
    bool? isDark,
    bool? isAutoScrolling,
  }) {
    return PortfolioState(
      activeIndex: activeIndex ?? this.activeIndex,
      scrollToSectionIndex: scrollToSectionIndex ?? this.scrollToSectionIndex,
      isDark: isDark ?? this.isDark,
      isAutoScrolling: isAutoScrolling ?? this.isAutoScrolling,
    );
  }

  @override
  List<Object?> get props =>
      [activeIndex, scrollToSectionIndex, isDark, isAutoScrolling];
}

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(const PortfolioState()) {
    on<SectionChanged>((event, emit) {
      if (state.isAutoScrolling && !event.force) return;
      if (state.activeIndex != event.index) {
        emit(state.copyWith(activeIndex: event.index));
      }
    });

    on<ScrollToSectionRequested>((event, emit) {
      emit(state.copyWith(
        scrollToSectionIndex: event.index,
        activeIndex: event.index,
        isAutoScrolling: true,
      ));
      // Reset scroll request immediately after emitting
      emit(state.copyWith(scrollToSectionIndex: -1));
    });

    on<ResetAutoScroll>((event, emit) {
      emit(state.copyWith(isAutoScrolling: false));
    });

    on<ToggleThemeRequested>((event, emit) {
      emit(state.copyWith(isDark: !state.isDark));
    });
  }
}
