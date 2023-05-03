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
  String get mobileNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;

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
      String mobileNumber,
      String email,
      String password,
      String confirmPassword});
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
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
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
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
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
      String mobileNumber,
      String email,
      String password,
      String confirmPassword});
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
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_$_registerObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
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
      null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_registerObject implements _registerObject {
  _$_registerObject(this.userName, this.mobileNumber, this.email, this.password,
      this.confirmPassword);

  @override
  final String userName;
  @override
  final String mobileNumber;
  @override
  final String email;
  @override
  final String password;
  @override
  final String confirmPassword;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, mobileNumber: $mobileNumber, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_registerObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userName, mobileNumber, email, password, confirmPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_registerObjectCopyWith<_$_registerObject> get copyWith =>
      __$$_registerObjectCopyWithImpl<_$_registerObject>(this, _$identity);
}

abstract class _registerObject implements RegisterObject {
  factory _registerObject(
      final String userName,
      final String mobileNumber,
      final String email,
      final String password,
      final String confirmPassword) = _$_registerObject;

  @override
  String get userName;
  @override
  String get mobileNumber;
  @override
  String get email;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  @JsonKey(ignore: true)
  _$$_registerObjectCopyWith<_$_registerObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserProfileObject {
  File get userImage => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  String get government => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileObjectCopyWith<UserProfileObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileObjectCopyWith<$Res> {
  factory $UserProfileObjectCopyWith(
          UserProfileObject value, $Res Function(UserProfileObject) then) =
      _$UserProfileObjectCopyWithImpl<$Res, UserProfileObject>;
  @useResult
  $Res call(
      {File userImage,
      String userName,
      String userPhone,
      String government,
      String address});
}

/// @nodoc
class _$UserProfileObjectCopyWithImpl<$Res, $Val extends UserProfileObject>
    implements $UserProfileObjectCopyWith<$Res> {
  _$UserProfileObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userImage = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? government = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      userImage: null == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as File,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      government: null == government
          ? _value.government
          : government // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_userProfileObjectCopyWith<$Res>
    implements $UserProfileObjectCopyWith<$Res> {
  factory _$$_userProfileObjectCopyWith(_$_userProfileObject value,
          $Res Function(_$_userProfileObject) then) =
      __$$_userProfileObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {File userImage,
      String userName,
      String userPhone,
      String government,
      String address});
}

/// @nodoc
class __$$_userProfileObjectCopyWithImpl<$Res>
    extends _$UserProfileObjectCopyWithImpl<$Res, _$_userProfileObject>
    implements _$$_userProfileObjectCopyWith<$Res> {
  __$$_userProfileObjectCopyWithImpl(
      _$_userProfileObject _value, $Res Function(_$_userProfileObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userImage = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? government = null,
    Object? address = null,
  }) {
    return _then(_$_userProfileObject(
      null == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as File,
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      null == government
          ? _value.government
          : government // ignore: cast_nullable_to_non_nullable
              as String,
      null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_userProfileObject implements _userProfileObject {
  _$_userProfileObject(this.userImage, this.userName, this.userPhone,
      this.government, this.address);

  @override
  final File userImage;
  @override
  final String userName;
  @override
  final String userPhone;
  @override
  final String government;
  @override
  final String address;

  @override
  String toString() {
    return 'UserProfileObject(userImage: $userImage, userName: $userName, userPhone: $userPhone, government: $government, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_userProfileObject &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.government, government) ||
                other.government == government) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userImage, userName, userPhone, government, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_userProfileObjectCopyWith<_$_userProfileObject> get copyWith =>
      __$$_userProfileObjectCopyWithImpl<_$_userProfileObject>(
          this, _$identity);
}

abstract class _userProfileObject implements UserProfileObject {
  factory _userProfileObject(
      final File userImage,
      final String userName,
      final String userPhone,
      final String government,
      final String address) = _$_userProfileObject;

  @override
  File get userImage;
  @override
  String get userName;
  @override
  String get userPhone;
  @override
  String get government;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_userProfileObjectCopyWith<_$_userProfileObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdvertisementObject {
  File get image => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;

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
      {File image,
      String name,
      int price,
      String description,
      String purpose,
      String category,
      String condition});
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
    Object? purpose = null,
    Object? category = null,
    Object? condition = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
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
      {File image,
      String name,
      int price,
      String description,
      String purpose,
      String category,
      String condition});
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
    Object? purpose = null,
    Object? category = null,
    Object? condition = null,
  }) {
    return _then(_$_AdvertisementObject(
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AdvertisementObject implements _AdvertisementObject {
  _$_AdvertisementObject(this.image, this.name, this.price, this.description,
      this.purpose, this.category, this.condition);

  @override
  final File image;
  @override
  final String name;
  @override
  final int price;
  @override
  final String description;
  @override
  final String purpose;
  @override
  final String category;
  @override
  final String condition;

  @override
  String toString() {
    return 'AdvertisementObject(image: $image, name: $name, price: $price, description: $description, purpose: $purpose, category: $category, condition: $condition)';
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
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, name, price, description,
      purpose, category, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdvertisementObjectCopyWith<_$_AdvertisementObject> get copyWith =>
      __$$_AdvertisementObjectCopyWithImpl<_$_AdvertisementObject>(
          this, _$identity);
}

abstract class _AdvertisementObject implements AdvertisementObject {
  factory _AdvertisementObject(
      final File image,
      final String name,
      final int price,
      final String description,
      final String purpose,
      final String category,
      final String condition) = _$_AdvertisementObject;

  @override
  File get image;
  @override
  String get name;
  @override
  int get price;
  @override
  String get description;
  @override
  String get purpose;
  @override
  String get category;
  @override
  String get condition;
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
