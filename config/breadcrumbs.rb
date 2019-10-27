crumb :root do
  link "メルカリ", root_path
end

crumb :category do
  link "カテゴリー一覧" # パスを指定
end

crumb :brand do
  link "ブランド一覧" # パスを指定
end

crumb :mypage do
  link "マイページ", mypages_path
  parent :root
end

crumb :mypage_identification do
  link "本人情報の登録", identification_mypages_path
  parent :mypage
end

crumb :item do |item|
  link item.name, item_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).