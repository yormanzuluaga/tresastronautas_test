import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tresastronautas_ui/tresastronautas_ui.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onComplete,
    this.onFieldSubmitted,
    this.isDisabled = false,
    this.isObscureText = false,
    this.autocorrect = true,
    this.validator,
    this.controller,
    this.autoFillHints,
    this.inputFormatters,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.tapSuffixIcon,
    this.tapPrefixIcon,
    this.customErrorText,
    this.focusNode,
    this.scrollPadding,
    this.enableInteractiveSelection = true,
    this.showMaxLengthMessage = false,
    this.customErrorPaddingTop = AppSpacing.sm,
    this.helpText,
    this.onHelpIconClick,
    this.isRequired = false,
    this.initialValue,
    this.autovalidateMode,
    this.toolTipContent,
    this.addHelpIconSpace = false,
    this.isWeb = false,
  }) : assert(!(onHelpIconClick != null && toolTipContent != null),
            'Declaring both onHelpIconClick and toolTipContent is not supported.');

  final String? label;
  final String? hintText;
  final String? customErrorText;
  final int? maxLines;
  final int? maxLength;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onComplete;
  final Function(String)? onFieldSubmitted;
  final bool isDisabled;
  final bool isObscureText;
  final Function(String value)? validator;
  final TextEditingController? controller;
  final bool autocorrect;
  final Iterable<String>? autoFillHints;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final Function? tapSuffixIcon;
  final Function? tapPrefixIcon;
  final FocusNode? focusNode;
  final bool? enableInteractiveSelection;
  final bool showMaxLengthMessage;
  final EdgeInsets? scrollPadding;
  final double customErrorPaddingTop;
  final String? helpText;
  final void Function()? onHelpIconClick;
  final Widget? toolTipContent;
  final bool isRequired;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;
  final bool addHelpIconSpace;
  final bool isWeb;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();

  late FocusNode _textFocusNode;
  bool _hasError = false;
  String _text = '';
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _textFocusNode = widget.focusNode ?? FocusNode();
    _textFocusNode.addListener(_onFocusChange);
    _text = widget.controller?.text ?? '';
    _errorText = widget.customErrorText ?? '';
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _text = widget.controller?.text ?? '';
    if (widget.customErrorText?.isNotEmpty ?? false) {
      _errorText = widget.customErrorText!;
      _hasError = true;
    } else if (oldWidget.customErrorText != null &&
        (widget.customErrorText == null ||
            (widget.customErrorText?.isEmpty ?? false))) {
      _errorText = '';
      _hasError = false;
    }
  }

  @override
  void dispose() {
    _textFocusNode.removeListener(_onFocusChange);
    _textFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.label != null
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          (widget.onHelpIconClick != null && !kIsWeb ? 0.9 : 1),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: widget.label,
                        style:
                            UITextStyle.paragraphs.paragraph2Regular.copyWith(
                          color: widget.isDisabled
                              ? AppColors.grey4
                              : _hasError
                                  ? AppColors.primary
                                  : _textFocusNode.hasPrimaryFocus
                                      ? AppColors.primary
                                      : _text.isNotEmpty
                                          ? AppColors.black
                                          : AppColors.grey4,
                        ),
                        children: [
                          if (widget.isRequired)
                            TextSpan(
                              text: '*',
                              style: UITextStyle.paragraphs.paragraph2Regular
                                  .copyWith(
                                color: AppColors.primary,
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            if (widget.onHelpIconClick != null && !widget.isWeb)
              _renderHelpIconfromCallback(
                onTap: widget.onHelpIconClick,
                isWeb: widget.isWeb,
                isHidden: widget.addHelpIconSpace,
              ),
            if (widget.toolTipContent != null && !widget.isWeb)
              _renderHelpIconFromWidget(
                controller: _controller,
                link: _link,
                content: widget.toolTipContent!,
                isHidden: widget.addHelpIconSpace,
                isWeb: widget.isWeb,
              ),
          ],
        ),
        widget.label != null
            ? const SizedBox(
                height: AppSpacing.xs,
              )
            : const SizedBox(),
        widget.maxLines != null
            ? TextFormField(
                autovalidateMode: widget.autovalidateMode,
                initialValue: widget.initialValue,
                scrollPadding: widget.scrollPadding != null
                    ? widget.scrollPadding!
                    : const EdgeInsets.all(20.0),
                focusNode: _textFocusNode,
                controller: widget.controller,
                validator: widget.validator != null
                    ? (e) {
                        _validator(e);
                        return null;
                      }
                    : null,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                autocorrect: widget.autocorrect,
                enabled: !widget.isDisabled,
                autofillHints: widget.autoFillHints,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                onTap: () {
                  setState(() {
                    _textFocusNode.requestFocus();
                  });
                  if (widget.onTap != null) widget.onTap!();
                },
                onTapOutside: (_) {
                  setState(() {
                    _textFocusNode.unfocus();
                  });
                  if (widget.onComplete != null) widget.onComplete!(_text);
                },
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                  setState(() {
                    _text = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _textFocusNode.unfocus();
                  });
                  if (widget.onComplete != null) widget.onComplete!(_text);
                },
                cursorColor: _hasError ? AppColors.primary : AppColors.primary,
                decoration: InputDecoration(
                  counter: const SizedBox.shrink(),
                  filled: true,
                  fillColor:
                      widget.isDisabled ? AppColors.grey1 : AppColors.white,
                  hintText: _hasError ? '' : widget.hintText,
                  hintStyle: UITextStyle.paragraphs.paragraph1Regular.copyWith(
                    color: AppColors.grey4,
                  ),
                  hoverColor: AppColors.grey2,
                  prefixText: widget.prefixText,
                  contentPadding: kIsWeb
                      ? const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        )
                      : const EdgeInsets.all(16),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.grey4,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _hasError
                          ? AppColors.primary
                          : _textFocusNode.hasPrimaryFocus
                              ? AppColors.primary
                              : _text.isNotEmpty
                                  ? AppColors.black
                                  : AppColors.grey4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  error: _renderErrorWidget(),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10, left: 16),
                          child: Icon(
                            widget.prefixIcon,
                            size: 30.0,
                            color: _hasError
                                ? AppColors.primary
                                : _textFocusNode.hasPrimaryFocus
                                    ? AppColors.primary
                                    : _text.isNotEmpty
                                        ? AppColors.black
                                        : AppColors.grey4,
                          ))
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              if (widget.tapSuffixIcon != null) {
                                widget.tapSuffixIcon!();
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 16),
                              child: Icon(
                                widget.suffixIcon,
                                size: 30.0,
                                color: _hasError
                                    ? AppColors.primary
                                    : _textFocusNode.hasPrimaryFocus
                                        ? AppColors.primary
                                        : _text.isNotEmpty
                                            ? AppColors.black
                                            : AppColors.grey4,
                              ),
                            ),
                          ),
                        )
                      : null,
                  suffixIconConstraints: const BoxConstraints.tightFor(
                    width: 50,
                    height: 30,
                  ),
                  prefixIconConstraints: const BoxConstraints.tightFor(
                    width: 50,
                    height: 30,
                  ),
                ),
              )
            : Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      autovalidateMode: widget.autovalidateMode,
                      initialValue: widget.initialValue,
                      onFieldSubmitted: (value) {
                        if (widget.onFieldSubmitted != null)
                          widget.onFieldSubmitted!(value);
                        setState(() {
                          _text = value;
                        });
                      },
                      enableInteractiveSelection:
                          widget.enableInteractiveSelection,
                      focusNode: _textFocusNode,
                      scrollPadding: widget.scrollPadding != null
                          ? widget.scrollPadding!
                          : const EdgeInsets.all(20.0),
                      controller: widget.controller,
                      validator: widget.validator != null
                          ? (e) {
                              _validator(e);
                              return null;
                            }
                          : null,
                      maxLength: widget.maxLength,
                      obscureText: widget.isObscureText,
                      autocorrect: widget.autocorrect,
                      enabled: !widget.isDisabled,
                      autofillHints: widget.autoFillHints,
                      inputFormatters: widget.inputFormatters,
                      keyboardType: widget.keyboardType,
                      onTap: () {
                        setState(() {
                          _textFocusNode.requestFocus();
                        });
                        if (widget.onTap != null) widget.onTap!();
                      },
                      onTapOutside: (_) {
                        setState(() {
                          _textFocusNode.unfocus();
                        });
                        if (widget.onComplete != null)
                          widget.onComplete!(_text);
                      },
                      onChanged: (value) {
                        if (widget.onChanged != null) widget.onChanged!(value);
                        setState(() {
                          _text = value;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          _textFocusNode.unfocus();
                        });
                        if (widget.onComplete != null)
                          widget.onComplete!(_text);
                      },
                      cursorColor:
                          _hasError ? AppColors.primary : AppColors.primary,
                      decoration: InputDecoration(
                        counter: const SizedBox.shrink(),
                        filled: true,
                        fillColor: widget.isDisabled
                            ? AppColors.grey1
                            : AppColors.white,
                        hintText: _hasError ? '' : widget.hintText,
                        hintStyle:
                            UITextStyle.paragraphs.paragraph1Regular.copyWith(
                          color: AppColors.grey4,
                        ),
                        isDense: true,
                        hoverColor: AppColors.grey2,
                        prefixText: widget.prefixText,
                        contentPadding: kIsWeb
                            ? const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              )
                            : const EdgeInsets.all(16),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.grey4,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: _hasError
                                ? AppColors.primary
                                : _textFocusNode.hasPrimaryFocus
                                    ? AppColors.primary
                                    : _text.isNotEmpty
                                        ? AppColors.black
                                        : AppColors.grey4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: _hasError
                                ? AppColors.primary
                                : _textFocusNode.hasPrimaryFocus
                                    ? AppColors.primary
                                    : _text.isNotEmpty
                                        ? AppColors.black
                                        : AppColors.grey4,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        error: _renderErrorWidget(),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        prefixIcon: widget.prefixIcon != null
                            ? GestureDetector(
                                onTap: () {
                                  if (widget.tapPrefixIcon != null) {
                                    widget.tapPrefixIcon!();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 16),
                                  child: Icon(
                                    widget.prefixIcon,
                                    size: 30.0,
                                    color: _hasError
                                        ? AppColors.primary
                                        : _textFocusNode.hasPrimaryFocus
                                            ? AppColors.primary
                                            : _text.isNotEmpty
                                                ? AppColors.black
                                                : AppColors.grey4,
                                  ),
                                ),
                              )
                            : null,
                        suffixIcon: widget.suffixIcon != null
                            ? MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    if (widget.tapSuffixIcon != null) {
                                      widget.tapSuffixIcon!();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 16),
                                    child: Icon(
                                      widget.suffixIcon,
                                      size: 30.0,
                                      color: _hasError
                                          ? AppColors.primary
                                          : _textFocusNode.hasPrimaryFocus
                                              ? AppColors.primary
                                              : _text.isNotEmpty
                                                  ? AppColors.black
                                                  : AppColors.grey4,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        suffixIconConstraints: const BoxConstraints.tightFor(
                          width: 50,
                          height: 30,
                        ),
                        prefixIconConstraints: const BoxConstraints.tightFor(
                          width: 50,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  if (widget.onHelpIconClick != null && widget.isWeb)
                    _renderHelpIconfromCallback(
                      onTap: widget.onHelpIconClick,
                      isWeb: widget.isWeb,
                      isHidden: widget.addHelpIconSpace,
                    ),
                  if (widget.toolTipContent != null && widget.isWeb)
                    _renderHelpIconFromWidget(
                      controller: _controller,
                      link: _link,
                      content: widget.toolTipContent!,
                      isWeb: widget.isWeb,
                      isHidden: widget.addHelpIconSpace,
                    ),
                ],
              ),
        if (widget.helpText != null && !_hasError)
          Text(
            widget.helpText!,
            style: UITextStyle.captions.captionMedium.copyWith(
              color: AppColors.grey4,
            ),
          ),
        widget.showMaxLengthMessage && widget.maxLength != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Caracteres: ${widget.controller!.text.length}/${widget.maxLength}',
                  style: UITextStyle.paragraphs.paragraph2Regular.copyWith(
                    color: widget.isDisabled
                        ? AppColors.grey4
                        : _hasError
                            ? AppColors.primary
                            : _textFocusNode.hasPrimaryFocus
                                ? AppColors.primary
                                : _text.isNotEmpty
                                    ? AppColors.black
                                    : AppColors.grey4,
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _renderHelpIconfromCallback({
    void Function()? onTap,
    void Function(bool hasFocus)? onHover,
    bool isWeb = false,
    bool isHidden = false,
  }) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      child: Padding(
        padding: isWeb
            ? const EdgeInsets.only(bottom: AppSpacing.md, left: AppSpacing.sm)
            : const EdgeInsets.only(left: AppSpacing.sm),
        child: Icon(
          PhosphorIcons.question(),
          color: isHidden ? AppColors.transparent : AppColors.grey4,
          size: isWeb ? AppSpacing.xlg : AppSpacing.lg,
        ),
      ),
    );
  }

  Widget _renderHelpIconFromWidget({
    required OverlayPortalController controller,
    required LayerLink link,
    required Widget content,
    bool isHidden = false,
    bool isWeb = false,
  }) {
    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: link,
            targetAnchor: Alignment.centerRight,
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.translationValues(12, -120, 0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: content,
                ),
                Transform.translate(
                  offset: const Offset(-8, -20),
                  child: Transform.rotate(
                    angle: pi,
                    child: const Icon(
                      Icons.play_arrow,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: _renderHelpIconfromCallback(
          onTap: () => controller.toggle(),
          onHover: (hasFocus) =>
              hasFocus ? controller.show() : controller.hide(),
          isHidden: isHidden,
          isWeb: isWeb,
        ),
      ),
    );
  }

  Container? _renderErrorWidget() {
    return _errorText.isNotEmpty && _hasError
        ? Container(
            transform: Matrix4.translationValues(-16, 0, 0),
            child: Row(
              children: [
                _hasError
                    ? Icon(
                        PhosphorIcons.warningCircle(),
                        size: 16.0,
                        color: AppColors.primary,
                      )
                    : const SizedBox(),
                SizedBox(width: _hasError ? 8 : 0),
                Text(
                  _errorText,
                  style: UITextStyle.captions.captionMedium.copyWith(
                    color: _hasError
                        ? AppColors.primary
                        : _textFocusNode.hasPrimaryFocus
                            ? AppColors.primary
                            : _text.isNotEmpty
                                ? AppColors.black
                                : AppColors.grey4,
                    height: 1,
                  ),
                ),
              ],
            ),
          )
        : null;
  }

  String? _validator(String? value) {
    final validation = widget.validator!(value ?? '');

    if (validation != null) {
      _hasError = true;
      _errorText = validation;
    } else if (widget.customErrorText?.isNotEmpty ?? false) {
      _hasError = true;
      _errorText = widget.customErrorText!;
    } else {
      _hasError = false;
      _errorText = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });

    return validation;
  }
}
