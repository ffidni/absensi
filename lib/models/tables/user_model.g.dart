// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserModelCWProxy {
  UserModel id(int? id);

  UserModel nama(String? nama);

  UserModel email(String? email);

  UserModel password(String? password);

  UserModel tipeUser(String? tipeUser);

  UserModel token(String? token);

  UserModel tokenExpiresIn(int? tokenExpiresIn);

  UserModel tokenType(String? tokenType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    int? id,
    String? nama,
    String? email,
    String? password,
    String? tipeUser,
    String? token,
    int? tokenExpiresIn,
    String? tokenType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserModel.copyWith.fieldName(...)`
class _$UserModelCWProxyImpl implements _$UserModelCWProxy {
  const _$UserModelCWProxyImpl(this._value);

  final UserModel _value;

  @override
  UserModel id(int? id) => this(id: id);

  @override
  UserModel nama(String? nama) => this(nama: nama);

  @override
  UserModel email(String? email) => this(email: email);

  @override
  UserModel password(String? password) => this(password: password);

  @override
  UserModel tipeUser(String? tipeUser) => this(tipeUser: tipeUser);

  @override
  UserModel token(String? token) => this(token: token);

  @override
  UserModel tokenExpiresIn(int? tokenExpiresIn) =>
      this(tokenExpiresIn: tokenExpiresIn);

  @override
  UserModel tokenType(String? tokenType) => this(tokenType: tokenType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? nama = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? tipeUser = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? tokenExpiresIn = const $CopyWithPlaceholder(),
    Object? tokenType = const $CopyWithPlaceholder(),
  }) {
    return UserModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      nama: nama == const $CopyWithPlaceholder()
          ? _value.nama
          // ignore: cast_nullable_to_non_nullable
          : nama as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      tipeUser: tipeUser == const $CopyWithPlaceholder()
          ? _value.tipeUser
          // ignore: cast_nullable_to_non_nullable
          : tipeUser as String?,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      tokenExpiresIn: tokenExpiresIn == const $CopyWithPlaceholder()
          ? _value.tokenExpiresIn
          // ignore: cast_nullable_to_non_nullable
          : tokenExpiresIn as int?,
      tokenType: tokenType == const $CopyWithPlaceholder()
          ? _value.tokenType
          // ignore: cast_nullable_to_non_nullable
          : tokenType as String?,
    );
  }
}

extension $UserModelCopyWith on UserModel {
  /// Returns a callable class that can be used as follows: `instanceOfUserModel.copyWith(...)` or like so:`instanceOfUserModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserModelCWProxy get copyWith => _$UserModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      nama: json['nama'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      tipeUser: json['tipe_user'] as String?,
      token: json['token'] as String?,
      tokenExpiresIn: json['token_expires_in'] as int?,
      tokenType: json['token_type'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'email': instance.email,
      'password': instance.password,
      'tipe_user': instance.tipeUser,
      'token': instance.token,
      'token_expires_in': instance.tokenExpiresIn,
      'token_type': instance.tokenType,
    };
