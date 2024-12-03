import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  checkPermission() async {
    if (!(await Permission.camera.isGranted)) {
      emit(GetPermission());
    }
  }

  void showPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.audio,
      Permission.manageExternalStorage,
    ].request();
    // if (statuses[Permission.storage]!.isPermanentlyDenied ||
    //     statuses[Permission.camera]!.isPermanentlyDenied ||
    //     statuses[Permission.manageExternalStorage]!.isPermanentlyDenied ||
    //     statuses[Permission.audio]!.isPermanentlyDenied) {
      if (statuses[Permission.camera]!.isGranted ||
        statuses[Permission.camera]!.isProvisional) {
      emit(SuccessPermission());
    } else {
      emit(DeniedPermission());
    }
  }
}
