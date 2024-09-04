import '../models/timekeeping_model.dart';
import '../source/remote/point_remote.dart';
import '../../domain/repositories/point_repository.dart';

class PointRepository implements IPointRepository {
  final PointRemoteDataSource _remoteDataSource;

  PointRepository({required PointRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<void> clockIn(TimekeepingModel clockIn) async {
    await _remoteDataSource.clockIn(clockIn);
  }

  @override
  Future<void> clockOut(TimekeepingModel clockOut) async {
    await _remoteDataSource.clockOut(clockOut);
  }

  @override
  Future<List<TimekeepingModel>> listAll({int pageNumber = 1, int pageSize = 10, int? month, int? year}) async {
    return await _remoteDataSource.listAll(
      month: month,
      pageNumber: pageNumber,
      pageSize: pageSize,
      year: year,
    );
  }
}