$(function() {
  // Configura o Timezone do Moment.js
  moment.locale('pt-BR');
  // Inicia o tick de horário
  function iniciarHorario() {
    document.getElementById('horario').innerHTML = "<h3>" + moment().format(`HH:mm:ss » DD/MM/YYYY`) +  "</h3>";
    t = setTimeout(function() {
      iniciarHorario()
    }, 500);
  }
  iniciarHorario();
});
