import 'package:core_resources/core_resources.dart';
import 'package:flutter/cupertino.dart';

/// Use multiple validators, returning null if all of them pass or the result of the
/// first one not passing
FormFieldValidator<String> validators(List<FormFieldValidator<String>> validators) {
  return (input) {
    return validators.firstWhere(
      (validator) => (validator(input) ?? '').isNotBlank,
      orElse: () => (s) => null,
    )(input);
  };
}

/// Validator only allowing non-blank values
FormFieldValidator<String> requiredValidator({String errorMessage = 'Campo obrigatório'}) {
  return (input) => (input ?? '').isBlank ? errorMessage : null;
}

/// Validator only allowing values above the given length
FormFieldValidator<String> minLengthValidator(int minLength, {String? errorMessage}) {
  return (input) {
    return (input ?? '').length < minLength
        ? (errorMessage ?? 'Mínimo de $minLength caracteres requiridos')
        : null;
  };
}

/// Validator only allowing valid emails
FormFieldValidator<String> emailValidator({
  String errorMessage = 'Email inválido',
  bool allowBlank = false,
}) {
  final emailRegex = RegExp(r'''^[^@]+@[^@]+$''');
  return (input) {
    final str = input ?? '';
    if (allowBlank && str.isBlank) return null;
    return emailRegex.hasMatch(str) ? null : errorMessage;
  };
}

/// Validator only allowing valid phone numbers
FormFieldValidator<String> phoneValidator({
  int requiredLength = 11,
  String errorMessage = 'Telefone inválido',
}) {
  return (input) => (input ?? '').onlyNumbers().length == requiredLength ? null : errorMessage;
}

/// Validator only allowing valid cpf numbers
FormFieldValidator<String> cpfValidator({String errorMessage = 'CPF inválido'}) {
  return (input) => (input ?? '').onlyNumbers().length == 11 ? null : errorMessage;
}

/// Validator only allowing valid cnpj numbers
FormFieldValidator<String> cnpjValidator({String errorMessage = 'CNPJ inválido'}) {
  return (input) => (input ?? '').onlyNumbers().length == 14 ? null : errorMessage;
}

/// Validator only allowing valid zip numbers
FormFieldValidator<String> zipValidator({String errorMessage = 'CEP inválido'}) {
  return (input) => (input ?? '').onlyNumbers().length == 8 ? null : errorMessage;
}

/// Validator only allowing valid zip numbers
FormFieldValidator<String> userValidator({String errorMessage = 'Nome de usuário inválido'}) {
  return (input) {
    final regex = RegExp(r'^[\w\._]+$');
    return regex.hasMatch(input ?? '') ? null : errorMessage;
  };
}
