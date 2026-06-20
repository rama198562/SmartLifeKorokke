import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryGridProvider = NotifierProvider.autoDispose<CategoryGridNotifier, Set<String>>(CategoryGridNotifier.new);
class CategoryGridNotifier extends Notifier<Set<String>> {
  @override
   Set<String> build() {
    return {};
  }

  void toggleCategory(String CategoryId){
    final currentSet = Set<String>.from(state);
    if(currentSet.contains(CategoryId)){
      currentSet.remove(CategoryId);
    }else{
      currentSet.add(CategoryId);
    }
    state = currentSet;
  }
}