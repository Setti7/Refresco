import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseApi {
  Future<ParseResponse> query(QueryBuilder queryBuilder) {
    return queryBuilder.query();
  }
}
