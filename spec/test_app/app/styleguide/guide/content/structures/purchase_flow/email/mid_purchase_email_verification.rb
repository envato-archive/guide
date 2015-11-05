class Guide::Content::Structures::PurchaseFlow::Email::MidPurchaseEmailVerification < Guide::Component
  def formats
    [:html, :text]
  end

  def layout_template
    'layouts/email/mid_purchase_email_verification'
  end

  def layout_presenter
    Styleguide::OpenPresenter.new(
      current_year: Time.now.year
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
