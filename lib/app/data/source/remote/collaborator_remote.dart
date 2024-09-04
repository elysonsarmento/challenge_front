import 'package:dio/dio.dart';
import 'package:challenge_web/app/data/models/collaborator_model.dart';

class CollaboratorRemote {
  final Dio dio;

  CollaboratorRemote(
    this.dio,
  );

  Future<List<CollaboratorModel>> getCollaborators(
      {int? pageNumber = 1, int? pageQuantity = 10}) async {
    try {
      final response = await dio.get('/Collaborator',
          queryParameters: {
            'pageNumber': pageNumber,
            'pageQuantity': pageQuantity,
          }..removeWhere((key, value) => value == null));

      List<dynamic> data = response.data["items"];
      return data.map((json) => CollaboratorModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception(
          'Failed to load collaborators: $e ${dio.options.baseUrl}');
    }
  }

  Future<CollaboratorModel> getCollaboratorById(int id) async {
    try {
      final response = await dio.get('/Collaborator/$id');
      return CollaboratorModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load collaborator: $e');
    }
  }

  Future<void> addCollaborator(CollaboratorModel collaborator) async {
    try {
      final response = await dio.post(
        '/Collaborator',
        data: collaborator.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add collaborator $response');
      }
    } catch (e) {
      throw Exception('Failed to add collaborator: $e');
    }
  }

  Future<void> updateCollaborator(CollaboratorModel collaborator) async {
    try {
      final response = await dio.put(
        '/Collaborator/${collaborator.id}',
        data: collaborator.toJson(),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to update collaborator $response');
      }
    } catch (e) {
      throw Exception('Failed to update collaborator: $e');
    }
  }

  Future<void> deleteCollaborator(int id) async {
    try {
      final response = await dio.delete('/Collaborator/$id');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete collaborator');
      }
    } catch (e) {
      throw Exception('Failed to delete collaborator: $e');
    }
  }
}
