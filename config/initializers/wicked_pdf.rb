# Be sure to restart your server when you modify this file.

WickedPdf.configure do |config|
  config.exe_path = Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')
  config.default_options = {
    encoding: 'UTF-8',
    page_size: 'A4',
    margin: { top: 10, bottom: 10, left: 10, right: 10 },
    header: {
      content: nil
    },
    footer: {
      content: nil
    }
  }
end

# Configurações gerais
WickedPdf.config = {
  # Configurações gerais
  exe_path: Gem.win_platform? ? Rails.root.join('bin', 'wkhtmltopdf.exe').to_s : '/usr/local/bin/wkhtmltopdf',
  orientation: 'Portrait',
  page_size: 'A4',
  dpi: '300',
  lowquality: false,
  zoom: 1,
  
  # Configurações de margens
  margin: {
    top: '10mm',
    bottom: '10mm',
    left: '10mm',
    right: '10mm'
  },
  
  # Configurações de cabeçalho e rodapé
  header: {
    content: nil,
    spacing: 0
  },
  footer: {
    content: nil,
    spacing: 0
  },
  
  # Configurações de fonte
  font_family: 'Arial',
  font_size: 12,
  
  # Configurações de imagem
  image_quality: 100,
  
  # Configurações de JavaScript
  enable_javascript: true,
  javascript_delay: 1000,
  
  # Configurações de segurança
  disable_smart_shrinking: false,
  use_xserver: false,
  
  # Configurações de debug
  debug_javascript: false,
  quiet: true,
  
  # Configurações de cache
  cache: true,
  
  # Configurações de timeout
  timeout: 30,
  
  # Configurações de encoding
  encoding: 'UTF-8'
}

# Configurações específicas para ambiente de teste
if Rails.env.test?
  WickedPdf.config.merge!({
    javascript_delay: 0,
    no_pdf_compression: true,
    timeout: 5,
    use_xserver: false,
    print_media_type: true,
    disable_smart_shrinking: true,
    no_background: true,
    cache_dir: Rails.root.join('tmp', 'wicked_pdf_cache').to_s
  })
end 