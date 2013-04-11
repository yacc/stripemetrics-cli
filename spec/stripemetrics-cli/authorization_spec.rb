require 'spec_helper'
require 'tmpdir'
require 'netrc'
require 'stripemetrics'

module Stripemetrics

  describe "Authorize from credentials"  do

    before(:all) do
      @tmpdir = Dir.mktmpdir('testing')
      @netrcf = File.join(@tmpdir,".netrc")
    end

    after(:all) do
      FileUtils.rm_rf(@tmpdir)
    end 

    describe "login" do 
      it "creates token from valid email and password" do
        api_client = double 'stripemetrics api client'
        #response = {:token => 'xin128129nfsjb',:status => 200}
        token = 'xin128129nfsjb'
        api_client.stub(:post_login).and_return(token) 

        auth = Stripemetrics::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret',:netrcf => @netrcf})
        auth.token.should_not be_nil
        auth.token.should == token
      end
      it "error with invalid email and password" do
        api_client = double 'stripemetrics api client'
        #response = {:token => nil, :status => 401}
        token = nil
        api_client.stub(:post_login).and_return(token) 

        auth = Stripemetrics::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret',:netrcf => @netrcf})
        auth.token.should be_nil
        auth.valid?.should be_false
      end
    end 
  end
  describe "Authorize from netrc file" do  

    before(:all) do
      @tmpdir = Dir.mktmpdir('testing')
      @netrcf = File.join(@tmpdir,".netrc")
    end

    after(:all) do
      FileUtils.rm_rf(@tmpdir)
    end 
    describe "login" do 
      it "errors if no valid credentials and no .netrc file is found" do
        api_client = double 'stripemetrics api client'
        stub_netrc
        FileUtils.rm(@netrcf) if File.exist?(@netrcf)# just to make clean what case we're testing

        auth = Stripemetrics::Authorization.new(api_client,{:netrcf => @netrcf})
        auth.token.should be_nil
        auth.valid?.should be_false
      end 

      it "errors if no valid credentials are found in .netrc" do
        api_client = double 'stripemetrics api client'
        stub_netrc(false)

        auth = Stripemetrics::Authorization.new(api_client,{:netrcf => @netrcf})
        auth.token.should be_nil
      end 

      it "reads token from .netrc file" do
        api_client = double 'stripemetrics api client'
        stub_netrc
        
        auth = Stripemetrics::Authorization.new(api_client,{:netrcf => @netrcf})
        auth.token.should_not be_nil
        auth.token.should == @token
        auth.valid?.should be_true
      end

      it "saves token to .netrc file" do
        api_client = double 'stripemetrics api client'
        token = 'xin128129nfsjb'
        api_client.stub(:post_login).and_return(token) 
        FileUtils.rm(@netrcf) if File.exist?(@netrcf)# just to make clean what case we're testing

        auth = Stripemetrics::Authorization.new(api_client,{:email => 'yacin@me.com',:password => 'sekkret',:netrcf => @netrcf})

        netrc  = Netrc.read(@netrcf)
        user, pass = netrc["api.stripemetrics.com"]
        user.should == 'yacin@me.com'
        pass.should == token

      end

    end 

  end

end