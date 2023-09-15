require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /" do
    it "response return http status 200" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /help" do
    it "response return http status 200" do
      get help_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /about" do
    it "response return http status 200" do
      get about_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /contact" do
    it "response return http status 200" do
      get contact_path
      expect(response).to have_http_status(200)
    end
  end
end
