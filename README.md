# ssm--- spring + spring mvc +mybatis 框架整合

maven项目 实现 spring mybatis 两个框架整合
------------------------------------------------------------------------------------
1、maven项目
	
	src
		main
			java java源文件
			resources 配置文件
				beans.xml spring配置文件
					<?xml version="1.0" encoding="UTF-8"?>
					<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
					       xmlns:context="http://www.springframework.org/schema/context"
					       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
					       xsi:schemaLocation="http://www.springframework.org/schema/beans
					http://www.springframework.org/schema/beans/spring-beans-4.3.xsd
					http://www.springframework.org/schema/context
					http://www.springframework.org/schema/context/spring-context-4.3.xsd
					http://www.springframework.org/schema/aop
					http://www.springframework.org/schema/aop/spring-aop-4.3.xsd
					http://www.springframework.org/schema/tx
					http://www.springframework.org/schema/tx/spring-tx-4.3.xsd">

					    <context:component-scan base-package="com.entity"/>
					    <!-- 引入配置文件 -->
					    <bean id="propertyConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
						<property name="location" value="classpath:db.properties"/>
					    </bean>

					    <!-- 使用spring jdbc中的类建立数据源 -->
					    <bean id="ds" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
						<property name="driverClassName" value="${db.driver}"/>
						<property name="url" value="${db.url}"/>
						<property name="username" value="${db.user}"/>
						<property name="password" value="${db.password}"/>
					    </bean>
					    <!-- SqlSessionFactory -->
					    <bean id="sf" class="org.mybatis.spring.SqlSessionFactoryBean">
						<property name="dataSource" ref="ds"/>
						<!-- com.entity.Student 可以写 sutdent -->
						<property name="typeAliasesPackage" value="com.entity"/>
						<property name="mapperLocations" value="classpath:com/entity/mapper/*Mapper.xml"/>
					    </bean>
					    <!-- SqlSession -->
					    <bean id="session" class="org.mybatis.spring.SqlSessionTemplate">
						<constructor-arg index="0" ref="sf" />
					    </bean>

					    <!--创建数据映射器，数据映射器必须为接口 -->
					    <!--
					    <bean id="ssm" class="org.mybatis.spring.mapper.MapperFactoryBean">
						<property name="mapperInterface" value="com.entity.mapper.StudentMapper" />
						<property name="sqlSessionFactory" ref="sf" />
					    </bean>
					    -->

					    <!-- 扫描mapper包 自动在spring中生成 xxxxMapper bean -->
					    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
						<property name="basePackage" value="com.entity.mapper"/>
						<property name="sqlSessionFactoryBeanName" value="sf"/>
					    </bean>

					    <bean id="transactionManager"
						  class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
						<property name="dataSource" ref="ds"/>
					    </bean>

					    <bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
						<property name = "dataSource" ref="ds"/>
					    </bean>

					    <tx:annotation-driven transaction-manager="transactionManager" />
					</beans>


				db.properties 文件
					db.driver=com.mysql.jdbc.Driver
					db.url=jdbc:mysql://localhost:3306/db?useUnicode=true&characterEncoding=utf8&useSSL=true
					db.user=root
					db.password=

		test
			java 测试源文件
	
	pom.xml 文件
		<?xml version="1.0" encoding="UTF-8"?>
		<project xmlns="http://maven.apache.org/POM/4.0.0"
			 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
		    <modelVersion>4.0.0</modelVersion>
		    <groupId>com.fz</groupId>
		    <artifactId>springmybatis</artifactId>
		    <version>1.0</version>
		    <packaging>jar</packaging>

		    <properties>
			<java-version>1.7</java-version>
			<aspectj.version>1.6.11</aspectj.version>
			<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
			<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
			<maven.compiler.encoding>UTF-8</maven.compiler.encoding>
		    </properties>

		    <dependencies>
			<dependency>
			    <groupId>junit</groupId>
			    <artifactId>junit</artifactId>
			    <version>4.12</version>
			</dependency>
			<dependency>
			    <groupId>org.projectlombok</groupId>
			    <artifactId>lombok</artifactId>
			    <version>1.16.14</version>
			</dependency>

			<dependency>
			    <groupId>org.springframework</groupId>
			    <artifactId>spring-context</artifactId>
			    <version>4.3.6.RELEASE</version>
			</dependency>
			<dependency>
			    <groupId>org.springframework</groupId>
			    <artifactId>spring-jdbc</artifactId>
			    <version>4.3.6.RELEASE</version>
			</dependency>

			<dependency>
			    <groupId>org.mybatis</groupId>
			    <artifactId>mybatis</artifactId>
			    <version>3.4.2</version>
			</dependency>
			<dependency>
			    <groupId>org.mybatis</groupId>
			    <artifactId>mybatis-spring</artifactId>
			    <version>1.3.1</version>
			</dependency>
			<dependency>
			    <groupId>mysql</groupId>
			    <artifactId>mysql-connector-java</artifactId>
			    <version>5.1.40</version>
			</dependency>

		    </dependencies>
		    <build>
			<finalName>${project.artifactId}</finalName>
			<sourceDirectory>src/main/java</sourceDirectory>
			<testSourceDirectory>src/test/java</testSourceDirectory>
			<resources>
			    <resource>
				<directory>src/main/java</directory>
				<includes>
				    <include>**/*.xml</include>
				</includes>
			    </resource>
			    <resource>
				<directory>src/main/resources</directory>
				<includes>
				    <include>**/*.xml</include>
				    <include>**/*.properties</include>
				</includes>
			    </resource>
			</resources>
			<plugins>
			    <plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.3</version>
				<configuration>
				    <source>${java-version}</source>
				    <target>${java-version}</target>
				    <encoding>${project.build.sourceEncoding}</encoding>
				</configuration>
			    </plugin>
			    <plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
				<version>2.12.4</version>
				<configuration>
				    <skipTests>true</skipTests>
				</configuration>
			    </plugin>

			</plugins>
		    </build>
		</project>

2、com.entity.Student 实体类
	package com.entity;
	import lombok.Data;
	/**
	 * Created by webrx on 2017/2/15 0015 11:40.
	 */
	@Data
	public class Student {
	    private int id;
	    private String name;
	    private String address;
	}

3、mybatis mapper接口 及mapper配置文件
	/src/main/java/com/entity/mapper/StudentMapper.java
	StudentMapper.java
	package com.entity.mapper;

	import com.entity.Student;
	import org.apache.ibatis.annotations.Param;
	import org.apache.ibatis.annotations.Select;

	import java.util.List;

	/**
	 * Created by webrx on 2017/2/15 0015 11:52.
	 */
	public interface StudentMapper {
	    @Select("select * from student where id = #{id}")
	    public Student findById(int id);

	    @Select("select * from student where 1=1 order by id desc")
	    public List<Student> queryAll();

	    public int insert(Student student);

	    public int save(@Param("name") String name, @Param("address") String address);

	    public int add(String name,String address);

	    public List<Student> shows();
	    
	}

	src/main/java/com/entity/mapper/StudentMapper.xml
	StudentMapper.xml 
		<?xml version="1.0" encoding="UTF-8" ?>
		<!DOCTYPE mapper
			PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
			"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
		<mapper namespace="com.entity.mapper.StudentMapper">
		    <insert id="insert" parameterType="student">
			insert into student values(null,#{name},#{address})
		    </insert>

		    <insert id="save" parameterType="string">
			insert into student values(null,#{name},#{address})
		    </insert>

		    <select id="shows" resultType="student">
			select * from student
		    </select>

		    <insert id="add" parameterType="string">
			insert into student values(null,#{0},#{1})
		    </insert>
		</mapper>

4、测试主程序
	import com.entity.Student;
	import com.entity.StudentDAO;
	import com.entity.mapper.StudentMapper;
	import com.entity.mapper.UserMapper;
	import org.junit.Test;
	import org.springframework.context.support.ClassPathXmlApplicationContext;

	import java.sql.SQLException;
	import java.util.List;
	import java.util.Map;

	/**
	 * Created by webrx on 2017/2/15 0015 11:41.
	 */
	public class Demo {

	    @Test
	    public void xx(){
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");
		StudentMapper sm = ctx.getBean("studentMapper",StudentMapper.class);

		//sm.save("赵七","北京");
		sm.add("dd","zz111");

		//Student st = new Student();
		//st.setName("李四六");
		//st.setAddress("郑州文化路");
		//sm.insert(st);

		//System.out.println(sm.queryAll().size());
		System.out.println(sm.shows().size());
		ctx.close();
	    }


	    @Test
	    public void cc(){
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");

		for(String s : ctx.getBeanDefinitionNames()){
		    System.out.println(s);
		}

		System.out.println("----------------------------------------------------");
		StudentMapper sm = ctx.getBean("studentMapper",StudentMapper.class);
		for(Student st : sm.queryAll()){
		    System.out.println(st.getName());
		}
		System.out.println("----------------------------------------------------");
		StudentDAO sdao = ctx.getBean("studentdao",StudentDAO.class);
		for(Student st : sdao.query()){
		    System.out.println(st.getName());
		}
		System.out.println("----------------------------------------------------");
		System.out.println(sm==sdao.getSm());

		UserMapper um = ctx.getBean("userMapper",UserMapper.class);
		for(Map<String,Object> ss : um.query()){
		    System.out.println(ss.get("name"));
		}
		ctx.close();
	    }


	    @Test
	    public void aa(){
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");
		StudentMapper sm = ctx.getBean("sm",StudentMapper.class);
		List<Student> sts = sm.queryAll();
		System.out.println(sts.size());
		for(Student s : sts){
		    System.out.println(s.getAddress());
		}
		ctx.close();
	    }


	    @Test
	    public void tt() throws SQLException {
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");
		//SqlSessionFactory sf = ctx.getBean("sf",SqlSessionFactory.class);
		StudentDAO sd = ctx.getBean("studentdao",StudentDAO.class);

		Student myst = sd.queryById(8);
		System.out.println(myst.getName());
		System.out.println(myst.getAddress());

		System.out.println("------------------------");

		List<Student> sts = sd.query();
		for(Student s : sts){
		    System.out.println(s.getName());
		}
		ctx.close();
	    }
	}


