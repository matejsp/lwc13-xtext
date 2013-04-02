/*
 * generated by Xtext
 */
package org.eclipse.xtext.example.qls.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.example.qls.qlsDsl.QuestionnaireStyleModel
import org.eclipse.xtext.example.qls.qlsDsl.Page
import com.google.inject.Inject
import org.eclipse.xtext.example.qls.qlsDsl.StyleInformation
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.example.ql.qlDsl.Form
import org.eclipse.xtext.example.qls.qlsDsl.Section
import org.eclipse.xtext.example.ql.generator.JSFGenerator
import org.eclipse.xtext.example.qls.qlsDsl.QuestionStyling
import org.eclipse.xtext.example.ql.generator.JSFOutputConfigurationProvider
import org.eclipse.xtext.example.ql.QlDslExtensions

class QlsDslGenerator implements IGenerator {
  @Inject extension JSFOutputConfigurationProvider
  @Inject extension QlDslExtensions
  
  override void doGenerate(Resource input, IFileSystemAccess fsa) {
	if (input.URI.fileExtension!="qls")
      return
            
    val styleModel = input.contents.head as QuestionnaireStyleModel
    for (page: styleModel.pages) {
  	  val cssContent = generateCssFile(page);
   	  val cssFileName = "resources/default/css/generated/"+page.name+".css"
   	  fsa.generateFile(cssFileName, WEB_CONTENT, cssContent)
   	
   	  val xhtmlContent = generateXhtmlFile(page);
   	  val xhtmlFileName = "generated/pages/"+page.name+".xhtml"
   	  fsa.generateFile(xhtmlFileName, WEB_CONTENT, xhtmlContent)
    }
    val contentIndex  = generateIndexPage(styleModel.pages.get(0))
    fsa.generateFile("generated/pages/index.xhtml",WEB_CONTENT, contentIndex)
  }

  def generateCssFile(Page page) '''
    �FOR styleInfo: page.eAllContents.filter(typeof(StyleInformation)).toList�
		�styleInfo.id� {
		  �IF styleInfo.fontColor != null�color: �styleInfo.fontColor�;�ENDIF�
		  �IF styleInfo.fontFamily != null�font-family: �styleInfo.fontFamily�;�ENDIF�
		  �IF styleInfo.fontStyle != null�font-style: �styleInfo.fontStyle�;�ENDIF�
		  �IF styleInfo.fontWeight != null�font-weight: �styleInfo.fontWeight�;�ENDIF�
		}
   �ENDFOR�
  '''
	
  def generateXhtmlFile(Page page) '''
	<!-- @generated -->
	<html xmlns="http://www.w3.org/1999/xhtml"
	      xmlns:ui="http://java.sun.com/jsf/facelets"
	      xmlns:h="http://java.sun.com/jsf/html"
	      xmlns:f="http://java.sun.com/jsf/core">
	  <h:head></h:head>
	  <ui:composition template="/index.xhtml">
	    <ui:define name="content">
	      <h:outputStylesheet library="default/css/generated" name="�page.name�.css"  />
	      �IF page.form != null�
	      <div><ui:include src="/generated/forms/�page.form.name�Base.xhtml" /></div>
	      �ELSE�
	        �FOR section: page.eAllContents.toList.filter(typeof(Section)).toList SEPARATOR '<p/>'�
	        <div><ui:include src="/generated/forms/�section.form.name�Base.xhtml" /></div>
	        �ENDFOR�
	      �ENDIF�
	  
	  	  <div>
	  	  �IF page.navigation != null�
	  	    �FOR nextPage: page.navigation.nextPage�
	  	    <h:outputLink value="�nextPage.name�.jsf">�nextPage.name�</h:outputLink>
	  	    �ENDFOR�
	  	  �ENDIF�
		  </div>
	    </ui:define>
	  </ui:composition>
	</html>
  '''
    
  def generateIndexPage(Page page)'''
	<?xml version='1.0' encoding='UTF-8' ?>
	<!-- @generated -->
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml"
	      xmlns:h="http://java.sun.com/jsf/html"
	      xmlns:ui="http://java.sun.com/jsf/facelets">
	  <ui:composition template="/index.xhtml">
	    <ui:define name="content">
	      <h:outputLink value="�page.name�.jsf">�page.name�</h:outputLink>
	    </ui:define>
	  </ui:composition>
	</html>
  '''	
	
  def getId(StyleInformation styleInfo) {
	val question = (styleInfo.eContainer as QuestionStyling).question
	val form = EcoreUtil2::getContainerOfType(question, typeof(Form))
	"#"+form.id+ "\\:lbl"+question.id.toFirstUpper
  }

  def dispatch Form getForm(Section section) {
	if (section.form != null) {
	  section.form
	}
	else {
	  section.eContainer.form
	}
  }
	
  def dispatch getForm(Page page) {
	page.form
  }
}
