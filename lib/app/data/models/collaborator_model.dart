class CollaboratorModel {
  int? id;
  String name;
  String? position;
  double? salary;
  String enrollment;

  CollaboratorModel({
    this.id,
    required this.name,
    this.position,
    this.salary,
    required this.enrollment,
  });

  factory CollaboratorModel.fromJson(Map<String, dynamic> json) {
    return CollaboratorModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      salary: json['salary'].toDouble(),
      enrollment: json['enrollment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
      'enrollment': enrollment,
    }..removeWhere(
        (key, value) => value == null,
      );
  }

  @override
  String toString() {
    return 'CollaboratorModel(id: $id, name: $name, position: $position, salary: $salary, enrollment: $enrollment)';
  }
}
