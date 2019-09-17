### maven plugin for unit test coverage report ###

```shell
mvn -B org.codehaus.mojo:cobertura-maven-plugin:2.7:cobertura -Dmaven.test.failure.ignore=true
```

### Ignore test coverage for a specified module(eg,api or dal module) ###
```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>cobertura-maven-plugin</artifactId>
  <version>2.7</version>
  <configuration>
    <skip>true</skip>
  </configuration>
</plugin>
```
