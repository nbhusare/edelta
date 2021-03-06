package edelta.tests

import com.google.inject.Inject
import org.eclipse.emf.ecore.EcoreFactory
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.jvmmodel.IJvmModelInferrer
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Tests corner cases of the JvmModelInferrer
 */
@RunWith(XtextRunner)
@InjectWith(EdeltaInjectorProvider)
class EdeltaJvmModelInferrerTest extends EdeltaAbstractTest {

	@Inject IJvmModelInferrer inferrer

	@Test def void testWithANonXExpression() {
		inferrer.infer(EcoreFactory.eINSTANCE.createEClass, null, false)
	}

	@Test(expected=IllegalArgumentException)
	def void testWithNull() {
		inferrer.infer(null, null, false)
	}

}
