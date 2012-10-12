require 'rspec/expectations'

# Custom RSpec matcher to test that an array contains only a single class of object

RSpec::Matchers.define :contain_only_instances_of do |expected|
  match do |actual|
    classes = actual.map(&:class).uniq
    classes.size == 1 && classes.first == expected
  end
end

RSpec::Matchers.define :all_be_persisted do
  match do |actual|
    actual.map(&:persisted?).uniq == [true]
  end
end