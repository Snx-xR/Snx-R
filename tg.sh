function start() {
  ./telegram-bot-api-binary --api-id=15867628 --api-hash=78af1601f50c0b9c2db60c7a40b9bf35 -p 38118 --local 2>&1 > /dev/null &
  sleep 5
}
start
curl http://127.0.0.1:38118/ || start
curl http://127.0.0.1:38118/ || start
curl http://127.0.0.1:38118/ || start
curl http://127.0.0.1:38118/ || start
# curl https://gist.githubusercontent.com/Sa-Sajjad/ed4c268fda0729776769f456a7c2a24e/raw/s2.py -o fuk.py
python3 test.py ci
pkill telegram-bot