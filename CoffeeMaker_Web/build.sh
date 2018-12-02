base=$(pwd)
#build src
rm -R target
mkdir -p target/CoffeeMaker_Web/WEB-INF/classes/
cd CoffeeMaker_Web/src/main
javac $(find . -name "*.java") 
cd $base
cp -r CoffeeMaker_Web/src/main/java/edu target/CoffeeMaker_Web/WEB-INF/classes/  
#better to try  find . '*.class' -exec cp --parents '{}' $base/target/CoffeeMaker_Web/classes/ \;
cd CoffeeMaker_Web
#find . -name "*.class" | xargs rm
find . -name "*.jsp" | xargs -I{} cp {} $base/target/CoffeeMaker_Web/
cp src/main/webapp/WEB-INF/web.xml $base/target/CoffeeMaker_Web/WEB-INF
cd ../target/CoffeeMaker_Web
find . -name "*.java" | xargs rm
jar -cvf ../CoffeeMaker_Web.war *


#build test
cd $base/CoffeeMaker_Web/src/test/
#/edu/ncsu/csc326/coffeemaker/test
find  -name "*.class" | xargs rm 
#wrong===  javac -cp "../main/*     :$(find $base/CoffeeMaker_Web/lib -name "*.jar" | xargs -I{} printf {}\: );" ./java/edu/ncsu/csc326/coffeemaker/ITMain.java -d ./
#wrong===  javac -cp "../main/java:$(find $base/CoffeeMaker_Web/lib -name "*.jar" | xargs -I{} printf {}\: );" ./java/edu/ncsu/csc326/coffeemaker/ITMain.java xxxx
           javac -cp "../main/java:$(find $base/CoffeeMaker_Web/lib -name "*.jar" | xargs -I{} printf {}\: );" ./java/edu/ncsu/csc326/coffeemaker/ITMain.java -d ./
#wrong java -cp ".:$(find $base/CoffeeMaker_Web/lib -name "*.jar" | xargs -I{} printf {}\: );" org.junit.runner.JUnitCore  ITMain
       java -cp ".:$(find $base/CoffeeMaker_Web/lib -name "*.jar" | xargs -I{} printf {}\: );" org.junit.runner.JUnitCore  edu.ncsu.csc326.coffeemaker.ITMain