import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final String title;
  final T? selected;
  final List<T> options;
  final void Function(T?) onChanged;
  final String Function(T option)? itemLabelBuilder;

  const CustomRadioGroup({
    super.key,
    required this.title,
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
        Text(
          title,
          style: context.myTheme.textThemeT1.body.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        const VSpacing(spacing: 8),
        Column(
          children: options.map((option) {
            final label = itemLabelBuilder?.call(option) ?? option.toString();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomRadio<T>(
                value: option,
                groupValue: selected,
                onChanged: onChanged,
                label: label,
              ),
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
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColor.colorDF7838.withOpacity(0.8)
                    : AppColor.base90,
                width: 1,
              ),
            ),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColor.colorDF7838 : AppColor.base90,
                ),
              ),
            ),
          ),
          const HSpacing(spacing: 8),
          Text(
            label,
            style: context.myTheme.textThemeT1.title.copyWith(
              color: AppColor.base30,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
