```java
public class TestDo{
  private String name;
  public String getName(){return name;}
  public void setName(String name){System.out.println(name);this.name=name;}
}

@Bean
public TestDo testDo(){
  TestDo d =new TestDo();
  d.setName("a");
  return d;
}

//BeanFactoryPostProcessor
BeanDefinition testDoBeanDefinition = beanFactory.getBeanDefinition("testDo");
MutablePropertyValues propertyValues = testDoBeanDefinition.getPropertyValues();
propertyValues.add("name", "b");

//BeanPostProcessor
if(bean instanceof TestDo){
  TestDo d = (TestDo) bean;
  d.setName("c");
}

```

exexute result:
a
<br>
b
<br>
c
