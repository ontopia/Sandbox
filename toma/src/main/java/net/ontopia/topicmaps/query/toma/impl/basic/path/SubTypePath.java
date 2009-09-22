package net.ontopia.topicmaps.query.toma.impl.basic.path;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import net.ontopia.topicmaps.core.TopicIF;
import net.ontopia.topicmaps.query.core.InvalidQueryException;
import net.ontopia.topicmaps.query.toma.impl.basic.LocalContext;
import net.ontopia.topicmaps.query.toma.parser.ast.Level;
import net.ontopia.topicmaps.utils.AssociationWalker;
import net.ontopia.topicmaps.utils.PSI;
import net.ontopia.topicmaps.utils.SubjectIdentityDecider;
import net.ontopia.topicmaps.utils.TypeHierarchyUtils;
import net.ontopia.utils.DeciderIF;

/**
 * INTERNAL: Subtype path element in an path expression. Returns all subtypes 
 * of a given type in the topic map. 
 * <p>
 * <b>Allowed Input</b>:
 * <ul>
 * <li>TOPIC
 * </ul>
 * </p><p>
 * <b>Output</b>: TOPIC
 * </p>
 */
public class SubTypePath extends AbstractBasicPathElement {
  static final Set<TYPE> inputSet;

  static {
    inputSet = new HashSet<TYPE>();
    inputSet.add(TYPE.TOPIC);
  }

  private AssociationWalker subtypesWalker;
  
  public SubTypePath() {
    super("SUB");
    
    DeciderIF assocDecider = new SubjectIdentityDecider(PSI.getXTMSuperclassSubclass());
    DeciderIF subclassDecider = new SubjectIdentityDecider(PSI.getXTMSubclass());
    DeciderIF superclassDecider = new SubjectIdentityDecider(PSI.getXTMSuperclass());
        
    subtypesWalker = new AssociationWalker(assocDecider, superclassDecider, subclassDecider);
  }

  protected boolean isLevelAllowed() {
    return true;
  }

  protected boolean isScopeAllowed() {
    return false;
  }
  
  protected boolean isTypeAllowed() {
    return false;
  }

  protected boolean isChildAllowed() {
    return false;
  }
  
  public Set<TYPE> validInput() {
    return inputSet;
  }
  
  public TYPE output() {
    return TYPE.TOPIC;
  }

  @SuppressWarnings("unchecked")
  public Collection<TopicIF> evaluate(LocalContext context, Object input) {
    TopicIF topic = (TopicIF) input;
    
    // level is required for this element
    Level l = getLevel();
    
    // use a set as collection for the types, as one type can occur multiple
    // times (and should only be counted once).
    Collection<TopicIF> types = new HashSet<TopicIF>();

    int start = l.getStart()*2;
    int end = (l.getEnd() == Integer.MAX_VALUE) ? l.getEnd() : l.getEnd()*2;
    
    Iterator it = subtypesWalker.walkPaths(topic).iterator();
    while (it.hasNext()) {
      List path = (List) it.next();
      for (int idx = start; idx < path.size() && idx <= end; idx += 2) 
        types.add((TopicIF) path.get(idx));
    }
    
    return types;
  }  
}
