# SpringMVC 설정



## XML 설정

- spring version 수정: 5.0.7

```xml
<properties>
    <java-version>1.8</java-version>
    <org.springframework-version>5.0.7.RELEASE</org.springframework-version>
    <org.aspectj-version>1.6.10</org.aspectj-version>
    <org.slf4j-version>1.6.6</org.slf4j-version>
</properties>
```

- lombok 추가

```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>${org.springframework-version}</version>
    <scope>test</scope>
</dependency>
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.0</version>
    <scope>provided</scope>
</dependency>
```

- servlet version 3.0 이상 설정

```xml
<!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
</dependency>
```

- maven 컴파일 옵션 1.8 버전으로 변경하고 'maven -  update project'

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>2.5.1</version>
    <configuration>
        <source>1.8</source>
        <target>1.8</target>
        <compilerArgument>-Xlint:all</compilerArgument>
        <showWarnings>true</showWarnings>
        <showDeprecation>true</showDeprecation>
    </configuration>
</plugin>
```



---



## Java 설정

- web.xml, servlet-context.xml, root-context.xml 삭제

- pom.xml 에 web.xml 이 없다는 설정을 추가

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.0</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>
```

- src/main/java 밑에 org.zerock.config 패키지 생성

  - RootConfig 클래스 생성

  ```java
  package org.zerock.config;
  
  import org.springframework.context.annotation.Configuration;
  
  @Configuration
  public class RootConfig {
  
  }
  ```

  - WebConfig 클래스 생성

  ```java
  package org.zerock.config;
  
  import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
  // 상속받아야 할 클래스가 import 안뜰 경우 스프링 버전 확인!
  
  public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
  
  	@Override
  	protected Class<?>[] getRootConfigClasses() {
  		return new Class[] {RootConfig.class};
  	}
  
  	@Override
  	protected Class<?>[] getServletConfigClasses() {
  		// TODO Auto-generated method stub
  		return null;
  	}
  
  	@Override
  	protected String[] getServletMappings() {
  		// TODO Auto-generated method stub
  		return null;
  	}
  	
  }
  ```

  - ServletConfig 클래스 생성

  ```java
  package org.zerock.config;
  
  import org.springframework.context.annotation.ComponentScan;
  import org.springframework.web.servlet.config.annotation.EnableWebMvc;
  import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
  import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
  import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
  import org.springframework.web.servlet.view.InternalResourceViewResolver;
  import org.springframework.web.servlet.view.JstlView;
  
  @EnableWebMvc
  @ComponentScan(basePackages= {"org.zerock.controller"})
  public class ServletConfig implements WebMvcConfigurer {
  	
  	@Override
  	public void configureViewResolvers(ViewResolverRegistry registry) {
  		InternalResourceViewResolver bean = new InternalResourceViewResolver();
  		bean.setViewClass(JstlView.class);
  		bean.setPrefix("/WEB-INF/views/");
  		bean.setSuffix(".jsp");
  		registry.viewResolver(bean);
  	}
  	
  	@Override
  	public void addResourceHandlers(ResourceHandlerRegistry registry) {
  		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
  	}
  }
  ```

  - WebConfig.java 에 ServletConfig 정보를 추가한다.

  ```java
  package org.zerock.config;
  
  import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
  
  public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
  
  	@Override
  	protected Class<?>[] getRootConfigClasses() {
  		return new Class[] {RootConfig.class};
  	}
  
  	@Override
  	protected Class<?>[] getServletConfigClasses() {
  		return new Class[] {ServletConfig.class};
  	}
  
  	@Override
  	protected String[] getServletMappings() {
  		return new String[] { "/" };
  	}
  }
  ```

  