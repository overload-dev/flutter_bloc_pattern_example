import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/models/list_result.dart';
import 'package:flutter_bloc_pattern_example/service/movie_service.dart';

class MovieListings extends StatefulWidget {
  const MovieListings({Key? key}) : super(key: key);

  @override
  _MovieListingsState createState() => _MovieListingsState();
}

class _MovieListingsState extends State<MovieListings> {
  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";

  final MovieService ms = MovieService.create();

  final ScrollController _scrollController = ScrollController();

  List<ListResult> listResult = [];

  int page = 1;

  bool _dataLoading = false;

  @override
  void initState() {
    super.initState();
    //최초 진입 데이터 호출
    _initData();

    _scrollController.addListener(() {
      _loadData();
    });
  }

  _initData() async {
    var re = await ms.getPageOfMovies(page);
    setState(() {
      listResult.addAll(re.body!.results);
    });
  }

  _loadData() async {
    // _dataLoading 변수
    // 데이터 요청 도중에는 스크롤이 재 정의 되지 않으므로
    // 불필요하게 연속적으로 데이터를 호출하는 상황을 방지하기 위함.
    if (_scrollController.position.extentAfter <= 100.0 && !_dataLoading) {
      setState(() {
        _dataLoading = !_dataLoading;
      });

      var re = await ms.getPageOfMovies(page + 1);
      setState(() {
        page++;
        listResult.addAll(re.body!.results);
        _dataLoading = !_dataLoading;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie API Test - Page: $page'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                page++;
              });
            },
            child: const Text('Next'),
          )
        ],
      ),
      body: SafeArea(
        child: _buildMovieList(context),
      ),
    );
  }

  // 단일 호출
  // _buildBody(BuildContext context) {
  //   return FutureBuilder<Response<Lists>>(
  //     future: Provider.of<MovieService>(context).getPageOfMovies(page),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.hasError) {
  //           return Center(
  //             child: Text(
  //               snapshot.error.toString(),
  //               textAlign: TextAlign.center,
  //               textScaleFactor: 1.3,
  //             ),
  //           );
  //         }
  //
  //         final lists = snapshot.data!.body;
  //
  //         return _buildMovieList(context, lists!);
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  ListView _buildMovieList(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: listResult.length,
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
                    IMAGE_URL + listResult[index].posterPath,
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
                          listResult[index].name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Text(
                          // 6
                          listResult[index].description,
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
