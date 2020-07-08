package edelta.util

import com.google.inject.Inject
import edelta.resource.derivedstate.EdeltaDerivedStateHelper
import org.eclipse.emf.ecore.ENamedElement
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.util.IResourceScopeCache

import static edelta.util.EdeltaModelUtil.*

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
	@Inject extension EdeltaDerivedStateHelper

	/**
	 * Returns all the ENamedElements in the program:
	 * it uses the copied EPackages if present, otherwise it uses the original
	 * imported metamodels, but NOT both.
	 */
	def Iterable<? extends ENamedElement> getProgramENamedElements(EObject context) {
		cache.get("getProgramENamedElements", context.eResource) [
			val prog = getProgram(context)
			val copied = prog.eResource.copiedEPackagesMap.values
			// copied EPackage are present only when there's at least one modifyEcore
			val epackages = copied.empty ? prog.metamodels : copied
			return epackages.map[getAllENamedElements].flatten.toList
		]
	}

	/**
	 * Returns all ENamedElements of the passed EPackage, recursively,
	 * including subpackages and getAllENamedElements on each subpackage
	 */
	def private Iterable<ENamedElement> getAllENamedElements(EPackage e) {
		EcoreUtil2.eAllContents(e).filter(ENamedElement)
	}

	def Iterable<? extends ENamedElement> getENamedElements(ENamedElement e) {
		if (e === null)
			return emptyList
		return e.eContents.filter(ENamedElement)
	}

}
