ohai_section_begin "development libraries"

paru -S --needed --noconfirm base-devel pkgconf clang patch \
  openssl readline libyaml ncurses gdbm jemalloc libvips imagemagick graphicsmagick mupdf mupdf-tools gtop clutter \
  redis sqlite3 mariadb-clients libpqxx postgresql-libs pgcli llvm lldb lld dotnet-host dotnet-runtime

ohai_section_end "development libraries"
