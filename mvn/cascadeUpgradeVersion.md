```xml
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>versions-maven-plugin</artifactId>
                <version>2.2</version>
            </plugin>
```

```shell
#!/usr/bin/sh

mvn versions:set -DnewVersion=`cat project.version`
mvn versions:commit
```
