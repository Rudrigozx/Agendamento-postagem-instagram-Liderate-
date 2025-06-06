import 'package:agendamento_postagens/style/Cor.dart';
import 'package:flutter/material.dart';

class AgendamentoPicker extends StatelessWidget {
  final DateTime data;
  final TimeOfDay hora;
  final void Function(DateTime) onSelecionarData;
  final void Function(TimeOfDay) onSelecionarHora;

  const AgendamentoPicker({
    super.key,
    required this.data,
    required this.hora,
    required this.onSelecionarData,
    required this.onSelecionarHora,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final novaData = await showDatePicker(
                context: context,
                initialDate: data,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            Cor.primaria, // cor principal (botões, seleção)
                        onPrimary:
                            Colors.white, // cor do texto no botão principal
                        onSurface: Cor.primaria, // cor do texto padrão
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (novaData != null) {
                onSelecionarData(novaData);
              }
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
              child: Text(
                '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}',
                style: TextStyle(fontSize: width * 0.04),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final novaHora = await showTimePicker(
                barrierColor: Cor.primaria,
                context: context,
                initialTime: hora,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            Cor.primaria, // cor principal (botões, seleção)
                        onPrimary:
                            Colors.white, // cor do texto no botão principal
                        onSurface: Cor.primaria, // cor do texto padrão
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (novaHora != null) {
                onSelecionarHora(novaHora);
              }
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.access_time),
                labelText: 'Hora',
                border: OutlineInputBorder(),
              ),
              child: Text(
                hora.format(context),
                style: TextStyle(fontSize: width * 0.04),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
