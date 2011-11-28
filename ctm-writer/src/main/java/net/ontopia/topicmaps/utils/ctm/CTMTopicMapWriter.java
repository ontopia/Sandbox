package net.ontopia.topicmaps.utils.ctm;

import de.topicmapslab.ctm.writer.properties.CTMTopicMapWriterProperties;
import de.topicmapslab.ctm.writer.templates.TemplateFactory;
import de.topicmapslab.ctm.writer.utility.CTMIdentity;
import java.io.IOException;
import java.io.OutputStream;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import net.ontopia.topicmaps.core.TopicMapIF;
import net.ontopia.topicmaps.core.TopicMapWriterIF;
import net.ontopia.topicmaps.impl.tmapi2.MemoryTopicMapSystemImpl;
import net.ontopia.topicmaps.impl.tmapi2.TopicMapImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.tmapi.core.TMAPIException;
import org.tmapi.core.TopicMap;
import org.tmapi.core.TopicMapSystem;
import org.tmapi.core.TopicMapSystemFactory;

/**
 * 
 * Wrapper class for the CTM writer of the Topic Maps Lab.
 *
 * @see de.topicmapslab.ctm.writer.core.CTMTopicMapWriter
 * @author Pieter Brandwijk
 * @since 5.2.0
 */
public class CTMTopicMapWriter implements TopicMapWriterIF, org.tmapix.io.TopicMapWriter {

	static Logger log = LoggerFactory.getLogger(CTMTopicMapWriter.class.getName());
	
	protected de.topicmapslab.ctm.writer.core.CTMTopicMapWriter writer;

	public CTMTopicMapWriter(OutputStream outputStream, String baseURI) throws IOException {
		this.writer = new de.topicmapslab.ctm.writer.core.CTMTopicMapWriter(outputStream, baseURI);
	}

	public CTMTopicMapWriter(OutputStream outputStream, String baseURI, String propertyLine) {
		this.writer = new de.topicmapslab.ctm.writer.core.CTMTopicMapWriter(outputStream, baseURI, propertyLine);
	}

	/**
	 * Do conversion of Ontopia internal TM interfaces to TMAPI, then pass to CTM writer
	 * 
	 * @param source_topicmap
	 * @throws IOException 
	 */
	public void write(TopicMapIF source_topicmap) throws IOException {
		try {
			// do TMAPI setup
			TopicMapSystemFactory factory = TopicMapSystemFactory.newInstance();
			TopicMapSystem sys = factory.newTopicMapSystem();

			// create TMAPI topic map object
			TopicMapImpl topicmap = ((MemoryTopicMapSystemImpl) sys).createTopicMap(source_topicmap);

			write(topicmap);

		} catch (TMAPIException ex) {
			throw new IOException("Could not setup TMAPI: " + ex.getMessage(), ex);
		}
	}

	public void write(TopicMap tm) throws IOException {
		writer.write(tm);
	}

	public void write(org.tmapi.core.Construct[] constructs) throws IOException {
		writer.write(constructs);
	}

	public void write(Collection<org.tmapi.core.Construct> constructs) throws IOException {
		writer.write(constructs);
	}

	public void addTemplate(de.topicmapslab.ctm.writer.templates.Template template) {
		writer.addTemplate(template);
	}

	public void addIgnoredConstruct(org.tmapi.core.Construct construct) {
		writer.addIgnoredConstruct(construct);
	}

	public String getBaseURI() {
		return writer.getBaseURI();
	}

	public String getProperty(String key) {
		return writer.getProperty(key);
	}

	public void setProperty(String key, String value) {
		writer.setProperty(key, value);
	}

	public String getPrefix(String prefix) {
		return writer.getPrefix(prefix);
	}

	public void setPrefix(String prefix, String iri) {
		writer.setPrefix(prefix, iri);
	}

	public TemplateFactory getFactory() {
		return writer.getFactory();
	}

	public CTMIdentity getCtmIdentity() {
		return writer.getCtmIdentity();
	}

	public CTMTopicMapWriterProperties getProperties() {
		return writer.getProperties();
	}

	public void addInclude(String uri) {
		writer.addInclude(uri);
	}

	public void removeInclude(String uri) {
		writer.removeInclude(uri);
	}

	public List<String> getIncludes() {
		return writer.getIncludes();
	}

	public void addMergeXTMMap(String iri) {
		writer.addMergeXTMMap(iri);
	}

	public void addMergeCTMMap(String iri) {
		writer.addMergeCTMMap(iri);
	}

	public void removeMergeMap(String iri) {
		writer.removeMergeMap(iri);
	}

	public Map<String, String> getMergeMaps() {
		return writer.getMergeMaps();
	}
}
