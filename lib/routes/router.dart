import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/result_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'Question',
      builder: (BuildContext context, GoRouterState state) =>
          const QuestionScreen(),
    ),
    GoRoute(
      path: '/result/:id',
      name: 'ResultScreen',
      builder: (BuildContext context, GoRouterState state) {
        final id = int.parse(state.pathParameters['id']!);
        return ResultScreen(id: id);
      },
    ),
  ],
);
