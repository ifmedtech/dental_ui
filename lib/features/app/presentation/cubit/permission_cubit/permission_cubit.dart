import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  checkPermission() {
    emit(GetPermission());
  }

  void showPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.manageExternalStorage,
      Permission.audio,
    ].request();
    if (statuses[Permission.storage]!.isDenied ||
        statuses[Permission.camera]!.isDenied ||
        statuses[Permission.manageExternalStorage]!.isDenied ||
        statuses[Permission.audio]!.isDenied) {
      emit(DeniedPermission());
    } else {
      emit(SuccessPermission());
    }
  }
}
