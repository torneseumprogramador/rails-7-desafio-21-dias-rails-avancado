import { Controller } from "@hotwired/stimulus";
import renderClientesTable from "../templates/clientes/index";

export default class extends Controller {
  connect() {
    this.loadClientes();
  }

  async loadClientes() {
    const clientes = await (await fetch('http://localhost:3000/clientes.json')).json();
    const html = renderClientesTable(clientes);
    this.element.innerHTML = html;
  }
}
