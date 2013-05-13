module AfterSaveProcessing
  extend ActiveSupport::Concern

  included do
    after_commit :after_update_processing, on: :update, if: :updated?
    after_commit :after_create_processing, on: :create, if: :created?
  end
end