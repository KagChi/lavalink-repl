# lavalink-repl
Lavalink on replit
<br>
<a href="https://repl.it/github/kagchi/lavalink-repl"><img src="https://img.shields.io/badge/REPL-FORK-green"></a>
## Connecting
- [x] Lavalink's port will always 443
- [x] Default password `youshallnotpass`
- [x] using custom lavalink client

## Important notes:
- [x] To keep this 24/7 you need to make an account on UptimeRobot service, and make HTTP request to your app every 5 minutes. For example, if your app is named `lavalink-repl` and your repl username is `ahmasa` then make HTTP request to `https://lavalink-repl.ahmasa.repl.co`
- [x] Do not forget to set your password (in `application.yml` file)

## Advantages:
- [x] Use java 13 :3
- [x] Easy setup
- [x] Using Dev build
## Glitch
- for glitch user here [Repo](https://github.com/KagChi/lavalink-glitch)

## Example:
- [x] Lavacord
```js
const { Manager } = require("lavacord");
const nodes = [
    { id: "1", host: "lavalink-repl.ahmasa.repl.co", port: 443, password: "youshallnotpass" }
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

- [x] Latest Shoukaku (V1.6.1)
```js
const { Client } = require('discord.js');
const { Shoukaku } = require('shoukaku');
 
const LavalinkServer = [{ name: 'my-lavalink-server', host: 'lavalink-repl.ahmasa.repl.co', port: 443, auth: 'youshallnotpass', secure: true }];
const ShoukakuOptions = { moveOnDisconnect: false, resumable: false, resumableTimeout: 30, reconnectTries: 2, restTimeout: 10000 };
 
class ExampleBot extends Client {
    constructor(opts) {
        super(opts);
        this.shoukaku = new Shoukaku(this, LavalinkServer, ShoukakuOptions);
    }
 
    login(token) {
        this._setupShoukakuEvents();
        this._setupClientEvents();
        return super.login(token);
    }
 
    _setupShoukakuEvents() {
        this.shoukaku.on('ready', (name) => console.log(`Lavalink ${name}: Ready!`));
        this.shoukaku.on('error', (name, error) => console.error(`Lavalink ${name}: Error Caught,`, error));
        this.shoukaku.on('close', (name, code, reason) => console.warn(`Lavalink ${name}: Closed, Code ${code}, Reason ${reason || 'No reason'}`));
        this.shoukaku.on('disconnected', (name, reason) => console.warn(`Lavalink ${name}: Disconnected, Reason ${reason || 'No reason'}`));
    }
 
    _setupClientEvents() {
        this.on('message', async (msg) => {
            if (msg.author.bot || !msg.guild) return;
            if (!msg.content.startsWith('$play')) return;
            if (this.shoukaku.getPlayer(msg.guild.id)) return;
            const args = msg.content.split(' ');
            if (!args[1]) return;
            const node = this.shoukaku.getNode();
            let data = await node.rest.resolve(args[1]);
            if (!data) return;
            const player = await node.joinVoiceChannel({
                guildID: msg.guild.id,
                voiceChannelID: msg.member.voice.channelID
            }); 
            player.on('error', (error) => {
                console.error(error);
                player.disconnect();
            });
            for (const event of ['end', 'closed', 'nodeDisconnect']) player.on(event, () => player.disconnect());
            data = data.tracks.shift();
            await player.playTrack(data); 
            await msg.channel.send("Now Playing: " + data.info.title);
        });
        this.on('ready', () => console.log('Bot is now ready'));
    }
}
 
new ExampleBot()
    .login('token')
    .catch(console.error);
```
Example bot [here](https://github.com/KagChi/noteblock)
