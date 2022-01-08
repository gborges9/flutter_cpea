import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbx_login/domain/LoginModule.dart';
import 'package:gbx_login/domain/entity/user.dart';
import 'package:gbx_login/domain/usecases/update_user_data.dart';
import 'package:get/get.dart';

class UserDataCubit<T> extends Cubit<UserState<T>> {
  UserDataCubit([this.tag]) : super(Get.find<UserState<T>>(tag: tag));

  LoginModule get _module => (LoginModule.instance as LoginModule<T, GbxUser>);

  final String? tag;

  void getUserData() async {
    emit(UserState<T>(null, UAction.Loading));
    var data = await _module.getUserData();
    var action = data.didSuccess ? UAction.Complete : UAction.Failed;
    emit(UserState<T>(data.data, action));
  }

  void updateUserData(T updatedData) async {
    emit(UserState<T>(state.user, UAction.Loading));
    var data = await _module.updateUserData(UpdateUserParams<T>(updatedData));
    var action = data.didSuccess ? UAction.Complete : UAction.Failed;
    emit(UserState<T>(data.data ?? state.user, action));
  }
}

class UserState<U> extends Equatable {
  final UAction action;
  final U? user;

  const UserState([this.user, this.action = UAction.Complete]);

  @override
  List<Object?> get props => [action, user];
}

enum UAction { Complete, Loading, Updating, Failed }