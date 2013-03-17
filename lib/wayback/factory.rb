module Wayback
  class Factory

    # Instantiates a new action object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :action key.
    # @return [Wayback::Action::Favorite, Wayback::Action::Follow, Wayback::Action::ListMemberAdded, Wayback::Action::Mention, Wayback::Action::Reply, Wayback::Action::Retweet]
    def self.fetch_or_new(method, klass, attrs={})
      return unless attrs
      type = attrs.delete(method.to_sym)
      if type
        const_name = type.gsub(/\/(.?)/){"::#{$1.upcase}"}.gsub(/(?:^|_)(.)/){$1.upcase}
        klass.const_get(const_name.to_sym).fetch_or_new(attrs)
      else
        raise ArgumentError, "argument must have :#{method} key"
      end
    end

  end
end
