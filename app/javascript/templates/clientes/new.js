export default function renderClientesForm(cliente, csrfToken) {
    return `
        <h1>Cadastro de Clientes</h1>
        <hr>
        <form action="/clientes" accept-charset="UTF-8" method="post">
            <div>
                <label style="display: block" for="cliente_nome">Nome</label>
                <input type="text" name="cliente[nome]" value="${cliente.nome}" id="cliente_nome">
            </div>

            <div>
                <label style="display: block" for="cliente_telefone">Telefone</label>
                <input type="text" name="cliente[telefone]" value="${cliente.telefone}" id="cliente_telefone">
            </div>

            <div>
                <label style="display: block" for="cliente_endereco">Endereco</label>
                <input type="text" name="cliente[endereco]" value="${cliente.endereco}" id="cliente_endereco">
            </div>
            <hr>
            <div>
                <input type="hidden" name="authenticity_token" value="${csrfToken}">
                <input type="submit" name="commit" data-action="click->clientes#salvar" value="Salvar">
                <button data-action="click->clientes#loadClientes">Lista de Clientes</button>
            </div>
        </form>
    `;
}
