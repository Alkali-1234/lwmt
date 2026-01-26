// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Month implements DiagnosticableTreeMixin {

 int get allocation; set allocation(int value); int get month; set month(int value); int get year; set year(int value); List<Day> get days; set days(List<Day> value);
/// Create a copy of Month
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthCopyWith<Month> get copyWith => _$MonthCopyWithImpl<Month>(this as Month, _$identity);

  /// Serializes this Month to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Month'))
    ..add(DiagnosticsProperty('allocation', allocation))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('days', days));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Month(allocation: $allocation, month: $month, year: $year, days: $days)';
}


}

/// @nodoc
abstract mixin class $MonthCopyWith<$Res>  {
  factory $MonthCopyWith(Month value, $Res Function(Month) _then) = _$MonthCopyWithImpl;
@useResult
$Res call({
 int allocation, int month, int year, List<Day> days
});




}
/// @nodoc
class _$MonthCopyWithImpl<$Res>
    implements $MonthCopyWith<$Res> {
  _$MonthCopyWithImpl(this._self, this._then);

  final Month _self;
  final $Res Function(Month) _then;

/// Create a copy of Month
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allocation = null,Object? month = null,Object? year = null,Object? days = null,}) {
  return _then(_self.copyWith(
allocation: null == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<Day>,
  ));
}

}


/// Adds pattern-matching-related methods to [Month].
extension MonthPatterns on Month {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Month value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Month() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Month value)  $default,){
final _that = this;
switch (_that) {
case _Month():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Month value)?  $default,){
final _that = this;
switch (_that) {
case _Month() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int allocation,  int month,  int year,  List<Day> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Month() when $default != null:
return $default(_that.allocation,_that.month,_that.year,_that.days);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int allocation,  int month,  int year,  List<Day> days)  $default,) {final _that = this;
switch (_that) {
case _Month():
return $default(_that.allocation,_that.month,_that.year,_that.days);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int allocation,  int month,  int year,  List<Day> days)?  $default,) {final _that = this;
switch (_that) {
case _Month() when $default != null:
return $default(_that.allocation,_that.month,_that.year,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Month with DiagnosticableTreeMixin implements Month {
   _Month({required this.allocation, required this.month, required this.year, required this.days});
  factory _Month.fromJson(Map<String, dynamic> json) => _$MonthFromJson(json);

@override  int allocation;
@override  int month;
@override  int year;
@override  List<Day> days;

/// Create a copy of Month
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthCopyWith<_Month> get copyWith => __$MonthCopyWithImpl<_Month>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Month'))
    ..add(DiagnosticsProperty('allocation', allocation))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('days', days));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Month(allocation: $allocation, month: $month, year: $year, days: $days)';
}


}

/// @nodoc
abstract mixin class _$MonthCopyWith<$Res> implements $MonthCopyWith<$Res> {
  factory _$MonthCopyWith(_Month value, $Res Function(_Month) _then) = __$MonthCopyWithImpl;
@override @useResult
$Res call({
 int allocation, int month, int year, List<Day> days
});




}
/// @nodoc
class __$MonthCopyWithImpl<$Res>
    implements _$MonthCopyWith<$Res> {
  __$MonthCopyWithImpl(this._self, this._then);

  final _Month _self;
  final $Res Function(_Month) _then;

/// Create a copy of Month
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allocation = null,Object? month = null,Object? year = null,Object? days = null,}) {
  return _then(_Month(
allocation: null == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<Day>,
  ));
}


}

// dart format on
