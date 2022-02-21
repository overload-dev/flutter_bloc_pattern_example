import 'dart:async';

import 'package:chopper/chopper.dart';

// 요청 시 헤더에 토큰을 포함하기 위한 클래스
class HeaderInterceptor implements RequestInterceptor {
  static const String AUTH_HEADER = 'Authorization';
  static const String BEARER = 'Bearer ';
  static const String V4_AUTH_HEADER =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWM2MmNlY2U0YjMwMmVkOGQyOThjYWVmOWVlYmVjYiIsInN1YiI6IjYyMTJlZGU0YTM5ZDBiMDA2YzFhNGIwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0_8zLEQwiDDPWkopYASgKBKBlaCSKyjPxNB96rFhT5E";

  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest = request.copyWith(headers: {
      AUTH_HEADER: BEARER + V4_AUTH_HEADER,
    });
    return newRequest;
  }
}
