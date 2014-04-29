== Installing the required Gems ==

    $ bundle install

== Installing Protocol Buffers (for Unix / Linux / Mac) ==

Go [here](https://code.google.com/p/protobuf/downloads/list), and download the full source of your choice (I'm currently using v2.5.0).

    $ cd /the/path/where/you/extracted/that/folder/protobuf-2.5.0
    $ ./configure
    $ make
    $ make check
    $ make install
    $ protoc --version
      ^ should say "libprotoc 2.5.0"

From ProtoBuf's readme:

    If "make check" fails, you can still install, but it is likely that
    some features of this library will not work correctly on your system.
    Proceed at your own risk.

With protoc installed, you can now generate `gtfs-realtime.pb.rb` from `gtfs-realtime.proto` by running

    protoc --beefcake_out . -I . gtfs-realtime.proto

== Installing Protocol Buffers (for Windows) ==

i dunno lol
