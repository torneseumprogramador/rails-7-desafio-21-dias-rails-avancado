import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    Promise.all([
      fetch('/clientes.json').then(response => response.json()),
      fetch('/templates/clientes/index.html').then(response => response.text())
    ])
    .then(([clientes, template]) => {
      let tableContent = clientes.map(cliente => {
        return `
          <tr>
              <td>${cliente.id}</td>
              <td>${cliente.nome}</td>
              <td>${cliente.telefone}</td>
              <td>${cliente.endereco}</td>
          </tr>
        `;
      }).join('');

      this.element.innerHTML = template.replace('${tableContent}', tableContent);
    })
    .catch(error => console.error('Erro:', error));
  }
}
