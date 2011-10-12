
class NewsModel

  def add params
    @@news.insert( :title        => params[:title],
                               :author   => params[:author],
                               :cat_id    => 1,
                               :date      =>Time.now,
                               :content => params[:content]
    )
  end

  def delete id
    @@news.filter(:id => id.to_i).delete
  end

  def find_by_id id
    @@news[:id => id.to_i]
  end

  def find_all
    @@news.order(:date.desc)
  end

  def update params
    @@news.filter(:id => params[:id].to_i).update( :title        => params[:title],
                                                                         :author   => params[:author],
                                                                         :cat_id    => 1,
                                                                         :date      =>Time.now,
                                                                         :content => params[:content]
    )
  end

end
