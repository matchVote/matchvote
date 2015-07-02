class StanceHelper
  include FactoryGirl::Syntax::Methods

  def create_statements
    fp = create(:issue_category, name: "foreign_policy")
    abortion = create(:issue_category, name: "abortion")

    create(:statement, issue_category: fp, text: "Foreign policy statement 1")
    create(:statement, issue_category: fp, text: "Foreign policy statement 2")
    create(:statement, issue_category: abortion, text: "Abortion statement 1")
    create(:statement, issue_category: abortion, text: "Abortion statement 2")
  end

  def create_stances(entity)
    Statement.all.each do |statement|
      create(:stance, statement: statement, opinionable: entity)
    end
  end

  def create_one_stance(user, values = {})
    issue = create(:issue_category, name: "temp_name")
    statement = create(:statement, issue_category: issue, text: "blah blah")
    create(:stance, statement: statement, opinionable: user, 
      agreeance_value: values[:agreeance], 
      importance_value: values[:importance])
  end

  def build_issues
    [build(:issue_category, name: "foreign_policy"),
     build(:issue_category, name: "abortion")]
  end

  def build_statements(issues = build_issues)
    fp = issues.first
    abortion = issues.last

    [build(:statement, issue_category: fp, text: "Foreign policy statement 1"),
    build(:statement, issue_category: fp, text: "Foreign policy statement 2"),
    build(:statement, issue_category: abortion, text: "Abortion statement 1"),
    build(:statement, issue_category: abortion, text: "Abortion statement 2")]
  end

  def build_stance(statement, user)
    build(:stance, statement: statement, opinionable: user)
  end

  def create_stances_for(statements, entity, values)
    # values: [[agreeance, importance], ...]
    statements.zip(values).each do |opinion|
      create(:stance, 
        statement:        opinion.first,
        opinionable:      entity,
        agreeance_value:  opinion.last.first,
        importance_value: opinion.last.last)
    end
  end
end

