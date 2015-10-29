class Guide::Content::Structures::PurchaseFlow::Checkout < Guide::Component
  def template
    'purchase_flow/checkout'
  end

  def view_model
    Guide::ViewModel.new
  end

  private

  scenario :payment_method do
    view_model
  end
end
