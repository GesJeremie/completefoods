class User::Delete < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:token).filled
  end)

  step    Contract::Validate(name: 'params'), before: 'operation.new'
  step    :has_current_user_token!
  step    :user_can_delete?
  step    :user_exists?
  success :delete

  def has_current_user_token!(options, params:, **)
    if options['current_user_token'].present?
      true
    else
      options['errors'] = 'Current user not given'
      false
    end
  end

  def user_can_delete?(options, params:, **)
    if options['current_user_token'] == params[:token]
      true
    else
      options['errors'] = 'This user can\'t delete this user'
      false
    end
  end

  def user_exists?(options, params:, **)
    if User::where(token: params[:token]).take.nil?
      options['errors'] = 'Can\'t find user to delete'
      false
    else
      true
    end
  end

  def delete(optiosn, params:, **)
    User::where(token: params[:token]).first.destroy
  end
end
