module ActionDispatch
  class Cookies
    class CookieJar #:nodoc:
      def handle_options(options) #:nodoc:

        # Monkey patch to get app to work on Chrome and Firefox work inside iframes again
        if request.ssl? && request.user_agent =~ /Chrome\/8|Firefox/
          options[:same_site] ||= "None";options[:secure] = true
        end

        if options[:expires].respond_to?(:from_now)
          options[:expires] = options[:expires].from_now
        end

        options[:path] ||= "/"

        if options[:domain] == :all || options[:domain] == "all"
          # If there is a provided tld length then we use it otherwise default domain regexp.
          domain_regexp = options[:tld_length] ? /([^.]+\.?){#{options[:tld_length]}}$/ : DOMAIN_REGEXP

          # If host is not ip and matches domain regexp.
          # (ip confirms to domain regexp so we explicitly check for ip)
          options[:domain] = if (request.host !~ /^[\d.]+$/) && (request.host =~ domain_regexp)
            ".#{$&}"
          end
        elsif options[:domain].is_a? Array
          # If host matches one of the supplied domains without a dot in front of it.
          options[:domain] = options[:domain].find { |domain| request.host.include? domain.sub(/^\./, "") }
        end
      end
    end
  end
end