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
        title: 'OraVue',
        // theme: MaterialTheme.theme(MaterialTheme.lightScheme().toColorScheme()),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF636AE8),
          ),
          textTheme: GoogleFonts.latoTextTheme().copyWith(
              // bodyMedium:.oswald(textStyle: textTheme.bodyMedium GoogleFonts),
              ),
        ),
        // darkTheme:
        //     MaterialTheme.theme(MaterialTheme.darkScheme().toColorScheme()),
        routerConfig: Routing.goRouter,
      ),
    );
  }
}
