// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// AdminLTE
import "admin-lte"

// Select2
import "select2"
import "select2/dist/css/select2.css"

// Máscaras de input
import "jquery-mask-plugin"

// Configurações globais
document.addEventListener("turbo:load", function() {
  // Inicializa tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Inicializa select2
  $('select').select2({
    theme: 'bootstrap4',
    width: '100%'
  })

  // Inicializa máscaras
  $('.date').mask('00/00/0000')
  $('.time').mask('00:00:00')
  $('.date_time').mask('00/00/0000 00:00:00')
  $('.cep').mask('00000-000')
  $('.phone').mask('(00) 0000-00009')
  $('.cpf').mask('000.000.000-00')
  $('.cnpj').mask('00.000.000/0000-00')
  $('.money').mask('000.000.000.000.000,00', {reverse: true})
  $('.percent').mask('##0,00%', {reverse: true})
})

// Configurações do Turbo
Turbo.setProgressBarDelay(100)

// Nested fields handler para Rails forms (dinâmico, para importmap)
document.addEventListener('turbo:load', () => {
  function removeFields(link) {
    const field = link.closest('tr');
    if (field.querySelector('input[type="hidden"][name*="_destroy"]")) {
      field.querySelector('input[type="hidden"][name*="_destroy"]').value = 1;
      field.style.display = 'none';
    } else {
      field.remove();
    }
  }

  function addFields(link, association) {
    // Busca o template pelo id
    const template = document.getElementById(association + '_fields_template');
    if (!template) return;
    // Busca o tbody mais próximo do botão
    let tableBody = link.closest('.card').querySelector('tbody');
    if (!tableBody) {
      // fallback: busca o primeiro tbody da página
      tableBody = document.querySelector('tbody');
    }
    const newId = new Date().getTime();
    const newRow = template.innerHTML.replace(/__INDEX__/g, newId);
    tableBody.insertAdjacentHTML('beforeend', newRow);
  }

  document.body.addEventListener('click', function(e) {
    if (e.target.matches('[data-action="remove-fields"]')) {
      e.preventDefault();
      removeFields(e.target);
    }
    if (e.target.matches('[data-action="add-fields"]')) {
      e.preventDefault();
      addFields(e.target, e.target.dataset.association);
    }
  });
});
