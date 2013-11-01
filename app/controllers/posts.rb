get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/posts/new/create' do
  if logged_in?
    @tags = Tag.all
    erb :create_post
  else
    redirect to('/posts')
  end
end

post '/posts/new/create' do
  @post = Post.create(title: params[:title], body: params[:body], user_id: session[:user_id])
  if @post.valid?
    new_id = @post.id
    @tag_ids = params[:tags].map { |tag_id| tag_id.to_i }

    @tag_ids.each do |tag_id|
      @post.taggings.create(post_id: new_id, tag_id: tag_id)
    end

    redirect to('/posts')   
  else
    @errors = @post.errors
    @tags = Tag.all
    erb :create_post
  end
end

get '/posts/:id' do
  @posts = Post.all
  @post = Post.find(params[:id])
  erb :posts
end

get '/posts/:id/edit' do
  if logged_in?
    @tags = Tag.all
    @post = Post.find(params[:id])
    erb :edit_post
  else
    redirect to ('/posts')
  end
end

post '/posts/:id/add_tag' do
  @post = Post.find(params[:id])
  @post.taggings.create(post_id: @post.id, tag_id: params[:tag_id])
  redirect to("/posts/#{@post.id}/edit")
end

post '/posts/:id/update' do
  post_id = params[:id]
  Post.update(post_id, title: params[:title], body: params[:body])
  redirect to("/posts/#{post_id}")
end

post '/posts/:id/delete' do
  @post = Post.find(params[:id])
  @post.taggings.each do |tagging|
    tagging.destroy
  end
  @post.destroy
  redirect to('/posts')
end
