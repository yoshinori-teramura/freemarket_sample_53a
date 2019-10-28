crumb :root do
  link "メルカリ", root_path
end

crumb :item do |item|
  link item.name, item_path
  parent :root
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

crumb :mypage_profile do
  link "プロフィール", profile_mypages_path
  parent :mypage
end

crumb :mypage_deliver_address do
  link "発送元・お届け先住所変更", deliver_address_mypages_path
  parent :mypage
end

crumb :mypage_credit do
  link "支払い方法", credit_mypages_path
  parent :mypage
end

crumb :mypage_email_password do
  link "メール/パスワード", email_password_mypages_path
  parent :mypage
end

crumb :mypage_sms_confirmation do
  link "電話番号の確認", sms_confirmation_mypages_path
  parent :mypage
end

crumb :mypage_logout_index do
  link "ログアウト", logout_index_path
  parent :mypage
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
