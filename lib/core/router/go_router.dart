import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/features/app/presentation/pages/bottom_tab/overview_page.dart';
import 'package:dental_ui/features/app/presentation/pages/home_page.dart';
import 'package:dental_ui/features/app/presentation/pages/on_boarding_page.dart';
import 'package:dental_ui/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:go_router/go_router.dart';

class Routing {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/${AppRoute.overView}',
    routes: [
      GoRoute(
        path: '/${AppRoute.onBoarding}',
        name: AppRoute.onBoarding,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: '/${AppRoute.signIn}',
        name: AppRoute.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => HomePage(
          body: child,
        ),
        routes: [
          GoRoute(
            path: '/${AppRoute.overView}',
            name: AppRoute.overView,
            builder: (context, state) => const OverViewPage(),
          )
        ],
      ),
    ],
  );
}
