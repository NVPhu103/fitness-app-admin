import 'package:fitness_app_admin/utilities/context.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.title,
    this.initialText,
    required this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.onClear,
    this.isValidate = true,
    this.type,
  });

  final TextInputType? keyboardType;
  final String title;
  final String? initialText;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onClear;
  final bool isValidate;
  final int? type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title ${type != null ? (type == 1 ? '(gram)' : '(milligram)') : ''}',
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          autovalidateMode:
              isValidate ? AutovalidateMode.onUserInteraction : null,
          keyboardType: type != null ? TextInputType.number : keyboardType,
          enabled: enabled,
          readOnly: readOnly,
          initialValue: initialText,
          maxLines: 1,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: !enabled
                ? context.textTheme.bodySmall?.copyWith(
                    color: context.appColor.colorGrey,
                    fontWeight: FontWeight.w400,
                  )
                : context.textTheme.bodySmall,
            isDense: true,
            hintStyle: context.textTheme.bodySmall,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            suffixIcon: onClear != null && (initialText ?? '').isNotEmpty
                ? GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: context.appColor.colorBlack,
                    ),
                    onTap: () {
                      onClear?.call();
                    },
                  )
                : null,
          ),
          onChanged: onChanged,
          validator: isValidate ? _validationText : null,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  String? _validationText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }
}
