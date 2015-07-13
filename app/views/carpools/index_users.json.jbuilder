json.partial! 'carpool', carpool: @carpool
json.users do
  json.array! @users do |user|
    json.partial! 'users/user', user: user
  end
end