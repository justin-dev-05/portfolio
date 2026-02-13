import 'package:go_router/go_router.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PortfolioPage(),
      ),
    ],
  );
}
