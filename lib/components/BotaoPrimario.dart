import 'package:agendamento_postagens/style/Cor.dart';
import 'package:flutter/material.dart';

class BotaoPrimario extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoPrimario({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return SizedBox(
      width: largura * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Cor.primaria,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
