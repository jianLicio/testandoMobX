import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:testando_mobx/presentation/pages/home/home_page.dart';
import 'package:testando_mobx/presentation/pages/login/stores/login_page_store.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final FocusNode _emailNode = FocusNode();
  final FocusNode _senhaNode = FocusNode();
  final _loginPageStore = LoginPageStore();

  _mensagemDeErro(String mensagem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          mensagem,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _onPressedParaBotaoAcessar({BuildContext? context}) {
    if (_loginPageStore.oFormularioEhValido) {
      return () => Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobx App"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              focusNode: _emailNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_senhaNode),
              onChanged: (valor) => _loginPageStore.atualizarEmail(valor),
              decoration: const InputDecoration(
                prefix: Icon(Icons.email),
                hintText: "Informe o email",
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: !_loginPageStore.oEmailEhValido,
                  child: _mensagemDeErro("Email Necessário"),
                );
              },
            ),
            TextField(
              keyboardType: TextInputType.text,
              focusNode: _senhaNode,
              onChanged: (valor) => _loginPageStore.atualizarSenha(valor),
              decoration: const InputDecoration(
                prefix: Icon(Icons.security),
                hintText: "Informe a senha",
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: !_loginPageStore.aSenhaEhValida,
                  child: _mensagemDeErro("Senha Necessária"),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Observer(
                builder: (_) {
                  return ElevatedButton(
                    onPressed: _onPressedParaBotaoAcessar(context: context),
                    child: const Text("Acessar"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
