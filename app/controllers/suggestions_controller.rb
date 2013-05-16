class SuggestionsController < ApplicationController

  before_filter :new_resource

  # GET /suggestions/new
  # GET /suggestions/new.json
  def new
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(params[:suggestion])
    flash[:notice] = 'Thank you for your feedback. ' if @suggestion.save
    respond_with(@suggestion, location: root_url)
  end

  private
  def new_resource
    @suggestion = Suggestion.new(params[:suggestion])
  end
end
