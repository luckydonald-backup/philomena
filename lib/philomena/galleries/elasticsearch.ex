defmodule Philomena.Galleries.Elasticsearch do
  def mapping do
    %{
      settings: %{
        index: %{
          number_of_shards: 5,
          max_result_window: 10_000_000
        }
      },
      mappings: %{
        gallery: %{
          _all: %{enabled: false},
          dynamic: false,
          properties: %{
            id: %{type: "integer"}, # keyword
            image_count: %{type: "integer"},
            watcher_count: %{type: "integer"},
            updated_at: %{type: "date"},
            created_at: %{type: "date"},
            title: %{type: "keyword"},
            creator: %{type: "keyword"}, # missing creator_id
            image_ids: %{type: "keyword"},
            watcher_ids: %{type: "keyword"}, # ???
            description: %{type: "text", analyzer: "snowball"}
          }
        }
      }
    }
  end

  # [:subscribers, :creator, :interactions]
  def as_json(gallery) do
    %{
      id: gallery.id,
      image_count: gallery.image_count,
      watcher_count: length(gallery.subscribers),
      watcher_ids: Enum.map(gallery.subscribers, & &1.id),
      updated_at: gallery.updated_at,
      created_at: gallery.created_at,
      title: String.downcase(gallery.title),
      creator: String.downcase(gallery.creator.name),
      image_ids: Enum.map(gallery.interactions, & &1.image_id),
      description: gallery.description
    }
  end
end
