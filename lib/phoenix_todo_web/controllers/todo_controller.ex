defmodule PhoenixTodoWeb.TodoController do
   use PhoenixTodoWeb, :controller
   alias PhoenixTodo.Todo
   alias PhoenixTodo.Repo

   # Add a catch-all clause to see what parameters we're receiving
   def create(conn, params) do
     IO.inspect(params, label: "Received params")
   
     todo_params = params["todo"] || params
     
     changeset = Todo.changeset(%Todo{}, todo_params)

     case Repo.insert(changeset) do
        {:ok, todo} ->
           conn
           |> put_status(:created)
           |> render(:created, todo: todo)

        {:error, changeset} ->
           conn
           |> put_status(:unprocessable_entity)
           |> render(:error, changeset: changeset)
     end
   end

   def show(conn, %{"id" => id}) do
     case Repo.get(Todo, id) do
       nil ->
         conn
         |> put_status(:not_found)
         |> render(:error, message: "Todo not found with id: #{id}")

       todo ->
         conn
         |> put_status(:ok)
         |> render(:show, todo: todo)
     end
   end

   def show_all(conn, _params) do
      todos = Repo.all(Todo)
         
      conn
      |>  put_status(:ok)
      |> render(:show_all, todos: todos)
   end

   def delete(conn, %{"id" => id}) do
      case Repo.get(Todo, id) do
         nil ->
            conn
            |> put_status(:not_found)
            |> render(:error, message: "Todo not found with id: #{id}")

         todo ->
            Repo.delete(todo)

            conn
            |> put_status(:ok)
            |> render(:delete, message: "Todo with id: #{id} deleted successfully")
      end
   end
end
