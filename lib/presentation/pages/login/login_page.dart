import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:testando_mobx/presentation/pages/home/home_page.dart';
import 'package:testando_mobx/presentation/pages/login/mobx/login_page_mobx.dart';

class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);
  LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// // }

// class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _senhaNode = FocusNode();
  final _loginPageMobx = LoginPageMobx();
  final _senhaPageMobx = LoginPageMobx();

  // String _email = '';
  // String _senha = '';

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

  _senhaEhValida() {
    return _senhaPageMobx.senha.value.trim().isNotEmpty;
  }

  _emailEhValido() {
    if (_loginPageMobx.email.value.trim().isEmpty) {
      return false;
    }

    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    final RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(_loginPageMobx.email.value);
  }

  _onPressedParaBotaoAcessar({BuildContext? context}) {
    if (_emailEhValido() && _senhaEhValida()) {
      return () => Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
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
              onChanged: (valor) => _loginPageMobx.atualizarEmail!([valor]),
              decoration: const InputDecoration(
                prefix: Icon(Icons.email),
                hintText: "Informe o email",
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: !_emailEhValido(),
                  child: _mensagemDeErro("Email Necessário"),
                );
              },
            ),
            TextField(
              keyboardType: TextInputType.text,
              focusNode: _senhaNode,
              onChanged: (valor) => _senhaPageMobx.atualizarSenha!([valor]),
              decoration: const InputDecoration(
                prefix: Icon(Icons.security),
                hintText: "Informe a senha",
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: !_senhaEhValida(),
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
