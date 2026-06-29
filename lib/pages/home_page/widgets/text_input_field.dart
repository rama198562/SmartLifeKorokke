import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/text_input_provider.dart';

class TextInputField extends ConsumerWidget {
  const TextInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Geminiへの追加要望 (任意)',
        hintText: '例: 景色の良い道を通ってほしい',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        ref.read(textInputProvider.notifier).updateText(value);
      },
    );
  }
}
