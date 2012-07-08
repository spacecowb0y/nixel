//= require active_admin/base
//= require mousetrap.min
$(function(){
  Mousetrap.bind('ctrl+alt+n', function() { location.href = "/admin/presupuestos/new" });
  Mousetrap.bind('ctrl+alt+s', function() { location.href = "/admin/presupuestos" });
  Mousetrap.bind('ctrl+alt+u', function() { location.href = "/admin/clientes/new" });
  Mousetrap.bind('ctrl+alt+a', function() { location.href = "/admin/admin_users/new" });
})

