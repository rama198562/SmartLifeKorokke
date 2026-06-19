import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/category_grid_provider.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryGridProvider);
    //データ定義
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'カテゴリーを選択',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextButton(onPressed: (){},
            child: const Text(
              'すべて見る',
              style: TextStyle(
                fontSize: 18,
                ),              
              )
            ),
          ],
        ),
          const SizedBox(height: 12),

          //グリット部分
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // グリッド自体はスクロールさせない
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,         // 2列
              childAspectRatio: 1.4,     // カードの横縦比（横長に）
              crossAxisSpacing: 16,      // 横の隙間
              mainAxisSpacing: 16,       // 縦の隙間
            ),
            itemBuilder: (context, index){
              final item = categories[index];
              final String id = item['id'];
              final String title = item['title'];
              return GestureDetector(
                onTap: (){
                  ref.read(categoryGridProvider.notifier).toggleCategory(id);
                  print('${item['title']} がタップされました');
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16), // 角丸
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 8,
                    //     offset: const Offset(0, 4),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
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