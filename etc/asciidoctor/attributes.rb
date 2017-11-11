require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

def load_ext name
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

