require 'rails_helper'

RSpec.describe Application, type: :model do

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'instance methods' do

    describe '#edit status' do
      it 'changes description and status attributes for an instance' do
        application = Application.create!(name: 'Bill Jones',
                                           description: 'Loving Family',
                                           status: 'In Progress')

        application.edit_status({description: 'Big yard'})
      end
    end

  end

end
