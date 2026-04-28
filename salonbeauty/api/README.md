## OpenAPI контракт

Файл контракта: `openapi.yaml`

### Базовый URL

`http://localhost:8000/v1`

### Основные эндпоинты

- `GET /signups` - список записей
- `POST /signups` - создать запись
- `PATCH /signups/{signupId}` - обновить запись, статус
- `GET /masters/{masterId}/schedule` - расписание мастера
- `GET /payments` - список оплат
- `POST /payments` - создать оплату
- `GET /payments/{paymentId}` - получить оплату
- `GET /catalog/services` - каталог услуг
- `GET /promotions/active` - активные акции на дату

