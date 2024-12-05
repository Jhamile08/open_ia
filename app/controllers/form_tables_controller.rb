class FormTablesController < ApplicationController
  before_action :set_form_table, only: %i[ show edit update destroy ]

  # GET /form_tables or /form_tables.json
  def index
    @form_tables = FormTable.all
  end

  # GET /form_tables/1 or /form_tables/1.json
  def show
  end

  # GET /form_tables/new
  def new
    @user = User.new
    @form_table = FormTable.new
  end

  # GET /form_tables/1/edit
  def edit
  end

  # POST /form_tables or /form_tables.json
  def create
    @form_table = FormTable.new(form_table_params)

    respond_to do |format|
      if @form_table.save

        if @form_table.processed_in_job
          @user = User.new(user_params)
          if @user.save
            puts "guardado corractamente user"
            @form_table.user = @user
          end

        # if form_table_params[:name].blank? || form_table_params[:email].blank?
        #   # Si no se llenan los campos de nombre o correo, mostramos un error
        #   flash[:error] = "Please provide both name and email to enqueue the form."
        #   render :new and return
        # else
        #   # Aquí creamos o asociamos el usuario
        #   @user = User.new(user_params)
        #   @form_table.user = @user

        #   puts "trabajo procesado"
        #   puts "El trabajo está en cola ('pending')"
        #   @response = @form_table.responses.create(
        #     ai_response: nil, # Aquí se puede configurar como null
        #     status: "pending"
        #   )
        #   # response_new = Response.create(null, ai_response: nu, status: "confirmado")
        # end

        else
          description = @form_table.description
          form(@form_table, description)
          format.html { redirect_to @form_table, notice: "Form table was successfully created." }
          format.json { render :show, status: :created, location: @form_table }
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_tables/1 or /form_tables/1.json
  def update
    respond_to do |format|
      if @form_table.update(form_table_params)
        format.html { redirect_to @form_table, notice: "Form table was successfully updated." }
        format.json { render :show, status: :ok, location: @form_table }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form_table.errors, status: :unprocessable_entity }
      end
    end
  end

  def form(form_table, description)
    response = FormService.new(user_message: description).form_question
    response_new = Response.create(form_table_id: form_table.id, ai_response: response[:data], status: "confirmado")
    puts response_new.inspect
    puts "esta es la respuesta"
    puts response


    if response[:success]
      flash[:notice] = "Response received successfully!"

    else
      flash[:alert] = "Error: #{response[:error]}"
    end
  end


  # DELETE /form_tables/1 or /form_tables/1.json
  def destroy
    @form_table.destroy!

    respond_to do |format|
      format.html { redirect_to form_tables_path, status: :see_other, notice: "Form table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_table
      @form_table = FormTable.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def form_table_params
      params.expect(form_table: [ :user_id, :name, :description, :processed_in_job ])
    end
    def user_params
      params.require(:form_table).require(:user).permit(:name, :email)
    end
end
