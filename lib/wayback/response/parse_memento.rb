require 'faraday'
require 'time'

module Wayback
  module Response
    class ParseMemento < Faraday::Response::Middleware

      def parse(body, *opts)
        case body
          # Assume it starts with "<http"
          when /^\<http/
            body, info = body.gsub(/,(\s+)?\</, ",\n<").gsub(/\s(\s+)/, ' ').split("\n"), {:id => nil, :dates => {}, :first_date => nil, :last_date => nil}

            body.each do |s|
              attrs, uri = s.split('; '), s.gsub(/^(\<)([A-Z0-9\-\/\:\.\?\=\&]+)(\>)(.*)$/i, '\2')
              rels, datetime, date, from, til = [], nil, nil, nil, nil

              attrs.each do |a|
                k, v = a.gsub(/^([A-Z0-9\-]+)(=.*)$/i, '\1'), a.gsub(/^([A-Z0-9\-]+)(=(\'|\"))(.*)(\'|\")(,)?$/i, '\4')
                case k
                  when 'datetime'
                    datetime, date = v, Time.parse(v).to_i
                  when 'rel'
                    rels = v.split(' ')
                  when 'from'
                    # Not handled by archive.org
                  when 'until'
                    # Not handled by archive.org
                end
              end

              if rels.include?('original')
                info[:id] = uri
              elsif rels.include?('memento')
                info[:last_date] = date if rels.include?('last')
                info[:first_date] = date if rels.include?('first')
                info[:dates][date] = {:datetime => datetime, :uri => uri} unless date.nil?
              elsif rels.include?('timebundle')
                #
              elsif rels.include?('timegate')
                #
              elsif rels.include?('timemap')
                #
              end
            end

            info
          else
            nil
        end
      end

      def on_complete(env)
        if respond_to?(:parse) && ((env[:response_headers] && env[:response_headers]['content-type']) || '').match(/^application\/link-format/i)
          env[:body] = parse(env[:body]) unless [204, 301, 302, 304].include?(env[:status])
        end
      end

    end
  end
end
