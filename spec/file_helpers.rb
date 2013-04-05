module FileHelpers
   def stub_netrc(valid=true)
      @token = 'xin128129nfsjb'
      if valid
        File.open(@netrcf, "w") do |f|
          f.puts %Q{
  machine api.stripemetrics.com
  login yacin@me.com
  password #{@token}           
          }
        end
      else
        File.open(@netrcf, "w") do |f|
          f.puts %Q{
  machine api.something.com
  login yacin@me.com
  password anothersekkret           
  machine api.stripemetrics.com
  login yacin@me.com
          }
        end
      end
      FileUtils.chmod 0600, @netrcf unless RUBY_PLATFORM =~ /mswin32|mingw32/   
    end
end