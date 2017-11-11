RUBY_ENGINE == 'opal' ? (require 'attributes') : (require_relative 'attributes')

class GitMetadataPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    attrs['icons'] = true
    nil
  end
end

Asciidoctor::Extensions.register do
  preprocessor GitMetadataPreprocessor
end
