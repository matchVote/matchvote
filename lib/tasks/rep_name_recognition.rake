namespace :reps do
  task set_name_recognition: :environment do
    Representative.all.each do |rep|
      slug = rep.external_credentials["facebook_username"]
      results = Virility::Facebook.new("http://facebook.com/#{slug}").poll
      rep.update_attribute(:name_recognition, results["like_count"])
    end
  end
end

