class UsersController < Clearance::UsersController
  before_action :require_login
  def index

  end
  def secret
  end
  def show
    @user = User.find(params[:id])
    @reservations = current_user.reservations
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(userss_params)


    if @user.save
      flash[:notice]= "Successfuly updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end


  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    image = user_params.delete(:image)



    Clearance.configuration.user_model.new(user_params).tap do |user|

      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.image = image

    end
  end
  def userss_params

    params.require(:user).permit(:first_name, :last_name, :email , :image)
  end
end
