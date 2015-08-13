require 'test_helper'
class CreateTeamTest < ActionDispatch::IntegrationTest
include IntegrationTest::DefaultHelper
include IntegrationTest::AccountTeamSetupHelper
  test 'bob creates new normal team' do
    # Setup for test
    account = create_team_group_account('bob', 'password')

    # Create account link
    account_path = team_group_account_path(
                                  team_id: account.group.team.id,
                                  group_id: account.group.id,
                                  id: account.id)


    # Bob can access team / accounts
    can_access_account(account_path, 'bob')

    # Root can access team / account
    can_access_account(account_path, 'root')

    # Admin can access team / account
    can_access_account(account_path, 'admin')
  end

  test 'bob creates new noRoot team' do
    # Setup for test
    account = create_team_group_account_noroot('bob', 'password')

    # Create account link
    account_path = team_group_account_path(
                                  team_id: account.group.team.id,
                                  group_id: account.group.id,
                                  id: account.id)


    # Bob can access team / accounts
    can_access_account(account_path, 'bob')

    # Root can not access team / account
    cannot_access_account(account_path, 'root')

    # Admin can access team / account
    can_access_account(account_path, 'admin')
  end

  test 'bob creates private team' do
    # Setup for test
    account = create_team_group_account_private('bob', 'password')

    # Create account link
    account_path = team_group_account_path(
                                  team_id: account.group.team.id,
                                  group_id: account.group.id,
                                  id: account.id)


    # Bob can not access team / accounts
    can_access_account(account_path, 'bob')

    # Root can access team / account
    can_access_account(account_path, 'root')

    # Admin can not access team / account
    cannot_access_account(account_path, 'admin')
  end

  test 'bob creates private and noRoot team' do
    # Setup for test
    account = create_team_group_account_private_noroot('bob', 'password')

    # Create account link
    account_path = team_group_account_path(
                                  team_id: account.group.team.id,
                                  group_id: account.group.id,
                                  id: account.id)


    # Bob can access team / accounts
    can_access_account(account_path, 'bob')

    # Root can not access team / account
    cannot_access_account(account_path, 'root')

    # Admin can not access team / account
    cannot_access_account(account_path, 'admin')
  end
end