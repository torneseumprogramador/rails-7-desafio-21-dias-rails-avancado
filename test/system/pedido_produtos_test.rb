require "application_system_test_case"

class PedidoProdutosTest < ApplicationSystemTestCase
  setup do
    @pedido_produto = pedido_produtos(:one)
  end

  test "visiting the index" do
    visit pedido_produtos_url
    assert_selector "h1", text: "Pedido produtos"
  end

  test "should create pedido produto" do
    visit pedido_produtos_url
    click_on "New pedido produto"

    fill_in "Pedido", with: @pedido_produto.pedido_id
    fill_in "Produto", with: @pedido_produto.produto_id
    fill_in "Quantidade", with: @pedido_produto.quantidade
    fill_in "Valor", with: @pedido_produto.valor
    click_on "Create Pedido produto"

    assert_text "Pedido produto was successfully created"
    click_on "Back"
  end

  test "should update Pedido produto" do
    visit pedido_produto_url(@pedido_produto)
    click_on "Edit this pedido produto", match: :first

    fill_in "Pedido", with: @pedido_produto.pedido_id
    fill_in "Produto", with: @pedido_produto.produto_id
    fill_in "Quantidade", with: @pedido_produto.quantidade
    fill_in "Valor", with: @pedido_produto.valor
    click_on "Update Pedido produto"

    assert_text "Pedido produto was successfully updated"
    click_on "Back"
  end

  test "should destroy Pedido produto" do
    visit pedido_produto_url(@pedido_produto)
    click_on "Destroy this pedido produto", match: :first

    assert_text "Pedido produto was successfully destroyed"
  end
end
