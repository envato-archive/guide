class Guide::Content::Structures::PurchaseFlow::Email::OrderConfirmation < Guide::Component
  def formats
    [:html, :text]
  end

  def layout_template
    'layouts/email/order_confirmation'
  end

  def layout_presenter
    Styleguide::OpenPresenter.new(
      {
        :account_url => '#account_url?such_tracking=wow',
        :download_url => '#download_url?such_tracking=wow',
        :statement_url => '#statement_url?such_tracking=wow',
      }
    )
  end

  def template
    'temp/component'
  end

  def layout_css_classes
    {
      :parent => '',
      :scenario => ''
    }
  end

  def stylesheets
    ['application/core.css', 'application/default.css']
  end

  def javascripts
    ['application/core.js', 'application/default.js']
  end

  def view_model
    Guide::ViewModel.new
  end

  private

  scenario :default do
    view_model
  end
end
