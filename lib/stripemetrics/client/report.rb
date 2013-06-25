module Stripemetrics
  class Client
    module Report
      def report
        get('/v1/reports', :require_auth => true)
      end

      def print(options={},args={})
        puts options[:all]
        table(:border => true) do
          header
          active_users  if (args.include?("churn")   || options[:all])
          cancellations if (args.include?("active")  || options[:all])
          charges       if (args.include?("charges") || options[:all])
       end
      end

      def header
         row do
           column('Metric', :width => 15)
           column('This month', :width => 10)
           column('Last month', :width => 10)
           column('% change', :width => 10)
           column('TSM', :width => 10)
           column('Average', :width => 10)
           column('Goal', :width => 10)
         end                    
      end          
      def cancellations
         row do
           column('churn')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
         end
      end
      def active_users
         row do
           column('active')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
         end                
      end
      def charges
         row do
           column('charges')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
           column('Caesar')
         end                
      end
    end
  end
end

# Metric  This month  Last Month  % change  TSM Average Goal
# Active Users  100,000 50,000  100%  125%  75%
# Total User Base 500,000 400,000 25% 7%  10%