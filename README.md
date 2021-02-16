# andesite-repl
Andesite on replit
<br>
<a href="https://repl.it/github/kagchi/lavalink-repl"><img src="https://img.shields.io/badge/REPL-FORK-green"></a>
## Connecting
- [x] Andesite port will always 443 
- [x] Default password `null`

## Important notes:
- [x] To keep this 24/7 you need to make an account on UptimeRobot service, and make HTTP request to your app every 5 minutes. For example, if your app is named `andesite-repl` and your repl username is `ahmasa` then make HTTP request to `https://andesite-repl.ahmasa.repl.co`
- [x] Do not forget to set your password (in `application.conf` file)

## Advantages:
- [x] Easy setup

## Example:
- [x] Lavacord
```js
const { Manager } = require("lavacord");
const nodes = [
    { id: "1", host: "andesite-repl.ahmasa.repl.co", port: 443 }
];
const manager = new Manager(nodes, {
    user: client.user.id, // Client id
    shards: shardCount, // Total number of shards your bot is operating on
    send: (packet) => {
        // this needs to send the provided packet to discord using the method from your library. use the @lavacord package for the discord library you use if you don't understand this
    }
});

//...
```
