module Octokit
  class Client

    # Methods for the Search API
    #
    # @see http://developer.github.com/v3/search/
    module Repositories

      # Search repositories
      #
      # @param query [String] Search term and qualifiers
      # @param options [Hash] Sort and pagination options
      # @option options [String] :sort Sort field
      # @option options [String] :direction Sort direction (asc or desc)
      # @option options [Fixnum] :page Page of paginated results
      # @option options [Fixnum] :per_page Number of items per page
      # @return [Sawyer::Resource] Search results object
      # @see http://developer.github.com/v3/search/#search-repositories
      def new_search_repositories(query, options = {})
        search "/search/repositories", query, options
      end

      private

      def search(path, query, options = {})
        opts = options.merge(:q => query)
        opts[:accept] ||= "application/vnd.github.preview"
        get path, opts
      end

    end
  end
end