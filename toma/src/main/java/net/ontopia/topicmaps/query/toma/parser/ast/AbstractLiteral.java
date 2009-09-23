package net.ontopia.topicmaps.query.toma.parser.ast;

import net.ontopia.topicmaps.query.core.InvalidQueryException;
import net.ontopia.topicmaps.query.toma.parser.AntlrWrapException;
import net.ontopia.topicmaps.query.toma.util.IndentedStringBuilder;

/**
 * INTERNAL: Abstract base class for literals in the AST.
 */
public abstract class AbstractLiteral extends AbstractExpression implements
    ExpressionIF {
  private String value;

  public AbstractLiteral(String value) {
    super("LITERAL", 0);
    this.value = value;
  }

  public String getValue() {
    return value;
  }

  public void setValue(String value) {
    this.value = value;
  }

  @Override
  public void addChild(ExpressionIF child) throws AntlrWrapException {
    throw new AntlrWrapException(new InvalidQueryException(
        "Literals can not have children"));
  }

  @Override
  public void fillParseTree(IndentedStringBuilder buf, int level) {
    buf.append("(   LITERAL) [" + getValue() + "]", level);
  }

  public String toString() {
    return "'" + value + "'";
  }
}