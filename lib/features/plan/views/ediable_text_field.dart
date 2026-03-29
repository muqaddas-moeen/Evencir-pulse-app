import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class EditableTextField extends StatefulWidget {
  final String initialValue;
  final Function(String) onSave;
  final bool isDuration;

  const EditableTextField({
    super.key,
    required this.initialValue,
    required this.onSave,
    this.isDuration = false,
  });

  @override
  State<EditableTextField> createState() => EditableTextFieldState();
}

class EditableTextFieldState extends State<EditableTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _lastSavedValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _lastSavedValue = widget.initialValue;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(EditableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue && !_focusNode.hasFocus) {
      _controller.text = widget.initialValue;
      _lastSavedValue = widget.initialValue;
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _save();
    }
  }

  void _save() {
    if (_controller.text != _lastSavedValue) {
      _lastSavedValue = _controller.text;
      widget.onSave(_controller.text);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onSubmitted: (val) {
        _save();
        _focusNode.unfocus();
      },
      style: AppStyle.mulishTextStyle(
          c: AppColors.kOffWhiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: widget.isDuration ? '00m' : 'Workout Title',
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      ),
    );
  }
}
