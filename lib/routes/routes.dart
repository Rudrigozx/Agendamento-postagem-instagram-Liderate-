import 'package:agendamento_postagens/views/AgendarPostagemPage.dart';
import 'package:agendamento_postagens/views/PostagensAgendadasPage.dart';
import 'package:go_router/go_router.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'Postagens Agendadas',
      builder: (context, state) => PostagensAgendadasPage(),
    ),
    GoRoute(
      path: '/agendar',
      name: 'Agendar postagem',
      builder: (context, state) => AgendarPostagemPage(),
    ),
    
  ],

);
