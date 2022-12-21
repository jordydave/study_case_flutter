import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/presentation/bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<PostBloc>().add(PostGetList());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostHasData) {
              return Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      final suggestions = state.posts?.where(
                        (post) {
                          final postTitle = post.title?.toLowerCase();
                          final input = query.toLowerCase();

                          return postTitle!.contains(input);
                        },
                      ).toList();
                      setState(() {
                        if (query.isNotEmpty) {
                          state.posts = suggestions;
                        } else {
                          context.read<PostBloc>().add(PostGetList());
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.posts?.length,
                    itemBuilder: (context, index) {
                      final post = state.posts![index];
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: post,
                          );
                        },
                        title: Text(post.title ?? ""),
                      );
                    },
                  ),
                ],
              );
            } else if (state is PostError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
