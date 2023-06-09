export default function renderClientesTable(clientes) {
    return `
        <h1>Lista de clientes</h1>
        <a href="#">Novo Cliente</a>
        <hr>
        <table>
            <thead>
                <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Telefone</th>
                <th>Endereço</th>
                </tr>
            </thead>
            <tbody>
                ${clientes.map(cliente => `
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.nome}</td>
                    <td>${cliente.telefone}</td>
                    <td>${cliente.endereco}</td>
                </tr>
                `).join("")}
            </tbody>
        </table>
    `;
}
  