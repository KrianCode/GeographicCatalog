// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.
//
// Глобальная инициализация клиентских скриптов

document.addEventListener('DOMContentLoaded', function () {
    initThemeToggle();
    initAccessibilityToggle();
});

function initThemeToggle() {
    var toggleBtn = document.getElementById('themeToggleBtn');
    var toggleIcon = document.getElementById('themeToggleIcon');
    if (!toggleBtn || !toggleIcon) {
        return;
    }

    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        try {
            localStorage.setItem('gc-theme', theme);
        } catch (e) {
            // ignore storage errors
        }

        // Обновляем иконку
        if (theme === 'dark') {
            toggleIcon.classList.remove('bi-moon-fill');
            toggleIcon.classList.add('bi-sun-fill');
        } else {
            toggleIcon.classList.remove('bi-sun-fill');
            toggleIcon.classList.add('bi-moon-fill');
        }
    }

    // Устанавливаем начальное состояние иконки
    var savedTheme = null;
    try {
        savedTheme = localStorage.getItem('gc-theme');
    } catch (e) {
        savedTheme = null;
    }

    var prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    var currentTheme = savedTheme || document.documentElement.getAttribute('data-theme') || (prefersDark ? 'dark' : 'light');

    applyTheme(currentTheme);

    toggleBtn.addEventListener('click', function () {
        var theme = document.documentElement.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
        applyTheme(theme);
    });
}

function initAccessibilityToggle() {
    var btn = document.getElementById('a11yToggleBtn');
    var btnFooter = document.getElementById('a11yToggleBtnFooter');
    var buttons = [btn, btnFooter].filter(Boolean);
    if (buttons.length === 0) return;

    function applyAccessibility(on) {
        if (on) {
            document.documentElement.setAttribute('data-accessibility', 'on');
            buttons.forEach(function (b) { b.classList.add('active'); b.setAttribute('aria-pressed', 'true'); });
            if (btnFooter) btnFooter.textContent = 'Выключить версию для слабовидящих';
        } else {
            document.documentElement.removeAttribute('data-accessibility');
            buttons.forEach(function (b) { b.classList.remove('active'); b.setAttribute('aria-pressed', 'false'); });
            if (btnFooter) btnFooter.textContent = 'Версия для слабовидящих';
        }
        try { localStorage.setItem('gc-accessibility', on ? 'on' : 'off'); } catch (e) {}
    }

    var saved = localStorage.getItem('gc-accessibility');
    var isOn = document.documentElement.getAttribute('data-accessibility') === 'on' || saved === 'on';
    applyAccessibility(isOn);

    function toggle() {
        var isOn = document.documentElement.getAttribute('data-accessibility') === 'on';
        applyAccessibility(!isOn);
    }
    if (btn) btn.addEventListener('click', toggle);
    if (btnFooter) btnFooter.addEventListener('click', toggle);
}
