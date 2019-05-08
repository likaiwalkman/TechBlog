### Reference:
https://www.baeldung.com/spring-security-csrf

Form Submit CSRF demo:
```js
function post(URL) {
  var temp = document.createElement("form");
  temp.action = URL;
  temp.method = "post";
  temp.style.display = "none";
  var input1 = document.createElement("input");
  input1.name = "aaa"
  input1.value = "bbb"
  temp.appendChild(input1);
  document.body.appendChild(temp);
  temp.submit();
  return temp;
}
post("http://localhost:8080/post_path");
```
