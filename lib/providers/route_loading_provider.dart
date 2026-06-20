import 'package:flutter_riverpod/legacy.dart';


final routeLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});