class SalesController < ApplicationController
  def new

  end

  def done
    @sales = Sale.all
  end

  def create
   @sale = Sale.new(sale_params)
   @sale.total = @sale.value - ( @sale.value * @sale.discount / 100)
   #asignar interes
    if @sale.tax == 1 #checkbox seleccionado
      tax = 1
    else
      tax = 1.9
    end

    @sale.total = @sale.total * tax
    @sale.save


    if @sale.save
      redirect_to sales_done_path
    else
      redirect_to sales_new_path, notice: 'Error!!'
    end

  end

  private
    def sale_params
      params.require(:sale).permit(:cod, :datail, :category, :value, :discount, :tax)
    end
end
