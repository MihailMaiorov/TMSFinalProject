require 'rails_helper'

describe PagesController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get root_path

      expect(response).to have_http_status(:ok)
    end
  end
end
