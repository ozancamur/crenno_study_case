part of 'claim_form_bloc.dart';

sealed class ClaimFormEvent extends Equatable {
  const ClaimFormEvent();

  @override
  List<Object?> get props => [];
}

final class ClaimDateChanged extends ClaimFormEvent {
  const ClaimDateChanged(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

final class ClaimDescriptionChanged extends ClaimFormEvent {
  const ClaimDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

final class ClaimSubmitted extends ClaimFormEvent {
  const ClaimSubmitted();
}
