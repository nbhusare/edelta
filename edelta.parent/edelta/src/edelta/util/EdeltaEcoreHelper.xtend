/*
 * generated by Xtext 2.10.0
 */
package edelta.util

import com.google.inject.Inject
import edelta.resource.EdeltaDerivedStateComputer
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EDataType
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.xtext.util.IResourceScopeCache
import org.eclipse.emf.ecore.ENamedElement
import java.util.Collections

/**
 * Helper methods for accessing Ecore elements.
 * 
 * Computations that require filtering or mapping are cached in the scope
 * of the resource.
 * 
 * @author Lorenzo Bettini
 */
class EdeltaEcoreHelper {

	@Inject IResourceScopeCache cache
	@Inject extension EdeltaModelUtil
	@Inject extension EdeltaDerivedStateComputer

	/**
	 * If the passed EPackage is not null then it only returns the
	 * classifiers of that package, otherwise it returns all the
	 * available classifiers in the current program, including the
	 * created ones by the derived state computer.
	 */
	def getEClassifiers(EObject context, EPackage epackage) {
		getEClassifiers(context, epackage, null)
	}

	def getEClasses(EObject context, EPackage epackage) {
		getEClassifiers(context, epackage, EClass)
	}

	def getEDataTypes(EObject context, EPackage epackage) {
		getEClassifiers(context, epackage, EDataType)
	}

	def private getEClassifiers(EObject context,
			EPackage epackage,
			Class<? extends EClassifier> kind
	) {
		if (epackage !== null) {
			if (kind !== null)
				return epackage.getEClassifiers.filter(kind)
			return epackage.getEClassifiers
		}
		return 
			switch (kind) {
				case kind === EClass: getEClasses(context)
				case kind === EDataType: getEDataTypes(context)
				default: getEClassifiers(context)
			}
	}

	def private getEClassifiers(EObject context) {
		cache.get("getEClassifiers", context.eResource) [
			val prog = getProgram(context)
			// we also must explicitly consider the derived EPackages
			// created by our derived state computer, containing EClasses
			// created in the program
			(
				context.eResource.derivedEPackages.
					map[getEClassifiers].
					flatten
			+
				prog.metamodels.
					map[getEClassifiers].
					flatten
			).toList
		]
	}

	def private getEClasses(EObject context) {
		cache.get("getEClasses", context.eResource) [
			getEClassifiers(context).filter(EClass).toList
		]
	}

	def private getEDataTypes(EObject context) {
		cache.get("getEDataTypes", context.eResource) [
			getEClassifiers(context).filter(EDataType).toList
		]
	}

//	def private getEStructuralFeatures(EObject context) {
//		cache.get("getEStructuralFeatures", context.eResource) [
//			getEClasses(context).map[
//				getEStructuralFeatures
//			].flatten.toList
//		]
//	}

	def dispatch Iterable<? extends ENamedElement> getENamedElements(ENamedElement e) {
		Collections.emptyList
	}

	def dispatch Iterable<? extends ENamedElement> getENamedElements(EPackage e) {
		val classifiers = e.getEClassifiers
		classifiers +
		classifiers.map[getENamedElements].flatten
	}

	def dispatch Iterable<? extends ENamedElement> getENamedElements(EClass e) {
		e.EAllStructuralFeatures
	}
}
