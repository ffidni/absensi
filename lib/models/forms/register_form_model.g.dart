// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_form_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterFormModelCWProxy {
  RegisterFormModel nama(String? nama);

  RegisterFormModel email(String? email);

  RegisterFormModel password(String? password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterFormModel call({
    String? nama,
    String? email,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterFormModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterFormModel.copyWith.fieldName(...)`
class _$RegisterFormModelCWProxyImpl implements _$RegisterFormModelCWProxy {
  const _$RegisterFormModelCWProxyImpl(this._value);

  final RegisterFormModel _value;

  @override
  RegisterFormModel nama(String? nama) => this(nama: nama);

  @override
  RegisterFormModel email(String? email) => this(email: email);

  @override
  RegisterFormModel password(String? password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterFormModel call({
    Object? nama = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return RegisterFormModel(
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
    );
  }
}

extension $RegisterFormModelCopyWith on RegisterFormModel {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterFormModel.copyWith(...)` or like so:`instanceOfRegisterFormModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterFormModelCWProxy get copyWith =>
      _$RegisterFormModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFormModel _$RegisterFormModelFromJson(Map<String, dynamic> json) =>
    RegisterFormModel(
      nama: json['nama'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterFormModelToJson(RegisterFormModel instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'email': instance.email,
      'password': instance.password,
    };
