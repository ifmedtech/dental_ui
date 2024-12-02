import 'package:dental_ui/features/app/presentation/cubit/permission_cubit/permission_cubit.dart';
import 'package:dental_ui/injection_container.dart';

Future<void> appInjectionContainer() async {
  sl.registerFactory<PermissionCubit>(() => PermissionCubit());
}
