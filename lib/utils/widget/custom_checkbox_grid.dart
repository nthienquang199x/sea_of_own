import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class FormSectionTitle extends StatelessWidget {
  final String title;
  const FormSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.myTheme.textThemeT1.body.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class CustomCheckboxGrid<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final Set<T> selected;
  final void Function(T option, bool isSelected) onChanged;
  final String Function(T option)? itemLabelBuilder;

  const CustomCheckboxGrid({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.itemLabelBuilder,
  });

  @override
  State<CustomCheckboxGrid<T>> createState() => _CustomCheckboxGridState<T>();
}

class _CustomCheckboxGridState<T> extends State<CustomCheckboxGrid<T>> {
  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = widget.options.length > 3 ? 2 : 1;
    final int ratio = crossAxisCount == 1 ? 90 : 50;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormSectionTitle(title: widget.title),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          childAspectRatio:
              MediaQuery.of(context).size.width / (crossAxisCount * ratio),
          children: widget.options.map((option) {
            final isChecked = widget.selected.contains(option);
            final label =
                widget.itemLabelBuilder?.call(option) ?? option.toString();
            return CheckboxListTile(
              value: isChecked,
              onChanged: (checked) =>
                  widget.onChanged(option, checked ?? false),
              title: Text(
                label,
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: AppColor.base30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              hoverColor: AppColor.color00D7EF1A,
              side: const BorderSide(color: AppColor.base80),
              overlayColor: WidgetStateProperty.all(AppColor.base80),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColor.colorDF7838,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }
}
