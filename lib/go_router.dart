import 'package:dental_ui/camera.dart';
import 'package:go_router/go_router.dart';

class Routing {
  static GoRouter goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CameraTest(),
      ),
    ],
  );
}
