# encoding: utf-8

#  Copyright (c) 2008-2016, Puzzle ITC GmbH. This file is part of
#  Cryptopus and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/cryptopus.

class RemoveTeamAdmin < ActiveRecord::Migration
  def self.up
    remove_column "teammembers", "team_admin"
  end

  def self.down
    add_column "teammembers", "team_admin", :boolean, :default => false, :null => false
  end
end
