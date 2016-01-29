require 'test_helper'
class AccountTest <  ActiveSupport::TestCase
  test 'account to json' do
    account = accounts(:account1)
    team = teams(:team1)
    team_password = team.decrypt_team_password(bob, bobs_private_key)

    account.decrypt(team_password)

    account_json = JSON.parse(account.to_json)

    attrs = ['accountname', 'id', 'cleartext_password',
             'cleartext_username', 'group',
             'group_id', 'team', 'team_id']

    attrs.each { |attr|
      assert_includes account_json, attr
    }

    assert_not account_json.include? 'description'
    assert_not account_json.include? 'updated_at'
    assert_not account_json.include? 'created_at'
    assert_not account_json.include? 'username'
    assert_not account_json.include? 'password'
  end

  test 'decrypts username and password' do
    account = accounts(:account1)
    team = teams(:team1)
    team_password = team.decrypt_team_password(bob, bobs_private_key)

    account.decrypt(team_password)

    assert_equal 'test', account.cleartext_username
    assert_equal 'password', account.cleartext_password
  end

  test 'does not update password if blank' do
    account = accounts(:account1)
    team = teams(:team1)
    team_password = team.decrypt_team_password(bob, bobs_private_key)

    account.cleartext_username = 'new'
    account.cleartext_password = ''


    account.encrypt(team_password)
    account.save!
    account.reload
    account.decrypt(team_password)

    assert_equal 'new', account.cleartext_username
    assert_equal 'password', account.cleartext_password
  end

  test 'does update password and username' do
    account = accounts(:account1)
    team = teams(:team1)
    team_password = team.decrypt_team_password(bob, bobs_private_key)

    account.cleartext_username = 'new'
    account.cleartext_password = 'foo'


    account.encrypt(team_password)
    account.save!
    account.reload
    account.decrypt(team_password)

    assert_equal 'new', account.cleartext_username
    assert_equal 'foo', account.cleartext_password
  end

  private
  def bob
    users(:bob)
  end

  def bobs_private_key
    bob.decrypt_private_key('password')
  end
end
