class Api::CalcsController < ApplicationController
  include SumoCombo::Simulator

  def index
  end

  def create
    data = setting_params.to_hash.symbolize_keys
    data[:monsters].each.with_index do |mons, i|
      data[:monsters][i] = mons.symbolize_keys
    end
    @result = experiment(data)
  end

  private

  def setting_params
    params.require(:calc).permit(
      :turns,
      :times,
      monsters: [
        :name,
        :order,
        :lv,
        :doping,
        :weaken,
        :speed,
        :sealed,
        :strip,
        :friend,
        position: []
      ]).merge(
        field: params.require(:calc)[:field]
      )
  end
end