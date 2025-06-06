import 'package:agendamento_postagens/components/Calendario.dart';
import 'package:agendamento_postagens/components/PostagemCard.dart';
import 'package:agendamento_postagens/controllers/PostagemController.dart';
import 'package:agendamento_postagens/models/Postagem.dart';
import 'package:agendamento_postagens/style/Cor.dart';
import 'package:agendamento_postagens/utils/confirmar_saida.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class PostagensAgendadasPage extends StatefulWidget {
  const PostagensAgendadasPage({super.key});

  @override
  State<PostagensAgendadasPage> createState() => _PostagensAgendadasPageState();
}

class _PostagensAgendadasPageState extends State<PostagensAgendadasPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  List<Postagem> _postagens = [];
  List<Postagem> todasPostagens = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarPostagens();
    setState(() {
      isLoading = false;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _carregarPostagens();
  }

  DateTime normalizarData(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _carregarPostagens() async {
    final controller = PostagemController();
    todasPostagens = await controller.listar();
    setState(() {
      _postagens = todasPostagens
          .where(
            (post) =>
                post.dataAgendamento.year == _selectedDay!.year &&
                post.dataAgendamento.month == _selectedDay!.month &&
                post.dataAgendamento.day == _selectedDay!.day,
          )
          .toList();
      isLoading = false;
    });
  }

  Map<DateTime, List<Postagem>> agruparPostagensPorData(
    List<Postagem> postagens,
  ) {
    final Map<DateTime, List<Postagem>> mapa = {};

    for (var postagem in postagens) {
      final data = normalizarData(postagem.dataAgendamento);
      if (mapa.containsKey(data)) {
        mapa[data]!.add(postagem);
      } else {
        mapa[data] = [postagem];
      }
    }

    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        final confirmar = await ConfirmarSaida(context);
        if (confirmar && mounted) {
          SystemNavigator.pop(); // Fecha o app
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Cor.primaria,
          onPressed: () {
            context.go('/agendar');
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Postagens Agendadas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CalendarioWidget(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    onDaySelected: _onDaySelected,
                    eventosPorDia: agruparPostagensPorData(todasPostagens),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Postagens Agendadas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (_postagens.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _postagens.length,
                            itemBuilder: (context, index) {
                              final post = _postagens[index];
                              return PostagemCard(
                                titulo: post.titulo,
                                legenda: post.legenda,
                                data:
                                    '${post.dataAgendamento.day.toString().padLeft(2, '0')}/${post.dataAgendamento.month.toString().padLeft(2, '0')}/${post.dataAgendamento.year}',
                                hora:
                                    '${post.horaAgendamento.hour.toString().padLeft(2, '0')}:${post.horaAgendamento.minute.toString().padLeft(2, '0')}',
                                imagem: post.imagemUrl,
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text("Nenhuma postagem agendada"),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
