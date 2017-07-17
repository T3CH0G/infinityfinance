$(document).ready(function() {
    var max_fields2      = 5; //maximum input boxes allowed
    var wrapper2         = $(".input_fields_wrap2"); //Fields wrapper
    var add_button2      = $(".add_field_button2"); //Add button ID

    var x = 1; //initlal text box count
    $(add_button2).click(function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields2){ //max input box allowed
            x++; //text box increment
            $("#rm").remove(); 
            $(wrapper2).append('<div id="divs"><div class="form-group"><label for="confirm" class="cols-sm-2 control-label">Child Name</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="textarea" name="educationoutput[child'+x+'_name]" id="educationoutput_child'+x+'_name"></div><label for="confirm" class="cols-sm-2 control-label">Starting Age</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="educationoutput[child'+ x +'_startingage]" id="educationoutput_child'+ x +'_startingage"></div><label for="confirm" class="cols-sm-2 control-label">Current Age</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="educationoutput[child'+ x +'_currentage]" id="educationoutput_child'+ x +'_currentage"></div><label for="confirm" class="cols-sm-2 control-label">Years</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="educationoutput[child'+ x +'_years]" id="educationoutput_child'+ x +'_years"></div><label for="confirm" class="cols-sm-2 control-label">Tuition</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="educationoutput[child'+ x +'_tuition]" id="educationoutput_child'+ x +'_tuition"></div><label for="confirm" class="cols-sm-2 control-label">Living Expense</label><div class="input-group"><span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span><input class="form-control" type="number" name="educationoutput[child'+ x +'_living_expense]" id="educationoutput_child'+ x +'_living_expense"></div></div><hr></div>');
        }
    })

    $(".remove_field2").click(function(e){ //user click on remove text
        e.preventDefault();
        $("#divs").remove(); x--;
    })
});