import 'package:flutter/material.dart';

class Postagem {
  String titulo;
  String legenda;
  DateTime dataAgendamento;
  TimeOfDay horaAgendamento;

  Postagem({
    required this.titulo,
    required this.legenda,
    required this.dataAgendamento,
    required this.horaAgendamento,
  });
}
