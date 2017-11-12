require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

def load_extension name
    if File.exist? File.dirname(__FILE__) + "/#{name}.rb"
        begin
            RUBY_ENGINE == 'opal' ? (require name) : (require_relative name)
            $stdout.puts "#  loaded extension: " + File.basename(name) if ENV["DEBUG"]
        rescue LoadError => e
            $stdout.puts "#  load extension (#{File.basename(name)}) failed: #{e}" if ENV["DEBUG"]
        end
    else
        $stdout.puts "#  missed extension: " + File.basename(name) if ENV["DEBUG"]
    end
end

class AttributesPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    attrs['icons'] = 'font'

    attrs['source-highlighter'] = 'pygments' #coderay
    attrs['pygments-linenums-mode'] = 'inline'
    attrs['coderay-linenums-mode'] = 'inline'
    attrs['pygments-style']= 'pastie'

    attrs['skip-front-matter'] = true
  end
end


class PdfAttributesPreprocessor < AttributesPreprocessor
  def process document, reader
    super
    attrs = document.attributes
  end
end

class HtmlAttributesPreprocessor < AttributesPreprocessor
  def process document, reader
    super
    attrs = document.attributes
    attrs['data-uri'] = true
    attrs['allow-uri-read'] = true
    attrs['stylesdir'] = File.dirname(__FILE__) + '/stylesheets'
    attrs['stylesheet'] = 'asciidoctor.css'
    nil
  end
end

Asciidoctor::Extensions.register do
  if document.basebackend? 'html'
    load_extension 'extensions-lab/lib/chart-block-macro'
    load_extension 'extensions-lab/lib/git-metadata-preprocessor'
    preprocessor HtmlAttributesPreprocessor

  elsif document.basebackend? 'pdf'
    preprocessor PdfAttributesPreprocessor

  else
    preprocessor AttributesPreprocessor
  end
end
