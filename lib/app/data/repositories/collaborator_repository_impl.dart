import 'package:challenge_web/app/data/source/remote/collaborator_remote.dart';
import 'package:challenge_web/app/data/models/collaborator_model.dart';
import 'package:challenge_web/app/domain/repositories/collaborator_repository.dart';

class CollaboratorRepositoryImpl implements ICollaboratorRepository {
  final CollaboratorRemote remoteDataSource;

  CollaboratorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CollaboratorModel>> getCollaborators(
      {int? pageNumber, int? pageQuantity}) async {
    return await remoteDataSource.getCollaborators(pageNumber: pageNumber, pageQuantity:pageQuantity);
  }

  @override
  Future<CollaboratorModel> getCollaboratorById(int id) async {
    return await remoteDataSource.getCollaboratorById(id);
  }

  @override
  Future<void> addCollaborator(CollaboratorModel collaborator) async {
    await remoteDataSource.addCollaborator(collaborator);
  }

  @override
  Future<void> updateCollaborator(CollaboratorModel collaborator) async {
    await remoteDataSource.updateCollaborator(collaborator);
  }

  @override
  Future<void> deleteCollaborator(int id) async {
    await remoteDataSource.deleteCollaborator(id);
  }
}
