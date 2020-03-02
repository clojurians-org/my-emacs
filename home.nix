{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

  home.packages = [
    pkgs.coreutils
    pkgs.inetutils
    pkgs.findutils
    pkgs.gnused
    pkgs.less

    pkgs.tmux
    pkgs.emacs
    pkgs.vim
    pkgs.cloc
    pkgs.git
    pkgs.gitAndTools.gitSVN
    pkgs.cachix

    pkgs.jre
    pkgs.cabal-install
    pkgs.obelisk
    pkgs.yarn
    pkgs.gradle
    pkgs.clojure
    pkgs.lombok
    pkgs.clang-tools
    pkgs.dhall
    pkgs.python38
    # pkgs.vue
    pkgs.maven

    pkgs.tree
    pkgs.jq
    pkgs.avro-tools
    pkgs.curl
    pkgs.wget
    pkgs.ws
    pkgs.aria2
    pkgs.wrk
    pkgs.unzip
    pkgs.xz

    pkgs.pandoc
    pkgs.privoxy

    pkgs.kafkacat
    # pkgs.apacheKafka
    pkgs.postgresql
    pkgs.minio
    pkgs.minio-client
    pkgs.neo4j
    # pkgs.clickhouse (no-darwin)
    pkgs.cassandra

    # pkgs.imagemagick
    # pkgs.shadowsocks-libev
  ];
}
