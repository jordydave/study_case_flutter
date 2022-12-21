import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/injection.dart' as di;
import 'package:study_case/presentation/pages/post_detail_page.dart';
import 'package:study_case/presentation/pages/post_page.dart';

import 'domain/entities/post.dart';
import 'presentation/bloc/post_bloc.dart';
import 'utils/utils.dart';

void main() {
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => di.locator<PostBloc>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coding Test Flutter',
        home: const PostPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const PostPage());
            case PostDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) => PostDetailPage(post: args as Post?),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
