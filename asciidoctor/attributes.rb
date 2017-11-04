require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

class GitMetadataPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    attrs['data-uri'] = true
    attrs['allow-uri-read'] = true
    attrs['stylesdir'] = File.dirname(__FILE__) + "/styles"
    attrs['stylesheet'] = 'asciidoctor-default.css'
    nil
  end
end

Asciidoctor::Extensions.register do
  preprocessor GitMetadataPreprocessor
end
