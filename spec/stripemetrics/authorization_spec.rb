require 'spec_helper'
require 'tmpdir'
require 'netrc'
require 'webmock/rspec'
require 'stripemetrics'

module Stripemetrics

  describe Client do
    describe "Authorizes from credentials" do 
      before(:all) do
        @tmpdir = Dir.mktmpdir('testing')
        @netrcf = File.join(@tmpdir,".netrc")
      end
      after(:all) do
        FileUtils.rm_rf(@tmpdir)
      end 
      def login
        @client = subject
        @auth_token = @client.login('yacin@me.com', 'sekkret',{:netrcf => @netrcf})
      end    

      it "creates token from valid email and password" do
        stub_login(:success)
        login
        @client.auth_token.should_not be_nil
        @client.auth_token.should == @auth_token
      end
      it "error with invalid email and password" do
        stub_login(:failed)
        expect { login }.to raise_error Stripemetrics::Client::TargetError
      end
      it "saves token to .netrc file" do
        FileUtils.rm(@netrcf) if File.exist?(@netrcf)# just to make clear what case we're testing
        stub_login(:success)
        login
        netrc  = Netrc.read(@netrcf)
        user, pass = netrc["api.stripemetrics.com"]
        user.should == 'yacin@me.com'
        pass.should == @auth_token
      end
    end 

  end  
end