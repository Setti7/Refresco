import 'package:refresco/core/models/address.dart';
import 'package:refresco/core/models/gallon.dart';
import 'package:refresco/core/models/store.dart';
import 'package:refresco/core/services/database/database_service.dart';
import 'package:refresco/core/services/service_response.dart';
import 'package:refresco/utils/logger.dart';
import 'package:logger/logger.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseDatabaseService implements DatabaseService {
  final Logger _logger = getLogger('ParseDatabaseService');

  @override
  Future<ServiceResponse> getStores(Address address) async {
    if (address == null) {
      _logger.w('failed to get stores: address is null');
      return ServiceResponse(success: false);
    }

    var addressQuery = QueryBuilder(ParseObject('Address'))
      ..whereWithinKilometers(
        'coordinate',
        ParseGeoPoint(
          latitude: address.coordinate.latitude,
          longitude: address.coordinate.longitude,
        ),
        10,
      );

    var storeQuery = QueryBuilder(ParseObject('Store'))
      ..whereValueExists('address', true)
      ..whereMatchesQuery('address', addressQuery)
      ..includeObject(['address']);

    var response = await storeQuery.query();

    var stores = <Store>[];

    if (response.success) {
      if (response.results != null) {
        stores = response.results.map((store) {
          return Store.fromParse(store);
        }).toList();
      }
      return ServiceResponse(success: true, results: stores);
    } else if (response.error.code == 1) {
      return ServiceResponse(success: true, results: stores);
    } else {
      return ServiceResponse.fromParseError(response.error, results: stores);
    }
  }

  @override
  Future<ServiceResponse> getGallons(Store store, GallonType gallonType) async {
    var query = QueryBuilder(ParseObject('Gallon'))
      ..whereRelatedTo('gallons', 'Store', store.id)
      ..whereEqualTo(
        'type',
        gallonType == GallonType.l20 ? 'l20' : 'l10',
      );

    var response = await query.query();

    var gallons = <Gallon>[];

    if (response.success) {
      if (response.results != null) {
        gallons = response.results.map((store) {
          return Gallon.fromParse(store);
        }).toList();
      }
      return ServiceResponse(success: true, results: gallons);
    } else if (response.error.code == 1) {
      return ServiceResponse(success: true, results: gallons);
    } else {
      return ServiceResponse.fromParseError(response.error, results: gallons);
    }
  }
}
