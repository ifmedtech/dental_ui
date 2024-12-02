import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/features/ai_analysis/presentation/cubit/capture_image_cubit/capture_image_cubit.dart';
import 'package:dental_ui/injection_container.dart' as di;
import 'package:dental_ui/router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/app/presentation/cubit/permission_cubit/permission_cubit.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CaptureImageCubit()),
        BlocProvider(
          create: (context) => di.sl<PermissionCubit>()..checkPermission(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'OraVue',
        // theme: MaterialTheme.theme(MaterialTheme.lightScheme().toColorScheme()),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF636AE8),
            primary: const Color(0xFF636AE8),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Color(0xFF636AE8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10), // Optional: Customize border radius
              ),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10), // Optional: Customize border radius
              ),
            ),
          ),
          textTheme: GoogleFonts.interTextTheme().copyWith(
            displayLarge: const TextStyle(fontWeight: FontWeight.w400),
            displayMedium: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            displaySmall: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            headlineLarge: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            headlineMedium: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            headlineSmall: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            titleLarge: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            titleMedium: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            titleSmall: const TextStyle(fontWeight: FontWeight.w400),
            bodyLarge: const TextStyle(fontWeight: FontWeight.w400),
            bodyMedium: const TextStyle(fontWeight: FontWeight.w400),
            bodySmall: const TextStyle(fontWeight: FontWeight.w400),
            labelLarge: const TextStyle(fontWeight: FontWeight.w400),
            labelMedium: const TextStyle(fontWeight: FontWeight.w400),
            labelSmall: const TextStyle(fontWeight: FontWeight.w400),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorUtils.get(context).outline.withOpacity(0.6)),
          ),
        ),
        // darkTheme:
        //     MaterialTheme.theme(MaterialTheme.darkScheme().toColorScheme()),
        routerConfig: Routing.goRouter,
      ),
    );
  }
}
