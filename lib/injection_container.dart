import 'package:dental_ui/features/authentication/auth_injection_container.dart';
import 'package:get_it/get_it.dart';

import 'features/app/app_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInjectionContainer();
  await appInjectionContainer();
}
