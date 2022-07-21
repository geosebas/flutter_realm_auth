import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.icon,
    this.autovalidateMode,
  });

  final String? restorationId;
  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final int? maxLength;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Icon? icon;
  final AutovalidateMode? autovalidateMode;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> with RestorationMixin {
  final RestorableBool _obscureText = RestorableBool(true);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_obscureText, '${widget.restorationId}_obscure_text');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      autovalidateMode: widget.autovalidateMode,
      restorationId: widget.restorationId,
      obscureText: _obscureText.value,
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText ?? ' ',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText.value = !_obscureText.value;
            });
          },
          hoverColor: Colors.transparent,
          icon: Icon(
            _obscureText.value ? Icons.visibility : Icons.visibility_off,
            semanticLabel: _obscureText.value ? "show password" : "Hide password",
          ),
        ),
      ),
    );
  }
}
