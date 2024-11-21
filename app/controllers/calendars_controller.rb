class CalendarsController < ApplicationController

  # 1週間のカレンダーと予定が表示されるページ
  def index

    get_week

    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week

    wdays = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)']
  

    @todays_date = Date.today
    @week_days = []
  
    plans = Plan.where(date: @todays_date..@todays_date + 6).group_by(&:date)
  
    7.times do |x|

      target_date = @todays_date + x
      day_plans = plans[target_date]&.map(&:plan) || []
  
      wday_num = (target_date.wday) % 7
      @week_days << {
        month: target_date.month,
        date: target_date.day,
        wday: wdays[wday_num], 
        plans: day_plans
      }

    end
  end
end