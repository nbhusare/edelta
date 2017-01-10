/*
 * generated by Xtext 2.10.0
 */
package edelta.ui.wizard


import com.google.inject.Inject
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.resource.FileExtensionProvider

class EdeltaNewProjectWizardInitialContents {
	@Inject
	FileExtensionProvider fileExtensionProvider

	def generateInitialContents(IFileSystemAccess2 fsa) {
		fsa.generateFile(
			"src/Example." + fileExtensionProvider.primaryFileExtension,
			'''
			// IMPORTANT: ecores must be in a source directory
			// otherwise you can't refer to them
			
			package com.example
			
			metamodel "myecore"
			metamodel "ecore"
			
			/*
			 * Reusable function to create a new EClass with the
			 * specified name, setting MyEClass as its superclass
			 * @param name
			 */
			def createClass(String name) {
				newEClass(name) => [
					ESuperTypes += (eclass MyEClass)
				]
			}
			
			// refer to EClasses with "eclass"
			val p = (eclass MyEClass).EPackage
			// create new EClasses manually...
			p.EClassifiers += createClass("NewClass") => [
				EStructuralFeatures += newEAttribute("myStringAttribute") => [
					// refer to EDataTypes with "edatatype"
					EType = edatatype EString
				]
				EStructuralFeatures += newEReference("myReference") => [
					EType = (eclass MyEClass)
					upperBound = -1;
					containment = true;
					lowerBound = 0
				]
			]
			
			// ... or using Edelta DSL specific syntax
			createEClass MyNewClass in myecore
			
			createEClass MyDerivedNewClass in myecore {
				ESuperTypes += eclass MyNewClass
				createEAttribute myNewAttribute {
					EType = edatatype EInt
					upperBound = -1;
				}
			}
			'''
			)
		fsa.generateFile(
			"model/My.ecore",
			'''
			<?xml version="1.0" encoding="UTF-8"?>
			<ecore:EPackage xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			    xmlns:ecore="http://www.eclipse.org/emf/2002/Ecore" name="myecore" nsURI="http://www.eclipse.org/emf/2002/Myecore" nsPrefix="myecore">
			  <eClassifiers xsi:type="ecore:EClass" name="MyEClass">
			    <eStructuralFeatures xsi:type="ecore:EAttribute" name="astring" eType="ecore:EDataType http://www.eclipse.org/emf/2002/Ecore#//EString"/>
			  </eClassifiers>
			</ecore:EPackage>
			'''
			)
		fsa.generateFile(
			"src/com/example/Main.java",
			'''
			package com.example;
			
			import edelta.lib.AbstractEdelta;
			
			public class Main {
			
				public static void main(String[] args) throws Exception {
					// Create an instance of the generated Java class
					AbstractEdelta edelta = new Example();
					// Make sure you load all the used Ecores
					edelta.loadEcoreFile("model/My.ecore");
					// Execute the actual transformations defined in the DSL
					edelta.execute();
					// Save the modified Ecore model into a new path
					edelta.saveModifiedEcores("modified");
				}
			}
			'''
			)
		fsa.generateFile(
			"modified/README",
			'''
			Modified ecores will be saved here (see Main.java file)
			'''
			)
	}
}
