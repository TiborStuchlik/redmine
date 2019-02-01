# This file is a part of Redmine CRM (redmine_contacts) plugin,
# customer relationship management plugin for Redmine
#
# Copyright (C) 2010-2018 RedmineUP
# http://www.redmineup.com/
#
# redmine_contacts is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_contacts is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_contacts.  If not, see <http://www.gnu.org/licenses/>.

class ContactsIssue < ActiveRecord::Base
  include Redmine::SafeAttributes
  validates_presence_of :contact_id, :issue_id
  validates_uniqueness_of :contact_id, :scope => [:issue_id]

  attr_protected :id if ActiveRecord::VERSION::MAJOR <= 4
  safe_attributes 'issue_id', 'contact_id'
  # after_create :send_mails
  # after_save :send_mails

  private

  def send_mails
    Mailer.deliver_contacts_issue_connected(Contact.find(contact_id), Issue.find(issue_id))
    true
  end
end
