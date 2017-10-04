var csrf = document.querySelector("meta[name=csrf]").content;

export var Schooldata = {
    student_ids: function(class_code){
	return $.ajax({
		url: "/student/"+ class_code +"/id",
		method: "POST",
		dataType: "json",
		headers: {
		    "X-CSRF-TOKEN": csrf,
		},
	    });
    }
}