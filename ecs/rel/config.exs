use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set config: "rel/dev.exs"
  set cookie: :"!Vcuwp?y@d{7=`5Ha*2*PLw:i8;i:9B|tq75|K]kt?T]_nap/or,7xBylYJ!N;m{"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set config: "rel/prod.exs"
  set cookie: :"HmewW_sUao={>LXTD8,g;xBu`.i]tq7Dz.m2?ZqO<g1Iz}?L(36T%w,Zz,)gHp$^"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :ejabberd do
  set version: current_version(:ejabberd)
end

