# Insurance Mobile App MVP

Flutter case study implementation for insurance policy listing and damage claim submission.

## Architecture

This project uses **Clean Architecture** with a feature-first structure.

- `presentation`: UI widgets, screens, and BLoC state management.
- `domain`: entities, repository contracts, and use cases.
- `data`: datasource, models, and repository implementation.

Selected stack:

- State management: `bloc` / `flutter_bloc`
- Routing: `go_router`
- Networking: `dio`

## Features

- Dashboard policy list (`GET /policies`) with async loading.
- Loading, error, and retry states.
- Policy detail screen with coverage and policy dates.
- Claim form (`POST /claims`) with:
  - incident date picker
  - incident description field
  - required field validation
  - success/error feedback

## Run

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

Coverage includes repository and BLoC state transition scenarios for dashboard and claim form.
