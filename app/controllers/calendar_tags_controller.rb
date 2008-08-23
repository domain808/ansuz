class CalendarTagsController < ApplicationController
	before_filter :login_required
  before_filter :load_calendar_tag, :only => [:show, :edit, :update, :destroy]

  protected
  def load_calendar_tag
    @calendar_tag = CalendarTag.find(params[:id])
  end

  public

  def index
    list
    render :action => 'list'
  end

  def list
    @calendar_tag_pages, @calendar_tags = paginate :calendar_tags, :per_page => 10
  end

  def show
  end

  def new
    @calendar_tag = CalendarTag.new
  end

  def create
    @calendar_tag = CalendarTag.new(params[:calendar_tag])
    if @calendar_tag.save
      flash[:notice] = 'CalendarTag was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @calendar_tag.update_attributes(params[:calendar_tag])
      flash[:notice] = 'CalendarTag was successfully updated.'
      redirect_to :action => 'show', :id => @calendar_tag
    else
      render :action => 'edit'
    end
  end

  def destroy
    @calendar_tag.destroy
    redirect_to :action => 'list'
  end
end
