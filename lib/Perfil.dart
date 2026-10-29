import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil Profissional"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person),),
                  SizedBox(width: 16,),
                  Expanded(child: Text(
                    'João Marcos - Engenheiro de Software',
                    style: TextStyle(fontSize: 20),
                    )
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Link para os projetos em:"),
              SizedBox(height: 8,),
              Text("Londrina - Paraná ")
            ],
          ),
        ),
      ),
    );
  }
}
