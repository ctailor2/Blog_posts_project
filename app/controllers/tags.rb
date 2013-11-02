get '/tags' do
  @tags = Tag.all
  erb :tags
end

get '/tags/:id/posts' do
  @tag = Tag.find(params[:id])
  @tags = Tag.all
  @taggings = Tagging.where(:tag_id => params[:id])
  @posts = @taggings.map do |tagging|
    tagging.post
  end
  erb :tags
end