import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    this.searchController,
    this.searchText,
    this.onChanged,
    this.onClear,
  });
  final TextEditingController? searchController;
  final String? searchText;
  final VoidCallback? onChanged;
  final VoidCallback? onClear;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  VoidCallback? _listener;
  @override
  void initState() {
    _listener = () {
      if (mounted) {
        setState(() {});
      }
    };
    widget.searchController?.addListener(_listener!);
    super.initState();
  }

  @override
  void dispose() {
    if (_listener != null) {
      widget.searchController?.removeListener(_listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormFieldCustom(
        hintText: "Search Account or Product name",
        borderColor: Colors.transparent,
        fillColor: context.myTheme.colorScheme.background,
        controller: widget.searchController,
        onChanged: (p0) {
          if (widget.onChanged != null) {
            widget.onChanged!();
          }
        },
        keyboardType: TextInputType.text,
        borderRadius: BorderRadius.circular(8),
        suffix: (widget.searchText?.isNotEmpty ?? false)
            ? InkWell(
                onTap: () {
                  widget.searchController?.clear();
                  if (widget.onChanged != null) {
                    widget.onClear!();
                  }
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "|",
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: context.myTheme.colorScheme.separator1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 16),
                  ),
                  TextSpan(
                    text: "Clear",
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: context.myTheme.colorScheme.mutedForeground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])),
              )
            : null,
      ),
    );
  }
}
