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
- Networking simulation: `dio` + custom interceptor

## Features

- Dashboard policy list (`GET /policies`) with async loading.
- Loading, error, and retry states.
- Policy detail screen with coverage and policy dates.
- Claim form (`POST /claims`) with:
  - incident date picker
  - incident description field
  - required field validation
  - success/error feedback

## Mock API strategy

A `Dio` interceptor in `lib/core/network/dio.dart` simulates backend behavior:

- `GET /policies` returns `assets/mocks/policies.json`
- `POST /claims` returns success by default
- If description contains `error`, API returns a simulated failure response
- Every request waits 2 seconds to simulate network delay

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
