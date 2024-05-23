class Validators {
  const Validators._();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email est requis';
    }
    if (!value.contains('@')) {
      return 'Email invalide';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe est requis';
    } else if (value.length < 6) {
      return 'password length should be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? passwordValue) {
    if (value == null || value.isEmpty) {
      return 'La confirmation du mot de passe est requise';
    }
    if (value != passwordValue) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  static String? nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    return null;
  }

  static String? pinCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    if (value.length < 6) {
      return 'Le code doit contenir 6 chiffres';
    }

    if (int.tryParse(value) == null) {
      return 'Le code doit contenir uniquement des chiffres';
    }
    return null;
  }

  static String? phone(String? value) {
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Numéro de téléphone invalide';
    }

    return null;
  }
}