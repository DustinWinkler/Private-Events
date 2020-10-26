class User < ApplicationRecord
  validates :name, uniqueness: true
  has_many :host_events, class_name: 'Event', inverse_of: 'creator'
  
  has_many :invites, dependent: :destroy
  has_many :invitations, class_name: 'Event', through: :invites, source: :event, foreign_key: 'event_id'

  def pending_events
    invitations.includes(:invites).where('invites.rsvp = ?', 'pending')
  end

  def declined_events
    invitations.includes(:invites).where('invites.rsvp = ?', 'no')
  end

  def attended_events
    invitations.includes(:invites).where('invites.rsvp = ?', 'yes')
  end
end
