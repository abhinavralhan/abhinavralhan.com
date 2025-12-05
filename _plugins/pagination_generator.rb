module Jekyll
  class PaginationPageGenerator < Generator
    safe true

    def generate(site)
      return unless site.config['posts_per_page']

      posts_per_page = site.config['posts_per_page'].to_i
      total_posts = site.posts.docs.size
      total_pages = (total_posts.to_f / posts_per_page).ceil

      # Generate pages 2 through total_pages
      (2..total_pages).each do |page_num|
        site.pages << PaginationPage.new(site, site.source, page_num)
      end
    end
  end

  class PaginationPage < Page
    def initialize(site, base, page_num)
      @site = site
      @base = base
      @dir = "page/#{page_num}"
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'pagination.html')
      self.data['page_num'] = page_num
    end
  end
end
