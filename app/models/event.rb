class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'host_events', foreign_key: 'user_id'

  has_many :invites, dependent: :destroy
  has_many :invitees, through: :invites, source: :user, foreign_key: 'user_id'


  def pending
    invitees.includes(:invites).where('invites.rsvp = ?', 'pending')
  end

  def declined
    invitees.includes(:invites).where('invites.rsvp = ?', 'no')
  end

  def confirmed
    invitees.includes(:invites).where('invites.rsvp = ?', 'yes')
  end

  # getter
  def invitee_list
    invitees.map { |invitee| invitee.id.to_s }
  end

  # setter (from invite form)
  def invitee_list=(invitee_list_array)
    invitee_ids = invitee_list_array
    found_invitees = invitee_ids.map { |id| User.find_by(id: id) }
    self.invitees = found_invitees
  end

  def declined_list
    declined.map(&:name).join(', ')
  end

  def confirmed_list
    confirmed.map(&:name).join(', ')
  end
end
