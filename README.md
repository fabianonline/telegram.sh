# telegram.sh

## What does it do?

Telegram offers the feature of bots. A bot allows automated systems and
servers to send telegram messages to users.
Quite often it can be useful to send stuff to yourself. A classic
application of this would be receiving results of cronjob tasks via email.
Or maybe you want to grab a small file from your server, but downloading it
via SCP would be too much work or wouldn't work at all because firewall
stuff / filters / proxy servers / whatever.

telegram.sh allows you to send such things via telegram.

## Examples

```bash
# Send a message to yourself, using a bot token and a chat_id.
telegram -t 123456:AbcDefGhi-JklMnoPrw -c 12345 "Hello, World."

# You can define the token and chat_id in environment variables or config files.
# Then you can just use
telegram "Hello, World."

# Split them into multiple lines
telegram "Hello,"$'\n'"World."
# or
echo -e "Hello\nWorld." | telegram -

# Or you send this one message to another chat:
telegram -c 6789 "Hello, Mars."

# You can also send messages to multiple chats:
telegram -c 1234 -c 6789 "Hello, Planets."

# Send stuff via stdin. It will automatically be sent as monospace code:
ls -l | telegram -

# Use markdown in your message (HTML is available as well):
telegram -M "To *boldly* go, where _no man_ has gone before."

# Send a local file.
telegram -f results.txt "Here are the results."

# Or an image, giving you a preview and stuff.
telegram -i solar_system.png # We don't need to send a message if we're
# sending a file.

# Use environment variables to tell curl to use a proxy server:
HTTPS_PROXY="socks5://127.0.0.1:1234" telegram "Hello, World."
# Check the curl documentation for more info about supported proxy
# protocols.
```

## Requirements

Only `bash` and `curl`. Listing known chats with `-l` requires `jq`, but you can
easily use this tool without this.

## Installation / configuration

* Grab the latest `telegram` file from this repository and put it somewhere.
* Create a bot at telegram:
  * Search for the user `@botfather` at telegram and start a chat with him.
  * Use the `/newbot` command to create a new bot. BotFather will give you a
    token. Keep this.
* Use your telegram client to send a message to your new bot. Any message
    will do.
* Find your chat id. Run telegram.sh with `-l`: `telegram -t
    <TOKEN> -l`. If you have `jq` installed, it will nicely list its known chats. The number at the front is
    your chat id. If you don't have `jq` installed, it will print a bit of
    JSON data and tell you what to look for.
* You now have your token and your chat id. Send yourself a first message:
    `telegram -t <TOKEN> -c <CHAT ID> "Hello there."`

Carrying the token and the chat id around can be quite cumbersome. You can
define them in 4 different ways:

1. In a file `/etc/telegram.sh.conf`.
2. In a file `~/.telegram.sh`.
3. In environment variables TELEGRAM_TOKEN and TELEGRAM_CHAT.
4. As seen above as parameters.

Later variants overwrite earlier variants, so you could define token and
chat in `/etc/telegram.sh.conf` and then overwrite the token with your own
in `~/.telegram.sh` or on the command line.

The files should look like this:

```bash
TELEGRAM_TOKEN="123456:AbcDefGhi-JlkMno"
TELEGRAM_CHAT="12345678"
```

Please be aware that you should keep your token a secret.

You can also add permanent proxy settings in there by adding:

```bash
export HTTPS_PROXY="socks5://127.0.0.1:1234"
```

See the curl documentation for more information about which proxy protocols
are supported.
