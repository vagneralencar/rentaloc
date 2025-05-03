class PdfGeneratorService
  def self.generate(template:, locals: {}, filename:)
    html = ApplicationController.renderer.render(
      template: template,
      locals: locals,
      layout: 'pdf'
    )
    
    pdf = WickedPdf.new.pdf_from_string(html)
    
    # Salva o PDF usando Active Storage
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(pdf),
      filename: filename,
      content_type: 'application/pdf'
    )
    
    blob
  end
end 