import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/models/lists.dart';
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
        title: const Text('Movie API Test'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                page++;
              });
            },
            child: const Text('call'),
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  List<Lists> contents = [];

  int page = 1;

  FutureBuilder<Response<Lists>> _buildBody(BuildContext context) {
    return FutureBuilder<Response<Lists>>(
      future: Provider.of<MovieService>(context).getPageOfMovies(page),
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

          final lists = snapshot.data!.body;

          return _buildMovieList(context, lists!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildMovieList(BuildContext context, Lists lists) {
    // 1
    return ListView.builder(
      // 2
      itemCount: lists.results.length,
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
                SizedBox(
                  width: 150,
                  height: 200,
                  child: Image.network(
                    IMAGE_URL + lists.results[index].posterPath,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/noImage.png');
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        // 5
                        Text(
                          lists.results[index].name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Text(
                          // 6
                          lists.results[index].description,
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
