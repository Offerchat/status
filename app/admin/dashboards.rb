ActiveAdmin::Dashboards.build do
   section "Recent Announcements" do
    table_for Announcement.order("created_at desc").limit(5) do
      column :title
      column :body
    end
    strong { link_to "Make an Announcement", new_admin_announcement_path }
  end # content

  section "ActiveAdmin" do

      div do
        br
        text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
      end
  end # content
end