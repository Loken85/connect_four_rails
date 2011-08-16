$(function() {	
	if ($("#gamecontainer").attr("data-id")){
		setTimeout(updateGame, 3000);
	}
});

function updateGame () {
	var game_id = $("#gamecontainer").attr("data-id");
	if (game_id) {
	$.getScript("/games/show.js?game_id=" + game_id)
	setTimeout(updateGame, 3000);
	}
}