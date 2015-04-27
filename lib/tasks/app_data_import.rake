namespace :app do
  task import_stance_data: :environment do
    hopper = YAML.load_file("#{Rails.root}/db/data/Stances_Hopper.yaml")

    hopper.keys.each do |issue|
      issue_category = IssueCategory.find_or_create_by(name: issue)
      hopper[issue].each do |statement|
        issue_category.statements.create(
          text: statement["statement"], 
          lean: statement["lean"])
      end
    end
  end
end

