defmodule PhoenixTodoWeb.TodoJSON do
   def created(%{todo: todo}) do
      %{
         data: %{
            id: todo.id,
            title: todo.title,
            description: todo.description,
            completed: todo.completed,
            inserted_at: todo.inserted_at,
            updated_at: todo.updated_at
         }
      }
   end

   def error(%{changeset: changeset}) do
      %{
         errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
      }
   end

   defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  def show(%{todo: todo}) do
      %{
         data: %{
            id: todo.id,
            title: todo.title,
            description: todo.description,
            completed: todo.completed,
            inserted_at: todo.inserted_at,
            updated_at: todo.updated_at
         }
      }
   end

   def error(%{message: message}) do
      %{
         errors: message
      }
   end

   def show_all(%{todos: todos}) do
      %{
         data: Enum.map(todos, fn todo ->
         %{
            id: todo.id,
            title: todo.title,
            description: todo.description,
            completed: todo.completed,
            inserted_at: todo.inserted_at,
            updated_at: todo.updated_at
         }
         end)
      }
   end

   def delete(%{message: message}) do
      %{
         data: %{
            message: message
         }
      }
   end
end
