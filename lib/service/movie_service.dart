import 'package:chopper/chopper.dart';
import 'package:flutter_bloc_pattern_example/models/lists.dart';
import 'package:flutter_bloc_pattern_example/models/popular.dart';
import 'package:flutter_bloc_pattern_example/service/header_interceptor.dart';
import 'package:flutter_bloc_pattern_example/service/model_converter.dart';

part 'movie_service.chopper.dart';

// API 호출 클래스, Chopper 로 Http Client 호출 구성을 자동화한다.
@ChopperApi()
abstract class MovieService extends ChopperService {
  @Get(path: 'movie/popular')
  Future<Response<Popular>> getPopularMovies();

  @Get(path: 'movie/550/lists')
  Future<Response<Lists>> getPageOfMovies(@Query() int page);

  static MovieService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3',
      services: [
        _$MovieService(),
      ],
      // HTTP 통신 요청을 가로 채 필요한 작업을 수행한다.(헤더 추가, 로그 기록 등)
      interceptors: [
        HeaderInterceptor(),
        HttpLoggingInterceptor(),
      ],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
    );
    return _$MovieService(client);
  }
}
