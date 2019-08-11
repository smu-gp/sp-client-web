import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/rendering.dart';
import 'package:flutter_web/widgets.dart';
import 'package:sp_client/widget/rich_text_field/service/spannable_text.dart';

class SpanEditableText extends EditableText {
  final SpannableTextController spannableController;

  SpanEditableText({
    Key key,
    @required TextEditingController controller,
    @required this.spannableController,
    @required FocusNode focusNode,
    bool obscureText = false,
    bool autocorrect = true,
    @required TextStyle style,
    StrutStyle strutStyle,
    @required Color cursorColor,
    @required Color backgroundCursorColor,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection,
    Locale locale,
    double textScaleFactor,
    int maxLines = 1,
    bool autofocus = false,
    Color selectionColor,
    TextSelectionControls selectionControls,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    ValueChanged<String> onChanged,
    VoidCallback onEditingComplete,
    ValueChanged<String> onSubmitted,
    SelectionChangedCallback onSelectionChanged,
    List<TextInputFormatter> inputFormatters,
    bool rendererIgnoresPointer = false,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    bool cursorOpacityAnimates = false,
    Offset cursorOffset,
    bool paintCursorAboveText = false,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    Brightness keyboardAppearance = Brightness.light,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection,
  }) : super(
          key: key,
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          autocorrect: autocorrect,
          style: style,
          strutStyle: strutStyle,
          cursorColor: cursorColor,
          backgroundCursorColor: backgroundCursorColor,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          autofocus: autofocus,
          selectionColor: selectionColor,
          selectionControls: selectionControls,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          onSelectionChanged: onSelectionChanged,
          inputFormatters: inputFormatters,
          rendererIgnoresPointer: rendererIgnoresPointer,
          cursorWidth: cursorWidth,
          cursorRadius: cursorRadius,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorOffset: cursorOffset,
          paintCursorAboveText: paintCursorAboveText,
          scrollPadding: scrollPadding,
          keyboardAppearance: keyboardAppearance,
          dragStartBehavior: dragStartBehavior,
          enableInteractiveSelection: enableInteractiveSelection ?? true,
        );

  @override
  SpanEditableTextState createState() =>
      SpanEditableTextState(this.spannableController);
}

class SpanEditableTextState extends EditableTextState {
  final SpannableTextController _spannableController;

  SpanEditableTextState(this._spannableController);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSpannableController);
    if (_spannableController != null) {
      _spannableController.addListener(_didChangeSpannableTextStyle);
    }
  }

  @override
  void dispose() {
    if (_spannableController != null) {
      _spannableController.removeListener(_didChangeSpannableTextStyle);
    }
    super.dispose();
  }

  void _updateSpannableController() {
    if (_spannableController != null) {
      _spannableController.sourceText = widget.controller.value.text;
      _spannableController.selection = widget.controller.value.selection;
    }
  }

  void _didChangeSpannableTextStyle() {
    setState(() {});
  }

  @override
  TextSpan buildTextSpan() {
    if (_spannableController != null) {
      return super.buildTextSpan();
    } else {
      return super.buildTextSpan();
    }
  }
}
