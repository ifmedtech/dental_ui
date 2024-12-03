import 'package:dental_ui/camera.dart';
import 'package:dental_ui/features/ai_analysis/presentation/pages/ai_analysis_page.dart';
import 'package:dental_ui/features/app/presentation/pages/bottom_tab/overview_page.dart';
import 'package:dental_ui/features/app/presentation/pages/bottom_tab/result_page.dart';
import 'package:dental_ui/features/app/presentation/pages/home_page.dart';
import 'package:dental_ui/features/app/presentation/pages/on_boarding_page.dart';
import 'package:dental_ui/features/app/presentation/pages/bottom_tab/view_analysis_page.dart';
import 'package:dental_ui/features/authentication/presentation/cubit/get_otp/get_otp_cubit.dart';
import 'package:dental_ui/features/authentication/presentation/pages/mobile_number_page.dart';
import 'package:dental_ui/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:dental_ui/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:dental_ui/injection_container.dart';
import 'package:dental_ui/pytorch_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';

class Routing {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/camera',
    // initialLocation: '/${AppRoute.onBoarding}',
    routes: [
      GoRoute(
        path: '/${AppRoute.onBoarding}',
        name: AppRoute.onBoarding,
        pageBuilder: (context, state) =>
            _PageTransition(child: const OnBoardingPage()),
      ),
      GoRoute(
        path: '/${AppRoute.signIn}',
        name: AppRoute.signIn,
        pageBuilder: (context, state) => _PageTransition(
          child: const SignInPage(),
        ),
      ),
      GoRoute(
          path: '/${AppRoute.mobileNumber}',
          name: AppRoute.mobileNumber,
          pageBuilder: (context, state) => _PageTransition(
                child: BlocProvider(
                  create: (context) => sl<GetOtpCubit>(),
                  child: MobileNumberPage(),
                ),
              ),
          routes: [
            GoRoute(
              path: AppRoute.otpVerification,
              name: AppRoute.otpVerification,
              pageBuilder: (context, state) => _PageTransition(
                child: const OtpVerificationPage(),
              ),
            ),
          ]),

      ///test
      GoRoute(
        path: '/camera',
        pageBuilder: (context, state) => _PageTransition(
          child: const CameraTest(),
        ),
      ),
      GoRoute(
        path: '/pytorch',
        pageBuilder: (context, state) => _PageTransition(
          child: PytorchTest(),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _PageTransition(
          child: HomePage(body: child),
        ),
        routes: [
          GoRoute(
            path: '/${AppRoute.overView}',
            name: AppRoute.overView,
            pageBuilder: (context, state) =>
                _PageTransition(child: const OverViewPage()),
          ),
          GoRoute(
              path: '/${AppRoute.aiAnalysis}',
              name: AppRoute.aiAnalysis,
              pageBuilder: (context, state) {
                String? path = state.uri.queryParameters['imagePath'];
                if (path != null) {
                  return _PageTransition(
                    child: AiAnalysisPage(
                      imagePath: path,
                    ),
                  );
                } else {
                  return _PageTransition(
                    child: const Scaffold(),
                  );
                }
              }),
          GoRoute(
            path: '/${AppRoute.result}',
            name: AppRoute.result,
            pageBuilder: (context, state) =>
                _PageTransition(child: const ResultPage()),
          ),
          GoRoute(
            path: '/${AppRoute.viewAnalysis}',
            name: AppRoute.viewAnalysis,
            pageBuilder: (context, state) => _PageTransition(
              child: const ViewAnalysisPage(),
            ),
          ),
        ],
      ),
    ],
  );
}

class _PageTransition extends CustomTransitionPage {
  _PageTransition({required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: true,
              child: child,
            );
          },
        );
}
