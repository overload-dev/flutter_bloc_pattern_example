import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/models/popular.dart';
import 'package:flutter_bloc_pattern_example/service/movie_service.dart';
import 'package:provider/provider.dart';

class MovieListings extends StatefulWidget {
  const MovieListings({Key? key}) : super(key: key);

  @override
  _MovieListingsState createState() => _MovieListingsState();
}

class _MovieListingsState extends State<MovieListings> {
  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie API Test'),
      ),
      body: _buildBody(context),
    );
  }


  FutureBuilder<Response<Popular>> _buildBody(BuildContext context) {
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
    // 1
    return ListView.builder(
      // 2
      itemCount: popular.results.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // 3
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // 4
                      image: NetworkImage(
                          IMAGE_URL + popular.results[index].posterPath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        // 5
                        Text(popular.results[index].title,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Text(
                              // 6
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
