//= require active_admin/base
//= require mousetrap.min
//= require chosen.jquery
$(function(){

  // Hotkeys
  Mousetrap.bind('ctrl+alt+n', function() { location.href = "/admin/presupuestos/new" });
  Mousetrap.bind('ctrl+alt+s', function() { location.href = "/admin/presupuestos" });
  Mousetrap.bind('ctrl+alt+u', function() { location.href = "/admin/clientes/new" });
  Mousetrap.bind('ctrl+alt+a', function() { location.href = "/admin/admin_users/new" });

  // Awesome selects
  $("#q_cliente_id").chosen();
  $("#q_tipo_reparacion").chosen();
  $("#q_nombre").chosen();
  $("#q_email").chosen();
  $("#presupuesto_cliente_id").chosen();
  $("#presupuesto_estado_reparacion").chosen();
  $("#presupuesto_tipo_reparacion").chosen();
});
