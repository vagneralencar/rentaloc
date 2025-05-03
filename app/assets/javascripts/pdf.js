// Funções utilitárias para PDF

// Formatação de moeda
function formatCurrency(value) {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value);
}

// Formatação de data
function formatDate(date) {
  return new Intl.DateTimeFormat('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  }).format(new Date(date));
}

// Formatação de data e hora
function formatDateTime(date) {
  return new Intl.DateTimeFormat('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(date));
}

// Cálculo de totais
function calculateTotal(items, field) {
  return items.reduce((sum, item) => sum + (parseFloat(item[field]) || 0), 0);
}

// Quebra de página automática
function handlePageBreaks() {
  const tables = document.querySelectorAll('table');
  tables.forEach(table => {
    const rect = table.getBoundingClientRect();
    if (rect.bottom > window.innerHeight) {
      table.classList.add('page-break');
    }
  });
}

// Inicialização
document.addEventListener('DOMContentLoaded', () => {
  handlePageBreaks();
}); 