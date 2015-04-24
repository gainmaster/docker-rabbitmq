setup() {
  docker history gainmaster/rabbitmq >/dev/null 2>&1
}

@test "pacman cache is empty" {
  run docker run --rm gainmaster/rabbitmq -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}
