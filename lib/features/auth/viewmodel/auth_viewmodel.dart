import 'dart:developer';

import 'package:flux_mvp/features/auth/models/user_model.dart';
import 'package:flux_mvp/features/auth/repositories/auth_service_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthServiceRepository _authServiceRepository;
  @override
  AsyncValue<UserModel>? build() {
    _authServiceRepository = ref.watch(authServiceRepositoryProvider);
    return null;
  }

  Future<void> signup(String name, String email, String password) async {
    state = const AsyncValue.loading();
    final val = await _authServiceRepository.signup(email,password);
        log("🟢Signup - $val");
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final val = await _authServiceRepository.login(email, password);
    log("🟢login - $val");
  }
}