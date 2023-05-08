
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// All Riverpod services should extend this abstract class to ensure access to the ProviderRef property

abstract class RiverpodStateNotifier<T> extends StateNotifier<T> {
  final StateNotifierProviderRef ref;
  RiverpodStateNotifier(T state, this.ref) : super(state);
}