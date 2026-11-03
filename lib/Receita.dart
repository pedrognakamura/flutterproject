import 'package:flutter/material.dart';

/// Normaliza a consulta: remove espaços nas pontas e reduz sequências de
/// espaços internos a um único espaço. Retorna string vazia se não houver texto.
String normalizarConsulta(String? texto) =>
    (texto ?? '').trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).join(' ');

/// Retorna a mensagem de erro para uma consulta inválida, ou null se válida.
String? validarConsulta(String? texto) {
  if (normalizarConsulta(texto).isEmpty) {
    return 'Digite o nome da receita para pesquisar. Exemplo: bolo de cenoura.';
  }
  return null;
}

class Receita extends StatefulWidget {
  const Receita({super.key});

  @override
  State<Receita> createState() => _ReceitaState();
}

class _ReceitaState extends State<Receita> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  /// Termo válido da última pesquisa; null quando não há pesquisa ativa.
  String? _termoPesquisado;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pesquisar() {
    // Após a primeira tentativa, o erro some assim que o usuário corrige.
    setState(() => _autovalidate = AutovalidateMode.onUserInteraction);

    if (!_formKey.currentState!.validate()) {
      // Consulta inválida: não inicia pesquisa e descarta feedback anterior.
      setState(() => _termoPesquisado = null);
      return;
    }

    setState(() => _termoPesquisado = normalizarConsulta(_controller.text));
  }

  Widget _buildBusca() {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  validator: validarConsulta,
                  onFieldSubmitted: (_) => _pesquisar(),
                  decoration: const InputDecoration(
                    errorMaxLines: 4,
                    labelText: 'Nome da receita',
                    hintText: 'Ex.: bolo de cenoura',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: FilledButton.icon(
                  onPressed: _pesquisar,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(48, 48),
                  ),
                  icon: const Icon(Icons.search),
                  label: const Text('Pesquisar'),
                ),
              ),
            ],
          ),
          if (_termoPesquisado != null) ...[
            const SizedBox(height: 12),
            Semantics(
              liveRegion: true,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesquisando por: "$_termoPesquisado"',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Resultados provisórios: a lista real de receitas '
                      'ainda será conectada. Você pode editar o campo e '
                      'pesquisar novamente.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Livro de Receitas"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBusca(),
            const SizedBox(height: 24),
            _buildReceita(),
          ],
        ),
      ),
    );
  }

  Widget _buildReceita() {
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.cake, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Bolo de Cenoura com Chocolate',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.timer, size: 18),
                  SizedBox(width: 6),
                  Text("Preparo: 50 minutos"),
                  SizedBox(width: 20),
                  Icon(Icons.restaurant, size: 18),
                  SizedBox(width: 6),
                  Text("Rende: 10 fatias"),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Ingredientes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("• 3 cenouras médias"),
              Text("• 4 ovos"),
              Text("• 1 xícara de óleo"),
              Text("• 2 xícaras de açúcar"),
              Text("• 2 xícaras de farinha de trigo"),
              Text("• 1 colher de sopa de fermento"),
              SizedBox(height: 20),
              Text(
                "Modo de preparo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("1. Bata no liquidificador a cenoura, os ovos e o óleo."),
              SizedBox(height: 4),
              Text("2. Misture com o açúcar e a farinha."),
              SizedBox(height: 4),
              Text("3. Acrescente o fermento e misture delicadamente."),
              SizedBox(height: 4),
              Text("4. Asse em forno a 180°C por cerca de 40 minutos."),
            ],
          ),
        );
  }
}
