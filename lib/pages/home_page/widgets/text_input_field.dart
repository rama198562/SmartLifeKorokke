import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/text_input_provider.dart';

class TextInputField extends ConsumerWidget {
  const TextInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      decoration: InputDecoration(
        labelText: 'Geminiへの追加要望 (任意)',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7)),
        hintText: '例: 景色の良い道を通ってほしい',
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2.0),
        ),
      ),
      onChanged: (value) {
        ref.read(textInputProvider.notifier).updateText(value);
      },
    );
  }
}
