require "swagger_helper"

RSpec.describe "Todos API", swagger_doc: "v1/swagger.yaml", type: :request do
  path "/todos" do
    get "List all todos and items" do
      tags "Todos"
      produces "application/json"

      response "200", "ok" do
        run_test!
      end
    end

    post "Create a todo" do
      tags "Todos"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: "My todo" },
          created_by: { type: :string, example: "Panos" }
        },
        required: ["title", "created_by"]
      }

      response "201", "created" do
        let(:payload) { { title: "My todo", created_by: "Panos" } }
        run_test!
      end

      response "422", "invalid" do
        let(:payload) { { title: "" } }
        run_test!
      end
    end
  end

  path "/todos/{id}" do
    parameter name: :id, in: :path, type: :integer, required: true

    get "Get a todo" do
      tags "Todos"
      produces "application/json"

      response "200", "ok" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let(:id) { todo.id }
        run_test!
      end

      response "404", "not found" do
        let(:id) { 999_999 }
        run_test!
      end
    end

    put "Update a todo" do
      tags "Todos"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: "Updated title" }
        }
      }

      response "204", "no content" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let(:id) { todo.id }
        let(:payload) { { title: "Updated title" } }
        run_test!
      end
    end

    delete "Delete a todo and its items" do
      tags "Todos"
      produces "application/json"

      response "204", "no content" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let(:id) { todo.id }
        run_test!
      end
    end
  end

  path "/todos/{id}/items" do
    parameter name: :id, in: :path, type: :integer, required: true

    post "Create a new todo item" do
      tags "Items"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: "Buy milk" },
          done: { type: :boolean, example: false }
        },
        required: ["name"]
      }

      response "201", "created" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let(:id) { todo.id }
        let(:payload) { { name: "Buy milk", done: false } }
        run_test!
      end
    end
  end

  path "/todos/{id}/items/{iid}" do
    parameter name: :id, in: :path, type: :integer, required: true
    parameter name: :iid, in: :path, type: :integer, required: true

    get "Get a todo item" do
      tags "Items"
      produces "application/json"

      response "200", "ok" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let!(:item) { Item.create!(todo: todo, name: "Buy milk", done: false) }
        let(:id) { todo.id }
        let(:iid) { item.id }
        run_test!
      end
    end

    put "Update a todo item" do
      tags "Items"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: "Buy bread" },
          done: { type: :boolean, example: true }
        }
      }

      response "204", "no content" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let!(:item) { Item.create!(todo: todo, name: "Buy milk", done: false) }
        let(:id) { todo.id }
        let(:iid) { item.id }
        let(:payload) { { done: true } }
        run_test!
      end
    end

    delete "Delete a todo item" do
      tags "Items"
      produces "application/json"

      response "204", "no content" do
        let!(:todo) { Todo.create!(title: "My todo", created_by: "Panos") }
        let!(:item) { Item.create!(todo: todo, name: "Buy milk", done: false) }
        let(:id) { todo.id }
        let(:iid) { item.id }
        run_test!
      end
    end
  end
end