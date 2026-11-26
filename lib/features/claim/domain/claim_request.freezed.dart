// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClaimRequest {

 String get id; String get itemId; String get claimantId; String get claimantName; String get message; ClaimStatus get status; DateTime get createdAt;
/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimRequestCopyWith<ClaimRequest> get copyWith => _$ClaimRequestCopyWithImpl<ClaimRequest>(this as ClaimRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClaimRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.itemId, _this.itemId) || other.itemId == _this.itemId)&&(identical(other.claimantId, _this.claimantId) || other.claimantId == _this.claimantId)&&(identical(other.claimantName, _this.claimantName) || other.claimantName == _this.claimantName)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as ClaimRequest;
  return Object.hash(runtimeType,_this.id,_this.itemId,_this.claimantId,_this.claimantName,_this.message,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as ClaimRequest;
  return 'ClaimRequest(id: ${_this.id}, itemId: ${_this.itemId}, claimantId: ${_this.claimantId}, claimantName: ${_this.claimantName}, message: ${_this.message}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ClaimRequestCopyWith<$Res>  {
  factory $ClaimRequestCopyWith(ClaimRequest value, $Res Function(ClaimRequest) _then) = _$ClaimRequestCopyWithImpl;
@useResult
$Res call({
 String id, String itemId, String claimantId, String claimantName, String message, ClaimStatus status, DateTime createdAt
});




}
/// @nodoc
class _$ClaimRequestCopyWithImpl<$Res>
    implements $ClaimRequestCopyWith<$Res> {
  _$ClaimRequestCopyWithImpl(this._self, this._then);

  final ClaimRequest _self;
  final $Res Function(ClaimRequest) _then;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemId = null,Object? claimantId = null,Object? claimantName = null,Object? message = null,Object? status = null,Object? createdAt = null,}) {
  return _then(ClaimRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,claimantId: null == claimantId ? _self.claimantId : claimantId // ignore: cast_nullable_to_non_nullable
as String,claimantName: null == claimantName ? _self.claimantName : claimantName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClaimStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimRequest].
extension ClaimRequestPatterns on ClaimRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimRequest value)  $default,){
final _that = this;
switch (_that) {
case _ClaimRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String itemId,  String claimantId,  String claimantName,  String message,  ClaimStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
return $default(_that.id,_that.itemId,_that.claimantId,_that.claimantName,_that.message,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String itemId,  String claimantId,  String claimantName,  String message,  ClaimStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ClaimRequest():
return $default(_that.id,_that.itemId,_that.claimantId,_that.claimantName,_that.message,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String itemId,  String claimantId,  String claimantName,  String message,  ClaimStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
return $default(_that.id,_that.itemId,_that.claimantId,_that.claimantName,_that.message,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ClaimRequest implements ClaimRequest {
  const _ClaimRequest({required this.id, required this.itemId, required this.claimantId, required this.claimantName, required this.message, this.status = ClaimStatus.pending, required this.createdAt});
  

@override final  String id;
@override final  String itemId;
@override final  String claimantId;
@override final  String claimantName;
@override final  String message;
@override@JsonKey() final  ClaimStatus status;
@override final  DateTime createdAt;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimRequestCopyWith<_ClaimRequest> get copyWith => __$ClaimRequestCopyWithImpl<_ClaimRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.claimantId, claimantId) || other.claimantId == claimantId)&&(identical(other.claimantName, claimantName) || other.claimantName == claimantName)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,itemId,claimantId,claimantName,message,status,createdAt);
}

@override
String toString() {
    return 'ClaimRequest(id: $id, itemId: $itemId, claimantId: $claimantId, claimantName: $claimantName, message: $message, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ClaimRequestCopyWith<$Res> implements $ClaimRequestCopyWith<$Res> {
  factory _$ClaimRequestCopyWith(_ClaimRequest value, $Res Function(_ClaimRequest) _then) = __$ClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String itemId, String claimantId, String claimantName, String message, ClaimStatus status, DateTime createdAt
});




}
/// @nodoc
class __$ClaimRequestCopyWithImpl<$Res>
    implements _$ClaimRequestCopyWith<$Res> {
  __$ClaimRequestCopyWithImpl(this._self, this._then);

  final _ClaimRequest _self;
  final $Res Function(_ClaimRequest) _then;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemId = null,Object? claimantId = null,Object? claimantName = null,Object? message = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_ClaimRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,claimantId: null == claimantId ? _self.claimantId : claimantId // ignore: cast_nullable_to_non_nullable
as String,claimantName: null == claimantName ? _self.claimantName : claimantName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClaimStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
