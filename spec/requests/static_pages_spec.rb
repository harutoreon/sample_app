require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET /" do
    it "response return http status code 200" do
      get root_path
      expect(response).to have_http_status(200)
    end
    it 'response.body return Ruby on Rails Tutorial Sample App' do
      get root_path
      expect(response.body).to include "#{base_title}"
    end
  end

  describe "GET /help" do
    it "response return http status code 200" do
      get help_path
      expect(response).to have_http_status(200)
    end
    it 'response.body return Ruby on Rails Tutorial Sample App' do
      get help_path
      expect(response.body).to include "#{base_title}"
    end
  end
  
  describe "GET /about" do
    it "response return http status code 200" do
      get about_path
      expect(response).to have_http_status(200)
    end
    it 'response.body return Ruby on Rails Tutorial Sample App' do
      get about_path
      expect(response.body).to include "#{base_title}"
    end
  end

  describe "GET /contact" do
    it "response return http status code 200" do
      get contact_path
      expect(response).to have_http_status(200)
    end
    it 'response.body return Ruby on Rails Tutorial Sample App' do
      get contact_path
      expect(response.body).to include "#{base_title}"
    end
  end
end