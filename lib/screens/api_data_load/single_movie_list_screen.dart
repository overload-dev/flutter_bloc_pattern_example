import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/models/popular.dart';
import 'package:flutter_bloc_pattern_example/service/movie_service.dart';
import 'package:provider/provider.dart';

class SingleMovieListScreen extends StatefulWidget {
  const SingleMovieListScreen({Key? key}) : super(key: key);

  @override
  _SingleMovieListScreenState createState() => _SingleMovieListScreenState();
}

class _SingleMovieListScreenState extends State<SingleMovieListScreen> {
  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
  final MovieService ms = MovieService.create();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MovieService 클래스에 액세스 하기 위한 클래스
    // 상위 클래스에서 선언하면 자식 클래스는 모두 Provider.of<MovieService>(context) 형태로 접근할 수 있다.
    return Provider(
      create: (context) => MovieService.create(),
      dispose: (_, MovieService service) => service.client.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie API Test (Single)'),
        ),
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  // 단일 호출
  _buildBody(BuildContext context) {
    return FutureBuilder<Response<Popular>>(
      future: Provider.of<MovieService>(context).getPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final popular = snapshot.data!.body;

          return _buildMovieList(context, popular!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildMovieList(BuildContext context, Popular popular) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: popular.results.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 200,
                  child: Image.network(
                    IMAGE_URL + popular.results[index].posterPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noImage.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        // Title
                        Text(
                          popular.results[index].title,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Overview
                        Expanded(
                            child: Text(
                          popular.results[index].overview,
                          style: const TextStyle(fontSize: 12),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
