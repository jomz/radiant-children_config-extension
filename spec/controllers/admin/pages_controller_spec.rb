require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagesController do
  dataset :home_page, :users, :children_config
  
  before do
    login_as :admin
  end
  
  it "should create the parts defined in children_config instead of the defaults" do
    get :new, :page_id => page_id(:services)
    response.should be_success
    page = assigns(:page)
    page.parts.map(&:name).join(" ").should eql("location description dat")
  end
  
end
