require 'spec_helper'

describe "suggestions/edit" do
  before(:each) do
    @suggestion = assign(:suggestion, stub_model(Suggestion,
      :suggestion => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit suggestion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => suggestions_path(@suggestion), :method => "post" do
      assert_select "textarea#suggestion_suggestion", :name => "suggestion[suggestion]"
      assert_select "input#suggestion_user_id", :name => "suggestion[user_id]"
    end
  end
end
