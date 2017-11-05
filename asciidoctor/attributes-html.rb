RUBY_ENGINE == 'opal' ? (require 'attributes') : (require_relative 'attributes')

load_ext 'extensions-lab/lib/chart-block-macro'
load_ext 'extensions-lab/lib/git-metadata-preprocessor'

class GitMetadataPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    attrs['data-uri'] = true
    attrs['allow-uri-read'] = true
    attrs['icons'] = 'font'
    attrs['coderay-linenums-mode'] = 'inline'
    attrs['source-highlighter'] = 'pygments' #coderay
    attrs['pygments-linenums-mode'] = 'inline'
    attrs['pygments-style']= 'pastie'
    attrs['stylesdir'] = File.dirname(__FILE__) + '/stylesheets'
    attrs['stylesheet'] = 'asciidoctor.css'
    nil
  end
end

Asciidoctor::Extensions.register do
  preprocessor GitMetadataPreprocessor
end
