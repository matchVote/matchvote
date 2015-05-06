class HopperLoader
  def initialize
    @hopper = YAML.load_file("#{Rails.root}/db/data/Stances_Hopper.yaml")
  end

  def load
    @hopper.keys.each do |issue|
      issue_category = IssueCategory.find_or_create_by(name: issue)
      @hopper[issue].each do |statement|
        issue_category.statements.create(
          text: statement["statement"], 
          lean: statement["lean"])
      end
    end
  end
end
