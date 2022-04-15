import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testando_mobx/domain/models/produto_model.dart';
import 'package:testando_mobx/presentation/mixins/presentation_mixin.dart';

class ListTileParaListaDeProdutosWidget extends StatelessWidget
    with PresentationMixin {
  final ProdutoModel produtoModel;
  final formacaoMonetaria = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final Function funcaoDeCallbackParaInserirProduto;

  ListTileParaListaDeProdutosWidget({
    Key? key,
    required this.produtoModel,
    required this.funcaoDeCallbackParaInserirProduto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(produtoModel.urlImagem),
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gerarTexto(
                  texto: produtoModel.nome,
                  negrito: true,
                ),
                gerarTexto(
                  texto: produtoModel.descricao,
                  tamanhoDaFonte: 15,
                )
              ],
            ),
          ),
          gerarTexto(
              texto: formacaoMonetaria.format(produtoModel.valor),
              negrito: true,
              cor: Colors.blue),
        ],
      ),
      trailing: Column(
        children: const [
          InkWell(
            child: Icon(
              Icons.add,
              size: 48,
              color: Color.fromARGB(255, 22, 208, 233),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
