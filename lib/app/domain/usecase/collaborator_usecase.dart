import 'package:challenge_web/app/domain/repositories/collaborator_repository.dart';
import 'package:challenge_web/app/data/models/collaborator_model.dart';

class CollaboratorUseCases {
  final ICollaboratorRepository repository;

  CollaboratorUseCases(this.repository);

  Future<List<CollaboratorModel>> getCollaborators({int? pageNumber, int? pageQuantity}) {
    return repository.getCollaborators(pageNumber:pageNumber, pageQuantity:pageNumber);
  }

  Future<CollaboratorModel> getCollaboratorById(int id) {
    return repository.getCollaboratorById(id);
  }

  Future<void> addCollaborator(CollaboratorModel collaborator) {
    return repository.addCollaborator(collaborator);
  }

  Future<void> updateCollaborator(CollaboratorModel collaborator) {
    return repository.updateCollaborator(collaborator);
  }

  Future<void> deleteCollaborator(int id) {
    return repository.deleteCollaborator(id);
  }
}