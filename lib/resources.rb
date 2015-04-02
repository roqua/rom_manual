require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'
require 'time'
require 'csv'

module GitHub
  module Resources
    module Helpers
      STATUSES = {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        205 => '205 Reset Content',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        307 => '307 Temporary Redirect',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method not allowed',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error',
        502 => '502 Bad Gateway'
      }

      AUTHORS = {
        :technoweenie => '821395fe70906c8290df7f18ac4ac6cf',
        :tclem        => '2f4861b27dc35663ed271d39f5358261',
        :pengwynn     => '7e19cd5486b5d6dc1ef90e671ba52ae0',
        :pezra        => 'f38112009dc16547051c8ac246cee443',
        :rick         => 'a44d5abad6e86cff4e34d9f0839535c9',
        :agh          => '6af915d3c6aa4ad30bbad43d8035fe10',
        :jasonrudolph => '592e1e6f041f9a4ec51846fd82013aea',
        :Caged        => '97c3a8eea9b7eaa9e1e93ea3cd47399f',
        :foca         => 'd0ca2bf32bda9e9ea8c4473ffc3aaa0d',
        :ymendel      => 'b1b1d33e0655e841d4fd8467359c58d0',
        :mastahyeti   => '8caa0afdae1a934c30a1998472c63134',
        :atmos        => 'a86224d72ce21cd9f5bee6784d4b06c7',
        :kdaigle      => 'bc622cf1dc277323515fd4d7ed66ed24',
        :gjtorikian   => 'befd819b3fced8c6bd3dba7e633dd068'
      }

      DefaultTimeFormat = "%B %-d, %Y".freeze

      def post_date(item)
        strftime item[:created_at]
      end

      def status_label(item)
        status = item[:status] || 'draft'
        %(<span class="status status-#{status.downcase}">
          #{status}
          </span>)
      end

      def screenshot(name)
        %(<div class="screenshot">
            <img src="/assets/images/screenshots/#{name}.png" />
          </div>)
      end

      def strftime(time, format = DefaultTimeFormat)
        attribute_to_time(time).strftime(format)
      end

      def headers(status, head = {})
        css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << link_header(value)
            else
              lines << "#{key}: #{value}"
          end
        end

        %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
      end

      def link_header(rels)
        formatted_rels = rels.map { |name, url| link_header_rel(name, url) }

        lines = ["Link: #{formatted_rels.shift}"]
        while formatted_rels.any?
          lines.last << ","
          lines << "      #{formatted_rels.shift}"
        end

        lines
      end

      def link_header_rel(name, url)
        %Q{<#{url}>; rel="#{name}"}
      end

      def json(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        %(<pre><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end

      def no_body
        %(<pre><code>(no response body)</code></pre>)
      end

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre><code>) + res + "</code></pre>"
      end
    end
  end
end

include GitHub::Resources::Helpers
