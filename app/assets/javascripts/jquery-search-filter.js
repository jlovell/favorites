$(document).on('ready page:load', function () {
    $("#search-filter").keyup(function () {
        console.log("up!");
        //split the current value of searchInput
        var data = this.value
        var searched = data.toUpperCase()
        //create a jquery object of the rows
        var jo = $("#restaurants-filtered").find(".filter-row");
        if (this.value == "") {
            jo.show();
            return;
        }
        //hide all the rows
        jo.hide();

        //Recusively filter the jquery object to get results.
        jo.filter(function (i, v) {
            var $t = $(this);
            if ($t.find('.filter-on').text().toUpperCase().indexOf(searched) > -1) {
                return true;
            }
            return false;
        })
        //show the rows that match.
        .show();
        $('#add-new-place').show().find('span.name-field').html(data);
        $('#add-new-place input.name-field').val(data);
    });
});
