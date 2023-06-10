export default function renderClientesTable(clientes, paginaCorrente=1) {
    return `
        <h1>Lista de clientes</h1>
        <button data-action="click->clientes#formClientes">Novo Cliente</button>
        <hr style="margin: 16px 0px;">
        <table style="margin-top: 0px;margin-bottom: 5px;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Telefone</th>
                    <th>Endereço</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                ${clientes.map(cliente => `
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.nome}</td>
                    <td>${cliente.telefone}</td>
                    <td>${cliente.endereco}</td>
                    <td>
                        <button class="btn" data-action="click->clientes#alterar" data-cliente='${JSON.stringify(cliente)}'>Alterar</button>
                        <button class="btn" data-action="click->clientes#excluir" data-cliente='${JSON.stringify(cliente)}'>Excluir</button>
                    </td>
                </tr>
                `).join("")}
            </tbody>
        </table>

        <button data-action="click->clientes#anterior" ${paginaCorrente === 1 ? ' style="display: none;"' : ""}>< Anterior</button>
        <button data-action="click->clientes#proximo" ${clientes.length < 3 ? ' style="display: none;"' : ""}>Próximo ></button>
    `;
}
  