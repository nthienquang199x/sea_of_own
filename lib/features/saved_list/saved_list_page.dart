import 'package:app_base/app/config/app_router.dart';
import 'package:app_base/app/theme/icons.dart';
import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/models/collection.dart';
import 'package:app_base/features/home/models/navigation_type.dart';
import 'package:app_base/features/profile/components/custom_bottom_sheet.dart';
import 'package:app_base/features/saved_list/saved_list_cubit.dart';
import 'package:app_base/features/saved_list/saved_list_state.dart';
import 'package:app_base/features/search/components/search_widget.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/text_form_field_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavedListPage extends StatefulWidget {
  const SavedListPage({super.key, this.onTapNavigation});
  final Function(NavigationType type)? onTapNavigation;

  @override
  State<SavedListPage> createState() => _SavedListPageState();
}

class _SavedListPageState
    extends BaseState<SavedListState, SavedListCubit, SavedListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.init();
    });
  }

  @override
  Widget buildByState(BuildContext context, SavedListState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Saved List",
                        style: context.myTheme.textThemeT1.title.copyWith(
                          color: context.myTheme.colorScheme.foreground,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => buildAddNewListDialog(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.myTheme.colorScheme.menuIconBg,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                              "assets/icons/ic_product_plus.svg",
                              colorFilter: ColorFilter.mode(
                                context.myTheme.colorScheme.foreground,
                                BlendMode.srcIn,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SearchWidget(
              searchController: cubit.searchController,
              searchText: state.searchText,
              onChanged: () => cubit.onSearchChanged(),
              onClear: () => cubit.onSearchChanged(fromClear: true),
            ),
            const SizedBox(height: 24),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final collection = state.savedCollections[index];
                  return buildProductCard(collection);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: state.savedCollections.length),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(Collection collection) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.router
              .push(ProductSavedListRoute(
                  id: collection.id, title: collection.name))
              .then((value) {
            if (value != null && value is NavigationType) {
              widget.onTapNavigation?.call(value);
            } else if (value != null && value is bool && value) {
              cubit.fetchSavedCollections();
            }
          });
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: collection.thumbnail ?? '',
                fit: BoxFit.cover,
                height: 114,
                width: 114,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      collection.name,
                      style: context.myTheme.textThemeT1.title.copyWith(
                        color: context.myTheme.colorScheme.textColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${collection.totalProducts} items',
                          style: context.myTheme.textThemeT1.body.copyWith(
                            color: context.myTheme.colorScheme.mutedForeground,
                          ),
                        ),
                        SvgPicture.asset(
                          AppIcons.ic_chevron_right,
                          colorFilter: ColorFilter.mode(
                            context.myTheme.colorScheme.iconInactive,
                            BlendMode.srcIn,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddNewListDialog() {
    return CustomBottomSheet(
        title: AppLocale.create_new_list,
        titleButton: AppLocale.create,
        child: TextFormFieldCustom(
          hintText: AppLocale.add_a_name.tr(context),
          borderColor: Colors.transparent,
          fillColor: context.myTheme.colorScheme.background,
          controller: cubit.createNameController,
          keyboardType: TextInputType.text,
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          cubit.createCollection().then((value) {
            context.router.maybePop();
          });
        });
  }
}
