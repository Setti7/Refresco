// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    name: json['name'] as String,
    id: json['id'] as String,
    description: json['description'] as String,
    rating: (json['rating'] as num).toDouble(),
    minDeliveryTime: json['minDeliveryTime'] as int,
    maxDeliveryTime: json['maxDeliveryTime'] as int,
    phone: json['phone'] as int,
    operatingTime:
        OperatingTime.fromJson(json['operatingTime'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'minDeliveryTime': instance.minDeliveryTime,
      'maxDeliveryTime': instance.maxDeliveryTime,
      'phone': instance.phone,
      'operatingTime': instance.operatingTime.toJson(),
    };
