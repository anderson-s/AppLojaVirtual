class Validations {
  String? validator;

  static validarNome(validator) {
    if (validator.trim().isEmpty) {
      return "O nome é obrigatório!";
    } else if (validator.trim().length < 3) {
      return "O nome precisa de pelo menos três caracteres";
    } else {
      return null;
    }
  }

  static validarPreco(validator) {
    if (validator.trim().isEmpty) {
      return "O preço é obrigatório!";
    }
  }

  static validarDescricao(validator) {
    if (validator.trim().isEmpty) {
      return "A descrição é obrigatória!";
    } else {
      return null;
    }
  }

  static validarUrl(validator) {
    bool isValidUrl = Uri.tryParse(validator)?.hasAbsolutePath ?? false;
    bool endsWithFile = validator.toString().toLowerCase().endsWith(".png") ||
        validator.toString().toLowerCase().endsWith(".jpg") ||
        validator.toString().toLowerCase().endsWith(".jpeg");
    if (validator.isEmpty) {
      return "A imagem é obrigatória!";
    } else if (!isValidUrl || !endsWithFile) {
      return "A url é inválida";
    } else {
      return null;
    }
  }
}
