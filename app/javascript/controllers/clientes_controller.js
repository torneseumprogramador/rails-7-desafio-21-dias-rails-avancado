import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.loadClientes();
  }

  async loadClientes() {
    const clientes = await (await fetch('http://localhost:3000/clientes.json')).json();
    const html = this.renderClientesTable(clientes);
    this.element.innerHTML = html;
  }

  renderClientesTable(clientes) {
    return `
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Telefone</th>
            <th>Endereço</th>
            <th>Data de Criação</th>
            <th>Data de Atualização</th>
          </tr>
        </thead>
        <tbody>
          ${clientes.map(cliente => `
            <tr>
              <td>${cliente.id}</td>
              <td>${cliente.nome}</td>
              <td>${cliente.telefone}</td>
              <td>${cliente.endereco}</td>
              <td>${cliente.created_at}</td>
              <td>${cliente.updated_at}</td>
            </tr>
          `).join("")}
        </tbody>
      </table>
    `;
  }
}
