require 'faker'

10.times do
  Tag.create(name: Faker::Company.buzzwords.sample)
end

