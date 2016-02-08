# encoding: utf-8

#  Copyright (c) 2008-2016, Puzzle ITC GmbH. This file is part of
#  Cryptopus and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/cryptopus.

require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  include ControllerTest::DefaultHelper

  test 'show breadcrumb path 1 if user is on index of groups' do
    login_as (:bob)
# require 'pry';binding.pry
    team1 = teams(:team1)

    get :index, team_id: team1
    assert_select '.breadcrumbs', text: 'Teams > team1'
    assert_select '.breadcrumbs a', count: 1
    assert_select '.breadcrumbs a', text: 'Teams'
    assert_select '.breadcrumbs a', text: 'team1', count: 0

  end

  test 'show breadcrump path 2 if user is on edit of groups' do
    login_as (:bob)

    team1 = teams(:team1)
    group1 = groups(:group1)

    get :edit, id: group1, team_id: team1
    assert_select '.breadcrumbs', text: 'Teams > team1 > group1'
    assert_select '.breadcrumbs a', count: 2
    assert_select '.breadcrumbs a', text: 'Teams'
    assert_select '.breadcrumbs a', text: 'team1'
    assert_select '.breadcrumbs a', text: 'group1', count: 0
    end

end
