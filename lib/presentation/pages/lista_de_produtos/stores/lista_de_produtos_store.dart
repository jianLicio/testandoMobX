import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:testando_mobx/domain/models/produto_model.dart';
import 'package:testando_mobx/presentation/pages/home/stores/home_page_store.dart';
part 'lista_de_produtos_store.g.dart';

class ListaDeProdutosStore = _ListaDeProdutosStore with _$ListaDeProdutosStore;

abstract class _ListaDeProdutosStore with Store {
  @observable
  int _quantidadeSelecionada = 1;

  @computed
  int get quantidadeSelecionada => _quantidadeSelecionada;

  @action
  atualizarQuantidadeSelecionada(int novaQuantidade) {
    _quantidadeSelecionada = novaQuantidade;
  }

  @action
  registrarProduto({required ProdutoModel produto, required int quantidade}) {
    GetIt.instance
        .get<HomePageStore>()
        .somarAoTotalDoPedido(valor: produto.valor * quantidade);
  }
}
