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
    try {
      final val = await _authServiceRepository.signup(name, email, password);
      state = AsyncValue.data(val);
      log("🟢Signup - $val");
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
      log("🔴Signup - Error - $e");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final val = await _authServiceRepository.login(email, password);
      state = AsyncValue.data(val);
      log("🟢login - $val");
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
      log("🔴login - Error - $e");
    }
  }
}
