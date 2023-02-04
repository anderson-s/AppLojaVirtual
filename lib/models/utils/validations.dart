class Validations {
  String? validacao;
  static validarNome(String validator) {
    if (validator.trim().isEmpty) {
      return "O nome é obrigatório!";
    } else if (validator.trim().length < 3) {
      return "O nome precisa de pelo menos três caracteres";
    } else {
      return null;
    }
  }

  static validarPreco(String validator) {
    if (validator.trim().isEmpty) {
      return "O preço é obrigatório!";
    }
  }

  static validarDescricao(String validator) {
    if (validator.trim().isEmpty) {
      return "A descrição é obrigatória!";
    } else {
      return null;
    }
  }

  static validarUrl(String validator) {
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

  static String? validarEmail(validacao) {
    if (validacao.toString().isEmpty) {
      return "O email é obrigatório";
    }
    if (!validacao.trim().toString().contains("@")) {
      return "Informe um email válido";
    }
    return null;
  }

  static String? validarSenha(validacao) {
    if (validacao.toString().isEmpty) {
      return "A senha é obrigatória";
    }
    if (validacao.toString().length < 6) {
      return "A senha deve ter pelo menos 6 caracteres";
    }
    return null;
  }
}
