module MiscStepHelper
  def model_class(name)
    name.singularize.camelize.constantize
  end
end
World(MiscStepHelper)

Given /^there are no (\w+)$/ do |model|
  model_class(model).delete_all
end

Then /^there should be (\d+) (\w+)$/ do |count, model|
  model_class(model).count.should == count.to_i
end

Then /^the (\w+) should have a (\w+)$/ do |model, association|
  model_class(model).first.send(association.to_sym).should_not == nil
end

Then /^the (\w+) should have (\d+) (\w+)$/ do |model, count, association|
  model_class(model).first.send(association.pluralize.to_sym).count.should == count.to_i
end
