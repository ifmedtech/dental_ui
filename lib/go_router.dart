import 'package:dental_ui/features/app/presentation/pages/on_boarding_page.dart';
import 'package:go_router/go_router.dart';

class Routing {
  static GoRouter goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnBoardingPage(),
      ),
    ],
  );
}
