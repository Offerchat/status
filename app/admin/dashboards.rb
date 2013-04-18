ActiveAdmin::Dashboards.build do
   section "Recent Reservations" do
    table_for Reservation.order("reserved_date desc").limit(5) do
      column :user
      column :reserved_date
    end
    strong { link_to "View All Reservations", admin_reservations_path }
  end # content

  section "Recent Users" do
    table_for User.order("created_at desc").limit(5) do
      column :name
      column :email
    end
    strong { link_to "View All Users", admin_users_path }
  end # content

  section "ActiveAdmin" do

      div do
        br
        text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
      end
  end # content
end