import 'package:absensi/models/forms/absen_form_model.dart';
import 'package:absensi/models/page_fetchs/kehadiran_fetchs_model.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/services/AbsensiService.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:absensi/ui/absen_form_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'absensi_event.dart';
part 'absensi_state.dart';

class AbsensiBloc extends Bloc<AbsensiEvent, AbsensiState> {
  AbsensiBloc() : super(AbsensiInitial()) {
    on<AbsensiEvent>((event, emit) async {
      emit(AbsensiLoading());
      try {
        if (event is AbsensiGetAll) {
          await _handleGetAll(emit);
        } else if (event is AbsensiGetAllByDate) {
          await _handleGetAll(emit, date: event.date);
        } else if (event is AbsensiGetAllByDateAndUserId) {
          await _handleGetAll(emit, date: event.date, userId: event.userId);
        } else if (event is AbsensiGetLaporanKehadiran) {
          await _handleGetLaporan(event.userId, emit);
        } else if (event is AbsensiAdd) {
          await _handleAdd(event.absenForm, emit);
        } else if (event is AbsensiEdit) {
          await _handleEdit(event.id, event.absenForm, emit);
        } else if (event is AbsensiDelete) {
          await _handleDelete(event.id, emit);
        }
      } catch (e) {
        emit(AbsensiFailed(ErrorException(e.toString())));
      }
    });
  }
}

Future<void> _handleGetAll(
  Emitter<AbsensiState> emit, {
  int? userId,
  String? date,
}) async {
  List<AbsenModel> data =
      await AbsensiService().getAllAbsen(date: date, userId: userId);
  print(data);
  emit(AbsensiGetAllSuccess(data));
}

Future<void> _handleGetLaporan(int userId, Emitter<AbsensiState> emit) async {
  KehadiranFetchsModel data =
      await AbsensiService().getLaporanKehadiran(userId);
  emit(AbsensiGetLaporanSuccess(data));
}

Future<void> _handleAdd(AbsenFormModel data, Emitter<AbsensiState> emit) async {
  await AbsensiService().addAbsen(data);
  emit(AbsensiSuccess("Berhasil menambah data absen"));
}

Future<void> _handleEdit(
    int id, AbsenFormModel data, Emitter<AbsensiState> emit) async {
  await AbsensiService().editAbsen(id, data);
  emit(AbsensiSuccess("Berhasil merubah data absen"));
}

Future<void> _handleDelete(List<int> ids, Emitter<AbsensiState> emit) async {
  for (var id in ids) {
    await AbsensiService().deleteAbsen(id);
  }
  emit(AbsensiSuccess("Berhasil menghapus data absen"));
}
