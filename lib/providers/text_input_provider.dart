import 'package:flutter_riverpod/flutter_riverpod.dart';

final textInputProvider = NotifierProvider.autoDispose<TextInputNotifier, String>(TextInputNotifier.new);

class TextInputNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void updateText(String newText) {
    state = newText;
  }
}