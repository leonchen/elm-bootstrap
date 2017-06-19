const Elm = require('./Main.elm');
const node = document.getElementById('main');
const app = Elm.Main.embed(node);

app.ports.setWindowSize.subscribe((dimension) => {
  console.log(dimension);
})

window.addEventListener('resize', () => {
  const w = window.innerWidth;
  const h = window.innerHeight;
  app.ports.getWindowSize.send([w, h]);
});
