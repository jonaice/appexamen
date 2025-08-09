import './bootstrap';
import "jsvectormap/dist/jsvectormap.min.css";
import "flatpickr/dist/flatpickr.min.css";
import "dropzone/dist/dropzone.css";
import Alpine from "alpinejs";
import persist from "@alpinejs/persist";
Alpine.plugin(persist);
window.Alpine = Alpine;
Alpine.start();