import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class AppUnderlineTextField extends FormField<String> {
  AppUnderlineTextField({
    super.key,
    required this.label,
    this.controller,
    String? initialValue,
    this.hintText,
    this.readOnly = false,
    super.enabled = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLength,
    super.validator,
    super.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.errorText,
    this.showErrorIcon = false,
    this.suffixIcon,
    this.helperWidget,
  }) : assert(initialValue == null || controller == null),
       super(
         initialValue:
             controller != null ? controller.text : (initialValue ?? ''),
         builder: (FormFieldState<String> field) {
           final state = field as _AppUnderlineTextFieldState;
           final effectiveError = errorText ?? state.errorText;
           final hasError =
               effectiveError != null && effectiveError.isNotEmpty;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               if (label.isNotEmpty) ...[
                 Text(
                   label,
                   style: AppTextStyles.label.copyWith(
                     color: AppColors.textPrimary,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
                 SizedBox(height: AppDimensions.h6),
               ],
               Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: AppColors.fieldFill,
                   border: Border(
                     bottom: BorderSide(
                       color: hasError
                           ? AppColors.error
                           : AppColors.fieldUnderline,
                       width: hasError ? 1.5 : 1.0,
                     ),
                   ),
                 ),
                 child: TextField(
                   controller: state._effectiveController,
                   readOnly: readOnly,
                   enabled: enabled,
                   maxLines: maxLines,
                   keyboardType: keyboardType,
                   textCapitalization: textCapitalization,
                   inputFormatters: inputFormatters,
                   maxLength: maxLength,
                   buildCounter: (
                     context, {
                     required currentLength,
                     required isFocused,
                     maxLength,
                   }) =>
                       null,
                   onChanged: (val) {
                     state.didChange(val);
                     if (state.hasError) {
                       state.validate();
                     }
                     onChanged?.call(val);
                   },
                   style: AppTextStyles.bodyLarge.copyWith(
                     color: !enabled
                         ? AppColors.textDisabled
                         : readOnly
                             ? AppColors.textMuted
                             : AppColors.textPrimary,
                     fontWeight: FontWeight.w500,
                   ),
                   cursorColor: AppColors.primary,
                   decoration: InputDecoration(
                     isDense: true,
                     hintText: hintText,
                     hintStyle: AppTextStyles.bodyLarge.copyWith(
                       color: AppColors.textDisabled,
                       fontWeight: FontWeight.w400,
                     ),
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.symmetric(
                       horizontal: AppDimensions.w12,
                       vertical: AppDimensions.h12,
                     ),
                     suffixIcon: suffixIcon != null
                         ? Padding(
                             padding: EdgeInsets.only(
                               right: AppDimensions.w12,
                             ),
                             child: suffixIcon,
                           )
                         : null,
                     suffixIconConstraints: const BoxConstraints(
                       minWidth: 0,
                       minHeight: 0,
                     ),
                   ),
                 ),
               ),
               if (helperWidget != null)
                 Padding(
                   padding: EdgeInsets.only(top: AppDimensions.h4),
                   child: helperWidget,
                 ),
               if (hasError)
                 Padding(
                   padding: EdgeInsets.only(top: AppDimensions.h4),
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       if (showErrorIcon) ...[
                         Icon(
                           Icons.error_outline_rounded,
                           size: AppDimensions.iconXs,
                           color: AppColors.error,
                         ),
                         SizedBox(width: AppDimensions.w4),
                       ],
                       Flexible(
                         child: Text(
                           effectiveError,
                           style: AppTextStyles.caption.copyWith(
                             color: AppColors.error,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
             ],
           );
         },
       );

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  final int maxLines;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool showErrorIcon;
  final Widget? suffixIcon;
  final Widget? helperWidget;

  @override
  FormFieldState<String> createState() => _AppUnderlineTextFieldState();
}

class _AppUnderlineTextFieldState extends FormFieldState<String> {
  TextEditingController? _internalController;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  AppUnderlineTextField get widget => super.widget as AppUnderlineTextField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppUnderlineTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _internalController =
            TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _internalController?.dispose();
          _internalController = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _internalController?.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
