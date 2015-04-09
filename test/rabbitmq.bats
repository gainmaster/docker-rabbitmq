setup() {
  docker history bachelorthesis/rabbitmq >/dev/null 2>&1
}

@test "pacman cache is empty" {
  run docker run --entrypoint=/bin/bash bachelorthesis/rabbitmq -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}
