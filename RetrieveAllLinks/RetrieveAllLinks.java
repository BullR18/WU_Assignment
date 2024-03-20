import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.List;


public class RetrieveAllLinks {

        public static void main(String[] args)  {

            // Set the path to chromedriver.exe

//            String path = System.getProperty("user.dir");
//            System.out.println(path);
//           // System.setProperty("webdriver.chrome.driver", path + "\\driver\\chromedriver.exe");

            WebDriver driver = new ChromeDriver();
            driver.manage().window().maximize();
            driver.get("https://www.flipkart.com/");

            List<WebElement> AllLinks = driver.findElements(By.tagName("a"));
            System.out.println("Total links found: " + AllLinks.size());

            //List Of Links Using For Each Loop
            System.out.println("List Of Links Using For Each Loop:");

            for (WebElement link : AllLinks) {
                System.out.println(link.getAttribute("href"));
            }

            //List Of Links Using Parallel Streams:
            System.out.println("List Of Links Using Parallel Streams:");

            AllLinks.parallelStream()
                    .map(link -> link.getAttribute("href"))
                    .forEach(System.out::println);

            //List Of Links Using Java Lambdas and Streams
            System.out.println("List Of Links Using Java Lambdas and Streams:");

            AllLinks.stream()
                    .map(link -> link.getAttribute("href"))
                    .forEach(System.out::println);


            driver.quit();

        }
    }


