package org.eclipse.xtext.example.ql.generator

import javax.inject.Inject
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.xbase.compiler.JvmModelGenerator

class Root implements IGenerator {
	@Inject JvmModelGenerator jvmModelGenerator

	override doGenerate(Resource input, IFileSystemAccess fsa) {
		// dispatch to other generators
		jvmModelGenerator.doGenerate(input, fsa)
		
	}
	
}