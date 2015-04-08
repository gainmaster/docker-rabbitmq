setup() {
  docker history bachelorthesis/nginx >/dev/null 2>&1
}

@test "pacman cache is empty" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "nginx binary is found in $PATH" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "which nginx"
  [ "$status" -eq 0 ]
}

@test "installs NGINX 1.6.2" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "/usr/sbin/nginx -v"
  [[ "$output" =~ "1.6.2"  ]]
}

@test "configuration file is ok" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "nginx -t"
  [ $status -eq 0 ]
}

@test "server root folder present" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "stat /srv/http"
  [ $status -eq 0 ]
}

@test  "server root folder correct owner" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "stat -c %U /srv/http/"
  [ "$output" = "http" ]
}

@test  "server root folder correct permissions" {
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "stat -c %a /srv/http/"
  [ "$output" = "755" ]
}

@test "logs to STDOUT" {
  skip "This command will return zero soon, but not now"
  run docker run --entrypoint=/bin/bash bachelorthesis/nginx -c "curl localhost > /dev/null 2>&1"
  [ $status -eq 0 ]
}