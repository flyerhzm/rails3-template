Factory.define :user_flyerhzm, :class => User do |u|
  u.login "flyerhzm"
  u.password "flyerhzm"
  u.password_confirmation "flyerhzm"
  u.email "flyerhzm@gmail.com"
end

Factory.define :invalid_user, :class => User do |u|
end
