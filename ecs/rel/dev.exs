use Mix.Config

# This is standard path in the context of ejabberd release
config :ejabberd,
  file: "/home/p1/ejabberd/config/ejabberd.yml",
  log_path: '/home/p1/ejabberd/log/ejabberd.log'

# Customize Mnesia directory:
config :mnesia,
  dir: '/home/p1/ejabberd/database/'
