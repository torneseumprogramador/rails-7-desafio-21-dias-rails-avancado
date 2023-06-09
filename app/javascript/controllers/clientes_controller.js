import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.loadClientes();
  }

  async loadClientes() {
    const clientes = await (await fetch('http://localhost:3000/clientes.json')).json();
    this.displayClientes(clientes);
  }

  displayClientes(clientes) {
    const tbody = document.getElementById('clientes-table');
    clientes.forEach(cliente => {
      const html = `
        <tr>
          <td>${cliente.id}</td>
          <td>${cliente.nome}</td>
          <td>${cliente.telefone}</td>
          <td>${cliente.endereco}</td>
        </tr>
      `;
      tbody.innerHTML += html;
    });
  }  
}
