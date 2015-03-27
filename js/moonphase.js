var lang  = 'en' // 'ca' , 'es' , 'en'
var month = new Date().getMonth() + 1 // 1 - 12
var year  = new Date().getFullYear()

var svgSize        = 150 // pixels
var svgLightColor  = "#f2ef42"
var svgShadeColor  = "#202020"
var svgSizeQuarter = 20 // pixels

$(document).ready(function() {
	sendAndRead()
})

function sendAndRead(){
	$.ajax({
		type: "GET",
		url: "http://www.wdisseny.com/lluna/api/",
		data: {
			lang : lang,
			size : svgSize,
			lightColor : svgLightColor,
			shadeColor : svgShadeColor,
			sizeQuarter: svgSizeQuarter,
			GTM : new Date().getTimezoneOffset(),
			month :month,
			year :year 
		}
	})
	.done(function( response ) {
		moon = $.parseJSON( response );
		if (typeof example_1 == "function")example_1(moon)
		if (typeof example_2 == "function")example_2(moon)
		if (typeof example_3 == "function")example_3(moon)
		$(".moon").css({backgroundColor:"#ffffff",display:"inline-table",padding:"10px 20px",color:"#808080",margin:"1px"})
		$(".phaseLimit").css({position:"absolute",float:"left"})		
	})
	.fail(function(jqXHR, textStatus) {
		$("#ex1").html(textStatus)
	})
}