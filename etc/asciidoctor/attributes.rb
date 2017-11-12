require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

def load_extension name
    if File.exist? File.dirname(__FILE__) + "/#{name}.rb"
        begin
            require_relative name unless RUBY_ENGINE == 'opal'
            $stdout.puts "#  loaded extension: " + File.basename(name) if ENV["DEBUG"]
            return true
        rescue LoadError => e
            $stdout.puts "#  load extension (#{File.basename(name)}) failed: #{e}" if ENV["DEBUG"]
        end
    else
        $stdout.puts "#  missed extension: " + File.basename(name) if ENV["DEBUG"]
    end
    return false
end

$stdout::puts "#  load '#{ENV['BACKEND']}' attributes" if ENV["DEBUG"]
load_extension 'extensions-lab/lib/chart-block-macro' if ENV['BACKEND'] == 'html'
load_extension 'asciidocotor-pdf/lib/asciidoctor-pdf' if ENV['BACKEND'] == 'pdf'
load_extension 'extensions-lab/lib/git-metadata-preprocessor' if false

# All backends attributes
class AttributesPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader

    attrs = document.attributes
    attrs['icons'] = 'font'

    attrs['source-highlighter'] = 'pygments' #coderay
    attrs['pygments-linenums-mode'] = 'inline'
    attrs['coderay-linenums-mode'] = 'inline'
    attrs['pygments-style']= 'pastie'

    attrs['skip-front-matter'] = true
    nil
  end
end

# Html attributes
class PdfAttributesPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    nil
  end
end

# pdf attributes
class HtmlAttributesPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    attrs = document.attributes
    attrs['data-uri'] = true
    attrs['allow-uri-read'] = true
    attrs['stylesdir'] = File.dirname(__FILE__) + '/stylesheets'
    attrs['stylesheet'] = 'asciidoctor.css'
    nil
  end
end

Asciidoctor::Extensions.register do
  preprocessor AttributesPreprocessor
  #2479 basebackend doesn't work for pdf backend
  if document.attributes['backend'] == 'pdf'
    preprocessor  PdfAttributesPreprocessor

  elsif document.basebackend? 'html'
    preprocessor HtmlAttributesPreprocessor
  end
end

