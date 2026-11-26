// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemReport {

 String get id; ReportType get type; String get title; String get description; ItemCategory get category; String get location; String? get handoverPoint; String? get imageUrl; String get reporterId; DateTime get createdAt; ItemStatus get status;
/// Create a copy of ItemReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemReportCopyWith<ItemReport> get copyWith => _$ItemReportCopyWithImpl<ItemReport>(this as ItemReport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ItemReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemReport&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.handoverPoint, _this.handoverPoint) || other.handoverPoint == _this.handoverPoint)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.reporterId, _this.reporterId) || other.reporterId == _this.reporterId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as ItemReport;
  return Object.hash(runtimeType,_this.id,_this.type,_this.title,_this.description,_this.category,_this.location,_this.handoverPoint,_this.imageUrl,_this.reporterId,_this.createdAt,_this.status);
}

@override
String toString() {
  final _this = this as ItemReport;
  return 'ItemReport(id: ${_this.id}, type: ${_this.type}, title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, location: ${_this.location}, handoverPoint: ${_this.handoverPoint}, imageUrl: ${_this.imageUrl}, reporterId: ${_this.reporterId}, createdAt: ${_this.createdAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $ItemReportCopyWith<$Res>  {
  factory $ItemReportCopyWith(ItemReport value, $Res Function(ItemReport) _then) = _$ItemReportCopyWithImpl;
@useResult
$Res call({
 String id, ReportType type, String title, String description, ItemCategory category, String location, String? handoverPoint, String? imageUrl, String reporterId, DateTime createdAt, ItemStatus status
});




}
/// @nodoc
class _$ItemReportCopyWithImpl<$Res>
    implements $ItemReportCopyWith<$Res> {
  _$ItemReportCopyWithImpl(this._self, this._then);

  final ItemReport _self;
  final $Res Function(ItemReport) _then;

/// Create a copy of ItemReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? category = null,Object? location = null,Object? handoverPoint = freezed,Object? imageUrl = freezed,Object? reporterId = null,Object? createdAt = null,Object? status = null,}) {
  return _then(ItemReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ItemCategory,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,handoverPoint: freezed == handoverPoint ? _self.handoverPoint : handoverPoint // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ItemStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemReport].
extension ItemReportPatterns on ItemReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemReport value)  $default,){
final _that = this;
switch (_that) {
case _ItemReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemReport value)?  $default,){
final _that = this;
switch (_that) {
case _ItemReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ReportType type,  String title,  String description,  ItemCategory category,  String location,  String? handoverPoint,  String? imageUrl,  String reporterId,  DateTime createdAt,  ItemStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemReport() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.imageUrl,_that.reporterId,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ReportType type,  String title,  String description,  ItemCategory category,  String location,  String? handoverPoint,  String? imageUrl,  String reporterId,  DateTime createdAt,  ItemStatus status)  $default,) {final _that = this;
switch (_that) {
case _ItemReport():
return $default(_that.id,_that.type,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.imageUrl,_that.reporterId,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ReportType type,  String title,  String description,  ItemCategory category,  String location,  String? handoverPoint,  String? imageUrl,  String reporterId,  DateTime createdAt,  ItemStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ItemReport() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.imageUrl,_that.reporterId,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ItemReport implements ItemReport {
  const _ItemReport({required this.id, required this.type, required this.title, required this.description, required this.category, required this.location, this.handoverPoint, this.imageUrl, required this.reporterId, required this.createdAt, this.status = ItemStatus.open});
  

@override final  String id;
@override final  ReportType type;
@override final  String title;
@override final  String description;
@override final  ItemCategory category;
@override final  String location;
@override final  String? handoverPoint;
@override final  String? imageUrl;
@override final  String reporterId;
@override final  DateTime createdAt;
@override@JsonKey() final  ItemStatus status;

/// Create a copy of ItemReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemReportCopyWith<_ItemReport> get copyWith => __$ItemReportCopyWithImpl<_ItemReport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemReport&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.location, location) || other.location == location)&&(identical(other.handoverPoint, handoverPoint) || other.handoverPoint == handoverPoint)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.reporterId, reporterId) || other.reporterId == reporterId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,title,description,category,location,handoverPoint,imageUrl,reporterId,createdAt,status);
}

@override
String toString() {
    return 'ItemReport(id: $id, type: $type, title: $title, description: $description, category: $category, location: $location, handoverPoint: $handoverPoint, imageUrl: $imageUrl, reporterId: $reporterId, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ItemReportCopyWith<$Res> implements $ItemReportCopyWith<$Res> {
  factory _$ItemReportCopyWith(_ItemReport value, $Res Function(_ItemReport) _then) = __$ItemReportCopyWithImpl;
@override @useResult
$Res call({
 String id, ReportType type, String title, String description, ItemCategory category, String location, String? handoverPoint, String? imageUrl, String reporterId, DateTime createdAt, ItemStatus status
});




}
/// @nodoc
class __$ItemReportCopyWithImpl<$Res>
    implements _$ItemReportCopyWith<$Res> {
  __$ItemReportCopyWithImpl(this._self, this._then);

  final _ItemReport _self;
  final $Res Function(_ItemReport) _then;

/// Create a copy of ItemReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? category = null,Object? location = null,Object? handoverPoint = freezed,Object? imageUrl = freezed,Object? reporterId = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_ItemReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ItemCategory,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,handoverPoint: freezed == handoverPoint ? _self.handoverPoint : handoverPoint // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ItemStatus,
  ));
}


}

// dart format on
