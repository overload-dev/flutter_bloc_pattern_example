import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_bloc_pattern_example/models/lists.dart';
import 'package:flutter_bloc_pattern_example/models/popular.dart';
import 'package:flutter_bloc_pattern_example/service/constants.dart';

// API 에서 호출한 문자열을 클래스 인스턴스로 변환하기 위한 변환기
class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];

    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }

    String requestUrl = response.base.request!.url.path;
    try {
      var mapData = json.decode(body);

      //데이터 구조가 다르므로 요청 데이터에 따라 변환 클래스에 분기를 준다.
      switch (requestUrl) {
        case REQ_LISTS:
          var lists = Lists.fromJson(mapData);
          return response.copyWith<BodyType>(body: lists as BodyType);
        case REQ_POPULAR:
          var popular = Popular.fromJson(mapData);
          return response.copyWith<BodyType>(body: popular as BodyType);
        default:
          throw Exception('invalid request');
      }
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
