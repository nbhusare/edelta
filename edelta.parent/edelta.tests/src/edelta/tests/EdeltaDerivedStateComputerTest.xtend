/*
 * generated by Xtext 2.10.0
 */
package edelta.tests

import org.eclipse.emf.ecore.EClass
import org.eclipse.xtext.common.types.JvmGenericType
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.resource.DerivedStateAwareResource
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*
import com.google.inject.Inject
import edelta.resource.EdeltaDerivedStateComputer

@RunWith(XtextRunner)
@InjectWith(EdeltaInjectorProviderCustom)
class EdeltaDerivedStateComputerTest extends EdeltaAbstractTest {

	@Inject extension EdeltaDerivedStateComputer

	@Test
	def void testDerivedState() {
		val program = '''
		package test
		
		metamodel "foo"
		
		createEClass First in foo
		'''.
		parseWithTestEcore
		val resource = program.eResource as DerivedStateAwareResource
		assertEquals("First", (resource.contents.last as EClass).name)
		// discard derived state
		program.main.expressions.clear
		resource.discardDerivedState
		// only program must be there and the inferred Jvm Type
		assertEquals("test.__synthetic0", (resource.contents.last as JvmGenericType).identifier)
	}

	@Test
	def void testSourceElementOfNull() {
		assertNull(getPrimarySourceElement(null))
	}

	@Test
	def void testSourceElementOfNotDerived() {
		assertNull('''
		package test
		'''.
		parse.getPrimarySourceElement
		)
	}

	@Test
	def void testSourceElementOfCreateEClass() {
		val program = '''
		package test
		
		metamodel "foo"
		
		createEClass First in foo
		'''.
		parseWithTestEcore
		val e = program.lastExpression
		val derived = (program.eResource.contents.last as EClass)
		assertSame(e, derived.getPrimarySourceElement)
	}

}
