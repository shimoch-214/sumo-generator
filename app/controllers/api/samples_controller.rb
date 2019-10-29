class Api::SamplesController < ApplicationController
  def show
    @sample = Sample.find(params[:id]).setting
  end
end