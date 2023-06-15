$.getScript('/js/jquery-desafio/controllers/clientes_controller.js', () => {

  const carregarFuncoesJquery = () => {
    const $elementos = $('[data-controller-jquery]');
    if($elementos.length > 0){
      const $elemento = $($elementos[0]);
      const nomeFuncao = $elemento.data("controller-jquery");
      eval(`new ${nomeFuncao}($elemento)`)
    }
  }

  // $(document).ready(()=>{
  //   carregarFuncoesJquery();
  // });

  // $(()=>{
  //   carregarFuncoesJquery();
  // })

  (($) => {
    carregarFuncoesJquery();
  })(jQuery);

});