# Site Eagle Security

Сайт приложения **Eagle Security** (продуктовый лендинг). Репозиторий: [site-eaglesecurity](https://github.com/nedimonvam/site-eaglesecurity).

## Структура

- **`spec/`** — спецификация и ТЗ: обзор сайта, шаблон задания, инструкции для AI. Заполните ТЗ перед разработкой.
- **`src/`** — исходники сайта (контент, шаблоны, стили, скрипты). Реализуется по ТЗ.

## Быстрый старт

После клонирования можно сразу запустить локальный просмотр или деплой из **корня репозитория**:

```bash
git clone https://github.com/nedimonvam/site-eaglesecurity.git
cd site-eaglesecurity
./serve.sh    # локальный сервер на http://localhost:8080 (при первом запуске установит зависимости)
# или
GITHUB_PAGES=1 ./deploy.sh   # сборка и публикация на GitHub Pages
```

1. Ознакомьтесь с [spec/00-site-overview.md](spec/00-site-overview.md).
2. Заполните [spec/01-tz-template.md](spec/01-tz-template.md).
3. По ТЗ и [spec/AI-INDEX.md](spec/AI-INDEX.md) реализуйте сайт в `src/`.
