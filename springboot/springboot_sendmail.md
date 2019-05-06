### Java 代码
```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

@SpringBootApplication
@Component
public class App {
    public static void main( String[] args ) {
        SpringApplication.run(App.class, args);

    }
    @Autowired
    private JavaMailSender javaMailSender;

    @PostConstruct
    public void init() throws MessagingException, UnsupportedEncodingException {

        System.out.println(javaMailSender);

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        messageHelper.setFrom("abc@163.com", "abc");
        messageHelper.setSubject("Mail Topic Name1");
        messageHelper.setTo(new String[]{"abc@qq.com"});
        messageHelper.setText("Hello, haha!");
        javaMailSender.send(mimeMessage);
    }
}
```
### Spring boot配置
```
spring.mail.host=smtp.163.com
spring.mail.username=abc@163.com
spring.mail.password=abc
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.starttls.required=true
```

### Maven 依赖
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```
