use Mix.Config

# This is standard path in the context of ejabberd release
config :ejabberd,
  file: "/Users/mremond/devel/p1/ejabberd/ejabberd/config/ejabberd.yml",
  log_path: '/Users/mremond/devel/p1/ejabberd/ejabberd/log/ejabberd.log'

# Customize Mnesia directory:
config :mnesia,
  dir: '/Users/mremond/devel/p1/ejabberd/ejabberd/mnesiadb/'
