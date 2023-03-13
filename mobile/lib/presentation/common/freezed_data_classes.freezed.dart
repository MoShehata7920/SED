// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_loginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_loginObjectCopyWith(
          _$_loginObject value, $Res Function(_$_loginObject) then) =
      __$$_loginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class __$$_loginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_loginObject>
    implements _$$_loginObjectCopyWith<$Res> {
  __$$_loginObjectCopyWithImpl(
      _$_loginObject _value, $Res Function(_$_loginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_$_loginObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_loginObject implements _loginObject {
  _$_loginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_loginObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_loginObjectCopyWith<_$_loginObject> get copyWith =>
      __$$_loginObjectCopyWithImpl<_$_loginObject>(this, _$identity);
}

abstract class _loginObject implements LoginObject {
  factory _loginObject(final String userName, final String password) =
      _$_loginObject;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_loginObjectCopyWith<_$_loginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get userName => throw _privateConstructorUsedError;
  String get countryMobileCode => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {String userName,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      countryMobileCode: null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_registerObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$_registerObjectCopyWith(
          _$_registerObject value, $Res Function(_$_registerObject) then) =
      __$$_registerObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password});
}

/// @nodoc
class __$$_registerObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$_registerObject>
    implements _$$_registerObjectCopyWith<$Res> {
  __$$_registerObjectCopyWithImpl(
      _$_registerObject _value, $Res Function(_$_registerObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_registerObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_registerObject implements _registerObject {
  _$_registerObject(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password);

  @override
  final String userName;
  @override
  final String countryMobileCode;
  @override
  final String mobileNumber;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, countryMobileCode: $countryMobileCode, mobileNumber: $mobileNumber, email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_registerObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.countryMobileCode, countryMobileCode) ||
                other.countryMobileCode == countryMobileCode) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userName, countryMobileCode, mobileNumber, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_registerObjectCopyWith<_$_registerObject> get copyWith =>
      __$$_registerObjectCopyWithImpl<_$_registerObject>(this, _$identity);
}

abstract class _registerObject implements RegisterObject {
  factory _registerObject(
      final String userName,
      final String countryMobileCode,
      final String mobileNumber,
      final String email,
      final String password) = _$_registerObject;

  @override
  String get userName;
  @override
  String get countryMobileCode;
  @override
  String get mobileNumber;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_registerObjectCopyWith<_$_registerObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdvertisementObject {
  String get image => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get sectionId => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  int get conditionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdvertisementObjectCopyWith<AdvertisementObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvertisementObjectCopyWith<$Res> {
  factory $AdvertisementObjectCopyWith(
          AdvertisementObject value, $Res Function(AdvertisementObject) then) =
      _$AdvertisementObjectCopyWithImpl<$Res, AdvertisementObject>;
  @useResult
  $Res call(
      {String image,
      String name,
      String price,
      String description,
      int sectionId,
      int categoryId,
      int conditionId});
}

/// @nodoc
class _$AdvertisementObjectCopyWithImpl<$Res, $Val extends AdvertisementObject>
    implements $AdvertisementObjectCopyWith<$Res> {
  _$AdvertisementObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? name = null,
    Object? price = null,
    Object? description = null,
    Object? sectionId = null,
    Object? categoryId = null,
    Object? conditionId = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      conditionId: null == conditionId
          ? _value.conditionId
          : conditionId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdvertisementObjectCopyWith<$Res>
    implements $AdvertisementObjectCopyWith<$Res> {
  factory _$$_AdvertisementObjectCopyWith(_$_AdvertisementObject value,
          $Res Function(_$_AdvertisementObject) then) =
      __$$_AdvertisementObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image,
      String name,
      String price,
      String description,
      int sectionId,
      int categoryId,
      int conditionId});
}

/// @nodoc
class __$$_AdvertisementObjectCopyWithImpl<$Res>
    extends _$AdvertisementObjectCopyWithImpl<$Res, _$_AdvertisementObject>
    implements _$$_AdvertisementObjectCopyWith<$Res> {
  __$$_AdvertisementObjectCopyWithImpl(_$_AdvertisementObject _value,
      $Res Function(_$_AdvertisementObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? name = null,
    Object? price = null,
    Object? description = null,
    Object? sectionId = null,
    Object? categoryId = null,
    Object? conditionId = null,
  }) {
    return _then(_$_AdvertisementObject(
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int,
      null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      null == conditionId
          ? _value.conditionId
          : conditionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_AdvertisementObject implements _AdvertisementObject {
  _$_AdvertisementObject(this.image, this.name, this.price, this.description,
      this.sectionId, this.categoryId, this.conditionId);

  @override
  final String image;
  @override
  final String name;
  @override
  final String price;
  @override
  final String description;
  @override
  final int sectionId;
  @override
  final int categoryId;
  @override
  final int conditionId;

  @override
  String toString() {
    return 'AdvertisementObject(image: $image, name: $name, price: $price, description: $description, sectionId: $sectionId, categoryId: $categoryId, conditionId: $conditionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdvertisementObject &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.conditionId, conditionId) ||
                other.conditionId == conditionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, name, price, description,
      sectionId, categoryId, conditionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdvertisementObjectCopyWith<_$_AdvertisementObject> get copyWith =>
      __$$_AdvertisementObjectCopyWithImpl<_$_AdvertisementObject>(
          this, _$identity);
}

abstract class _AdvertisementObject implements AdvertisementObject {
  factory _AdvertisementObject(
      final String image,
      final String name,
      final String price,
      final String description,
      final int sectionId,
      final int categoryId,
      final int conditionId) = _$_AdvertisementObject;

  @override
  String get image;
  @override
  String get name;
  @override
  String get price;
  @override
  String get description;
  @override
  int get sectionId;
  @override
  int get categoryId;
  @override
  int get conditionId;
  @override
  @JsonKey(ignore: true)
  _$$_AdvertisementObjectCopyWith<_$_AdvertisementObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MyProfileAds {
  List<Items> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyProfileAdsCopyWith<MyProfileAds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProfileAdsCopyWith<$Res> {
  factory $MyProfileAdsCopyWith(
          MyProfileAds value, $Res Function(MyProfileAds) then) =
      _$MyProfileAdsCopyWithImpl<$Res, MyProfileAds>;
  @useResult
  $Res call({List<Items> items});
}

/// @nodoc
class _$MyProfileAdsCopyWithImpl<$Res, $Val extends MyProfileAds>
    implements $MyProfileAdsCopyWith<$Res> {
  _$MyProfileAdsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyProfileAdsCopyWith<$Res>
    implements $MyProfileAdsCopyWith<$Res> {
  factory _$$_MyProfileAdsCopyWith(
          _$_MyProfileAds value, $Res Function(_$_MyProfileAds) then) =
      __$$_MyProfileAdsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Items> items});
}

/// @nodoc
class __$$_MyProfileAdsCopyWithImpl<$Res>
    extends _$MyProfileAdsCopyWithImpl<$Res, _$_MyProfileAds>
    implements _$$_MyProfileAdsCopyWith<$Res> {
  __$$_MyProfileAdsCopyWithImpl(
      _$_MyProfileAds _value, $Res Function(_$_MyProfileAds) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$_MyProfileAds(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>,
    ));
  }
}

/// @nodoc

class _$_MyProfileAds implements _MyProfileAds {
  _$_MyProfileAds(final List<Items> items) : _items = items;

  final List<Items> _items;
  @override
  List<Items> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'MyProfileAds(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyProfileAds &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyProfileAdsCopyWith<_$_MyProfileAds> get copyWith =>
      __$$_MyProfileAdsCopyWithImpl<_$_MyProfileAds>(this, _$identity);
}

abstract class _MyProfileAds implements MyProfileAds {
  factory _MyProfileAds(final List<Items> items) = _$_MyProfileAds;

  @override
  List<Items> get items;
  @override
  @JsonKey(ignore: true)
  _$$_MyProfileAdsCopyWith<_$_MyProfileAds> get copyWith =>
      throw _privateConstructorUsedError;
}
