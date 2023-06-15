class ClienteController {
    constructor($elemento){
        this.$elemento = $elemento;
        this.init();
    }
    
    init(){
        this.lista()
    }

    lista(){
        $.getScript('/js/jquery-desafio/templates/clientes/index.html.js', () => {
            $.getScript('/js/jquery-desafio/models/cliente.js', () => {
                $.getScript('/js/jquery-desafio/servicos/clientes_servico.js', async () => {
                    const clientes = await ClienteServico.todos(this.paginaCorrente);
                    const paginaCorrente = 0
                    this.$elemento.html(indexTemplate(clientes, paginaCorrente));
                    this.setActions()
                });
            });
        });
    }

    async atualizar($form){
        const cliente = new Cliente();
        cliente.nome = $form.find("#cliente_nome").val();
        cliente.telefone = $form.find("#cliente_telefone").val();
        cliente.endereco = $form.find("#cliente_endereco").val();
      
        const authenticity_token = $form.find('input[name="authenticity_token"]').val()
        await ClienteServico.salvar(cliente, authenticity_token)
        this.lista();
    }

    setActions(){
        const $buttonsAlterar = $('[data-alterar]');
        if($buttonsAlterar.length > 0){
            for(const elen of $buttonsAlterar){
                $(elen).on('click', (even) => {
                    const cliente = $(even.target).data('cliente');
                    $.getScript('/js/jquery-desafio/templates/clientes/form.html.js', () => {
                        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
                        this.$elemento.html(renderClientesForm(cliente, csrfToken))
                        this.setActions();
                    });
                });
            }
        }


        const $buttonsLista = $('[data-lista]');
        if($buttonsLista.length > 0){
            for(const elen of $buttonsLista){
                $(elen).on('click', (even) => {
                    even.preventDefault();
                    this.lista();
                });
            }
        }

        const $buttonsAtualizar = $('[data-atualizar]');
        if($buttonsAtualizar.length > 0){
            for(const elen of $buttonsAtualizar){
                $(elen).on('click', (even) => {
                    even.preventDefault();
                    const $botaoSubmit = $(even.target)
                    const form = $botaoSubmit.parents("form");
                    this.atualizar(form);
                });
            }
        }
    }
    
    alterar(elen){
        debugger
    }
}