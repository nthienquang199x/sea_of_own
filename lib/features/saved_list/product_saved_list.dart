import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/profile/components/custom_dialog.dart';
import 'package:app_base/features/saved_list/models/filter_list.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductSavedList extends StatefulWidget {
  const ProductSavedList({super.key});

  @override
  State<ProductSavedList> createState() => _ProductSavedListState();
}

class _ProductSavedListState extends State<ProductSavedList> {
  FilterList? selectedFilter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildProductCard(
                    "Default list",
                    "assets/images/img_search_product.png",
                  ),
                  buildProductCard(
                    "Another list",
                    "assets/images/img_search_product.png",
                  ),
                  buildProductCard(
                    "Sample list",
                    "assets/images/img_search_product.png",
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(
          "assets/icons/ic_chevron_left.svg",
          colorFilter: ColorFilter.mode(
            context.myTheme.colorScheme.foreground,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        'Default List',
        style: context.myTheme.textThemeT1.title.copyWith(
            color: context.myTheme.colorScheme.foreground,
            fontWeight: FontWeight.w500),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => buildFilter(),
            );
          },
          child: Container(
              decoration: BoxDecoration(
                color: context.myTheme.colorScheme.menuIconBg,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/icons/ic_products_sort.svg",
                colorFilter: ColorFilter.mode(
                  context.myTheme.colorScheme.foreground,
                  BlendMode.srcIn,
                ),
              )),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => buildOptionDialog(),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.menuIconBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/ic_menu.svg",
                colorFilter: ColorFilter.mode(
                  context.myTheme.colorScheme.foreground,
                  BlendMode.srcIn,
                )),
          ),
        ),
        const SizedBox(width: 12),
      ],
      backgroundColor: context.myTheme.colorScheme.muted,
    );
  }

  Widget buildProductCard(String productName, String productImage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              "assets/images/img_search_product.png",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: context.myTheme.textThemeT1.title.copyWith(
                      color: context.myTheme.colorScheme.textColor,
                    ),
                  ),
                  Text(
                    "CA\$ 450.00",
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: context.myTheme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilter() {
    return CustomDialog(
        title: AppLocale.sort_by,
        titleButton: AppLocale.sort,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.myTheme.colorScheme.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomRadioGroup<FilterList>(
            selected: selectedFilter,
            options: FilterList.values,
            itemLabelBuilder: (option) => option.title.tr(context),
            onChanged: (value) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),
        ));
  }

  Widget buildOptionDialog() {
    return Dialog(
      backgroundColor: context.myTheme.colorScheme.muted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGroup([
                  _buildItem(
                    AppLocale.rename,
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(
                      color: context.myTheme.colorScheme.separator1,
                      height: 1,
                    ),
                  ),
                  _buildItem(
                    AppLocale.delete_this_list,
                    textColor: context.myTheme.colorScheme.destructive,
                    onTap: () {},
                  ),
                ]),
              ],
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildItem(
    String title, {
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.tr(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor ?? context.myTheme.colorScheme.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
