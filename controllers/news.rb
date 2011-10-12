# news controller
class NewsController
  # first page
  def index
     @@show_all_news = NewsModel.new.find_all
  end
  # del news
  def delete id
  	NewsModel.new.delete id
  end
  # show one news
  def show
    @@show_news = NewsModel.new.find_by_id @@id
  end
  # edit news
  def edit
    @@edit_news = NewsModel.new.find_by_id @@id
  end
end
