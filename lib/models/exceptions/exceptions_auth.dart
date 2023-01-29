class ExceptionsAuth implements Exception {
  final String msg;

  Map<String, String> exceptions = {
    "EMAIL_EXISTS": "O endereço de e-mail já está sendo usado por outra conta.",
    "OPERATION_NOT_ALLOWED":
        "O login por senha está desabilitado para este projeto.",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.",
    "EMAIL_NOT_FOUND": "Email não encontrado.",
    "INVALID_PASSWORD": "Senha inválida.",
    "USER_DISABLED":
        "A conta de usuário foi desabilitada por um administrador.",
  };

  ExceptionsAuth({required this.msg});

  @override
  String toString() {
    return exceptions[msg] ?? "Ocorreu um erro no processo.";
  }
}
