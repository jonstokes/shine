class SyncSession < ActiveRecord::Base
  has_many :posts
  has_many :authors
  has_many :categories

  validates :status, presence: true, inclusion: { in: ['started', 'success', 'failure'] }
  validates :mode,   presence: true, inclusion: { in: ['delete', 'upsert'] }

  def self.next_sync_url(mode)
    last_session(mode).try(:next_sync_url)
  end

  def self.last_session(mode)
    self.where(status: 'success', mode: mode).last
  end

  def self.sync_in_progress?
    self.where(status: 'started').any?
  end
end
