module Stripemetrics
  class Client
    module Report

      def get_metrics
        response = get('/v1/metrics', :require_auth => true)
        raise TargetError if response.status == 404
        raise AuthError if response.status == 401
        (response.status == 200) ? 'success' : 'failure'
        response.body
      end

      def print(metrics, options={},args={})
        table(:border => true) do
          header
          metrics.each do |metric|
            display_row(metric) if (args.include?(metric['_type'])   || options[:all])
          end
        end
      end

      def header
         row do
           column('Metric', :width => 15)
           column('This month', :width => 11)
           column('Last month', :width => 11)
           column('% change', :width => 11)
           column('TSM Average', :width => 11)
           column('Goal', :width => 11)
         end                    
      end          

      def display_row(metric)
         row do
           column(metric['name'])
           column(metric['this_month'])
           column(metric['last_month'])
           column(metric['change'])
           column(metric['tsm_avrg'])
           column(metric['goal'])
         end        
      end

    end
  end
end
