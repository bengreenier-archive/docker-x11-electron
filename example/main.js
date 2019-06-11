const electron = require("electron");

electron.app.on("ready", () => {
  const bw = new electron.BrowserWindow();
  bw.on("show", () => {
    console.log("showing window");
  });
  bw.show();
});
