function transformarNome(nome) {
  return '/js/jquery-desafio/controllers/' + nome.replace(/[A-Z]/g, (match, offset) => {
    if (offset === 0) {
      return match.toLowerCase();
    }
    return '_' + match.toLowerCase();
  }) + '.js';
}

const carregarFuncoesJquery = () => {
  const $elementos = $('[data-controller-jquery]');
  if($elementos.length > 0){
    const $elemento = $($elementos[0]);
    const nomeFuncao = $elemento.data("controller-jquery");
    const js = transformarNome(nomeFuncao)
    $.getScript(js, () => {
      eval(`new ${nomeFuncao}($elemento)`)
    });
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
