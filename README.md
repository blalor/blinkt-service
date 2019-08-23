# blinkt-service

This is a little HTTP server that controls a [blinkt](https://shop.pimoroni.com/products/blinkt), a small set of RGB LEDs attached to a Raspberry Pi.  It listens on a unix domain socket and accepts `PUT` requests to `/led/<N>` with a JSON payload containing the RGB values of the LEDs and an overall brightness value from 0-1.

Start the service like `blinkt-service --socket-path=/run/blinkt.sock` and then use `curl` to make it shine:

```
curl -sfS \
    --unix-socket /run/blinkt.sock \
    --max-time 5 \
    --request PUT \
    --data '{
        "red":        255,
        "green":      0,
        "blue":       0,
        "brightness": 0.5
    }' \
    http://blinkt/led/1
```
