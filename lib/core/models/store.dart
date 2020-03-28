import 'dart:math';

import 'package:flutter_base/core/models/address.dart';
import 'package:flutter_base/core/models/gallon.dart';
import 'package:flutter_base/core/models/operating_time.dart';
import 'package:flutter_parse/flutter_parse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store {
  final String id;
  final String name;
  final String description;
  final double rating;
  final int minDeliveryTime;
  final int maxDeliveryTime;
  final int phone;
  final OperatingTime operatingTime;
  final Address address;
  final List<Gallon> gallons;

  const Store({
    this.name,
    this.id,
    this.description,
    this.rating,
    this.minDeliveryTime,
    this.maxDeliveryTime,
    this.phone,
    this.operatingTime,
    this.address,
    this.gallons,
  });

  // TODO: remove this from the store card
  Gallon lowestPrice(GallonType gallonType) {
    if (gallons.isEmpty) {
      return Gallon(type: GallonType.l20, price: 100.0, company: 'Bonafont');
    }

    var lowestPrice = gallons
        .where((g) => g.type == gallonType)
        .map((g) => g.price)
        .reduce(min);

    return gallons.firstWhere((g) => g.price == lowestPrice);
  }

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  factory Store.fromParse(ParseObject store) {
    // TODO finish
    return Store(
      name: store.getString('name'),
      id: store.getString('id'),
      description: store.getString('description'),
      rating: store.getDouble('rating'),
      phone: store.getInteger('phone'),
      gallons: [],
      maxDeliveryTime: 15,
      minDeliveryTime: 10,
      address: Address.fromParse(
        store.getParseObject('address'),
      ),
    );
  }

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
