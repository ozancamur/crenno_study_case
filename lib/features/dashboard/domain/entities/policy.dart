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

  int get totalDurationDays => endDate.difference(startDate).inDays.abs();

  int elapsedDaysAt(DateTime now) => now.difference(startDate).inDays;

  double progressAt(DateTime now) {
    final normalizedTotal = totalDurationDays == 0 ? 1 : totalDurationDays;

    return (elapsedDaysAt(now) / normalizedTotal).clamp(0.0, 1.0);
  }

  int remainingDaysAt(DateTime now) => endDate.difference(now).inDays;

  bool isActiveAt(DateTime now) => remainingDaysAt(now) >= 0;

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
