defmodule PhilomenaWeb.Router do
  use PhilomenaWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhilomenaWeb.Plugs.Session, otp_app: :philomena
    # plug PhilomenaWeb.Plugs.DenyAnonymousTor
    plug PhilomenaWeb.Plugs.RenderTime
    plug PhilomenaWeb.Plugs.CurrentFilter
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/api/v2", PhilomenaWeb.Api.V2 do
    pipe_through :api

    scope "/images" do
      get "/show", ImageController, :show
      get "/fetch_many", ImageController, :fetch_many
    end

    scope "/tags" do
      get "/show", TagController, :show
      get "/fetch_many", TagController, :fetch_many
    end

    scope "/users" do
      get "/current", UserController, :current
      get "/show", UserController, :show
      get "/fetch_many", UserController, :fetch_many
    end

    scope "/notifications" do
      get "/unread", NotificationController, :unread
      put "/watch", NotificationController, :watch
      put "/unwatch", NotificationController, :unwatch
      put "/mark_read", NotificationController, :mark_read
    end

    scope "/interactions" do
      put "/vote", InteractionContoller, :vote
      put "/fave", InteractionContoller, :fave
      put "/hide", InteractionContoller, :hide
    end
  end

  scope "/", PhilomenaWeb do
    pipe_through :browser

    scope "/filters", Filters do
      resources "/current", CurrentController, only: [:show, :update], singleton: true
      resources "/spoiler", SpoilerController, only: [:create, :delete], singleton: true
      resources "/hide", HideController, only: [:create, :delete], singleton: true
    end
    resources "/filters", FilterController

    resources "/forums", ForumController do
      resources "/topics", TopicController do
        scope alias: Topics do
          resources "/lock", LockController, only: [:create, :delete], singleton: true
          resources "/stick", StickController, only: [:create, :delete], singleton: true
          resources "/hide", HideController, only: [:create, :delete], singleton: true
          resources "/move", MoveController, only: [:create], singleton: true

          resources "/posts", PostController, except: [:index, :show] do
            scope alias: Posts do
              resources "/hide", HideController, only: [:create, :delete], singleton: true
              resources "/history", HistoryController, only: [:show], singleton: true
            end
          end

          scope "/poll", Polls do
            resources "/voters", VoteController, only: [:index]
          end
        end
      end
    end

    resources "/dnp", DnpEntryController do
      resources "/rescind", DnpEntries.RescindController, only: [:create], singleton: true
    end

    scope "/posts", Posts do
      resources "/posted", PostedController, only: [:index]
      resources "/preview", PreviewController, only: [:create], singleton: true
    end
    resources "/posts", PostController, only: [:index]

    # todo: nest this under topics
    resources "/poll_votes", PollVoteController, only: [:create]

    resources "/channels", ChannelController

    resources "/profiles", ProfileController, only: [:show, :edit, :update] do
      scope alias: Profiles do
        resources "/details", DetailController, only: [:show], singleton: true
        resources "/downvotes", DownvoteController, only: [:delete], singleton: true
        resources "/fp_history", FpHistoryController, only: [:show], singleton: true
        resources "/ip_history", IpHistoryController, only: [:show], singleton: true
        resources "/scratchpad", ScratchpadController, only: [:edit, :update], singleton: true
        resources "/votes_and_faves", VoteAndFaveController, only: [:delete], singleton: true

        resources "/aliases", AliasController, only: [:index]
        resources "/badge_awards", BadgeAwardController, except: [:index]
        resources "/source_changes", SourceChangeController, only: [:index]
        resources "/tag_changes", TagChangeController, only: [:index]
      end
    end

    # Lists
    # todo: use resources for these distinct actions
    scope "/lists" do
      get "/user_comments/:user_id", ListController, :my_comments
      get "/my_comments", ListController, :my_comments
      get "/recent_comments", ListController, :recent_comments
    end
    resources "/lists", ListController, only: [:index]

    # Activity
    resources "/activity", ActivityController, only: [:show], singleton: true

    # Notifications
    resources "/notifications", NotificationController, only: [:index]

    # Settings
    resources "/settings", SettingController, only: [:edit, :update], singleton: true

    # Search
    scope "/search", Search do
      resources "/reverse", ReverseController, only: [:show, :create], singleton: true
      resources "/syntax", SyntaxController, only: [:show], singleton: true
    end
    resources "/search", SearchController, only: [:index]

    scope "/conversations", Conversations do
      resources "/hide_batch", HideBatchController, only: [:create], singleton: true
    end
    resources "/conversations", ConversationController do
      scope alias: Conversations do
        resources "/hide", HideController, only: [:create, :delete]
        resources "/read", ReadController, only: [:create, :delete]
        resources "/messages", MessageController, only: [:new, :create]
      end
    end

    resources "/duplicate_reports", DuplicateReportController, except: [:update] do
      scope alias: DuplicateReports do
        resources "/accept", AcceptController, only: [:create], singleton: true
        resources "/accept_reverse", AcceptReverseController, only: [:create], singleton: true
        resources "/claim", ClaimController, only: [:create], singleton: true
        resources "/reject", RejectController, only: [:create], singleton: true
      end
    end

    scope "/images", Images do
      resources "/watched", WatchedController, only: [:show], singleton: true
      resources "/preview", PreviewController, only: [:create], singleton: true
    end
    resources "/images", ImageController do
      scope alias: Images do
        resources "/comment_lock", CommentLockController, only: [:create, :delete], singleton: true
        resources "/description_lock", DescriptionLockController, only: [:create, :delete], singleton: true
        resources "/description", DescriptionController, only: [:update], singleton: true
        resources "/feature", FeatureController, only: [:create], singleton: true
        resources "/file", FileController, only: [:update], singleton: true
        resources "/hash", HashController, only: [:delete], singleton: true
        resources "/hide", HideController, only: [:create, :update, :delete], singleton: true
        resources "/related", RelatedController, only: [:show], singleton: true
        resources "/repair", RepairController, only: [:create], singleton: true
        resources "/reporting", ReportingController, only: [:show], singleton: true
        resources "/scratchpad", ScratchpadController, only: [:edit, :update], singleton: true
        resources "/source_history", SourceHistoryController, only: [:delete], singleton: true
        resources "/source", SourceController, only: [:update], singleton: true
        resources "/tag_lock", TagLockController, only: [:create, :delete], singleton: true
        resources "/tags", TagController, only: [:update], singleton: true
        resources "/uploader", UploaderController, only: [:update], singleton: true

        resources "/favorites", FavoriteController, only: [:index]
        resources "/source_changes", SourceChangeController, only: [:index]
        resources "/tag_changes", TagChangeController, only: [:index]
        resources "/votes", VoteController, only: [:delete]

        resources "/comments", CommentController do
          scope alias: Comments do
            resources "/hide", HideController, only: [:create, :delete], singleton: true
            resources "/history", HistoryController, only: [:show], singleton: true
          end
        end
      end
    end

    # oEmbed API
    resources "/oembed", OembedController, only: [:show], singleton: true

    resources "/reports", ReportController, only: [:index, :new, :create]

    scope "/tags", Tags do
      resources "/autocomplete", AutocompleteController, only: [:show], singleton: true
      resources "/aliases", AliasController, only: [:index]
      resources "/ratings", RatingController, only: [:index]
    end
    resources "/tags", TagController do
      scope alias: Tags do
        resources "/watch", WatchController, only: [:create, :delete], singleton: true
        resources "/usage", UsageController, only: [:show], singleton: true
        resources "/tag_changes", TagChangeController, only: [:index]
      end
    end

    resources "/comments", CommentController, only: [:index]

    scope "/tag_changes", TagChanges do
      resources "/mass_revert", MassRevertController, only: [:delete]
    end
    resources "/tag_changes", TagChangeController
    resources "/source_changes", SourceChangeController

    resources "/adverts", AdvertController, only: [:show]

    resources "/galleries", GalleryControllers do
      scope alias: Galleries do
        resources "/random", RandomController, only: [:show], singleton: true
        resources "/order", OrderController, only: [:update], singleton: true
        resources "/images", ImageController, only: [:create, :delete]
      end
    end

    resources "/commissions", CommissionController do
      resources "/items", Commissions.ItemController
    end

    resources "/user_links", UserLinkController

    scope "/admin", Admin do
      resources "/forums", ForumController
      resources "/mod_notes", ModNoteController
      resources "/user_bans", UserBanController
      resources "/whitelists", WhitelistController
      resources "/subnet_bans", SubnetBanController
      resources "/fingerprint_bans", FingerprintBanController
      resources "/site_notices", SiteNoticeController
      resources "/adverts", AdvertController

      resources "/badges", BadgeController do
        resources "/users", Badges.UserController, only: [:index]
      end

      resources "/users", UserController do
        scope alias: Users do
          resources "/activation", ActivationController, only: [:create, :delete], singleton: true
          resources "/api_key", ApiKeyController, only: [:delete], singleton: true
          resources "/wipe", WipeController, only: [:create], singleton: true
        end
      end

      resources "/user_links", UserLinkController do
        resources "/transition", UserLinks.TransitionController, only: [:create], singleton: true
      end

      resources "/tags", TagController do
        scope alias: Tags do
          resources "/reindex", ReindexController, only: [:create], singleton: true
          resources "/slug", SlugController, only: [:create], singleton: true
        end
      end

      resources "/reports", ReportController do
        scope alias: Reports do
          resources "/close", CloseController, only: [:create, :delete], singleton: true
          resources "/claim", ClaimController, only: [:create, :delete], singleton: true
        end
      end

      resources "/dnp_entries", DnpEntryController do
        resources "/transition", DnpEntries.TransitionController, only: [:create], singleton: true
      end

      scope "/donations", Donations do
        resources "/users", UserController, only: [:show]
      end
      resources "/donations", DonationController

      scope "/batch", Batch do
        resources "/tags", TagController, only: [:update]
      end

      resources "/polls", PollController, only: [:edit, :update, :delete] do
        resources "/votes", Polls.VotesController, only: [:delete]
      end
    end

    resources "/ip_profiles", IpProfileController, only: [:show] do
      scope alias: IpProfiles do
        resources "/tag_changes", TagChangeController, only: [:index]
        resources "/source_changes", SourceChangeController, only: [:index]
      end
    end

    resources "/fingerprint_profiles", FingerprintProfileController, only: [:show] do
      scope alias: FingerprintProfiles do
        resources "/tag_changes", TagChangeController, only: [:index]
        resources "/source_changes", SourceChangeController, only: [:index]
      end
    end

    resources "/captchas", CaptchaController, only: [:create]

    resources "/pages", StaticPageController do
      resources "/versions", StaticPages.VersionController, only: [:index]
    end

    resources "/staff", StaffController, only: [:show], singleton: true
    resources "/spoiler_type", SpoilerTypeController, only: [:update], singleton: true
    resources "/changelog", ChangelogController, only: [:show], singleton: true

    get "/", ActivityController, :index

    """
      TODO: add glob router to handle the following vanity routes:

      constraints(id: /[0-9]+/) do
        get '/:id' => 'images#show', :as => 'short_image'
        get '/next/:id' => 'images#navigate', :as => 'next_image', :do => 'next'
        get '/prev/:id' => 'images#navigate', :as => 'prev_image', :do => 'prev'
        get '/find/:id' => 'images#navigate', :as => 'find_image', :do => 'find'
      end
      constraints(id: /[a-z]+/) do
        get ':id', controller: 'forums', action: 'show'
        get '/:id' => 'forums#show', as: 'short_forum'
      end
      constraints(forum_id: /(?!users)(?!pages)(?!thumbs)(?!media)[a-z]+/) do
        get '/:forum_id/:id' => 'topics#show', as: 'short_topic'
        get '/forums/:forum_id/:id' => 'topics#show'
        get '/:forum_id/topics/:id' => 'topics#show'

        get '/:forum_id/:id/last' => 'topics#show_last_page'
        get '/forums/:forum_id/topics/:id/last' => 'topics#show_last_page'
        get '/:forum_id/topics/:id/last' => 'topics#show_last_page'

        constraints(page: /[0-9]+/) do
          get '/:forum_id/:id/:page' => 'topics#show'
          get '/:forum_id/topics/:id/:page' => 'topics#show'
        end

        get '/:forum_id/:id/post/:post_id' => 'topics#show', as: 'short_topic_post'
        get '/:forum_id/topics/:id/post/:post_id' => 'topics#show'
      end
    """
  end
end
