import 'package:go_router/go_router.dart';
import 'package:lista_tienda/presentation/screen/screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: HomeProductosScreen.name,
      builder: (context, state) => const HomeProductosScreen(),
    ),
  ],
);
