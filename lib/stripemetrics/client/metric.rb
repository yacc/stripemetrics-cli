module Stripemetrics
  class Client
    module Metric

      def get_data
        response = get('/v1/metrics', :require_auth => true)
        raise TargetError if response.status == 404
        raise AuthError if response.status == 401
        (response.status == 200) ? 'success' : 'failure'
        response.body
      end

      def print(metrics, options={},args={})
        table(:border => true) do
          header(metrics.first['this_month_ts'],metrics.first['last_month_ts'])
          metrics.each do |metric|
            display_row(metric) if (args.include?(metric['_type'])   || options[:all])
          end
        end
      end

      def header(month1,month2)
         row do
           column 'Metric', :width => 15,       :align => 'left'
           column "This month,#{month1}", :width => 11,   :align => 'right'
           column "Last month,#{month2}", :width => 11,   :align => 'right'
           column '% change', :width => 11,     :align => 'right'
           column 'TSM Average', :width => 11,  :align => 'right'
           column 'Goal', :width => 11,         :align => 'right'
         end                    
      end          

      def display_row(metric)
         row do
           column metric['name']
           column with_unit(metric['_type'],metric['this_month'])
           column with_unit(metric['_type'],metric['last_month'])
           column rounded_percent(metric['_type'],metric['change'])
           column rounded_percent(metric['_type'],metric['tsm_avrg'])
           column metric['goal']
         end        
      end

      def rounded_percent(type,val)
        '%+.2f%' % (val*100)
      end

      def with_unit(type,val)
         (type.downcase =~ /revenue/) ? "$#{val}" : "#{val.to_i}"
      end

    end
  end
end
