class UnsignedColumnsTestsController < ApplicationController
  # GET /unsigned_columns_tests
  # GET /unsigned_columns_tests.json
  def index
    @unsigned_columns_tests = UnsignedColumnsTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unsigned_columns_tests }
    end
  end

  # GET /unsigned_columns_tests/1
  # GET /unsigned_columns_tests/1.json
  def show
    @unsigned_columns_test = UnsignedColumnsTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unsigned_columns_test }
    end
  end

  # GET /unsigned_columns_tests/new
  # GET /unsigned_columns_tests/new.json
  def new
    @unsigned_columns_test = UnsignedColumnsTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unsigned_columns_test }
    end
  end

  # GET /unsigned_columns_tests/1/edit
  def edit
    @unsigned_columns_test = UnsignedColumnsTest.find(params[:id])
  end

  # POST /unsigned_columns_tests
  # POST /unsigned_columns_tests.json
  def create
    @unsigned_columns_test = UnsignedColumnsTest.new(params[:unsigned_columns_test])

    respond_to do |format|
      if @unsigned_columns_test.save
        format.html { redirect_to @unsigned_columns_test, notice: 'Unsigned columns test was successfully created.' }
        format.json { render json: @unsigned_columns_test, status: :created, location: @unsigned_columns_test }
      else
        format.html { render action: "new" }
        format.json { render json: @unsigned_columns_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /unsigned_columns_tests/1
  # PUT /unsigned_columns_tests/1.json
  def update
    @unsigned_columns_test = UnsignedColumnsTest.find(params[:id])

    respond_to do |format|
      if @unsigned_columns_test.update_attributes(params[:unsigned_columns_test])
        format.html { redirect_to @unsigned_columns_test, notice: 'Unsigned columns test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unsigned_columns_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unsigned_columns_tests/1
  # DELETE /unsigned_columns_tests/1.json
  def destroy
    @unsigned_columns_test = UnsignedColumnsTest.find(params[:id])
    @unsigned_columns_test.destroy

    respond_to do |format|
      format.html { redirect_to unsigned_columns_tests_url }
      format.json { head :no_content }
    end
  end
end
