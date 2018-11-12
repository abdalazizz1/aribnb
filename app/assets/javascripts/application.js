// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//
       $(document).ready(function(){
            $('.count').prop('disabled', true);
            $(document).on('click','.plus',function(){
                $('.count').val(parseInt($('.count').val()) + 1 );
            });
            $(document).on('click','.minus',function(){
                $('.count').val(parseInt($('.count').val()) - 1 );
                    if ($('.count').val() == 0) {
                        $('.count').val(1);
                    }
                });
        });


       $(document).ready(function(){
        $("#keyup").on('keyup', function(e){
            $.ajax({
                url:"/listings",
                method:"GET",
                data: $("#keyup").serialize(),
                dataType:"json",
                success: function(data){

                    console.log(data);
                    var box = document.getElementById("titles")
                    box.innerHTML = ""
                    data.forEach(function(listing){
                        var item = document.createElement("option")
                        item.value = listing.title_name
                        box.append(item)
                    })

                    // body...
                }
        })

    })



})

       