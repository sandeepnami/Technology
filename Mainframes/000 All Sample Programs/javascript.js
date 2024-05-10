//javascript select element by id
document.getElementById("next").click()
document.getElementById("navigation")
document.getElementById("cc_iframe")

//javascript select element by id for elements inside iframes
var iframe = document.getElementById('cc_iframe');
var innerDoc = iframe.contentDocument || iframe.contentWindow.document;
innerDoc.getElementById("next").click();

//