module RequestHelpers

  def fixture_path
    File.expand_path("../fixtures", __FILE__)
  end

  def fixture(file)
    File.new(fixture_path + '/' + file)
  end

  def stub_login(status)
    fixture_file = status == :success ? "login_success.txt" : "login_fail.txt"
    stub_request(:post, "http://api.stripemetrics.com/auth/tokens").
            with(:body => {:username => 'yacin@me.com', :password => 'sekkret'}).
            to_return(fixture(fixture_file))  end

end