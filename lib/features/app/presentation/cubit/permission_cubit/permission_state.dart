part of 'permission_cubit.dart';

sealed class PermissionState {
  const PermissionState();
}

final class PermissionInitial extends PermissionState {
}

final class GetPermission extends PermissionState {
}

final class DeniedPermission extends PermissionState {

}

final class SuccessPermission extends PermissionState {

}
