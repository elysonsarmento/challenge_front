import 'package:challenge_web/app/data/models/collaborator_model.dart';

abstract class ICollaboratorRepository {
  Future<List<CollaboratorModel>> getCollaborators({int? pageNumber, int? pageQuantity});
  Future<CollaboratorModel> getCollaboratorById(int id);
  Future<void> addCollaborator(CollaboratorModel collaborator);
  Future<void> updateCollaborator(CollaboratorModel collaborator);
  Future<void> deleteCollaborator(int id);
}