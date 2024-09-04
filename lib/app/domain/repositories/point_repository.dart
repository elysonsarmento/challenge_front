import "../../data/models/timekeeping_model.dart";

abstract class IPointRepository {
  Future<void> clockIn(TimekeepingModel clockIn);
  Future<void> clockOut(TimekeepingModel clockOut);
  Future<List<TimekeepingModel>> listAll({int pageNumber = 1, int pageSize = 10, int? month, int? year});
}