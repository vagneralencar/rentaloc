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
