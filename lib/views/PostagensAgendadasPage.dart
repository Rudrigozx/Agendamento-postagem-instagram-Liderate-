import 'package:agendamento_postagens/components/Calendario.dart';
import 'package:agendamento_postagens/components/PostagemCard.dart';
import 'package:agendamento_postagens/controllers/PostagemController.dart';
import 'package:agendamento_postagens/models/Postagem.dart';
import 'package:agendamento_postagens/style/Cor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    print('eae');
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
          isLoading=false;
    });
  }

  Map<DateTime, List<Postagem>> agruparPostagensPorData(
    List<Postagem> postagens,
  ) {
    final Map<DateTime, List<Postagem>> mapa = {};

    for (var postagem in postagens) {
      final data = normalizarData(
        postagem.dataAgendamento,
      ); 
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Cor.primaria,
        onPressed: () {
          context.go('/agendar');
        },
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      body: (isLoading)?Center(child: CircularProgressIndicator())
      :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Postagens Agendadas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CalendarioWidget(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            onDaySelected: _onDaySelected,
            eventosPorDia: agruparPostagensPorData(todasPostagens),
          ),
          SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Postagens Agendadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          (_postagens.length > 0)
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _postagens.length,
                    itemBuilder: (context, index) {
                      final post = _postagens[index];
                      return PostagemCard(
                        titulo: post.titulo,
                        legenda: post.legenda,
                        data:
                            '${post.dataAgendamento.day.toString().padLeft(2, '0')}/${post.dataAgendamento.month.toString().padLeft(2, '0')}/${post.dataAgendamento.year}',
                        imagem:
                            'https://tse3.mm.bing.net/th?id=OIP.kuW2YzHPI3SnqKMjuD_PGgHaE8&pid=Api&P=0&h=180',
                      );
                    },
                  ),
                )
              : Expanded(
                  child: Center(child: Text("Nenhuma postagem agendada")),
                ),
        ],
      ),
    );
  }
}
