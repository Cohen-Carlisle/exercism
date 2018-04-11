var TwoFer = function () {};

TwoFer.prototype.twoFer = function (who) {
  who = (typeof who === "undefined") ? "you" : who;
  return "One for " + who + ", one for me.";
};

module.exports = TwoFer;
