import 'dart:developer';

import 'package:flux_mvp/features/nav_screens/repositories/complete_profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'complete_profile_viewmodel.g.dart';

@riverpod
class CompleteProfileViewmodel extends _$CompleteProfileViewmodel {
  late CompleteProfileRepository _completeProfileRepository;
  @override
  AsyncValue? build() {
    _completeProfileRepository = ref.watch(completeProfileRepositoryProvider);
    return null;
  }

  Future<void> getProfileDetails() async {
    try {
      final val = await _completeProfileRepository.getProfileDetails();
      state = AsyncValue.data(val);
      log("🟢getProfileDetails - $val");
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
      log("🔴getProfileDetails - Error - $e");
    }
  }

  Future<void> completeProfile(Map<String, dynamic> details) async {
    state = const AsyncValue.loading();
    try {
      log("🟢Entered completeProfile 1");
      final val = await _completeProfileRepository.completeProfile(details);
      log("🟢Entered completeProfile 2");
      state = AsyncValue.data(val);
      log("🟢completeProfile - $val");
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
      log("🔴completeProfile - Error - $e");
    }
  }
}
