import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/authentication/authentication_repository.dart';
import 'package:my_task_firebase_june_ndz/src/helpers/storage_helper.dart';
import 'package:my_task_firebase_june_ndz/src/helpers/storage_keys.dart';
import 'package:my_task_firebase_june_ndz/src/models/user_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
 final AuthenticationRepository _repository = AuthenticationRepository();
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> createUser(UserModel userModel) async {
    emit(AuthenticationLoading());
    try {
      UserCredential user = await _repository.createUser(
          userModel.email, userModel.password??"");
      String? token = await user.user!.getIdToken();
      String? uid = user.user!.uid; //userId from firebase
      StorageHelper.writeData(StorageKeys.token.name, token??"");
      StorageHelper.writeData(StorageKeys.uid.name, uid??"");
      // TODO : Store token,uid to the storage
      userModel.id = uid; // Updating userId
      await _repository.storeUserData(
          userModel); // Create user,Store the other datas like address,name etc of database in the firebase database
      emit(AuthenticationSuccess());
    } catch (ex) {
      emit(AuthenticationFailure("Something went wrong"));
    }
  }

      loginUser(String email,String password) async {
      emit(AuthenticationLoading());
      try {
        UserCredential user = await _repository.loginUser(
            email,password??"");
        String? token = await user.user!.getIdToken();
        String? uid = user.user!.uid; //userId from firebase
        StorageHelper.writeData(StorageKeys.token.name, token??"");
        StorageHelper.writeData(StorageKeys.uid.name, uid??"");
        emit(AuthenticationSuccess());
      } catch (ex) {
        emit(AuthenticationFailure("Something went wrong"));
      }
    }
  }


// Store the other database in the firebase database