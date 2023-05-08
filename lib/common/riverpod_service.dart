
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// All Riverpod services should extend this abstract class to ensure access to the ProviderRef property

abstract class RiverpodService {
  final ProviderRef ref;
  RiverpodService(this.ref);
}