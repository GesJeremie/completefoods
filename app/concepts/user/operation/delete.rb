=begin

  Usage:
  ---

  User::Delete.(
    {user_id: 10},
    'current_user' => User<Model>
  )


class User::Delete < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:user_id).filled
  end)

  step    Contract::Validate(name: 'params'), before: 'operation.new'
  step    :has_current_user?
  step    :user_exists?
  step    :authorize!
  step    :delete!

  def has_current_user?(options, params:, **)
    return true if options['current_user'].present?

    options['errors'] = 'Current user not given'
    false
  end

  def user_exists?(options, params:, **)
    user = User::find(params[:user_id])

    if !user.nil?
      options['data.user'] = user
    else
      options['errors'] = 'User doesn\'t exist'
      false
    end

  end

  def authorize!(options, params:, **)
    return true if options['data.user'].id == options['current_user'].id

    options['errors'] = 'This user cant\'t delete this user'
    false
  end

  def delete!(options, params:, **)
    return true if options['data.user'].destroy

    options['errors'] = 'Impossible to delete this user at this time'
    false
  end

end
=end
