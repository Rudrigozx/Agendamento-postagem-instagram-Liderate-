import 'package:flutter/material.dart';

class Postagem {
  String titulo;
  String legenda;
  DateTime dataAgendamento;
  TimeOfDay horaAgendamento;
  String imagemUrl;

  Postagem({
    required this.titulo,
    required this.legenda,
    required this.imagemUrl,
    required this.dataAgendamento,
    required this.horaAgendamento,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagemUrl': imagemUrl,
      'titulo': titulo,
      'legenda': legenda,
      'dataAgendamento': dataAgendamento.toIso8601String(),
      'horaAgendamento': '${horaAgendamento.hour}:${horaAgendamento.minute}',
    };
  }

  factory Postagem.fromJson(Map<String, dynamic> json) {
    final horaSplit = json['horaAgendamento'].split(':');
    return Postagem(
      imagemUrl: json['imagemUrl'],
      titulo: json['titulo'],
      legenda: json['legenda'],
      dataAgendamento: DateTime.parse(json['dataAgendamento']),
      horaAgendamento: TimeOfDay(
        hour: int.parse(horaSplit[0]),
        minute: int.parse(horaSplit[1]),
      ),
    );
  }
}
