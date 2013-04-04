require 'spec_helper'
require 'fakefs/spec_helpers'
require 'netrc'

require 'stripemetrics-cli'
require 'stripemetrics-cli/authorization'

module StripemetricsCli
  describe "Authorize from credentials"  do
    describe "login" do 
      it "creates token from valid email and password" do
        api_client = double 'stripemetrics api client'
        #response = {:token => 'xin128129nfsjb',:status => 200}
        token = 'xin128129nfsjb'
        api_client.stub(:get_token).and_return(token) 

        auth = StripemetricsCli::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret'})
        auth.token.should_not be_nil
        auth.token.should == token
      end
      it "error with invalid email and password" do
        api_client = double 'stripemetrics api client'
        #response = {:token => nil, :status => 401}
        token = nil
        api_client.stub(:get_token).and_return(token) 

        auth = StripemetricsCli::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret'})
        auth.token.should be_nil
        auth.valid?.should be_false
      end
    end 
  end
  describe "Authorize from netrc file", fakefs: true do
    FakeFS.activate!

    def stub_netrc(valid=true)
      @token = 'xin128129nfsjb'
      FileUtils.mkdir_p(Dir.home)
      @netrcf = File.join(Dir.home,".netrc")
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

    describe "login" do 

      it "errors if no valid credentials and no .netrc file is found" do
        api_client = double 'stripemetrics api client'
        stub_netrc
        FileUtils.rm(@netrcf) # just to make clean what case we're testing

        auth = StripemetricsCli::Authorization.new(api_client)
        auth.token.should be_nil
        auth.valid?.should be_false
      end 

      it "errors if no valid credentials are found in .netrc" do
        api_client = double 'stripemetrics api client'
        stub_netrc(false)

        auth = StripemetricsCli::Authorization.new(api_client)
        auth.token.should be_nil
      end 

      it "reads token from .netrc file" do
        api_client = double 'stripemetrics api client'
        stub_netrc
        
        auth = StripemetricsCli::Authorization.new(api_client)
        auth.token.should_not be_nil
        auth.token.should == @token
        auth.valid?.should be_true
      end

      it "saves token to .netrc file" do
        api_client = double 'stripemetrics api client'
        token = 'xin128129nfsjb'
        api_client.stub(:get_token).and_return(token) 

        auth = StripemetricsCli::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret'})

        netrc  = Netrc.read(File.join(Dir.home,".netrc"))
        user, pass = netrc["api.stripemetrics.com"]
        user.should == 'yacin@me.com'
        pass.should == token

      end

    end 
    FakeFS.deactivate!

  end

end