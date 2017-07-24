$(document).ready(function() {
$('#myTabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})
});
$('#myTabs a[href="#livingexpense"]').tab('show');