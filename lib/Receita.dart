import 'package:flutter/material.dart';

class Receita extends StatelessWidget {
  const Receita({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Livro de Receitas"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
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
        ),
      ),
    );
  }
}
