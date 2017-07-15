$(document).ready(function() {
    var max_fields      = 5; //maximum input boxes allowed
    var wrapper         = $(".input_fields_wrap"); //Fields wrapper
    var add_button      = $(".add_field_button"); //Add button ID

    var x = 1; //initlal text box count
    $(add_button).click(function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            $("#rm").remove(); 
            $(wrapper).append('<div id="divs"><div class="form-group"><label for="confirm" class="cols-sm-2 control-label">Investment Name</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="text_area" name="investment_calculator[investment_name'+ x +']" id="investment_calculator_investment_name'+ x +'"></div><label for="confirm" class="cols-sm-2 control-label">Lump Sum</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="investment_calculator[investment_ls'+ x +']" id="investment_calculator_investment_ls'+ x +'"></div><label for="confirm" class="cols-sm-2 control-label">Regular Contribution</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="investment_calculator[investment_regular'+ x +']" id="investment_calculator_investment_regular'+ x +'"></div><label for="confirm" class="cols-sm-2 control-label">Growth Rate</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="investment_calculator[investment_growth'+ x +']" id="investment_calculator_investment_growth'+ x +'"></div></div><hr></div>');
        }
    })

    $(".remove_field").click(function(e){ //user click on remove text
        e.preventDefault();
        $("#divs").remove(); x--;
    })
});