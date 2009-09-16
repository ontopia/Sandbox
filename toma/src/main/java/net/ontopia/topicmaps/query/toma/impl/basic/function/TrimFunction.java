package net.ontopia.topicmaps.query.toma.impl.basic.function;

import net.ontopia.topicmaps.query.toma.impl.utils.Stringifier;

public class TrimFunction extends AbstractSimpleFunction {
  
  public TrimFunction() {
    super("TRIM", 2);
  }

  public String evaluate(Object obj) {
    String str = Stringifier.toString(obj);
    if (str != null) {
      // TODO: implement complete trim function
      return str.trim();
    } else {
      return str;
    }
  }
}
