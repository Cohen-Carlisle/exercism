module.exports = function (string) {
  reverse = "";
  for(i = string.length - 1; i >= 0; i--) {
    reverse = reverse + string[i];
  }
  return reverse;
};
