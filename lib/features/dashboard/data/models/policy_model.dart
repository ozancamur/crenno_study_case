import '../../domain/entities/policy.dart';

class PolicyModel {
  const PolicyModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.coverageAmount,
    required this.description,
  });

  final String id;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final double coverageAmount;
  final String description;

  factory PolicyModel.fromMap(Map<String, dynamic> map) {
    return PolicyModel(
      id: map['id'] as String,
      type: map['type'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      coverageAmount: (map['coverageAmount'] as num).toDouble(),
      description: map['description'] as String,
    );
  }

  Policy toEntity() {
    return Policy(
      id: id,
      type: type,
      startDate: startDate,
      endDate: endDate,
      coverageAmount: coverageAmount,
      description: description,
    );
  }
}
