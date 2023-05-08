
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/riverpod_state_notifier.dart';
import '../models/user.dart';


final userStateProvider = StateNotifierProvider<UserStateNotifier, AsyncValue<User?>>(
  (ref) => UserStateNotifier(ref),
);


class UserStateNotifier extends RiverpodStateNotifier<AsyncValue<User?>> {

  UserStateNotifier(StateNotifierProviderRef ref): super(
    const AsyncValue.data(null),
    ref
  );

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setError(Object error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }

  void setUser(User? user) {
    state = AsyncValue.data(user);
  }
}