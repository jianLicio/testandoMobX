import '../../domain/models/produto_model.dart';

List<ProdutoModel> _listaDeProdutos = [
  ProdutoModel(
    produtoId: 1,
    nome: 'Suco de Laranja',
    descricao: 'Suco natural (300ml)',
    valor: 4,
    urlImagem: 'assets/images/produtos/sucodelaranja.jpg',
  ),
  ProdutoModel(
    produtoId: 2,
    nome: 'Suco de uva',
    descricao: 'Suco de polpa (300ml)',
    valor: 4.5,
    urlImagem: 'assets/images/produtos/sucodeuva.jpg',
  ),
  ProdutoModel(
    produtoId: 3,
    nome: 'Frango à passárinho',
    descricao: '300 gramas',
    valor: 40,
    urlImagem: 'assets/images/produtos/frangoapassarinho.jpg',
  ),
  ProdutoModel(
    produtoId: 4,
    nome: 'tabua de frios',
    descricao: 'é isso ae...',
    valor: 82.96,
    urlImagem: 'assets/images/produtos/tabuadefrios.jpeg',
  ),
];

List<ProdutoModel> listaDeProdutos() {
  _listaDeProdutos.sort(
    ((a, b) => a.nome.toLowerCase().compareTo(
          b.nome.toLowerCase(),
        )),
  );
  return List.unmodifiable(_listaDeProdutos);
}
