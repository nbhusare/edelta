/*
 * generated by Xtext 2.10.0
 */
package edelta

import edelta.compiler.EdeltaGeneratorConfigProvider
import edelta.compiler.EdeltaOutputConfigurationProvider
import edelta.compiler.EdeltaXbaseCompiler
import edelta.interpreter.EdeltaInterpreter
import edelta.interpreter.EdeltaSafeInterpreter
import edelta.resource.EdeltaDerivedStateComputer
import edelta.resource.EdeltaEObjectAtOffsetHelper
import edelta.resource.EdeltaLocationInFileProvider
import edelta.resource.EdeltaResourceDescriptionStrategy
import edelta.scoping.EdeltaQualifiedNameProvider
import edelta.services.IEdeltaEcoreModelAssociations
import edelta.typesystem.EdeltaTypeComputer
import edelta.validation.EdeltaDiagnosticConverter
import org.eclipse.xtext.generator.IContextualOutputConfigurationProvider
import org.eclipse.xtext.generator.IOutputConfigurationProvider
import org.eclipse.xtext.validation.IDiagnosticConverter
import org.eclipse.xtext.xbase.compiler.IGeneratorConfigProvider
import org.eclipse.xtext.xbase.compiler.XbaseCompiler

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class EdeltaRuntimeModule extends AbstractEdeltaRuntimeModule {

	override bindIQualifiedNameProvider() {
		EdeltaQualifiedNameProvider
	}

	override bindITypeComputer() {
		EdeltaTypeComputer
	}

	override bindIDerivedStateComputer() {
		EdeltaDerivedStateComputer
	}

	override bindILocationInFileProvider() {
		EdeltaLocationInFileProvider
	}

	override bindIDefaultResourceDescriptionStrategy() {
		EdeltaResourceDescriptionStrategy
	}

	override bindEObjectAtOffsetHelper() {
		EdeltaEObjectAtOffsetHelper
	}

	def Class<? extends XbaseCompiler> bindXbaseCompiler() {
		EdeltaXbaseCompiler
	}

	def Class<? extends IEdeltaEcoreModelAssociations> bindIEdeltaEcoreModelAssociations() {
		EdeltaDerivedStateComputer
	}

	def Class<? extends EdeltaInterpreter> bindEdeltaInterpreter() {
		EdeltaSafeInterpreter
	}

	def Class<? extends IDiagnosticConverter> bindIDiagnosticConverter() {
		return EdeltaDiagnosticConverter
	}

	def Class<? extends IGeneratorConfigProvider> bindIGeneratorConfigProvider() {
		EdeltaGeneratorConfigProvider
	}

	def Class<? extends IOutputConfigurationProvider> bindIOutputConfigurationProvider() {
		return EdeltaOutputConfigurationProvider
	}

	def Class<? extends IContextualOutputConfigurationProvider> bindIContextualOutputConfigurationProvider() {
		return EdeltaOutputConfigurationProvider
	}

}
