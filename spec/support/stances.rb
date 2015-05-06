def create_statements
  fp = create(:issue_category, name: "foreign_policy")
  abortion = create(:issue_category, name: "abortion")

  create(:statement, issue_category: fp, text: "Foreign policy statement 1")
  create(:statement, issue_category: fp, text: "Foreign policy statement 2")
  create(:statement, issue_category: abortion, text: "Abortion statement 1")
  create(:statement, issue_category: abortion, text: "Abortion statement 2")
end
