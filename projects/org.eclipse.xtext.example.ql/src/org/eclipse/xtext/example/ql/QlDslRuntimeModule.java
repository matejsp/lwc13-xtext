/*
 * generated by Xtext
 */
package org.eclipse.xtext.example.ql;

import org.eclipse.xtext.example.ql.customizing.JvmModelAssociatorCustom;
import org.eclipse.xtext.example.ql.generator.JSFOutputConfigurationProvider;
import org.eclipse.xtext.example.ql.generator.Root;
import org.eclipse.xtext.generator.IGenerator;
import org.eclipse.xtext.generator.IOutputConfigurationProvider;
import org.eclipse.xtext.xbase.jvmmodel.ILogicalContainerProvider;

import com.google.inject.Binder;
import com.google.inject.Singleton;

/**
 * Use this class to register components to be used at runtime / without the
 * Equinox extension registry.
 */
public class QlDslRuntimeModule extends
    org.eclipse.xtext.example.ql.AbstractQlDslRuntimeModule {
  // @Override
  // public Class<? extends IScopeProvider> bindIScopeProvider() {
  // return QlScopeProvider.class;
  // }

  @Override
  public Class<? extends IGenerator> bindIGenerator() {
    return Root.class;
  }

  public Class<? extends ILogicalContainerProvider> bindILogicalContainerProvider() {
    return JvmModelAssociatorCustom.class;
  }

  @Override
  public void configure(Binder binder) {
    super.configure(binder);
    binder.bind(IOutputConfigurationProvider.class)
        .to(JSFOutputConfigurationProvider.class).in(Singleton.class);
  }
}
