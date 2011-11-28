package net.ontopia.topicmaps.utils.ctm;

import java.io.FileOutputStream;
import java.io.InputStream;
import net.ontopia.infoset.impl.basic.URILocator;
import net.ontopia.topicmaps.core.TopicMapIF;
import net.ontopia.utils.StreamUtils;
import org.junit.Test;

public class CTMTopicMapWriterTest {
	
	public static final String BASE = CTMTopicMapWriter.class.getPackage().getName().replaceAll("\\.", "/");
	
	@Test
	public void testWrite() throws Exception {
		
		InputStream in = StreamUtils.getInputStream(BASE + "/ontology.ctm");
		
		TopicMapIF source_topicmap = 
				new CTMTopicMapReader(in, URILocator.create("ctm::test:ontology.ctm")).read();
		
		CTMTopicMapWriter instance = new CTMTopicMapWriter(new FileOutputStream("target/out.ctm"), "ctm::test:ontology.ctm");
		
		instance.setPrefix("tm", "http://psi.topicmaps.org/iso13250/model/");
		instance.setPrefix("i", "http://psi.elcid.org/connex/");
		instance.setPrefix("concept", "http://psi.elcid.org/connex/concepts/");
		instance.setPrefix("expression", "http://psi.elcid.org/connex/expressions/");
		instance.setPrefix("lang", "http://psi.elcid.org/connex/languages/");
		instance.setPrefix("script", "http://psi.elcid.org/connex/scripts/");
		instance.write(source_topicmap);
	}
}
