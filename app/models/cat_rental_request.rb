# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED ) }
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat



  # private

  def overlapping_requests
    #we are comparing to see if requested start date or end date exist between desired cat's
    # current gigs.
    #debugger
    cat_gigs  = self.class.joins(:cat)
      .where('cat_id = ?', self.cat_id)
      .where.not(id: self.id)
      .where('? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date', self.start_date, self.end_date)

    # if cats_gigs != 0
    #   errors[:cat_gigs] << 'cat\'s gigs are booked'
    # else
     cat_gigs
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.exists?
      errors[:base] << 'Sorry, Cat\'s got a gig'
    else
      true
    end

  end
end
