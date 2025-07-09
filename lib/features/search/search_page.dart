import 'package:app_base/models/category.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Category> categories = [
    Category(name: 'Tech & Audio'),
    Category(name: 'Tools'),
    Category(name: 'Work'),
    Category(name: 'Home'),
    Category(name: 'Personal'),
    Category(name: 'Craft'),
  ];
  @override
  Widget build(BuildContext context) {
    final categorySelected = categories.first;
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    color: context.myTheme.colorScheme.foreground,
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormFieldCustom(
                  hintText: "Search Account or Product name",
                  borderColor: Colors.transparent,
                  fillColor: context.myTheme.colorScheme.background,
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category.name == categorySelected.name;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < categories.length - 1 ? 12 : 16,
                    left: index == 0 ? 16 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.myTheme.colorScheme.foreground
                            : context.myTheme.colorScheme.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        category.name,
                        style: context.myTheme.textThemeT1.body.copyWith(
                          color: isSelected
                              ? context.myTheme.colorScheme.background
                              : context.myTheme.colorScheme.foreground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: context.myTheme.colorScheme.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1),
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return buildProductCard(category.name);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Recently viewed",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    color: context.myTheme.colorScheme.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    height: 136,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.myTheme.colorScheme.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    child: Image.asset(
                                      "assets/images/img_search_product.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buildProductCard(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.myTheme.textThemeT1.body.copyWith(
            color: context.myTheme.colorScheme.foreground,
          ),
        ),
        SvgPicture.asset(
          "assets/icons/ic_home_arrow_right.svg",
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            context.myTheme.colorScheme.iconInactive,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
