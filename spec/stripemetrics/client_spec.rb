require 'stripemetrics'
require 'spec_helper'
require 'webmock/rspec'

describe Stripemetrics::Client do
  describe "#initialize" do
    it "can set the auth_token, app_name and target_url" do
      client = Stripemetrics::Client.new(:auth_token => 'token', :target_url => 'bar')
      client.auth_token.should == 'token'
      client.target_url.should == 'bar'
    end
  end

  describe "#login" do
    def login
      @client = subject
      @auth_token = @client.login('yacin@me.com', 'sekkret')
    end

    context "when successful" do
      before do
        stub_login(:success)
        login
      end

      it "sets the user" do
        @client.user.should == 'yacin@me.com'
      end

      it "sets and returns the auth_token" do
        @client.auth_token.should == @auth_token
        @auth_token.should == "valid_auth_token"
      end
    end

    it "raises an exception when failed" do
      stub_login(:failed)
      expect { login }.to raise_error Stripemetrics::Client::TargetError
    end
  end
end
