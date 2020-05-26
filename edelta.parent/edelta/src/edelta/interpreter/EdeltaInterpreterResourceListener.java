package edelta.interpreter;

import static org.eclipse.emf.ecore.EcorePackage.Literals.*;

import java.util.List;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.ecore.ENamedElement;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.Resource.Diagnostic;
import org.eclipse.emf.ecore.util.EContentAdapter;
import org.eclipse.xtext.linking.impl.XtextLinkingDiagnostic;
import org.eclipse.xtext.util.IResourceScopeCache;
import org.eclipse.xtext.validation.EObjectDiagnosticImpl;
import org.eclipse.xtext.xbase.XExpression;

import edelta.edelta.EdeltaEcoreReferenceExpression;
import edelta.lib.EdeltaLibrary;
import edelta.resource.derivedstate.EdeltaENamedElementXExpressionMap;
import edelta.util.EdeltaModelUtil;
import edelta.validation.EdeltaValidator;

/**
 * Listens for changes on a {@link Resource} and performs tasks accordingly.
 * 
 * For example, it clears the {@link IResourceScopeCache} of the specified
 * {@link Resource} and removes issues added by the type system properly.
 * Scoping and type computation will be performed on the next access, taking now
 * into consideration the new information collected during interpretation.
 * 
 * @author Lorenzo Bettini
 *
 */
public class EdeltaInterpreterResourceListener extends EContentAdapter {

	private IResourceScopeCache cache;

	private Resource resource;

	private EdeltaENamedElementXExpressionMap enamedElementXExpressionMap;

	private XExpression currentExpression;

	private EdeltaInterpreterDiagnosticHelper diagnosticHelper;

	private EdeltaLibrary lib = new EdeltaLibrary();

	public EdeltaInterpreterResourceListener(IResourceScopeCache cache, Resource resource,
			EdeltaENamedElementXExpressionMap enamedElementXExpressionMap,
			EdeltaInterpreterDiagnosticHelper diagnosticHelper) {
		this.cache = cache;
		this.resource = resource;
		this.enamedElementXExpressionMap = enamedElementXExpressionMap;
		this.diagnosticHelper = diagnosticHelper;
	}

	@Override
	public void notifyChanged(Notification notification) {
		super.notifyChanged(notification);
		if (notification.getFeature() == ENAMED_ELEMENT__NAME) {
			enamedElementXExpressionMap.put(
				(ENamedElement) notification.getNotifier(),
				currentExpression);
		} else {
			final Object newValue = notification.getNewValue();
			if (notification.getEventType() == Notification.ADD &&
					newValue instanceof ENamedElement) {
				enamedElementXExpressionMap.put(
					(ENamedElement) newValue,
					currentExpression);
				if (notification.getFeature() == EPACKAGE__ESUBPACKAGES) {
					EPackage subPackage = (EPackage) newValue;
					if (EdeltaModelUtil.hasCycleInSuperPackage(subPackage)) {
						diagnosticHelper.addError(subPackage, EdeltaValidator.EPACKAGE_CYCLE,
							"Cycle in superpackage/subpackage: " +
								lib.getEObjectRepr(subPackage));
					}
				}
			}
		}
		cache.clear(resource);
		clearIssues(resource.getErrors());
		clearIssues(resource.getWarnings());
	}

	public void setCurrentExpression(XExpression currentExpression) {
		this.currentExpression = currentExpression;
	}

	private void clearIssues(final List<Diagnostic> issues) {
		issues.removeIf(this::isToBeRemoved);
	}

	private boolean isToBeRemoved(Diagnostic d) {
		if (d instanceof EdeltaInterpreterDiagnostic)
			return false;
		if (d instanceof XtextLinkingDiagnostic)
			return true;
		if (d instanceof EObjectDiagnosticImpl) {
			// during typing if the EdeltaEcoreReferenceExpression.EdeltaEcoreReference
			// is not resolved, RootResolvedTypes will put an error of type mismatch
			// the interpreter might change the metamodel and later the ecoreref
			// might become valid, so we must remove previous errors when the metamodel
			// changes
			return ((EObjectDiagnosticImpl) d).getProblematicObject() instanceof EdeltaEcoreReferenceExpression;
		}
		return false;
	}
}
