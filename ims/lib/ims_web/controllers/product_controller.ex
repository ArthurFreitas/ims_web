defmodule ImsWeb.ProductController do
  use ImsWeb, :controller
  alias Ims.ProductHelper
  alias Ims.Product

  def index(conn, _params) do
    render(conn, :list, products: ProductHelper.list)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id, product: ProductHelper.get!(id))
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    product = ProductHelper.get!(id)
    changeset = Product.changeset(product,%{})
    render(conn, :edit, changeset: changeset, product: product)
  end

  def create(conn, %{"product" => product}) do
    ProductHelper.insert(product)
    redirectToIndex(conn)
  end

  def update(conn, %{"id" => id, "product" => updatedProduct}) do
    product = ProductHelper.get!(id)
    ProductHelper.update(product, updatedProduct)
    redirectToIndex(conn)
  end

  def destroy(conn, %{"id" => id}) do
    ProductHelper.delete(id)
    redirectToIndex(conn)
  end

  defp redirectToIndex(conn) do
    conn |> redirect(to: "/product") |> halt()
  end
end
