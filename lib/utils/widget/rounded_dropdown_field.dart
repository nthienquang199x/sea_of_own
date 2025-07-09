import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';

class RoundedDropdownField<T> extends StatefulWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final BorderRadius? borderRadius;
  final ValueChanged<T?>? onChanged;

  const RoundedDropdownField({
    super.key,
    required this.label,
    this.borderRadius,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  State<RoundedDropdownField<T>> createState() =>
      _RoundedDropdownFieldState<T>();
}

class _RoundedDropdownFieldState<T> extends State<RoundedDropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: context.myTheme.textThemeT1.body.copyWith(
              fontWeight: FontWeight.w600,
            )),
        const VSpacing(spacing: 4),
        DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          menuMaxHeight: 250,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
          onChanged: widget.onChanged,
          dropdownColor: const Color(0xFF121212),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            hintStyle: context.myTheme.textThemeT1.body
                .copyWith(color: AppColor.base30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.base90, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.base90, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.base90, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
          ),
          style: context.myTheme.textThemeT1.title.copyWith(
            color: AppColor.base50,
            fontWeight: FontWeight.w400,
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        ),
      ],
    );
  }
}
