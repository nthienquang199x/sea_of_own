import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom(
      {super.key,
      this.title,
      this.isRequired = false,
      this.controller,
      this.hintText,
      this.obscureText = false,
      this.enabled,
      this.keyboardType,
      this.onChanged,
      this.maxlines,
      this.minLines,
      this.minLength,
      this.maxLength,
      this.suffix,
      this.borderRadius,
      this.suffixIcon,
      this.prefix,
      this.prefixIcon,
      this.initialValue,
      this.borderColor,
      this.validator,
      this.validators,
      this.fillColor});
  final String? title;
  final String? hintText;
  final bool isRequired;
  final int? minLength;
  final int? maxLength;
  final int? maxlines;
  final int? minLines;
  final bool? enabled;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<FormFieldValidator<String>>? validators;
  final TextInputType? keyboardType;
  final Function(dynamic)? onChanged;
  final bool? obscureText;
  final String? initialValue;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? borderColor;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null || widget.isRequired == true) ...{
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: widget.title,
              style: context.myTheme.textThemeT1.body
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            if (widget.isRequired)
              TextSpan(
                text: ' *',
                style: context.myTheme.textThemeT1.body.copyWith(
                  color: Colors.red,
                ),
              ),
          ]))
        },
        const VSpacing(
          spacing: 8,
        ),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          minLines: (widget.minLines != null && widget.maxlines != null)
              ? (widget.minLines! <= widget.maxlines!
                  ? widget.minLines
                  : widget.maxlines)
              : widget.minLines,
          maxLines: widget.maxlines,
          enabled: widget.enabled ?? true,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            hintStyle: context.myTheme.textThemeT1.body
                .copyWith(color: context.myTheme.colorScheme.foreground),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor ?? AppColor.base90, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor ?? AppColor.base90, width: 1.0),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor ?? AppColor.base90, width: 1.0),
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
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffix: widget.suffix,
            suffixIcon: widget.suffixIcon,
          ),
          validator: (value) {
            String? message;
            if (widget.isRequired && (value == null || value.isEmpty)) {
              message = '${widget.title} ${AppLocale.is_required.tr(context)}';
            }
            if (message == null &&
                (widget.minLength != null &&
                    value != null &&
                    value.length < widget.minLength!) &&
                value.isNotEmpty) {
              message =
                  '${widget.title} ${AppLocale.must_be_at_least.tr(context)} ${widget.minLength!} ${AppLocale.characters.tr(context)}';
            }
            if (message == null && widget.validator != null) {
              final validationMessage = widget.validator?.call(value);
              if (validationMessage != null) {
                message = validationMessage;
              }
            }
            return message;
          },
        ),
      ],
    );
  }
}
