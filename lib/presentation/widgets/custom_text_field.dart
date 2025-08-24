import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_system.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool readOnly;
  final String? helperText;
  final String? errorText;
  final Color? borderColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.readOnly = false,
    this.helperText,
    this.errorText,
    this.borderColor,
    this.fillColor,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (labelText.isNotEmpty) ...[
          Text(
            labelText,
            style: DesignSystem.inputLabelStyle,
          ),
          const SizedBox(height: 8),
        ],
        
        // Text Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          enabled: enabled,
          autofocus: autofocus,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          readOnly: readOnly,
          validator: validator,
          style: AppTheme.bodyStyle.copyWith(
            color: enabled ? AppTheme.textPrimaryColor : AppTheme.textSecondaryColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(
              prefixIcon,
              color: _getIconColor(context),
              size: 20,
            ) : null,
            suffixIcon: suffixIcon,
            helperText: helperText,
            errorText: errorText,
            filled: true,
            fillColor: _getFillColor(context),
            border: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: _getBorderColor(context),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: _getBorderColor(context),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: AppTheme.errorColor,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: AppTheme.errorColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: DesignSystem.radius12,
              borderSide: BorderSide(
                color: AppTheme.borderColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            contentPadding: contentPadding ?? DesignSystem.inputPadding,
            hintStyle: DesignSystem.inputHintStyle.copyWith(
              color: enabled ? AppTheme.textTertiaryColor : AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
            errorStyle: AppTheme.captionStyle.copyWith(
              color: AppTheme.errorColor,
              fontSize: 12,
            ),
            helperStyle: AppTheme.captionStyle.copyWith(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Color _getIconColor(BuildContext context) {
    if (!enabled) return AppTheme.textSecondaryColor.withOpacity(0.5);
    if (errorText != null) return AppTheme.errorColor;
    return AppTheme.textSecondaryColor;
  }

  Color _getFillColor(BuildContext context) {
    if (fillColor != null) return fillColor!;
    if (!enabled) return AppTheme.backgroundColor;
    return AppTheme.surfaceColor;
  }

  Color _getBorderColor(BuildContext context) {
    if (borderColor != null) return borderColor!;
    if (!enabled) return AppTheme.borderColor.withOpacity(0.5);
    return AppTheme.borderColor;
  }
}

// Specialized text field variants
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const EmailTextField({
    super.key,
    required this.controller,
    this.validator,
    this.helperText,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'البريد الإلكتروني',
      hintText: 'أدخل بريدك الإلكتروني',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email,
      validator: validator ?? _emailValidator,
      helperText: helperText,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.validator,
    this.helperText,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool _isPasswordVisible = false;
        
        return CustomTextField(
          controller: controller,
          labelText: 'كلمة المرور',
          hintText: 'أدخل كلمة المرور',
          obscureText: !_isPasswordVisible,
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppTheme.textSecondaryColor,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          validator: validator ?? _passwordValidator,
          helperText: helperText,
          enabled: enabled,
          focusNode: focusNode,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.done,
        );
      },
    );
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const SearchTextField({
    super.key,
    required this.controller,
    this.hintText = 'البحث...',
    this.onChanged,
    this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: '',
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: Icon(
                Icons.clear,
                color: AppTheme.textSecondaryColor,
              ),
              onPressed: () {
                controller.clear();
                onClear?.call();
              },
            )
          : null,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const NumberTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.helperText,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      keyboardType: TextInputType.number,
      prefixIcon: Icons.numbers,
      validator: validator,
      helperText: helperText,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
    );
  }
}
