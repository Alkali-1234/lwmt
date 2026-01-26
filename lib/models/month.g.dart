// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Month _$MonthFromJson(Map<String, dynamic> json) => _Month(
  allocation: (json['allocation'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  days: (json['days'] as List<dynamic>)
      .map((e) => Day.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MonthToJson(_Month instance) => <String, dynamic>{
  'allocation': instance.allocation,
  'month': instance.month,
  'year': instance.year,
  'days': instance.days,
};
