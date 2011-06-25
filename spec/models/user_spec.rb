require 'spec_helper'

describe User do
  before(:each) do
    @attr ={:name => "Example user", :email =>"user@example.com"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create(@attr) 
  end
  
  it "should avoid invalid name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end 

  it "should avoid invalid email" do
    no_email = User.new(@attr.merge(:email => ""))
    no_email.should_not be_valid
  end 
  
  it "shoud reject invalid emails addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
end
