// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportItemState {

 ReportType get reportType; String get title; String get description; ItemCategory? get category; String get location; String get handoverPoint; XFile? get selectedImage; bool get isSubmitting; bool get isPickingImage; String? get imageError; int get formRevision;
/// Create a copy of ReportItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportItemStateCopyWith<ReportItemState> get copyWith => _$ReportItemStateCopyWithImpl<ReportItemState>(this as ReportItemState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReportItemState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportItemState&&(identical(other.reportType, _this.reportType) || other.reportType == _this.reportType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.handoverPoint, _this.handoverPoint) || other.handoverPoint == _this.handoverPoint)&&(identical(other.selectedImage, _this.selectedImage) || other.selectedImage == _this.selectedImage)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&(identical(other.isPickingImage, _this.isPickingImage) || other.isPickingImage == _this.isPickingImage)&&(identical(other.imageError, _this.imageError) || other.imageError == _this.imageError)&&(identical(other.formRevision, _this.formRevision) || other.formRevision == _this.formRevision));
}


@override
int get hashCode {
  final _this = this as ReportItemState;
  return Object.hash(runtimeType,_this.reportType,_this.title,_this.description,_this.category,_this.location,_this.handoverPoint,_this.selectedImage,_this.isSubmitting,_this.isPickingImage,_this.imageError,_this.formRevision);
}

@override
String toString() {
  final _this = this as ReportItemState;
  return 'ReportItemState(reportType: ${_this.reportType}, title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, location: ${_this.location}, handoverPoint: ${_this.handoverPoint}, selectedImage: ${_this.selectedImage}, isSubmitting: ${_this.isSubmitting}, isPickingImage: ${_this.isPickingImage}, imageError: ${_this.imageError}, formRevision: ${_this.formRevision})';
}


}

/// @nodoc
abstract mixin class $ReportItemStateCopyWith<$Res>  {
  factory $ReportItemStateCopyWith(ReportItemState value, $Res Function(ReportItemState) _then) = _$ReportItemStateCopyWithImpl;
@useResult
$Res call({
 ReportType reportType, String title, String description, ItemCategory? category, String location, String handoverPoint, XFile? selectedImage, bool isSubmitting, bool isPickingImage, String? imageError, int formRevision
});




}
/// @nodoc
class _$ReportItemStateCopyWithImpl<$Res>
    implements $ReportItemStateCopyWith<$Res> {
  _$ReportItemStateCopyWithImpl(this._self, this._then);

  final ReportItemState _self;
  final $Res Function(ReportItemState) _then;

/// Create a copy of ReportItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportType = null,Object? title = null,Object? description = null,Object? category = freezed,Object? location = null,Object? handoverPoint = null,Object? selectedImage = freezed,Object? isSubmitting = null,Object? isPickingImage = null,Object? imageError = freezed,Object? formRevision = null,}) {
  return _then(ReportItemState(
reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as ReportType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ItemCategory?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,handoverPoint: null == handoverPoint ? _self.handoverPoint : handoverPoint // ignore: cast_nullable_to_non_nullable
as String,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isPickingImage: null == isPickingImage ? _self.isPickingImage : isPickingImage // ignore: cast_nullable_to_non_nullable
as bool,imageError: freezed == imageError ? _self.imageError : imageError // ignore: cast_nullable_to_non_nullable
as String?,formRevision: null == formRevision ? _self.formRevision : formRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportItemState].
extension ReportItemStatePatterns on ReportItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportItemState value)  $default,){
final _that = this;
switch (_that) {
case _ReportItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportItemState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportItemState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportType reportType,  String title,  String description,  ItemCategory? category,  String location,  String handoverPoint,  XFile? selectedImage,  bool isSubmitting,  bool isPickingImage,  String? imageError,  int formRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportItemState() when $default != null:
return $default(_that.reportType,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.selectedImage,_that.isSubmitting,_that.isPickingImage,_that.imageError,_that.formRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportType reportType,  String title,  String description,  ItemCategory? category,  String location,  String handoverPoint,  XFile? selectedImage,  bool isSubmitting,  bool isPickingImage,  String? imageError,  int formRevision)  $default,) {final _that = this;
switch (_that) {
case _ReportItemState():
return $default(_that.reportType,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.selectedImage,_that.isSubmitting,_that.isPickingImage,_that.imageError,_that.formRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportType reportType,  String title,  String description,  ItemCategory? category,  String location,  String handoverPoint,  XFile? selectedImage,  bool isSubmitting,  bool isPickingImage,  String? imageError,  int formRevision)?  $default,) {final _that = this;
switch (_that) {
case _ReportItemState() when $default != null:
return $default(_that.reportType,_that.title,_that.description,_that.category,_that.location,_that.handoverPoint,_that.selectedImage,_that.isSubmitting,_that.isPickingImage,_that.imageError,_that.formRevision);case _:
  return null;

}
}

}

/// @nodoc


class _ReportItemState implements ReportItemState {
  const _ReportItemState({this.reportType = ReportType.lost, this.title = '', this.description = '', this.category, this.location = '', this.handoverPoint = '', this.selectedImage, this.isSubmitting = false, this.isPickingImage = false, this.imageError, this.formRevision = 0});


@override@JsonKey() final  ReportType reportType;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override final  ItemCategory? category;
@override@JsonKey() final  String location;
@override@JsonKey() final  String handoverPoint;
@override final  XFile? selectedImage;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isPickingImage;
@override final  String? imageError;
@override@JsonKey() final  int formRevision;

/// Create a copy of ReportItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportItemStateCopyWith<_ReportItemState> get copyWith => __$ReportItemStateCopyWithImpl<_ReportItemState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportItemState&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.location, location) || other.location == location)&&(identical(other.handoverPoint, handoverPoint) || other.handoverPoint == handoverPoint)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isPickingImage, isPickingImage) || other.isPickingImage == isPickingImage)&&(identical(other.imageError, imageError) || other.imageError == imageError)&&(identical(other.formRevision, formRevision) || other.formRevision == formRevision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reportType,title,description,category,location,handoverPoint,selectedImage,isSubmitting,isPickingImage,imageError,formRevision);
}

@override
String toString() {
    return 'ReportItemState(reportType: $reportType, title: $title, description: $description, category: $category, location: $location, handoverPoint: $handoverPoint, selectedImage: $selectedImage, isSubmitting: $isSubmitting, isPickingImage: $isPickingImage, imageError: $imageError, formRevision: $formRevision)';
}


}

/// @nodoc
abstract mixin class _$ReportItemStateCopyWith<$Res> implements $ReportItemStateCopyWith<$Res> {
  factory _$ReportItemStateCopyWith(_ReportItemState value, $Res Function(_ReportItemState) _then) = __$ReportItemStateCopyWithImpl;
@override @useResult
$Res call({
 ReportType reportType, String title, String description, ItemCategory? category, String location, String handoverPoint, XFile? selectedImage, bool isSubmitting, bool isPickingImage, String? imageError, int formRevision
});




}
/// @nodoc
class __$ReportItemStateCopyWithImpl<$Res>
    implements _$ReportItemStateCopyWith<$Res> {
  __$ReportItemStateCopyWithImpl(this._self, this._then);

  final _ReportItemState _self;
  final $Res Function(_ReportItemState) _then;

/// Create a copy of ReportItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportType = null,Object? title = null,Object? description = null,Object? category = freezed,Object? location = null,Object? handoverPoint = null,Object? selectedImage = freezed,Object? isSubmitting = null,Object? isPickingImage = null,Object? imageError = freezed,Object? formRevision = null,}) {
  return _then(_ReportItemState(
reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as ReportType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ItemCategory?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,handoverPoint: null == handoverPoint ? _self.handoverPoint : handoverPoint // ignore: cast_nullable_to_non_nullable
as String,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isPickingImage: null == isPickingImage ? _self.isPickingImage : isPickingImage // ignore: cast_nullable_to_non_nullable
as bool,imageError: freezed == imageError ? _self.imageError : imageError // ignore: cast_nullable_to_non_nullable
as String?,formRevision: null == formRevision ? _self.formRevision : formRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
