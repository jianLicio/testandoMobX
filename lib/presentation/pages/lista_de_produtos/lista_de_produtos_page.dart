import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testando_mobx/data/datasources/produtos_datasource.dart'
    as datasurce;
import 'package:testando_mobx/presentation/pages/lista_de_produtos/lista_de_produtos_mixin.dart';
import 'package:testando_mobx/presentation/pages/lista_de_produtos/stores/lista_de_produtos_store.dart';
import 'package:testando_mobx/presentation/pages/lista_de_produtos/widgets/listtile_para_lista_de_produtos_widget.dart';

import '../../../domain/models/produto_model.dart';

class ListaDeProdutosPage extends StatelessWidget with ListaDeProdutosMixin {
  const ListaDeProdutosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProdutoModel> produtos = datasurce.listaDeProdutos();
    final ListaDeProdutosStore listaDeProdutosStore =
        GetIt.instance<ListaDeProdutosStore>();

    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ListTileParaListaDeProdutosWidget(
            produtoModel: produtos[index],
            funcaoDeCallbackParaInserirProduto: () async {
              int quantidade = await exibirSelecaoDeQuantidade(
                context: context,
                item: produtos[index].nome,
              );
              listaDeProdutosStore.registrarProduto(
                produto: produtos[index],
                quantidade: quantidade,
              );
              print('quantidade: $quantidade');
            },
          );
        });
  }
}
