class Pin < ActiveRecord::Base
  after_create :enqueue_create_document_job
  after_update :enqueue_update_document_job
  after_destroy :enqueue_delete_document_job

  private

  def enqueue_create_document_job
    Delayed::Job.enqueue CreateSwiftypeDocumentJob.new(self.id)
  end

  def enqueue_update_document_job
    Delayed::Job.enqueue UpdateSwiftypeDocumentJob.new(self.id)
  end

  def enqueue_delete_document_job
    Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
  end
end

