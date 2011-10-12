
require './db/db_migrate'

# DB config
set :database, 'sqlite://db/app.db'
#set :database, 'mysql://root@localhost/app_dev'

# migrate
add_data_to_db = false
if !database.table_exists?('news')
  add_data_to_db = true
  puts ">>> the news table doesn't exist"
end

migration "create news table" do
  database.create_table :news do
    primary_key :id
    string           :title
    string           :author
    integer         :cat_id
    timestamp   :date
    text              :content

    index :title
  end
end

# initialize data
@@news = database[:news]
if add_data_to_db
  @@news.insert( :title        => 'Lorem ipsum dolor sit amet',
                             :author   => 'admin',
                             :cat_id    => 1,
                             :date      =>Time.now,
                             :content => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer luctus quam quis nibh fringilla sit amet consectetur lectus malesuada. Sed nec libero erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mi nisi, rhoncus ut vestibulum ac, sollicitudin quis lorem. Duis felis dui, vulputate nec adipiscing nec, interdum vel tortor. Sed gravida, erat nec rutrum tincidunt, metus mauris imperdiet nunc, et elementum tortor nunc at eros. Donec malesuada congue molestie. Suspendisse potenti. Vestibulum cursus congue sem et feugiat. Morbi quis elit odio.'
  )
  @@news.insert( :title        => 'Morbi quis elit odio',
                             :author   => 'user',
                             :cat_id    => 2,
                             :date      =>Time.now,
                             :content => "In this tutorial, we are creating a photo shoot effect with our just-released PhotoShoot jQuery plug-in. With it you can convert a regular div on the page into a photo shooting stage simulating a camera-like feel.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer luctus quam quis nibh fringilla sit amet consectetur lectus malesuada. Sed nec libero erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mi nisi, rhoncus ut vestibulum ac, sollicitudin quis lorem. Duis felis dui, vulputate nec adipiscing nec, interdum vel tortor. Sed gravida, erat nec rutrum tincidunt, metus mauris imperdiet nunc, et elementum tortor nunc at eros. Donec malesuada congue molestie. Suspendisse potenti. Vestibulum cursus congue sem et feugiat. Morbi quis elit odio. "
  )
end
