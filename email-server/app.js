const express = require("express");
const dotenv = require("dotenv");
const nodemailer = require("nodemailer");
const bodyParser = require("body-parser");

dotenv.config();

const port = process.env.port;

const app = express();
app.use(bodyParser.json());

app.use("/error-report", async (req, res) => {
  try {
    const mailer = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: process.env.email,
        pass: process.env.email_password,
      },
    });
    const mail = {
      from: process.env.email,
      to: process.env.error_email,
      subject: "Error",
      text: JSON.stringify(req.body),
    };
    await mailer
      .sendMail(mail)
      .then((data) => {
        console.log(data);
      })
      .catch((err) => {
        console.log(err);
      });
    return res.status(200).send({
      message: "Success",
      error: null,
    });
  } catch (error) {
    return res.status(400).send({
      message: "Failed",
      error: error.message,
    });
  }
});

app.listen(port, () => {
  console.log("Server started at " + port);
});
