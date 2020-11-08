require 'rails_helper'

describe Cookie do
  subject { Cookie.new }

  describe "associations" do
    it { is_expected.to belong_to(:storage) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:storage) }
    it { is_expected.to validate_presence_of(:fillings) }
  end

  describe "notifications" do
    let(:user) { User.create() }
    let(:cookie) { Cookie.new(fillings: 'Something', ready: false, storage: user) }
    
    it 'notifies when ready' do
      expect(CookieChannel).to receive(:broadcast_ready).with(cookie)
      cookie.update!(ready: true)
    end
  end
end
