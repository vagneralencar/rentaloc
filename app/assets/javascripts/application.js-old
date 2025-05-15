// Arquivo desativado para evitar conflito com importmap e garantir funcionamento correto dos campos dinâmicos
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .

// Inicialização do AdminLTE
document.addEventListener('turbo:load', function() {
  // Inicializa todos os componentes do AdminLTE
  if (typeof $.fn.tree !== 'undefined') {
    $('[data-widget="treeview"]').Treeview('init');
  }

  // Inicializa tooltips
  if (typeof $.fn.tooltip !== 'undefined') {
    $('[data-toggle="tooltip"]').tooltip();
  }

  // Inicializa popovers
  if (typeof $.fn.popover !== 'undefined') {
    $('[data-toggle="popover"]').popover();
  }

  // Inicializa dropdowns
  if (typeof $.fn.dropdown !== 'undefined') {
    $('.dropdown-toggle').dropdown();
  }
});

// Funções utilitárias
function formatCurrency(value) {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value);
}

function formatDate(date) {
  return new Intl.DateTimeFormat('pt-BR').format(new Date(date));
}

// Funções para manipulação de tabelas
function initializeDataTable(tableId) {
  if (typeof $.fn.DataTable !== 'undefined') {
    $(`#${tableId}`).DataTable({
      language: {
        url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Portuguese-Brasil.json'
      },
      responsive: true
    });
  }
}

// Funções para manipulação de formulários
function initializeSelect2(selector) {
  if (typeof $.fn.select2 !== 'undefined') {
    $(selector).select2({
      theme: 'bootstrap4',
      width: '100%'
    });
  }
}

// Funções para manipulação de máscaras
function initializeMasks() {
  if (typeof $.fn.mask !== 'undefined') {
    $('.mask-cpf').mask('000.000.000-00');
    $('.mask-cnpj').mask('00.000.000/0000-00');
    $('.mask-phone').mask('(00) 00000-0000');
    $('.mask-cep').mask('00000-000');
    $('.mask-money').mask('#.##0,00', {reverse: true});
  }
}

// Inicialização de componentes quando a página carrega
document.addEventListener('turbo:load', function() {
  initializeMasks();
  initializeSelect2('.select2');
});

// Adição/remoção dinâmica de referências (comercial, bancária, pessoa relacionada)
document.addEventListener('turbo:load', function() {
  // Inicializa os contadores se não existirem
  if (!window.nestedCounters) {
    window.nestedCounters = {
      commercial_references: 0,
      bank_references: 0,
      related_people: 0
    };
  }

  // Remove event listeners antigos para evitar duplicidade
  document.body.removeEventListener('click', handleDynamicFields);
  
  // Adiciona o novo event listener
  document.body.addEventListener('click', handleDynamicFields);
});

function handleDynamicFields(e) {
  // Adicionar campos
  if (e.target.matches('[data-action="add-fields"]')) {
    e.preventDefault();
    const association = e.target.getAttribute('data-association');
    const template = document.getElementById(`${association}_fields_template`);
    
    if (template) {
      const table = e.target.closest('.card-body').querySelector('table tbody');
      if (table) {
        // Clona o template e insere no DOM
        const clone = template.content.cloneNode(true);
        table.appendChild(clone);
        
        // Inicializa máscaras e outros componentes se necessário
        initializeMasks();
      }
    }
  }
  
  // Remover campos
  if (e.target.matches('[data-action="remove-fields"]')) {
    e.preventDefault();
    const row = e.target.closest('tr');
    if (row) {
      const form = row.closest('form');
      if (form) {
        form.remove();
      } else {
        row.remove();
      }
    }
  }
}
