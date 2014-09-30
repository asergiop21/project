$(document).ready(function(){

  $(document).on('click','.remove_fields_stocks', function(event){
    $(this).closest('div.line3').find('input[type=hidden]').val('1');
  $(this).closest('div.line3').hide()
    event.preventDefault();
  });

  $('div.line3').on('keydown', '[data-autocomplete-for]', function(event){

    if (event.which == 13 ){
      console.log(event.which);
      event.preventDefault();
    }

    var input = $(this);
    input.autocomplete({
      source: function(request, response) {
        $.ajax({
          url: input.data('autocomplete-url'),
          dataType: 'json', data: { q: request.term },
          success: function(data) {
            response(
              $.map(data, function(item) {
                return {label:item.barcode + " - " + item.name, item: item};
              })
              );
          },
        });
      },
      minLength: 2,
      autoFocus: true,
      select: function(event, ui) {
        input.val(ui.item.label);
        var field = this.id;
        var id = field.split("_");
        var field_article_id = '#invoice_stock_stocks_attributes_' + id[4] + '_article_id';

        $(field_article_id).val(ui.item.item.id);
      }
    }).removeAttr('data-autocomplete-field');
  });
  });

