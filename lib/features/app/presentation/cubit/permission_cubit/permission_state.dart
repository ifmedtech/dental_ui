part of 'permission_cubit.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();
}

final class PermissionInitial extends PermissionState {
  @override
  List<Object> get props => [];
}

final class GetPermission extends PermissionState {
  @override
  List<Object> get props => [];
}

final class DeniedPermission extends PermissionState {
  @override
  List<Object?> get props => [];
}

final class SuccessPermission extends PermissionState {
  @override
  List<Object?> get props => [];
}
