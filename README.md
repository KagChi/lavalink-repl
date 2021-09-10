# lavalink-repl
Lavalink on replit
<br>
<a href="https://replit.com/github/kagchi/lavalink-repl"><img src="https://img.shields.io/badge/REPL-FORK-green"></a>
## Connecting
- [x] Lavalink's port will always 443 
- [x] Default password `youshallnotpass`
- [x] using custom lavalink client if your client doesnt support secure options


## Important notes:
- [x] Do not change port in `application.yml`
- [x] To keep this 24/7 you need to make an account on UptimeRobot service, and make HTTP request to your app every 5 minutes. For example, if your app is named `lavalink-repl` and your repl username is `ahmasa` then make HTTP request to `https://lavalink-repl.ahmasa.repl.co`
- [x] Do not forget to set your password (in `application.yml` file)
- [x] Connection to node must be secured E.g https/wss
## Advantages:
- [x] Use java 13 :3
- [x] Easy setup
- [x] Using Dev build
## Glitch
- for glitch user here [Repo](https://github.com/KagChi/lavalink-glitch)

## Example
- [x] Latest Shoukaku (v1.6.x)
```js
const { Client } = require('discord.js');
const { Shoukaku, Libraries } = require('shoukaku');

const LavalinkServer = [{ name: 'my-lavalink-server', url: 'lavalink-repl.ahmasa.repl.co:443', auth: 'youshallnotpass', secure: true }];
const ShoukakuOptions = { moveOnDisconnect: false, resumable: false, resumableTimeout: 30, reconnectTries: 2, restTimeout: 10000 };

class ExampleBot extends Client {
    constructor(opts) {
        super(opts);
        this.shoukaku = new Shoukaku(new Libraries.DiscordJS(client), LavalinkServer, ShoukakuOptions);
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
        this.on('messageCreate', async (msg) => {
            if (msg.author.bot || !msg.guild) return;
            if (!msg.content.startsWith('$play')) return;
            if (this.shoukaku.players.get(msg.guild.id)) return;
            const args = msg.content.split(' ');
            if (!args[1]) return;
            const node = this.shoukaku.getNode();
            let data = await node.rest.resolve(args[1]);
            if (!data) return;
            const player = await node.joinChannel({
                guildId: msg.guild.id,
                shardId: msg.guild.shardId,
                channelId: msg.member.voice.channelId
            });
            const events = ['end', 'error', 'closed', 'disconnect'];
            for (const event of events) {
                player.on(event, info => {
                    console.log(info);
                    player.disconnect();
                });
            }
            data = data.tracks.shift();
            player.playTrack(data); 
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
