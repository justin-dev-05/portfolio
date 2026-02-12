import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Logcat.print('Bloc Error in ${bloc.runtimeType}');
    // Logcat.print(error.toString());
    print('Bloc Error in ${bloc.runtimeType}');
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
