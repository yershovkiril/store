RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                  
    index do
      except ['CreditCard']
    end                        
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app do
      except ['Order']
    end
  
    config.model 'Order' do
      edit do
        field :state, :enum do
          enum do
            bindings[:object].aasm.states(:permitted => true).map(&:name)
          end
        end
      end
    end
  
    config.model 'Author' do
      object_label_method :full_name
      field :biography, :ck_editor
      include_all_fields
      exclude_fields :books
    end
  
    config.model 'Book' do
      include_all_fields
      field :full_description, :ck_editor
      exclude_fields :order_items, :reviews
    end
  
    config.model 'Category' do
      exclude_fields :books
    end
  
    config.model 'Coupon' do
      edit do
        exclude_fields :orders
      end
    end
  
    config.model 'Review' do
      edit do
        field :approved
        field :text_review do
          read_only true
        end
      end
    end

  end
end
