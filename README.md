# CRENNO Study Case


## MİMARİ VE TASARIM
**Clean Architecture** prensiplerine uygun olarak **Feature-First** (özellik öncelikli) klasör yapısıyla kurgulanmıştır.

### Katmanlar:
* **DOMAIN:** Entities, Use Case'leri ve Repository arayüzlerini içerir.
* **DATA:** API entegrasyonu yönetir. **Dio** kullanılarak Repository implementasyonları ve datasources bu katmanda tutulur.
* **PRESENTATION:** BLoC tarafından yönetilen UI mantığını ve widget'ları içerir.

## Kullanılan Teknolojiler
* **STATE MANAGEMENT:** Durum yönetimi için [BLoC](https://pub.dev/packages/flutter_bloc) tercih edilmiştir.
* **ROUTE:** Rota yönetimi için [GoRouter](https://pub.dev/packages/go_router) kullanılmıştır.
* **NETWORK:** Gelişmiş hata yönetimi ve interceptor desteği için [Dio](https://pub.dev/packages/dio) kullanılmıştır.
* **DEPENDENCY INJECTION(DI):** Servis yönetimi için [GetIt](https://pub.dev/packages/get_it) kullanılmıştır.
* **MOCK DATA:** Poliçe verilerini asenkron olarak çekmek için **Mocky** üzerinde 2 adet endpoint oluşturulmuştur.
