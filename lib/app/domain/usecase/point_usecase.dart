import 'package:challenge_web/app/data/models/timekeeping_model.dart';
import 'package:challenge_web/app/domain/repositories/point_repository.dart';

class PointUsecase {
  final IPointRepository _repository;

  PointUsecase({required IPointRepository repository})
      : _repository = repository;

  Future<List<TimekeepingModel>> getAll({int pageNumber = 1, int pageSize = 10, int? month, int? year}) async {
    return await _repository.listAll(month: month, pageNumber: pageNumber, pageSize: pageSize, year: year);
  }

  Future<void> clockOut(TimekeepingModel timekeeping) async {
    await _repository.clockOut(timekeeping);
  }

  Future<void> clockIn(TimekeepingModel timekeeping) async {
    await _repository.clockIn(timekeeping);
  }
}
