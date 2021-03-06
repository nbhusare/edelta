package edelta.tests;

import com.google.inject.Inject;
import edelta.tests.EdeltaAbstractTest;
import edelta.tests.EdeltaInjectorProviderCustom;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.testing.InjectWith;
import org.eclipse.xtext.testing.XtextRunner;
import org.eclipse.xtext.testing.formatter.FormatterTestHelper;
import org.eclipse.xtext.testing.formatter.FormatterTestRequest;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(XtextRunner.class)
@InjectWith(EdeltaInjectorProviderCustom.class)
@SuppressWarnings("all")
public class EdeltaFormatterTest extends EdeltaAbstractTest {
  @Inject
  @Extension
  private FormatterTestHelper _formatterTestHelper;
  
  @Test
  public void testFormatting() {
    final Procedure1<FormatterTestRequest> _function = (FormatterTestRequest it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.newLine();
      _builder.newLine();
      _builder.append("import edelta.refactorings.lib.EdeltaRefactorings");
      _builder.newLine();
      _builder.newLine();
      _builder.append("// IMPORTANT: ecores must be in source directories");
      _builder.newLine();
      _builder.append("// otherwise you can\'t refer to them");
      _builder.newLine();
      _builder.newLine();
      _builder.append("package    my.code");
      _builder.newLine();
      _builder.newLine();
      _builder.append("metamodel   \"ecore\"");
      _builder.newLine();
      _builder.append("metamodel  \"myexample\"");
      _builder.newLine();
      _builder.append("metamodel \"myecore\"");
      _builder.newLine();
      _builder.newLine();
      _builder.append("use  Example  as  example ");
      _builder.newLine();
      _builder.append("use EdeltaRefactorings as  extension  std");
      _builder.newLine();
      _builder.newLine();
      _builder.append("def  createClass2 ( String  name  , int  i  ) { \t\t\t\tnewEClass(name)");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.newLine();
      _builder.append("def createClass3()    :   String  {");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("val a= newEAttribute(attrname)[");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("lowerBound=1");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("]");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("modifyEcore   aModification   epackage   myecore    {");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("std . addMandatoryAttr( \"name\" , ");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("ecoreref(EString), it)");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("ecoreref (  ecore  .  EString  )  ");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("ecoreref (    EString  )");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("val a= newEAttribute(attrname)[");
      _builder.newLine();
      _builder.append("\t\t\t\t\t\t\t\t");
      _builder.append("lowerBound=1");
      _builder.newLine();
      _builder.append("\t\t\t\t\t\t\t");
      _builder.append("]");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.newLine();
      it.setToBeFormatted(_builder);
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.newLine();
      _builder_1.append("import edelta.refactorings.lib.EdeltaRefactorings");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("// IMPORTANT: ecores must be in source directories");
      _builder_1.newLine();
      _builder_1.append("// otherwise you can\'t refer to them");
      _builder_1.newLine();
      _builder_1.append("package my.code");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("metamodel \"ecore\"");
      _builder_1.newLine();
      _builder_1.append("metamodel \"myexample\"");
      _builder_1.newLine();
      _builder_1.append("metamodel \"myecore\"");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("use Example as example");
      _builder_1.newLine();
      _builder_1.append("use EdeltaRefactorings as extension std");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("def createClass2(String name, int i) {");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("newEClass(name)");
      _builder_1.newLine();
      _builder_1.append("}");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("def createClass3() : String {");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("val a = newEAttribute(attrname) [");
      _builder_1.newLine();
      _builder_1.append("\t\t");
      _builder_1.append("lowerBound = 1");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("]");
      _builder_1.newLine();
      _builder_1.append("}");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("modifyEcore aModification epackage myecore {");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("std.addMandatoryAttr(\"name\", ecoreref(EString), it)");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("ecoreref(ecore.EString)");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("ecoreref(EString)");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("val a = newEAttribute(attrname) [");
      _builder_1.newLine();
      _builder_1.append("\t\t");
      _builder_1.append("lowerBound = 1");
      _builder_1.newLine();
      _builder_1.append("\t");
      _builder_1.append("]");
      _builder_1.newLine();
      _builder_1.newLine();
      _builder_1.append("}");
      _builder_1.newLine();
      it.setExpectation(_builder_1);
    };
    this._formatterTestHelper.assertFormatted(_function);
  }
}
