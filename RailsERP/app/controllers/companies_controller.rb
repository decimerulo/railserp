# Controller CLass for Companies
class CompaniesController < ApplicationController
  
  # GET /companies
  # GET /companies.xml
  before_filter :login_required
  before_filter :has_permission?
  # List all Companys
  def index
    @companies = Company.find(:all, :limit => @@listlimit )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  # Show the Company
  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  # Create a new Company
  def new
    @company = Company.new
    @companyarts= Companyart.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  # Edit a Company
  def edit
    @companyarts= Companyart.find(:all)
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  # Save the Company
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        flash[:notice] = 'Company was successfully created.'
        format.html { redirect_to(@company) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  # Update a Company
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(@company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  # Delete a Company
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end

 # Search for a Company with a String
 def search
    @companies = Company.search params[:name]
    respond_to do |format|
      format.html { render :template =>"companies/index"}
      format.xml  { render :xml => @companies }
    end
  end

   # Search for a Company with a srting AJAX Search
  def live_search
    @phrase = params[:searchtext]
    @results = Company.search @phrase

    @number_match = @results.length

    render(:layout => false)
  end
end
