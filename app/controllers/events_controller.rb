class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
      @event = Event.find_by(id: params[:id])
      @user = @event.user
  end

  # GET /events/new
  def new
    if user_signed_in?
      @event = Event.new
    else
      flash[:caution] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  # GET /events/1/edit
  def edit
    if user_signed_in?
      @event = Event.find_by(id: params[:id])
    else
      flash[:caution] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    if user_signed_in?
      @event.user_id = current_user.id
      respond_to do |format|
        if @event.save
          flash[:caution] = "予定を作成しました"
          format.html { redirect_to @event }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end

    else
      flash[:caution] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @event.update(event_params)
          flash[:caution] = "予定を編集しました"
          format.html { redirect_to @event }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:caution] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if user_signed_in?
      @event.destroy
      respond_to do |format|
        flash[:caution] = "予定を削除しました"
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    else
      flash[:caution] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date)
    end
end
