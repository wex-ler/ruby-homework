json.extract! post, :id, :author_id, :content, :published, :created_at, :updated_at
json.url post_url(post, format: :json)
