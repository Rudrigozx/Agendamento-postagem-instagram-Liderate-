import 'package:flutter/material.dart';

class PostagemCard extends StatelessWidget {
  final String titulo;
  final String legenda;
  final String data;
  final String imagem;

  const PostagemCard({
    super.key,
    required this.titulo,
    required this.legenda,
    required this.data,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imagem, width: constraints.maxWidth * 0.18, height: constraints.maxWidth * 0.18, fit: BoxFit.cover),
          ),
          title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(legenda, maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: Chip(
            label: Text(data, style: const TextStyle(fontSize: 12)),
            backgroundColor: Colors.blue.shade50,
          ),
        ),
      ),
    );
  }
}