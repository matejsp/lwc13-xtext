/*
 * generated by Xtext
 */
package org.eclipse.xtext.example.ql;

import org.eclipse.xtext.example.ql.customizing.QlScopeProvider;
import org.eclipse.xtext.example.ql.generator.Root;
import org.eclipse.xtext.generator.IGenerator;
import org.eclipse.xtext.scoping.IScopeProvider;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class QlDslRuntimeModule extends org.eclipse.xtext.example.ql.AbstractQlDslRuntimeModule {
	@Override
	public Class<? extends IScopeProvider> bindIScopeProvider() {
		return QlScopeProvider.class;
	}
	
	@Override
	public Class<? extends IGenerator> bindIGenerator() {
		return Root.class;
	}
}
