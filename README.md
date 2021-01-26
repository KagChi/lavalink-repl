# lavalink-repl
Lavalink on replit

## Connecting
- [x] Lavalink's port will always 80
- [x] Default password `youshallnotpass`
 

## Important notes:
- [x] To keep this 24/7 you need to make an account on UptimeRobot service, and make HTTP request to your app every 5 minutes. For example, if your app is named `lavalink-repl` and your repl username is `ahmasa` then make HTTP request to `https://lavalink-repl.ahmasa.repl.co`
- [x] Do not forget to set your password (in `application.yml` file)

## Advantages:
- [x] Use java 13 :3
- [x] Easy setup
- [x] Using Dev build

## Example:
- [x] Lavacord
```js
const { Manager } = require("lavacord");
const nodes = [
    { id: "1", host: "https://lavalink-repl.ahmasa.repl.co", port: 80, password: "youshallnotpass" }
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
