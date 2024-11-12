import 'package:dental_ui/core/router/go_router.dart';
import 'package:dental_ui/features/ai_analysis/presentation/cubit/capture_image_cubit/capture_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CaptureImageCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'OraVue',
        // theme: MaterialTheme.theme(MaterialTheme.lightScheme().toColorScheme()),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF636AE8),
            primary: Color(0xFF636AE8),
          ),
          textTheme: GoogleFonts.interTextTheme().copyWith(
            displayLarge: const TextStyle(fontWeight: FontWeight.w400),
            displayMedium: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            displaySmall: GoogleFonts.archivo(fontWeight: FontWeight.w600),
            headlineLarge: const TextStyle(fontWeight: FontWeight.w400),
            headlineMedium: const TextStyle(fontWeight: FontWeight.w400),
            headlineSmall: const TextStyle(fontWeight: FontWeight.w400),
            titleLarge: const TextStyle(fontWeight: FontWeight.w400),
            titleMedium: const TextStyle(fontWeight: FontWeight.w400),
            titleSmall: const TextStyle(fontWeight: FontWeight.w600),
            bodyLarge: const TextStyle(fontWeight: FontWeight.w400),
            bodyMedium: const TextStyle(fontWeight: FontWeight.w400),
            bodySmall: const TextStyle(fontWeight: FontWeight.w400),
            labelLarge: const TextStyle(fontWeight: FontWeight.w400),
            labelMedium: const TextStyle(fontWeight: FontWeight.w400),
            labelSmall: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        // darkTheme:
        //     MaterialTheme.theme(MaterialTheme.darkScheme().toColorScheme()),
        routerConfig: Routing.goRouter,
      ),
    );
  }
}
