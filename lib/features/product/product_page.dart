import 'package:app_base/models/product.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.primary,
                  image: product.images.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(product.images.first),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(product.category,
                            style: context.myTheme.textThemeT1.title.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: context.myTheme.colorScheme.foreground,
                            )),
                      ),
                      SvgPicture.asset(
                        "assets/icons/ic_product_share.svg",
                        colorFilter: ColorFilter.mode(
                          context.myTheme.colorScheme.foreground,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: context.myTheme.textThemeT1.title.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: context.myTheme.colorScheme.foreground),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.currency} ${product.price.toStringAsFixed(2)}',
                    style: context.myTheme.textThemeT1.title.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: context.myTheme.colorScheme.foreground),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_product_heart.svg",
                          colorFilter: ColorFilter.mode(
                            context.myTheme.colorScheme.foreground,
                            BlendMode.srcIn,
                          )),
                      const SizedBox(width: 8),
                      Text('124',
                          style: context.myTheme.textThemeT1.title.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: context.myTheme.colorScheme.foreground,
                          )),
                      const SizedBox(width: 24),
                      SvgPicture.asset("assets/icons/ic_product_bookmark.svg",
                          colorFilter: ColorFilter.mode(
                            context.myTheme.colorScheme.foreground,
                            BlendMode.srcIn,
                          )),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    product.description,
                    style: context.myTheme.textThemeT1.body.copyWith(
                      fontSize: 18,
                      color: context.myTheme.colorScheme.foreground,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ExpandableWidget(
                    title: 'Specs',
                    body: product.description,
                  ),
                  ExpandableWidget(
                    title: 'Buy Here',
                    body: product.description,
                  ),
                  ExpandableWidget(
                    title: 'What we like',
                    body: product.description,
                  ),
                  ExpandableWidget(
                    title: 'What we don’t like',
                    body: product.description,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            width: double.infinity,
                            color: context.myTheme.colorScheme.primary,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: 5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: context.myTheme.colorScheme.separator1,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(widget.title,
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: context.myTheme.colorScheme.foreground,
                        ))),
                SvgPicture.asset("assets/icons/ic_product_plus.svg",
                    colorFilter: ColorFilter.mode(
                      context.myTheme.colorScheme.iconInactive,
                      BlendMode.srcIn,
                    )),
              ],
            ),
            if (_isExpanded) ...{
              const SizedBox(height: 8),
              Text(
                widget.body,
                style: context.myTheme.textThemeT1.body.copyWith(
                  fontSize: 16,
                  color: context.myTheme.colorScheme.foreground,
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
