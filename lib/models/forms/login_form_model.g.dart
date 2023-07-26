// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginFormModelCWProxy {
  LoginFormModel email(String? email);

  LoginFormModel password(String? password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginFormModel call({
    String? email,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginFormModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginFormModel.copyWith.fieldName(...)`
class _$LoginFormModelCWProxyImpl implements _$LoginFormModelCWProxy {
  const _$LoginFormModelCWProxyImpl(this._value);

  final LoginFormModel _value;

  @override
  LoginFormModel email(String? email) => this(email: email);

  @override
  LoginFormModel password(String? password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginFormModel call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return LoginFormModel(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
    );
  }
}

extension $LoginFormModelCopyWith on LoginFormModel {
  /// Returns a callable class that can be used as follows: `instanceOfLoginFormModel.copyWith(...)` or like so:`instanceOfLoginFormModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginFormModelCWProxy get copyWith => _$LoginFormModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFormModel _$LoginFormModelFromJson(Map<String, dynamic> json) =>
    LoginFormModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginFormModelToJson(LoginFormModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
