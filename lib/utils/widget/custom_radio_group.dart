import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final T? selected;
  final List<T> options;
  final void Function(T?) onChanged;
  final String Function(T option)? itemLabelBuilder;

  const CustomRadioGroup({
    super.key,
    required this.selected,
    required this.options,
    required this.onChanged,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: options.map((option) {
            final label = itemLabelBuilder?.call(option) ?? option.toString();
            return Column(
              children: [
                CustomRadio<T>(
                  value: option,
                  groupValue: selected,
                  onChanged: onChanged,
                  label: label,
                ),
                if (option != options.last)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(
                      color: context.myTheme.colorScheme.separator1,
                      height: 1,
                      thickness: 1,
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CustomRadioGrid<T> extends StatelessWidget {
  final String title;
  final T? selected;
  final List<T> options;
  final void Function(T?) onChanged;
  final String Function(T option)? itemLabelBuilder;

  const CustomRadioGrid({
    super.key,
    required this.title,
    required this.selected,
    required this.options,
    required this.onChanged,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = options.length > 3 ? 2 : 1;
    final double ratio = crossAxisCount == 1 ? 90 : 50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.myTheme.textThemeT1.body.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        const VSpacing(spacing: 8),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          childAspectRatio:
              MediaQuery.of(context).size.width / (crossAxisCount * ratio),
          children: options.map((option) {
            final label = itemLabelBuilder?.call(option) ?? option.toString();

            return CustomRadio<T>(
              value: option,
              groupValue: selected,
              onChanged: onChanged,
              label: label,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.myTheme.textThemeT1.title.copyWith(
              color: context.myTheme.colorScheme.foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
          const HSpacing(spacing: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.myTheme.colorScheme.separator1,
            ),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? context.myTheme.colorScheme.foreground
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
