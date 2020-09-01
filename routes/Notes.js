const express = require("express");
const router = express.Router();
const database = require("../database");
const jwt = require("jsonwebtoken");

//AUTHENTICATE MIDDLEWARE FOR THE JSONWEBTOKEN
function authenticate(req, res, next) {
  console.log(req.session.token);
  const token = req.session.token;
  if (token == null) return res.sendStatus(401);

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
  });
  next();
}
module.exports = () => {
  //GET ALL THE BEERS
  router.post("/", authenticate, (req, res) => {
    const note = req.body;
    note.user_id = req.user.id;
    database.getNote(req.user.id, req.body.beer_id).then((existingnote) => {
      if (existingnote) {
        database.updateNote(note).then((data) => res.send({ data }));
      } else {
        database.addNote(note).then((data) => res.send({ data }));
      }
    });
  });

  router.get("/:id", authenticate, (req, res) => {
    database
      .getNote(req.user.id, req.params.id)
      .then((data) => res.send({ data }));
  });

  return router;
};
