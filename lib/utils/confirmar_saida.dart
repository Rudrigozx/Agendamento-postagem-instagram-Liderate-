import 'package:flutter/material.dart';

Future<bool> ConfirmarSaida(BuildContext context) async {
  final bool? confirmar = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Tem certeza que deseja sair?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Sim, sair'),
        ),
      ],
    ),
  );

  return confirmar ?? false;
}
