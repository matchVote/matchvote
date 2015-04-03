namespace :reps do
  task set_name_recognition: :environment do
    Representative.all.each do |rep|
      if (slug = rep.external_credentials["facebook_username"])
        results = Virility::Facebook.new("http://facebook.com/#{slug}").poll
        rep.update_attribute(:name_recognition, results["like_count"])
      else
        rep.update_attribute(:name_recognition, 0)
      end
    end
  end
end

