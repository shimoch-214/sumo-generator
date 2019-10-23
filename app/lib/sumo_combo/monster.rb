# require_relative './su_module.rb'
# require_relative './sumo_combo.rb'
# include SuModule
# include SumoCombo

# def experiment(params)
#   result = {}
#   params[:times].times do
#     sequence = Sequence.new(params)
#     sequence.one_set
#     if result.empty?
#       result = sequence.result
#     else
#       result.each_key do |key|
#         result[key][:exp] += sequence.result[key][:exp]
#         result[key][:death] += sequence.result[key][:death]
#       end
#     end
#   end
#   result.each_key do |key|
#     result[key][:exp] /= params[:times]
#   end
#   failure_rate = (Sequence.get_failure.fdiv(params[:times])*100).round(2)
#   result[:failure_rate] = failure_rate
#   result
# end

# start = Time.now
# puts experiment(params)
# puts "it takes #{Time.now - start} second to calculate."