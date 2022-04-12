import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
//flutter packages pub run build_runner buil
part 'login_page_store.g.dart';

class LoginPageStore = _LoginPageStore with _$LoginPageStore;

abstract class _LoginPageStore with Store {
  @observable
  String email = '';

  @observable
  String senha = '';

  @computed
  bool get oEmailEhValido {
    if (email.trim().isEmpty) return false;
    const Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regex = RegExp(pattern as String);

    return regex.hasMatch(email);
  }

  @computed
  bool get aSenhaEhValida => senha.trim().isNotEmpty;

  @computed
  bool get oFormularioEhValido => (oEmailEhValido && aSenhaEhValida);

  @action
  atualizarEmail(String novoValor) {
    email = novoValor;
  }

  @action
  atualizarSenha(String novoValor) {
    senha = novoValor;
  }
}
