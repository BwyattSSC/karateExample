package examples;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

// Based off of https://github.com/intuit/karate/blob/ae199b270b9f566847d275760d779456ff7d5289/karate-core/src/test/java/com/intuit/karate/core/parallel/ParallelOutlineTest.java

public class ExampleParallelTest {
    static final Logger logger = LoggerFactory.getLogger(ExampleParallelTest.class);

    @Test
    void testParallelOutline() {
        Results results = Runner.path(
                "classpath:examples/rest/swapi/swapi-json-structure.feature",
                "classpath:examples/rest/swapi/swapi-simple.feature",
                "classpath:examples/rest/pokeapi/pokemon-simple.feature",
                "classpath:examples/graphql/pokeapi/pokemon.feature")
                .parallel(5);
        generateReport(results.getReportDir());
        assertEquals(5, results.getPassCount());
        assertEquals(0, results.getFailCount());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
