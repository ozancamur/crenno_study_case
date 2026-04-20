import 'package:equatable/equatable.dart';

class Policy extends Equatable {
  const Policy({
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

  @override
  List<Object?> get props => [
        id,
        type,
        startDate,
        endDate,
        coverageAmount,
        description,
      ];
}
