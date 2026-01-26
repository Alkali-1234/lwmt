// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Day _$DayFromJson(Map<String, dynamic> json) => _Day(
  day: (json['day'] as num).toInt(),
  spendings: (json['spendings'] as List<dynamic>)
      .map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) =>
              ($jsonValue[r'$1'] as String, ($jsonValue[r'$2'] as num).toInt()),
        ),
      )
      .toList(),
);

Map<String, dynamic> _$DayToJson(_Day instance) => <String, dynamic>{
  'day': instance.day,
  'spendings': instance.spendings
      .map((e) => <String, dynamic>{r'$1': e.$1, r'$2': e.$2})
      .toList(),
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
