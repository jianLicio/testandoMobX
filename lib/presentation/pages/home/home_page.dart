import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:testando_mobx/presentation/mixins/presentation_mixin.dart';
import 'package:testando_mobx/presentation/pages/home/stores/home_page_store.dart';
import 'package:testando_mobx/presentation/pages/lista_de_produtos/lista_de_produtos_page.dart';
import 'package:testando_mobx/presentation/pages/produtos_selecionados/produtos_selecionados_page.dart';

class HomePage extends StatelessWidget with PresentationMixin {
  final HomePageStore _homePageStore = GetIt.instance.get<HomePageStore>();
  final formatacaoMonetaria = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final List<Widget> _paginas = [
    const ListaDeProdutosPage(),
    const ProdutoSelecionadosPage(),
  ];

  HomePage({Key? key}) : super(key: key);

  _bottomNavigationBarItem({required IconData icone, required String titulo}) {
    return BottomNavigationBarItem(
      icon: Icon(icone),
      label: titulo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(_homePageStore.tituloHomePage);
          },
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total Pedido',
              ),
              Observer(
                builder: (_) {
                  return gerarTexto(
                    texto:
                        formatacaoMonetaria.format(_homePageStore.totalPedido),
                    cor: const Color.fromARGB(255, 27, 221, 72),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          return _paginas[_homePageStore.paginaAtual];
        },
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavigationBar(
            iconSize: 48,
            currentIndex: _homePageStore.paginaAtual,
            onTap: (index) => _homePageStore.alternarPagina(index),
            items: [
              _bottomNavigationBarItem(
                icone: Icons.menu,
                titulo: 'Produtos',
              ),
              _bottomNavigationBarItem(
                  icone: Icons.add_shopping_cart, titulo: 'Pedido'),
            ],
          );
        },
      ),
    );
  }
}
