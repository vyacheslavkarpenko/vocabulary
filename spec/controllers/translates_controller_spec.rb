require 'rails_helper'

RSpec.describe TranslatesController do
  let(:translate){create(:translate)}
  describe "#index" do
    it "return 200" do
      get :index
      binding.pry
      expect(response.code).to eq('200')
    end
  end
end
