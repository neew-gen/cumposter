trimTextFromEnd(text, textMaxLength) {
  if (text.length > textMaxLength + 3) {
    var trimStart = text.length - textMaxLength;
    var trimEnd = text.length;
    return '...${text.substring(trimStart, trimEnd)}';
  } else {
    return text;
  }
}