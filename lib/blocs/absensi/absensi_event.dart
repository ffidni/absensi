part of 'absensi_bloc.dart';

abstract class AbsensiEvent extends Equatable {
  const AbsensiEvent();

  @override
  List<Object> get props => [];
}

class AbsensiGetAll extends AbsensiEvent {
  const AbsensiGetAll();

  @override
  List<Object> get props => [];
}

class AbsensiGetAllByDate extends AbsensiEvent {
  final String date;
  const AbsensiGetAllByDate(this.date);

  @override
  List<Object> get props => [date];
}

class AbsensiGetAllByDateAndUserId extends AbsensiEvent {
  final int userId;
  final String date;

  const AbsensiGetAllByDateAndUserId(this.userId, this.date);

  @override
  List<Object> get props => [];
}

class AbsensiGetLaporanKehadiran extends AbsensiEvent {
  final int userId;
  const AbsensiGetLaporanKehadiran(this.userId);

  @override
  List<Object> get props => [userId];
}

class AbsensiEdit extends AbsensiEvent {
  final int id;
  final AbsenFormModel absenForm;
  const AbsensiEdit(this.id, this.absenForm);

  @override
  List<Object> get props => [id, absenForm];
}

class AbsensiAdd extends AbsensiEvent {
  final AbsenFormModel absenForm;
  const AbsensiAdd(this.absenForm);

  @override
  List<Object> get props => [absenForm];
}

class AbsensiDelete extends AbsensiEvent {
  final List<int> id;
  const AbsensiDelete(this.id);

  @override
  List<Object> get props => [id];
}
