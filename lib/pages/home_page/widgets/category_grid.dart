import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/category_grid_provider.dart';


// ① 複数選択の状態を管理するため、StatefulWidgetに変更
class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({super.key});




  // // ② ユーザーが選択したカテゴリーの「タイトル」を保存しておくリスト
  // final List<String> selectedTitles = [];
  
  // // 読み込み中かどうかを管理するフラグ
  // bool isLoading = false;

  // // ③ ボタンが押された時にGeminiを呼び出す関数
  // Future<void> _onGenerateRouteRequested() async {
  //   if (selectedTitles.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('カテゴリーを1つ以上選択してください')),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     isLoading = true; // ぐるぐる（インジケータ）を表示
  //   });

  //   // 💡 選ばれた項目を「、」で繋いでプロンプト（userRequest）にする
  //   final userRequest = "${selectedTitles.join('、')}に立ち寄るお散歩ルートを提案してください。";
  //   print('Geminiへのリクエスト: $userRequest');

  //   // あなたが作ったGeminiServiceを呼び出す！
  //   final geminiService = GeminiService();
  //   final result = await geminiService.fetchRoutePreferences(userRequest);

  //   setState(() {
  //     isLoading = false; // ぐるぐるを消す
  //   });

  //   if (result != null) {
  //     print('--- Geminiからの解析結果（JSON） ---');
  //     print(result);
      
  //     // 🚀 【次のステップ】ここで地図API（Google Maps等）の画面に result を渡して画面遷移する
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('ルート解析成功: ${result['keywords'] ?? '完了'}')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Geminiとの通信に失敗しました')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データ定義
    final List<Map<String, dynamic>> categories = [
      {
        'title':'公園',
        'id':'peak', 
      },
      {
        'title':'コンビニ',
        'id':'convenience',
      },
      {
        'title':'カフェ',
        'id':'cafe',
      },
      {
        'title':'病院',
        'id':'hospital',
      },
    ];
    final selectedIds = ref.watch(categoryGridProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'カテゴリーを選択',
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('すべて見る', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // グリッド部分
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];
            final String id = item['id'];

            final isSelected = selectedIds.contains(id);

            return GestureDetector(
              onTap: () {
                ref.read(categoryGridProvider.notifier).toggleCategory(id);
                // ⑤ タップされたら選択リストに追加/削除する（setStateで画面を再描画）
                // setState(() {
                //   if (isSelected) {
                //     selectedTitles.remove(item['title']);
                //   } else {
                //     selectedTitles.add(item['title']);
                //   }
                // });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  // 💡 色のダブりを解消し、選択時はほんのり青くなるように修正
                  color: isSelected 
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
                    width: isSelected ? 2.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (isSelected)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 20),
                      ),
                  ],
                ),
              ),
            );
          },
        ),

      ],
    );
  }
}
