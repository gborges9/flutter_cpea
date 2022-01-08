library gbx_firebase_login;

import 'package:gbx_core/core/interfaces/index.dart';
import 'package:gbx_firebase_login/data/datasources/firestore_user_datasource.dart';
import 'package:gbx_firebase_login/domain/firebase_login_module.dart';
import 'package:gbx_login/data/datasources/cached_user_data_datasource.dart';
import 'package:gbx_login/data/repositories/user_data_repository.dart';
import 'package:gbx_login/data/repositories/user_repository.dart';
import 'package:gbx_login/domain/entity/user.dart';

import 'data/datasources/firestore_user_data_datasource.dart';

Future<void> initializeWith<T>({
  Serializer<T>? serializer,
  Deserializer<T>? deserializer,
  FirestoreUserDataDataSource<T>? userDataDataSource,
  ICachedUserDataDataSource<T>? cachedUserDataDataSource,
}) async {
  assert(
      userDataDataSource != null ||
          (serializer != null && deserializer != null),
      "You must provide a custom user data datasource or the serializer/deserializer");

  var userRepo = UserRepository<GbxUser>(FirebaseUserDataSource());

  var userDataRepo = UserDataRepository<T>(
    userDataDataSource ??
        FirestoreUserDataDataSource(
            serializer: serializer!, deserializer: deserializer!),
    cachedUserDataDataSource ??
        const GetxCachedUserDataDataSource(tag: "cached_user_data"),
  );

  await FirebaseLoginModule<T>(userRepo, userDataRepo).initialize();
}
