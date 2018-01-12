use Mix.Config

# This is standard path in the context of ejabberd release
config :ejabberd,
  file: "/home/ejabberd/conf/ejabberd.yml",
  log_path: '/home/ejabberd/logs/ejabberd.log'

# Customize Mnesia directory:
config :mnesia,
  dir: '/home/ejabberd/database/'
