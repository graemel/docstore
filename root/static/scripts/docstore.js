$(document).ready(function(){

	$('#search').click( function(){
			location.href = '/search/'+ encodeURIComponent($("#q").val());
			return false;
		}
	);

});