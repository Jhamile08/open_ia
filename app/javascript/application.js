// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function () {
    if (window.location.pathname !== '/form_tables/new') return;
    const checkbox = document.getElementById('show-modal-checkbox');
    const modal = document.getElementById('hidden-modal');


    function handle() {
        if (checkbox.checked) {
            modal.style.display = 'block';
        } else {
            modal.style.display = 'none';
        }
    };

    checkbox.addEventListener('change', handle)

    cleanRouteListeners([{
        element: checkbox,
        event: "change",
        callback: handle
    }])
});

function cleanRouteListeners(listeners) {
    const handleTurboLoad = () => {
        for (const listener of listeners) {
            listener.element.removeEventListener(listener.event, listener.callback);
        }
        document.removeEventListener('turbo:load', handleTurboLoad);
    };
    document.addEventListener('turbo:load', handleTurboLoad);
}