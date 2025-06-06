import 'package:agendamento_postagens/components/AgendamentoPicker.dart';
import 'package:agendamento_postagens/components/BotaoPrimario.dart';
import 'package:agendamento_postagens/components/CampoDeTexto.dart';
import 'package:agendamento_postagens/components/ImageSelector.dart';
import 'package:agendamento_postagens/controllers/PostagemController.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgendarPostagemPage extends StatefulWidget {
  const AgendarPostagemPage({super.key});

  @override
  State<AgendarPostagemPage> createState() => _AgendarPostagemPageState();
}

class _AgendarPostagemPageState extends State<AgendarPostagemPage> {
  int selectedIndex = 0;

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController legendaController = TextEditingController();

  late DateTime dataAgendamento;
  late TimeOfDay horaAgendamento;

  @override
  void initState() {
    super.initState();
    final agora = DateTime.now();
    dataAgendamento = agora;
    horaAgendamento = TimeOfDay(hour: agora.hour, minute: agora.minute);
  }
  List<String> imageUrls = [
    'https://tse3.mm.bing.net/th?id=OIP.kuW2YzHPI3SnqKMjuD_PGgHaE8&pid=Api&P=0&h=180',
    'https://tse4.mm.bing.net/th?id=OIP.yqbYGaQ5gg7qnCm9jVpAogHaDW&pid=Api&P=0&h=180',
    'https://tse2.mm.bing.net/th?id=OIP.fpKCNvXCZx3BQtP08IKDtAHaEK&pid=Api&P=0&h=180',
    'https://tse2.mm.bing.net/th?id=OIP.ldrfgqL3Zd7GPCvmx5YRVQHaFj&pid=Api&P=0&h=180',
    'https://tse2.mm.bing.net/th?id=OIP.FBlvUm-gzoo0TsVHZaBL9gHaEK&pid=Api&P=0&h=180'
  ];

  void onImageSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onSelecionarData(DateTime novaData) {
    setState(() {
      dataAgendamento = novaData;
    });
  }

  void onSelecionarHora(TimeOfDay novaHora) {
    setState(() {
      horaAgendamento = novaHora;
    });
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: altura * 0.08),
            Center(
              child: Text(
                'Agendar Postagem',
                style: TextStyle(fontSize: largura * 0.05, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: altura * 0.03),
            ImageSelector(
              imageUrls: imageUrls,
              selectedIndex: selectedIndex,
              onImageSelected: onImageSelected,
            ),
            SizedBox(height: altura * 0.04),
            Text('Título',
                style: TextStyle(fontSize: largura * 0.045, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CampoTexto(
              label: 'Título da postagem',
              hint: 'Digite o título',
              controller: tituloController,
            ),
            SizedBox(height: altura * 0.03),
            Text('Legenda',
                style: TextStyle(fontSize: largura * 0.045, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CampoTexto(
              label: 'Legenda da postagem',
              hint: 'Digite a legenda',
              controller: legendaController,
              maxLines: 4,
            ),
            SizedBox(height: altura * 0.04),
            AgendamentoPicker(
              data: dataAgendamento,
              hora: horaAgendamento,
              onSelecionarData: onSelecionarData,
              onSelecionarHora: onSelecionarHora,
            ),
            SizedBox(height: altura * 0.05),
            Center(
              child: BotaoPrimario(
                texto: 'Agendar',
                onPressed: () {
                  final titulo = tituloController.text;
                  final descricao = legendaController.text;

                  if (titulo.isEmpty || descricao.isEmpty ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos')),
                    );
                    return;
                  }

                  PostagemController controller = PostagemController();
                  controller.criar(titulo, descricao, dataAgendamento, horaAgendamento);
                  context.go('/');
                },
              ),
            ),
            SizedBox(height: altura * 0.05),
          ],
        ),
      ),
    );
  }
}
