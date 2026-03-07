# Eagle Security — сайт (исходники)

Статический сайт на [Eleventy](https://www.11ty.dev/). Контент в Markdown и JSON.

## Требования

- [Node.js](https://nodejs.org/) (LTS)

## Локальный просмотр и деплой

Скрипты **`./serve.sh`** и **`./deploy.sh`** лежат в **корне репозитория**. Запускайте их из корня после клона — зависимости установятся при первом запуске.

```bash
# из корня site-eaglesecurity
./serve.sh
# Откройте http://localhost:8080
```

## Деплой на GitHub Pages

Сайт по адресу `https://<username>.github.io/site-eaglesecurity/`:

**Из клона site-eaglesecurity:**
```bash
GITHUB_PAGES=1 ./deploy.sh
```

**Из монорепо lide** (папка `app/site-eaglesecurity` или `app/play/site-eaglesecurity`), добавьте remote и деплойте в него:
```bash
git remote add site-eaglesecurity git@github.com:nedimonvam/site-eaglesecurity.git   # один раз
REMOTE=site-eaglesecurity GITHUB_PAGES=1 ./deploy.sh
```

В репозитории на GitHub: **Settings → Pages → Source**: ветка **publish**, папка **/ (root)**.

Сборка использует pathPrefix `/site-eaglesecurity/`. Публикация в ветку **publish**.

Кастомный домен (eaglesecurity.app):

```bash
CUSTOM_DOMAIN=1 ./deploy.sh
```

При необходимости: `CUSTOM_DOMAIN_NAME=eaglesecurity.app CUSTOM_DOMAIN=1 ./deploy.sh`

## Языки

- **EN** (по умолчанию): `/`, `/impressum/`, `/privacy/`, `/faq/`
- **DE**: `/de/`, `/de/impressum/`, `/de/datenschutz/`, `/de/faq/`

Переключатель языка в футере.

## Структура

- **content/en/** и **content/de/** — страницы в Markdown
- **_data/strings.json** — подписи навигации и переключателя
- **_data/apps.json** — приложения FREE и UNLIMITED (ссылки, лого)
- **_includes/** — шаблоны Nunjucks
- **assets/css/style.css** — стили
- **assets/img/** — логотип, скриншоты (или из папки `input/`/`inputs` в корне проекта)
