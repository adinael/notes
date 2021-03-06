
# start sbt fast
sbt "set skip in update := true" compile

# enable remote debugging
sbt -J-Xdebug -J-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 run

# display dependency tree
sbt "inspect tree clean"

# install libs locally
set offline := true
publishM2
publishLocal

# run with a custom config (for typesafe config)
sbt -Dconfig.resource="custom.conf" run

# exclude files from compiling
excludeFilter := HiddenFileFilter || "example*"

# allows `sbt console` import packages without a fatal warning due to unused imports
scalacOptions in (Compile, console) ~= (_ filterNot (_ == "-Ywarn-unused-import"))

# exclude transitive dependencies while importing a library
libraryDependencies += "com.twitter" %% "finagle-thriftmux" % "6.16.0" exclude("org.slf4j", "slf4j-jdk14")
