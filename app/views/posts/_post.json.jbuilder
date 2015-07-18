json.id post.id
json.carpool do
  json.partial! 'carpools/carpool2', carpool: post.carpool
end
json.user do
  json.partial! 'users/user', user: post.user
end
json.urgency post.urgency
json.title post.title
json.body post.body
json.updated_at post.updated_at