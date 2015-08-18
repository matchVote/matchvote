# require "rails_helper"

# describe DirectoryPresenter do
#   let(:points) { [100, 88, 10] }
#   let(:representatives) do
#     (1..10).map { build(:representative) }
#   end

#   describe "#reps" do
#     context "when no sort_by is given" do
#       it "sorts reps by popularity" do
#         points.each { |num| create(:representative, name_recognition: num) }
#         presenter = described_class.new(reps: Representative.all)
#         expect(presenter.reps.map(&:name_recognition)).to eq points
#       end
#     end
#   end

#   describe "#present" do
#     it "wraps all given reps in their own presenter" do
#       reps = described_class.new.present(representatives)
#       expect(reps.map(&:class).uniq.first).to eq RepresentativePresenter
#     end
#   end
# end

