//Code originally written by Allvaa
const { default: { stream } } = require("got");
const { createWriteStream } = require("fs");
const { execSync } = require("child_process");

const url = "https://github.com/natanbc/andesite/releases/download/0.20.1-2/andesite-0.20.1-all.jar";

const start = () => {
    const download = stream(url).pipe(createWriteStream('Andesite.jar'));
    download.on("finish", () => {
        execSync("java -jar Andesite.jar", { stdio: "inherit" });
    });
};

start();
