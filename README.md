# GeographicCatalog

**Государственный каталог наименований географических объектов Республики Беларусь** — веб-приложение для поиска, просмотра и администрирования топонимических данных: населённых пунктов, аэропортов, объектов железнодорожной инфраструктуры и физико-географических объектов.

Каталог служит централизованным источником сведений о наименованиях (русский, белорусский, латиница), координатах, кодах СОАТО, истории переименований и связанных справочниках.

---

## Содержание

- [Возможности](#возможности)
- [Типы объектов](#типы-объектов)
- [Технологический стек](#технологический-стек)
- [Структура репозитория](#структура-репозитория)
- [Требования](#требования)
- [Быстрый старт (Docker)](#быстрый-старт-docker)
- [Локальная разработка](#локальная-разработка)
- [Конфигурация](#конфигурация)
- [База данных](#база-данных)
- [Маршруты и разделы](#маршруты-и-разделы)
- [Администрирование](#администрирование)
- [CI/CD](#cicd)
- [Устранение неполадок](#устранение-неполадок)

---

## Возможности

### Публичный каталог

- Полнотекстовый и фильтрованный поиск по наименованиям (русский / белорусский).
- Фильтры: тип объекта, область, район, первая буква алфавита, статус, население (для АТЕ), высота (для ФГО), год основания.
- Постраничный вывод результатов (50 записей на страницу).
- Карточки объектов с подробными атрибутами и историей изменений наименований.
- Экспорт результатов поиска в **CSV** и **PDF**.
- Экспорт карточек отдельных объектов в PDF.
- Массовый экспорт выбранных записей в PDF.
- Статистика на главной странице и в каталоге.
- Поддержка тёмной темы и стилей доступности (`wwwroot/css/accessibility.css`).

### Панель администратора

- CRUD для всех типов объектов (создание, редактирование, удаление).
- Списки с пагинацией, поиском и сортировкой.
- Отчёты и выгрузка административных отчётов в PDF.
- Автогенерация кода СОАТО при создании/редактировании АТЕ.
- Доступ по cookie-аутентификации (раздел `/Admin`).

---

## Типы объектов

| Код | Название | Таблица БД | Маршрут детализации |
|-----|----------|------------|---------------------|
| `ATE` | Административно-территориальные единицы (населённые пункты) | `kn_dbate` | `/Catalog/ATE/{id}` |
| `AIR` | Аэропорты | `kn_dbair` | `/Catalog/Airport/{id}` |
| `RW` | Объекты железнодорожной инфраструктуры | `kn_dbrw` | `/Catalog/Railway/{id}` |
| `FGO` | Физико-географические объекты | `kn_dbfgo` | `/Catalog/FGO/{id}` |

Связанные справочники: области (`kn_obl`), районы (`kn_ra`), категории, значения АТЕ, история изменений (`kn_hchange*`) и др.

---

## Технологический стек

| Компонент | Технология |
|-----------|------------|
| Серверная часть | ASP.NET Core **10.0** (MVC) |
| Доступ к данным | **Dapper** + **Npgsql** (PostgreSQL) |
| База данных | **PostgreSQL 16** |
| PDF | iTextSharp 5.x |
| Клиент | Razor Views, Bootstrap 5, jQuery |
| Контейнеризация | Docker, Docker Compose |
| CI | GitHub Actions (self-hosted runner) |

> В проекте также подключены пакеты Entity Framework Core и SqlClient (исторически); активный путь доступа к БД — **Dapper** через `IDbConnection` / `NpgsqlConnection`.

---

## Структура репозитория

```
GeographicCatalog/                          # корень репозитория
├── README.md
├── .github/workflows/ci.yml                # сборка, Docker, деплой
└── GeographicCatalog/                      # каталог решения
    ├── docker-compose.yml                  # PostgreSQL + приложение
    ├── docker-compose.dcproj
    ├── init.sql                            # дамп схемы и данных (инициализация БД)
    ├── init-db/
    │   ├── 00-create-user.sql                # пользователь rebasedata
    │   ├── 02-rename-tables.sql            # _dbo_kn_* → kn_*
    │   └── 03-lowercase-columns.sql        # имена столбцов в нижнем регистре
    └── GeographicCatalog/                  # веб-проект
        ├── GeographicCatalog.csproj
        ├── Dockerfile
        ├── Program.cs
        ├── appsettings.json
        ├── Controllers/
        │   ├── HomeController.cs           # главная, статистика, карта
        │   ├── CatalogController.cs        # каталог, поиск, экспорт
        │   ├── AdminController.cs          # админ-панель
        │   └── AccountController.cs        # вход / выход
        ├── Models/
        └── Views/
```

Путь к проекту для `dotnet` CLI:

```
GeographicCatalog/GeographicCatalog/GeographicCatalog.csproj
```

---

## Требования

- [.NET SDK 10.0](https://dotnet.microsoft.com/download) — для локальной сборки и запуска.
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (или Docker Engine + Compose) — для запуска в контейнерах.
- **PostgreSQL 16** — если БД поднимается отдельно от Compose.

Порты по умолчанию:

| Сервис | Порт |
|--------|------|
| Веб-приложение (Docker) | `8080` |
| PostgreSQL | `5432` |
| Локальный `dotnet run` (профиль http) | `5298` |

---

## Быстрый старт (Docker)

Из каталога `GeographicCatalog` (где лежит `docker-compose.yml`):

```powershell
cd GeographicCatalog
docker compose up -d
```

Будут запущены:

1. **db** — PostgreSQL с автоматическим применением скриптов из `init.sql` и `init-db/`.
2. **geographiccatalog** — веб-приложение на http://localhost:8080/

Проверка состояния:

```powershell
docker compose ps
docker compose logs -f geographiccatalog
```

Остановка:

```powershell
docker compose down
```

Полная переинициализация БД (удалит том с данными):

```powershell
docker compose down -v
docker compose up -d
```

---

## Локальная разработка

### 1. Поднять только базу данных

```powershell
cd GeographicCatalog
docker compose up -d db
```

Дождитесь статуса `healthy` у контейнера `geographiccatalog-db`.

### 2. Запустить приложение

```powershell
cd GeographicCatalog/GeographicCatalog
dotnet restore
dotnet run
```

По умолчанию откроется http://localhost:5298 (см. `Properties/launchSettings.json`).

Профиль с HTTPS: https://localhost:7079.

### 3. Сборка Release

```powershell
dotnet build GeographicCatalog/GeographicCatalog/GeographicCatalog.csproj -c Release
dotnet publish GeographicCatalog/GeographicCatalog/GeographicCatalog.csproj -c Release -o ./publish
```

### Запуск из Visual Studio

Откройте `GeographicCatalog/docker-compose.dcproj` или `.csproj` проекта. Доступен профиль **Container (Dockerfile)** с портами `8080` / `8081`.

---

## Конфигурация

Основные параметры — в `GeographicCatalog/GeographicCatalog/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Port=5432;Database=geographiccatalog;Username=postgres;Password=postgres"
  },
  "CatalogSettings": {
    "ItemsPerPage": 50,
    "MaxSearchResults": 1000,
    "MapApiKey": "your-map-api-key-here",
    "DefaultRegion": "Брестская"
  },
  "Admin": {
    "Login": "admin",
    "Password": "admin"
  }
}
```

| Параметр | Описание |
|----------|----------|
| `ConnectionStrings:DefaultConnection` | Строка подключения Npgsql. В Docker задаётся переменной `ConnectionStrings__DefaultConnection`. |
| `CatalogSettings:ItemsPerPage` | Размер страницы каталога (в коде контроллера также задано 50). |
| `CatalogSettings:MapApiKey` | Ключ для картографического API на главной странице. |
| `Admin:Login` / `Admin:Password` | Учётные данные администратора (cookie-аутентификация). |

Для секретов в разработке можно использовать [User Secrets](https://learn.microsoft.com/aspnet/core/security/app-secrets) (`UserSecretsId` задан в `.csproj`):

```powershell
cd GeographicCatalog/GeographicCatalog
dotnet user-secrets set "Admin:Password" "надёжный-пароль"
```

> **Важно:** перед развёртыванием в production обязательно смените пароль администратора и пароль PostgreSQL. Не коммитьте реальные секреты в репозиторий.

Переменные окружения в Docker Compose (сервис `geographiccatalog`):

- `ASPNETCORE_URLS=http://+:8080`
- `ConnectionStrings__DefaultConnection=Host=db;Port=5432;...`

---

## База данных

### Инициализация

При первом запуске контейнера `db` PostgreSQL выполняет скрипты из `/docker-entrypoint-initdb.d/` в порядке:

1. `00-create-user.sql` — роль `rebasedata`.
2. `01-schema.sql` — дамп из `init.sql` (таблицы с префиксом `_dbo_kn_*`).
3. `02-rename-tables.sql` — переименование в `kn_*`.
4. `03-lowercase-columns.sql` — приведение имён столбцов к нижнему регистру.

Том `postgres_data` сохраняет данные между перезапусками.

### Учётные записи PostgreSQL (по умолчанию)

| Пользователь | Пароль | Назначение |
|--------------|--------|------------|
| `postgres` | `postgres` | Подключение приложения |
| `rebasedata` | `rebasedata` | Владелец таблиц из дампа |

### Особенность схемы

В таблице `kn_dbate` колонка даты регистрации в исходном дампе содержит **кириллическую букву «Е»** в имени: `daterЕg` (не латинская `e`). Код приложения (`CatalogController`, `AdminController`) обращается к ней явно. При ручных миграциях не переименовывайте этот столбец без правки SQL-запросов в контроллерах.

---

## Маршруты и разделы

### Публичные страницы

| URL | Описание |
|-----|----------|
| `/` | Главная: статистика, быстрый доступ к каталогу |
| `/Home/About` | О проекте |
| `/Home/Privacy` | Политика конфиденциальности |
| `/Catalog` | Поиск и список объектов |
| `/Catalog/ATE/{id}` | Карточка населённого пункта |
| `/Catalog/Airport/{id}` | Карточка аэропорта |
| `/Catalog/Railway/{id}` | Карточка объекта Ж/Д |
| `/Catalog/FGO/{id}` | Карточка ФГО |

### API и служебные endpoints (выборочно)

| Метод | URL | Назначение |
|-------|-----|------------|
| GET | `/Home/GetQuickStats` | Краткая статистика |
| GET | `/Home/GetMapData` | Данные для карты на главной |
| GET | `/Home/HealthCheck` | Проверка работоспособности |
| GET | `/Catalog/GetRegions` | Список областей |
| GET | `/Catalog/GetDistrictsByRegion` | Районы по области |
| GET | `/Catalog/ExportToCsv` | Экспорт результатов поиска |
| GET | `/Catalog/ExportToPdf` | PDF по текущим фильтрам |
| POST | `/Catalog/ExportSelectedToPdf` | PDF по выбранным записям |

### Администрирование

| URL | Описание |
|-----|----------|
| `/Account/Login` | Вход |
| `/Account/Logout` | Выход |
| `/Admin` | Панель управления |
| `/Admin/ListAte`, `ListAirports`, `ListRailway`, `ListFgo` | Списки объектов |
| `/Admin/Edit*`, `Create*`, `Delete*` | Редактирование записей |
| `/Admin/Reports` | Отчёты |

Сессия cookie: 2 часа (с продлением при активности). Опция «Запомнить меня» — до 7 дней.

---

## Администрирование

1. Откройте http://localhost:8080/Account/Login (или локальный порт `dotnet run`).
2. Введите логин и пароль из `Admin` в `appsettings.json` (по умолчанию `admin` / `admin`).
3. После входа доступен раздел `/Admin`.

Рекомендации для production:

- Задайте сложный пароль через переменные окружения или User Secrets.
- Разместите приложение за reverse proxy с HTTPS.
- Ограничьте доступ к порту PostgreSQL (`5432`) только внутренней сетью.

---

## CI/CD

Workflow `.github/workflows/ci.yml` на **self-hosted** runner:

| Job | Действие |
|-----|----------|
| `build` | `dotnet restore` + `dotnet build` (Release), .NET 10.0.x |
| `docker` | Сборка образа `geographiccatalog:latest` |
| `deploy` | Только при `push`: `docker compose up` (БД + приложение), health-check http://localhost:8080/ |

Ветки: `master`, `dev`, `ci-cd`.

Локальная сборка образа (контекст — каталог `GeographicCatalog/`):

```powershell
docker build -f GeographicCatalog/GeographicCatalog/Dockerfile -t geographiccatalog:latest GeographicCatalog
```

---

## Устранение неполадок

### Приложение не подключается к БД

- Убедитесь, что PostgreSQL запущен и контейнер `db` в состоянии `healthy`.
- Проверьте строку подключения: для Docker хост — `db`, для локального `dotnet run` — `localhost`.
- При первом запуске инициализация БД может занять несколько минут из-за объёма `init.sql`.

### Пустой каталог или ошибки SQL

- Убедитесь, что выполнились все скрипты `init-db/` (таблицы должны называться `kn_*`, не `_dbo_kn_*`).
- Проверьте логи: `docker compose logs db`.

### Порт 8080 занят

Измените маппинг в `docker-compose.yml`:

```yaml
ports:
  - "9080:8080"
```

### Ошибки кодировки в PDF

В `Program.cs` регистрируется `CodePagesEncodingProvider` для корректной работы iTextSharp с кириллицей.

### Health-check CI не проходит

Просмотрите логи приложения:

```powershell
docker compose -f GeographicCatalog/docker-compose.yml logs geographiccatalog --tail=50
```

---

## Правовая основа (предметная область)

Система ориентирована на учёт наименований географических объектов в соответствии с законодательством Республики Беларусь, в том числе:

- Закон «О наименованиях географических объектов»;
- Инструкция о порядке государственного учёта наименований географических объектов;
- Нормативные акты уполномоченных органов.

Подробнее — на странице **О проекте** в приложении (`/Home/About`).

---

## Лицензия

Лицензия на репозиторий не указана. Уточните условия использования у правообладателя перед распространением и коммерческим применением.
