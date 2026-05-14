// Функции для работы с каталогом

document.addEventListener('DOMContentLoaded', function () {
    // Инициализация компонентов
    initAlphabetFilter();
    initSearchForm();
    initTableInteractions();
    initExportButtons();
});

// Инициализация алфавитного фильтра
function initAlphabetFilter() {
    const alphabetButtons = document.querySelectorAll('.alphabet-letter');

    alphabetButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            // Если уже выбранная буква, снимаем выбор
            if (this.classList.contains('btn-primary')) {
                this.classList.remove('btn-primary');
                this.classList.add('btn-outline-secondary');
                document.querySelector('input[name="FirstLetter"]').value = '';
            } else {
                // Снимаем выделение с других букв
                alphabetButtons.forEach(btn => {
                    btn.classList.remove('btn-primary');
                    btn.classList.add('btn-outline-secondary');
                });

                // Выделяем текущую букву
                this.classList.remove('btn-outline-secondary');
                this.classList.add('btn-primary');
                document.querySelector('input[name="FirstLetter"]').value = this.textContent.trim();
            }

            // Автоматически отправляем форму
            document.querySelector('.search-form').submit();
        });
    });
}

// Инициализация формы поиска
function initSearchForm() {
    const searchForm = document.querySelector('.search-form');
    const searchInput = searchForm.querySelector('input[name="SearchQuery"]');

    // Автокомплит
    if (searchInput) {
        searchInput.addEventListener('input', debounce(function (e) {
            const query = e.target.value;
            if (query.length >= 2) {
                fetchAutocomplete(query);
            }
        }, 300));
    }

    // Обработка отправки формы
    searchForm.addEventListener('submit', function (e) {
        // Сбрасываем страницу на первую при новом поиске
        if (!this.querySelector('input[name="Page"]').value) {
            this.querySelector('input[name="Page"]').value = 1;
        }
    });
}

// Функция автозаполнения
function fetchAutocomplete(query) {
    fetch(`/api/search/suggest?q=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
            showAutocompleteSuggestions(data);
        })
        .catch(error => console.error('Ошибка автозаполнения:', error));
}

// Показ подсказок автозаполнения
function showAutocompleteSuggestions(suggestions) {
    // Реализация выпадающего списка с подсказками
    // (упрощенная версия)
}

// Инициализация взаимодействий с таблицей
function initTableInteractions() {
    const tableRows = document.querySelectorAll('.search-result');

    tableRows.forEach(row => {
        row.addEventListener('click', function (e) {
            // Снимаем выделение с других строк
            tableRows.forEach(r => r.classList.remove('selected-object'));

            // Выделяем текущую строку
            this.classList.add('selected-object');

            // Получаем данные объекта
            const objectType = this.dataset.objectType;
            const objectId = this.dataset.objectId;
            const nameRu = this.dataset.nameRu;
            const nameBe = this.dataset.nameBe;
            const lat = this.dataset.lat;
            const lng = this.dataset.lng;

            // Вызываем функцию отображения на карте
            if (typeof selectObject === 'function') {
                selectObject(objectType, objectId, nameRu, nameBe, lat, lng);
            }
        });
    });
}

// Инициализация кнопок экспорта
function initExportButtons() {
    const exportButtons = document.querySelectorAll('.export-btn');

    exportButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            const format = this.dataset.format;
            exportData(format);
        });
    });
}

// Экспорт данных
function exportData(format) {
    const searchParams = new URLSearchParams(window.location.search);

    fetch(`/Catalog/ExportTo${format.toUpperCase()}?${searchParams.toString()}`)
        .then(response => response.blob())
        .then(blob => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `geographic_catalog_${new Date().toISOString().slice(0, 10)}.${format}`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
        })
        .catch(error => console.error('Ошибка экспорта:', error));
}

// Вспомогательная функция debounce
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Функция для обновления статистики
function updateStatistics() {
    fetch('/api/catalog/statistics')
        .then(response => response.json())
        .then(data => {
            updateStatisticsDisplay(data);
        })
        .catch(error => console.error('Ошибка обновления статистики:', error));
}

// Обновление отображения статистики
function updateStatisticsDisplay(statistics) {
    // Обновление DOM элементов со статистикой
    // (реализация зависит от структуры HTML)
}

// Интеграция с картой (заглушка для будущей реализации)
function initMap() {
    console.log('Инициализация карты будет выполнена весной');

    // Здесь будет код для инициализации Leaflet/OpenLayers карты
    // window.map = L.map('mapContainer').setView([53.9, 27.5667], 7);
    // L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(window.map);
}

// Инициализация при загрузке страницы
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initMap);
} else {
    initMap();
}