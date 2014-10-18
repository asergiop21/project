var calculo = function(){
var  valor = 0;
$(document).find('.price_cost_stock').each(function(){
    precio = $(this).val();

    if (precio != "" && !isNaN(precio)){
  valor += parseFloat(precio);
    }
    });
  return valor;
};


$(document).ready(function(){

   $(document).on('blur', '.price_cost_stock', function(){
    var price_total = calculo(); 
  $('#invoice_stock_price_total').val(price_total.toFixed(2));
   }); 

});
