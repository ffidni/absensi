part of 'absensi_bloc.dart';

abstract class AbsensiState extends Equatable {
  const AbsensiState();

  @override
  List<Object> get props => [];
}

class AbsensiInitial extends AbsensiState {}

class AbsensiLoading extends AbsensiState {}

class AbsensiGetAllSuccess extends AbsensiState {
  final List<AbsenModel> absenData;

  const AbsensiGetAllSuccess(this.absenData);

  @override
  List<Object> get props => [absenData];
}

class AbsensiGetLaporanSuccess extends AbsensiState {
  final KehadiranFetchsModel laporan;

  const AbsensiGetLaporanSuccess(this.laporan);

  @override
  List<Object> get props => [laporan];
}

class AbsensiSuccess extends AbsensiState {
  final String message;
  const AbsensiSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class AbsensiFailed extends AbsensiState {
  final ErrorException error;

  const AbsensiFailed(this.error);

  @override
  List<Object> get props => [error];
}
