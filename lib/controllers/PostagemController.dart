import 'dart:convert';
import 'package:agendamento_postagens/models/Postagem.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostagemController {
  static const String _key = 'postagens';

  Future<void> criar(String titulo, String descricao, String imagemUrl,  DateTime dataAgendamento, TimeOfDay horaAgendamento) async {
    final prefs = await SharedPreferences.getInstance();
    final postagem = Postagem(
      titulo: titulo,
      legenda: descricao,
      imagemUrl: imagemUrl,
      dataAgendamento: dataAgendamento,
      horaAgendamento: horaAgendamento,
    );

    List<String> listaSalva = prefs.getStringList(_key) ?? [];
    listaSalva.add(jsonEncode(postagem.toJson()));
    await prefs.setStringList(_key, listaSalva);
  }

  Future<List<Postagem>> listar() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList(_key) ?? [];

    return lista
        .map((item) => Postagem.fromJson(jsonDecode(item)))
        .toList();
  }
}
