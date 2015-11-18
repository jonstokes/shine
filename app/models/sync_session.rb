class SyncSession < ActiveRecord::Base
  has_many :posts
  has_many :authors
  has_many :categories

  validates :status, presence: true, inclusion: { in: ['started', 'success', 'failure'] }

  def self.sync_in_progress?
    SyncSession.where(status: 'started').any?
  end
end
