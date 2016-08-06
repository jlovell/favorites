require 'rails_helper'

OmniAuth.config.test_mode = true

RSpec.describe 'authentication flow' do
  context 'when login is successful' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123545',
        info: {
          name: 'Donald Trump',
          email: 'donald@trump.com'
        }
      })
    end

    after { OmniAuth.config.mock_auth[:google_oauth2] = nil }

    it 'creates a new user upon a new sign in' do
      expect { visit new_session_path }.to change { User.count }.by 1
    end

    it 'signs in as the same user on subsequent logins' do
      visit new_session_path
      expect(page).to have_content "Welcome, Donald"

      visit sign_out_path
      expect(page).to have_content "logged out"

      expect { visit new_session_path }.not_to change { User.count }
    end
  end

  context 'when login fails due to some error' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      OmniAuth.config.on_failure = Proc.new { |env|
        OmniAuth::FailureEndpoint.new(env).redirect_to_failure
      }
    end

    after { OmniAuth.config.mock_auth[:google_oauth2] = nil }

    it 'creates a new user upon a new sign in' do
      expect { visit new_session_path }.not_to change { User.count }
      expect(page).to have_content "There was an error"
    end

  end
end
