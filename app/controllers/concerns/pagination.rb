# app/controllers/concerns/pagination.rb
module Pagination
    def pagination_dict(object, stats = {})
      meta = {
        current_page: object.current_page,
        total_pages: object.total_pages,
        total_count: object.total_count,
        next_page: object.next_page,
        prev_page: object.prev_page
      }
      meta.merge!(stats) unless stats.blank?
      return meta
    end
end
  