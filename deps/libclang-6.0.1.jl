using CBinding: @macros
@macros

@cbindings "{{ LIBCLANG_PATH }}" begin
	@doc raw"""
	\\brief A generic error code, no further details are available.
	
	Errors of this kind can get their own specific error codes in future
	libclang versions.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:41:3)
	""" CXError_Failure
	@doc raw"""
	\\brief Error codes returned by libclang routines.
	
	Zero (\\c CXError_Success) is the only error code indicating success.  Other
	error codes, including not yet assigned non-zero values, indicate errors.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:29:6)
	""" CXErrorCode
	@doc raw"""
	\\brief No error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:33:3)
	""" CXError_Success
	@doc raw"""
	\\brief libclang crashed while performing the requested operation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:46:3)
	""" CXError_Crashed
	@doc raw"""
	\\brief The function detected that the arguments violate the function
	contract.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:52:3)
	""" CXError_InvalidArguments
	@doc raw"""
	\\brief An AST deserialization error has occurred.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXErrorCode.h:57:3)
	""" CXError_ASTReadError
	export CXErrorCode, CXError_ASTReadError, CXError_Crashed, CXError_Failure, CXError_InvalidArguments, CXError_Success
	@cenum CXErrorCode {
		CXError_Success = (@Cuint)(0)
		CXError_Failure = (@Cuint)(1)
		CXError_Crashed = (@Cuint)(2)
		CXError_InvalidArguments = (@Cuint)(3)
		CXError_ASTReadError = (@Cuint)(4)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXString.h:41:3)
	""" CXString
	export CXString
	@ctypedef CXString @cstruct {
		data::(@Ptr){(@Cconst)(@Cvoid)}
		private_flags::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXString.h:46:3)
	""" CXStringSet
	export CXStringSet
	@ctypedef CXStringSet @cstruct {
		Strings::(@Ptr){CXString}
		Count::@Cuint
	}
	
	@doc raw"""
	\\brief Retrieve the character data associated with the given string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXString.h:51:28)
	""" clang_getCString
	export clang_getCString
	@cextern clang_getCString(string::CXString)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	\\brief Free the given string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXString.h:56:21)
	""" clang_disposeString
	export clang_disposeString
	@cextern clang_disposeString(string::CXString)::@Cvoid
	
	@doc raw"""
	\\brief Free the given string set.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXString.h:61:21)
	""" clang_disposeStringSet
	export clang_disposeStringSet
	@cextern clang_disposeStringSet(set::(@Ptr){CXStringSet})::@Cvoid
	
	@doc raw"""
	\\brief Return the timestamp for use with Clang's
	\\c -fbuild-session-timestamp= option.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:34:35)
	""" clang_getBuildSessionTimestamp
	export clang_getBuildSessionTimestamp
	@cextern clang_getBuildSessionTimestamp()::@Culonglong
	
	@doc raw"""
	\\brief Object encapsulating information about overlaying virtual
	file/directories over the real file system.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:40:42)
	""" CXVirtualFileOverlay
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:40:16)
	""" CXVirtualFileOverlayImpl
	export CXVirtualFileOverlay, CXVirtualFileOverlayImpl
	@ctypedef CXVirtualFileOverlay (@Ptr){@cstruct CXVirtualFileOverlayImpl}
	
	@doc raw"""
	\\brief Create a \\c CXVirtualFileOverlay object.
	Must be disposed with \\c clang_VirtualFileOverlay_dispose().
	
	\\param options is reserved, always pass 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:49:1)
	""" clang_VirtualFileOverlay_create
	export clang_VirtualFileOverlay_create
	@cextern clang_VirtualFileOverlay_create(options::@Cuint)::CXVirtualFileOverlay
	
	@doc raw"""
	\\brief Map an absolute virtual file path to an absolute real one.
	The virtual path must be canonicalized (not contain "."/"..").
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:57:1)
	""" clang_VirtualFileOverlay_addFileMapping
	export clang_VirtualFileOverlay_addFileMapping
	@cextern clang_VirtualFileOverlay_addFileMapping(var"?1?"::CXVirtualFileOverlay, virtualPath::(@Ptr){(@Cconst)(@Cchar)}, realPath::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	\\brief Set the case sensitivity for the \\c CXVirtualFileOverlay object.
	The \\c CXVirtualFileOverlay object is case-sensitive by default, this
	option can be used to override the default.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:68:1)
	""" clang_VirtualFileOverlay_setCaseSensitivity
	export clang_VirtualFileOverlay_setCaseSensitivity
	@cextern clang_VirtualFileOverlay_setCaseSensitivity(var"?1?"::CXVirtualFileOverlay, caseSensitive::(@Cint))::CXErrorCode
	
	@doc raw"""
	\\brief Write out the \\c CXVirtualFileOverlay object to a char buffer.
	
	\\param options is reserved, always pass 0.
	\\param out_buffer_ptr pointer to receive the buffer pointer, which should be
	disposed using \\c clang_free().
	\\param out_buffer_size pointer to receive the buffer size.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:81:1)
	""" clang_VirtualFileOverlay_writeToBuffer
	export clang_VirtualFileOverlay_writeToBuffer
	@cextern clang_VirtualFileOverlay_writeToBuffer(var"?1?"::CXVirtualFileOverlay, options::(@Cuint), out_buffer_ptr::(@Ptr){(@Ptr){@Cchar}}, out_buffer_size::(@Ptr){@Cuint})::CXErrorCode
	
	@doc raw"""
	\\brief free memory allocated by libclang, such as the buffer returned by
	\\c CXVirtualFileOverlay() or \\c clang_ModuleMapDescriptor_writeToBuffer().
	
	\\param buffer memory pointer to free.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:91:21)
	""" clang_free
	export clang_free
	@cextern clang_free(buffer::(@Ptr){@Cvoid})::@Cvoid
	
	@doc raw"""
	\\brief Dispose a \\c CXVirtualFileOverlay object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:96:21)
	""" clang_VirtualFileOverlay_dispose
	export clang_VirtualFileOverlay_dispose
	@cextern clang_VirtualFileOverlay_dispose(var"?1?"::CXVirtualFileOverlay)::@Cvoid
	
	@doc raw"""
	\\brief Object encapsulating information about a module.map file.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:101:43)
	""" CXModuleMapDescriptor
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:101:16)
	""" CXModuleMapDescriptorImpl
	export CXModuleMapDescriptor, CXModuleMapDescriptorImpl
	@ctypedef CXModuleMapDescriptor (@Ptr){@cstruct CXModuleMapDescriptorImpl}
	
	@doc raw"""
	\\brief Create a \\c CXModuleMapDescriptor object.
	Must be disposed with \\c clang_ModuleMapDescriptor_dispose().
	
	\\param options is reserved, always pass 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:110:1)
	""" clang_ModuleMapDescriptor_create
	export clang_ModuleMapDescriptor_create
	@cextern clang_ModuleMapDescriptor_create(options::@Cuint)::CXModuleMapDescriptor
	
	@doc raw"""
	\\brief Sets the framework module name that the module.map describes.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:117:1)
	""" clang_ModuleMapDescriptor_setFrameworkModuleName
	export clang_ModuleMapDescriptor_setFrameworkModuleName
	@cextern clang_ModuleMapDescriptor_setFrameworkModuleName(var"?1?"::CXModuleMapDescriptor, name::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	\\brief Sets the umbrealla header name that the module.map describes.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:125:1)
	""" clang_ModuleMapDescriptor_setUmbrellaHeader
	export clang_ModuleMapDescriptor_setUmbrellaHeader
	@cextern clang_ModuleMapDescriptor_setUmbrellaHeader(var"?1?"::CXModuleMapDescriptor, name::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	\\brief Write out the \\c CXModuleMapDescriptor object to a char buffer.
	
	\\param options is reserved, always pass 0.
	\\param out_buffer_ptr pointer to receive the buffer pointer, which should be
	disposed using \\c clang_free().
	\\param out_buffer_size pointer to receive the buffer size.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:138:1)
	""" clang_ModuleMapDescriptor_writeToBuffer
	export clang_ModuleMapDescriptor_writeToBuffer
	@cextern clang_ModuleMapDescriptor_writeToBuffer(var"?1?"::CXModuleMapDescriptor, options::(@Cuint), out_buffer_ptr::(@Ptr){(@Ptr){@Cchar}}, out_buffer_size::(@Ptr){@Cuint})::CXErrorCode
	
	@doc raw"""
	\\brief Dispose a \\c CXModuleMapDescriptor object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/BuildSystem.h:145:21)
	""" clang_ModuleMapDescriptor_dispose
	export clang_ModuleMapDescriptor_dispose
	@cextern clang_ModuleMapDescriptor_dispose(var"?1?"::CXModuleMapDescriptor)::@Cvoid
	
	@doc raw"""
	A compilation database holds all information used to compile files in a
	project. For each file in the database, it can be queried for the working
	directory or the command line used for the compiler invocation.
	
	Must be freed by \\c clang_CompilationDatabase_dispose
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:38:16)
	""" CXCompilationDatabase
	export CXCompilationDatabase
	@ctypedef CXCompilationDatabase (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Contains the results of a search in the compilation database
	
	When searching for the compile command for a file, the compilation db can
	return several commands, as the file may have been compiled with
	different options in different places of the project. This choice of compile
	commands is wrapped in this opaque data structure. It must be freed by
	\\c clang_CompileCommands_dispose.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:49:16)
	""" CXCompileCommands
	export CXCompileCommands
	@ctypedef CXCompileCommands (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Represents the command line invocation to compile a specific file.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:54:16)
	""" CXCompileCommand
	export CXCompileCommand
	@ctypedef CXCompileCommand (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:70:3)
	""" CXCompilationDatabase_Error
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:63:3)
	""" CXCompilationDatabase_NoError
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:68:3)
	""" CXCompilationDatabase_CanNotLoadDatabase
	export CXCompilationDatabase_CanNotLoadDatabase, CXCompilationDatabase_Error, CXCompilationDatabase_NoError
	@ctypedef CXCompilationDatabase_Error @cenum {
		CXCompilationDatabase_NoError = (@Cuint)(0)
		CXCompilationDatabase_CanNotLoadDatabase = (@Cuint)(1)
	}
	
	@doc raw"""
	\\brief Creates a compilation database from the database found in directory
	buildDir. For example, CMake can output a compile_commands.json which can
	be used to build the database.
	
	It must be freed by \\c clang_CompilationDatabase_dispose.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:80:1)
	""" clang_CompilationDatabase_fromDirectory
	export clang_CompilationDatabase_fromDirectory
	@cextern clang_CompilationDatabase_fromDirectory(BuildDir::(@Ptr){(@Cconst)(@Cchar)}, ErrorCode::(@Ptr){CXCompilationDatabase_Error})::CXCompilationDatabase
	
	@doc raw"""
	\\brief Free the given compilation database
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:87:1)
	""" clang_CompilationDatabase_dispose
	export clang_CompilationDatabase_dispose
	@cextern clang_CompilationDatabase_dispose(var"?1?"::CXCompilationDatabase)::@Cvoid
	
	@doc raw"""
	\\brief Find the compile commands used for a file. The compile commands
	must be freed by \\c clang_CompileCommands_dispose.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:94:1)
	""" clang_CompilationDatabase_getCompileCommands
	export clang_CompilationDatabase_getCompileCommands
	@cextern clang_CompilationDatabase_getCompileCommands(var"?1?"::CXCompilationDatabase, CompleteFileName::(@Ptr){(@Cconst)(@Cchar)})::CXCompileCommands
	
	@doc raw"""
	\\brief Get all the compile commands in the given compilation database.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:101:1)
	""" clang_CompilationDatabase_getAllCompileCommands
	export clang_CompilationDatabase_getAllCompileCommands
	@cextern clang_CompilationDatabase_getAllCompileCommands(var"?1?"::CXCompilationDatabase)::CXCompileCommands
	
	@doc raw"""
	\\brief Free the given CompileCommands
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:106:21)
	""" clang_CompileCommands_dispose
	export clang_CompileCommands_dispose
	@cextern clang_CompileCommands_dispose(var"?1?"::CXCompileCommands)::@Cvoid
	
	@doc raw"""
	\\brief Get the number of CompileCommand we have for a file
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:112:1)
	""" clang_CompileCommands_getSize
	export clang_CompileCommands_getSize
	@cextern clang_CompileCommands_getSize(var"?1?"::CXCompileCommands)::@Cuint
	
	@doc raw"""
	\\brief Get the I'th CompileCommand for a file
	
	Note : 0 <= i < clang_CompileCommands_getSize(CXCompileCommands)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:120:1)
	""" clang_CompileCommands_getCommand
	export clang_CompileCommands_getCommand
	@cextern clang_CompileCommands_getCommand(var"?1?"::CXCompileCommands, I::(@Cuint))::CXCompileCommand
	
	@doc raw"""
	\\brief Get the working directory where the CompileCommand was executed from
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:126:1)
	""" clang_CompileCommand_getDirectory
	export clang_CompileCommand_getDirectory
	@cextern clang_CompileCommand_getDirectory(var"?1?"::CXCompileCommand)::CXString
	
	@doc raw"""
	\\brief Get the filename associated with the CompileCommand.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:132:1)
	""" clang_CompileCommand_getFilename
	export clang_CompileCommand_getFilename
	@cextern clang_CompileCommand_getFilename(var"?1?"::CXCompileCommand)::CXString
	
	@doc raw"""
	\\brief Get the number of arguments in the compiler invocation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:139:1)
	""" clang_CompileCommand_getNumArgs
	export clang_CompileCommand_getNumArgs
	@cextern clang_CompileCommand_getNumArgs(var"?1?"::CXCompileCommand)::@Cuint
	
	@doc raw"""
	\\brief Get the I'th argument value in the compiler invocations
	
	Invariant :
	- argument 0 is the compiler executable
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:148:1)
	""" clang_CompileCommand_getArg
	export clang_CompileCommand_getArg
	@cextern clang_CompileCommand_getArg(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	\\brief Get the number of source mappings for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:154:1)
	""" clang_CompileCommand_getNumMappedSources
	export clang_CompileCommand_getNumMappedSources
	@cextern clang_CompileCommand_getNumMappedSources(var"?1?"::CXCompileCommand)::@Cuint
	
	@doc raw"""
	\\brief Get the I'th mapped source path for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:160:1)
	""" clang_CompileCommand_getMappedSourcePath
	export clang_CompileCommand_getMappedSourcePath
	@cextern clang_CompileCommand_getMappedSourcePath(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	\\brief Get the I'th mapped source content for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/CXCompilationDatabase.h:166:1)
	""" clang_CompileCommand_getMappedSourceContent
	export clang_CompileCommand_getMappedSourceContent
	@cextern clang_CompileCommand_getMappedSourceContent(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	\\brief An "index" that consists of a set of translation units that would
	typically be linked together into an executable or library.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:81:15)
	""" CXIndex
	export CXIndex
	@ctypedef CXIndex (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:87:16)
	""" CXTargetInfoImpl
	@doc raw"""
	\\brief An opaque type representing target information for a given translation
	unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:87:34)
	""" CXTargetInfo
	export CXTargetInfo, CXTargetInfoImpl
	@ctypedef CXTargetInfo (@Ptr){@cstruct CXTargetInfoImpl}
	
	@doc raw"""
	\\brief A single translation unit, which resides in an index.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:92:39)
	""" CXTranslationUnit
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:92:16)
	""" CXTranslationUnitImpl
	export CXTranslationUnit, CXTranslationUnitImpl
	@ctypedef CXTranslationUnit (@Ptr){@cstruct CXTranslationUnitImpl}
	
	@doc raw"""
	\\brief Opaque pointer representing client data that will be passed through
	to various callbacks and visitors.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:98:15)
	""" CXClientData
	export CXClientData
	@ctypedef CXClientData (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Provides the contents of a file that has not yet been saved to disk.
	
	Each CXUnsavedFile instance provides the name of a file on the
	system along with the current contents of that file that have not
	yet been saved to disk.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:107:8)
	""" CXUnsavedFile
	export CXUnsavedFile
	@cstruct CXUnsavedFile {
		Filename::(@Ptr){(@Cconst)(@Cchar)}
		Contents::(@Ptr){(@Cconst)(@Cchar)}
		Length::@Culong
	}
	
	@doc raw"""
	\\brief The entity is available, but has been deprecated (and its use is
	not recommended).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:140:3)
	""" CXAvailability_Deprecated
	@doc raw"""
	\\brief The entity is not available; any use of it will be an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:144:3)
	""" CXAvailability_NotAvailable
	@doc raw"""
	\\brief Describes the availability of a particular entity, which indicates
	whether the use of this entity will result in a warning or error due to
	it being deprecated or unavailable.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:131:6)
	""" CXAvailabilityKind
	@doc raw"""
	\\brief The entity is available, but not accessible; any use of it will be
	an error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:149:3)
	""" CXAvailability_NotAccessible
	@doc raw"""
	\\brief The entity is available.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:135:3)
	""" CXAvailability_Available
	export CXAvailabilityKind, CXAvailability_Available, CXAvailability_Deprecated, CXAvailability_NotAccessible, CXAvailability_NotAvailable
	@cenum CXAvailabilityKind {
		CXAvailability_Available = (@Cuint)(0)
		CXAvailability_Deprecated = (@Cuint)(1)
		CXAvailability_NotAvailable = (@Cuint)(2)
		CXAvailability_NotAccessible = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Describes a version number of the form major.minor.subminor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:155:16)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:173:3)
	""" CXVersion
	export CXVersion
	@ctypedef CXVersion @cstruct CXVersion {
		Major::@Cint
		Minor::@Cint
		Subminor::@Cint
	}
	
	@doc raw"""
	\\brief The cursor has exception specification basic noexcept.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:205:3)
	""" CXCursor_ExceptionSpecificationKind_BasicNoexcept
	@doc raw"""
	\\brief The cursor has exception specification throw(...).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:200:3)
	""" CXCursor_ExceptionSpecificationKind_MSAny
	@doc raw"""
	\\brief The cursor has exception specification throw(T1, T2)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:195:3)
	""" CXCursor_ExceptionSpecificationKind_Dynamic
	@doc raw"""
	\\brief The cursor has exception specification throw()
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:190:3)
	""" CXCursor_ExceptionSpecificationKind_DynamicNone
	@doc raw"""
	\\brief The cursor has exception specification computed noexcept.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:210:3)
	""" CXCursor_ExceptionSpecificationKind_ComputedNoexcept
	@doc raw"""
	\\brief The cursor has no exception specification.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:185:3)
	""" CXCursor_ExceptionSpecificationKind_None
	@doc raw"""
	\\brief The exception specification has not yet been evaluated.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:215:3)
	""" CXCursor_ExceptionSpecificationKind_Unevaluated
	@doc raw"""
	\\brief The exception specification has not yet been instantiated.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:220:3)
	""" CXCursor_ExceptionSpecificationKind_Uninstantiated
	@doc raw"""
	\\brief The exception specification has not been parsed yet.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:225:3)
	""" CXCursor_ExceptionSpecificationKind_Unparsed
	@doc raw"""
	\\brief Describes the exception specification of a cursor.
	
	A negative value indicates that the cursor is not a function declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:180:6)
	""" CXCursor_ExceptionSpecificationKind
	export CXCursor_ExceptionSpecificationKind, CXCursor_ExceptionSpecificationKind_BasicNoexcept, CXCursor_ExceptionSpecificationKind_ComputedNoexcept, CXCursor_ExceptionSpecificationKind_Dynamic, CXCursor_ExceptionSpecificationKind_DynamicNone, CXCursor_ExceptionSpecificationKind_MSAny, CXCursor_ExceptionSpecificationKind_None, CXCursor_ExceptionSpecificationKind_Unevaluated, CXCursor_ExceptionSpecificationKind_Uninstantiated, CXCursor_ExceptionSpecificationKind_Unparsed
	@cenum CXCursor_ExceptionSpecificationKind {
		CXCursor_ExceptionSpecificationKind_None = (@Cuint)(0)
		CXCursor_ExceptionSpecificationKind_DynamicNone = (@Cuint)(1)
		CXCursor_ExceptionSpecificationKind_Dynamic = (@Cuint)(2)
		CXCursor_ExceptionSpecificationKind_MSAny = (@Cuint)(3)
		CXCursor_ExceptionSpecificationKind_BasicNoexcept = (@Cuint)(4)
		CXCursor_ExceptionSpecificationKind_ComputedNoexcept = (@Cuint)(5)
		CXCursor_ExceptionSpecificationKind_Unevaluated = (@Cuint)(6)
		CXCursor_ExceptionSpecificationKind_Uninstantiated = (@Cuint)(7)
		CXCursor_ExceptionSpecificationKind_Unparsed = (@Cuint)(8)
	}
	
	@doc raw"""
	\\brief Provides a shared context for creating translation units.
	
	It provides two options:
	
	- excludeDeclarationsFromPCH: When non-zero, allows enumeration of "local"
	declarations (when loading any new translation units). A "local" declaration
	is one that belongs in the translation unit itself and not in a precompiled
	header that was used by the translation unit. If zero, all declarations
	will be enumerated.
	
	Here is an example:
	
	\\code
	// excludeDeclsFromPCH = 1, displayDiagnostics=1
	Idx = clang_createIndex(1, 1);
	
	// IndexTest.pch was produced with the following command:
	// "clang -x c IndexTest.h -emit-ast -o IndexTest.pch"
	TU = clang_createTranslationUnit(Idx, "IndexTest.pch");
	
	// This will load all the symbols from 'IndexTest.pch'
	clang_visitChildren(clang_getTranslationUnitCursor(TU),
	TranslationUnitVisitor, 0);
	clang_disposeTranslationUnit(TU);
	
	// This will load all the symbols from 'IndexTest.c', excluding symbols
	// from 'IndexTest.pch'.
	char *args[] = { "-Xclang", "-include-pch=IndexTest.pch" };
	TU = clang_createTranslationUnitFromSourceFile(Idx, "IndexTest.c", 2, args,
	0, 0);
	clang_visitChildren(clang_getTranslationUnitCursor(TU),
	TranslationUnitVisitor, 0);
	clang_disposeTranslationUnit(TU);
	\\endcode
	
	This process of creating the 'pch', loading it separately, and using it (via
	-include-pch) allows 'excludeDeclsFromPCH' to remove redundant callbacks
	(which gives the indexer the same performance benefit as the compiler).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:268:24)
	""" clang_createIndex
	export clang_createIndex
	@cextern clang_createIndex(excludeDeclarationsFromPCH::(@Cint), displayDiagnostics::(@Cint))::CXIndex
	
	@doc raw"""
	\\brief Destroy the given index.
	
	The index must not be destroyed until all of the translation units created
	within that index have been destroyed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:277:21)
	""" clang_disposeIndex
	export clang_disposeIndex
	@cextern clang_disposeIndex(index::CXIndex)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:311:3)
	""" CXGlobalOptFlags
	@doc raw"""
	\\brief Used to indicate that threads that libclang creates for editing
	purposes should use background priority.
	
	Affects #clang_reparseTranslationUnit, #clang_codeCompleteAt,
	#clang_annotateTokens
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:301:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForEditing
	@doc raw"""
	\\brief Used to indicate that threads that libclang creates for indexing
	purposes should use background priority.
	
	Affects #clang_indexSourceFile, #clang_indexTranslationUnit,
	#clang_parseTranslationUnit, #clang_saveTranslationUnit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:292:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForIndexing
	@doc raw"""
	\\brief Used to indicate that all threads that libclang creates should use
	background priority.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:307:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForAll
	@doc raw"""
	\\brief Used to indicate that no special CXIndex options are needed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:283:3)
	""" CXGlobalOpt_None
	export CXGlobalOptFlags, CXGlobalOpt_None, CXGlobalOpt_ThreadBackgroundPriorityForAll, CXGlobalOpt_ThreadBackgroundPriorityForEditing, CXGlobalOpt_ThreadBackgroundPriorityForIndexing
	@ctypedef CXGlobalOptFlags @cenum {
		CXGlobalOpt_None = (@Cuint)(0)
		CXGlobalOpt_ThreadBackgroundPriorityForIndexing = (@Cuint)(1)
		CXGlobalOpt_ThreadBackgroundPriorityForEditing = (@Cuint)(2)
		CXGlobalOpt_ThreadBackgroundPriorityForAll = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Sets general options associated with a CXIndex.
	
	For example:
	\\code
	CXIndex idx = ...;
	clang_CXIndex_setGlobalOptions(idx,
	clang_CXIndex_getGlobalOptions(idx) |
	CXGlobalOpt_ThreadBackgroundPriorityForIndexing);
	\\endcode
	
	\\param options A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:326:21)
	""" clang_CXIndex_setGlobalOptions
	export clang_CXIndex_setGlobalOptions
	@cextern clang_CXIndex_setGlobalOptions(var"?1?"::CXIndex, options::(@Cuint))::@Cvoid
	
	@doc raw"""
	\\brief Gets the general options associated with a CXIndex.
	
	\\returns A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags that
	are associated with the given CXIndex object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:334:25)
	""" clang_CXIndex_getGlobalOptions
	export clang_CXIndex_getGlobalOptions
	@cextern clang_CXIndex_getGlobalOptions(var"?1?"::CXIndex)::@Cuint
	
	@doc raw"""
	\\brief Sets the invocation emission path option in a CXIndex.
	
	The invocation emission path specifies a path which will contain log
	files for certain libclang invocations. A null value (default) implies that
	libclang invocations are not logged..
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:344:1)
	""" clang_CXIndex_setInvocationEmissionPathOption
	export clang_CXIndex_setInvocationEmissionPathOption
	@cextern clang_CXIndex_setInvocationEmissionPathOption(var"?1?"::CXIndex, Path::(@Ptr){(@Cconst)(@Cchar)})::@Cvoid
	
	@doc raw"""
	\\brief A particular source file that is part of a translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:355:15)
	""" CXFile
	export CXFile
	@ctypedef CXFile (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Retrieve the complete file and path name of the given file.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:360:25)
	""" clang_getFileName
	export clang_getFileName
	@cextern clang_getFileName(SFile::CXFile)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:373:3)
	""" CXFileUniqueID
	export CXFileUniqueID
	@ctypedef CXFileUniqueID @cstruct {
		data::(@Culonglong)[3]
	}
	
	@doc raw"""
	\\brief Retrieve the unique ID for the given \\c file.
	
	\\param file the file to get the ID for.
	\\param outID stores the returned CXFileUniqueID.
	\\returns If there was a failure getting the unique ID, returns non-zero,
	otherwise returns 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:383:20)
	""" clang_getFileUniqueID
	export clang_getFileUniqueID
	@cextern clang_getFileUniqueID(file::CXFile, outID::(@Ptr){CXFileUniqueID})::@Cint
	
	@doc raw"""
	\\brief Determine whether the given header is guarded against
	multiple inclusions, either with the conventional
	\\#ifndef/\\#define/\\#endif macro guards or with \\#pragma once.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:391:1)
	""" clang_isFileMultipleIncludeGuarded
	export clang_isFileMultipleIncludeGuarded
	@cextern clang_isFileMultipleIncludeGuarded(tu::CXTranslationUnit, file::CXFile)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a file handle within the given translation unit.
	
	\\param tu the translation unit
	
	\\param file_name the name of the file.
	
	\\returns the file handle for the named file in the translation unit \\p tu,
	or a NULL file handle if the file was not a part of this translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:403:23)
	""" clang_getFile
	export clang_getFile
	@cextern clang_getFile(tu::CXTranslationUnit, file_name::(@Ptr){(@Cconst)(@Cchar)})::CXFile
	
	@doc raw"""
	\\brief Retrieve the buffer associated with the given file.
	
	\\param tu the translation unit
	
	\\param file the file for which to retrieve the buffer.
	
	\\param size [out] if non-NULL, will be set to the size of the buffer.
	
	\\returns a pointer to the buffer in memory that holds the contents of
	\\p file, or a NULL pointer when the file is not loaded.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:418:28)
	""" clang_getFileContents
	export clang_getFileContents
	@cextern clang_getFileContents(tu::CXTranslationUnit, file::CXFile, size::(@Ptr){size_t})::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	\\brief Returns non-zero if the \\c file1 and \\c file2 point to the same file,
	or they are both NULL.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:425:20)
	""" clang_File_isEqual
	export clang_File_isEqual
	@cextern clang_File_isEqual(file1::CXFile, file2::CXFile)::@Cint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:454:3)
	""" CXSourceLocation
	export CXSourceLocation
	@ctypedef CXSourceLocation @cstruct {
		ptr_data::((@Ptr){(@Cconst)(@Cvoid)})[2]
		int_data::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:466:3)
	""" CXSourceRange
	export CXSourceRange
	@ctypedef CXSourceRange @cstruct {
		ptr_data::((@Ptr){(@Cconst)(@Cvoid)})[2]
		begin_int_data::@Cuint
		end_int_data::@Cuint
	}
	
	@doc raw"""
	\\brief Retrieve a NULL (invalid) source location.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:471:33)
	""" clang_getNullLocation
	export clang_getNullLocation
	@cextern clang_getNullLocation()::CXSourceLocation
	
	@doc raw"""
	\\brief Determine whether two source locations, which must refer into
	the same translation unit, refer to exactly the same point in the source
	code.
	
	\\returns non-zero if the source locations refer to the same location, zero
	if they refer to different locations.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:481:25)
	""" clang_equalLocations
	export clang_equalLocations
	@cextern clang_equalLocations(loc1::CXSourceLocation, loc2::CXSourceLocation)::@Cuint
	
	@doc raw"""
	\\brief Retrieves the source location associated with a given file/line/column
	in a particular translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:488:33)
	""" clang_getLocation
	export clang_getLocation
	@cextern clang_getLocation(tu::CXTranslationUnit, file::CXFile, line::(@Cuint), column::(@Cuint))::CXSourceLocation
	
	@doc raw"""
	\\brief Retrieves the source location associated with a given character offset
	in a particular translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:496:33)
	""" clang_getLocationForOffset
	export clang_getLocationForOffset
	@cextern clang_getLocationForOffset(tu::CXTranslationUnit, file::CXFile, offset::(@Cuint))::CXSourceLocation
	
	@doc raw"""
	\\brief Returns non-zero if the given source location is in a system header.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:503:20)
	""" clang_Location_isInSystemHeader
	export clang_Location_isInSystemHeader
	@cextern clang_Location_isInSystemHeader(location::CXSourceLocation)::@Cint
	
	@doc raw"""
	\\brief Returns non-zero if the given source location is in the main file of
	the corresponding translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:509:20)
	""" clang_Location_isFromMainFile
	export clang_Location_isFromMainFile
	@cextern clang_Location_isFromMainFile(location::CXSourceLocation)::@Cint
	
	@doc raw"""
	\\brief Retrieve a NULL (invalid) source range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:514:30)
	""" clang_getNullRange
	export clang_getNullRange
	@cextern clang_getNullRange()::CXSourceRange
	
	@doc raw"""
	\\brief Retrieve a source range given the beginning and ending source
	locations.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:520:30)
	""" clang_getRange
	export clang_getRange
	@cextern clang_getRange(var"begin"::CXSourceLocation, var"end"::CXSourceLocation)::CXSourceRange
	
	@doc raw"""
	\\brief Determine whether two ranges are equivalent.
	
	\\returns non-zero if the ranges are the same, zero if they differ.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:528:25)
	""" clang_equalRanges
	export clang_equalRanges
	@cextern clang_equalRanges(range1::CXSourceRange, range2::CXSourceRange)::@Cuint
	
	@doc raw"""
	\\brief Returns non-zero if \\p range is null.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:534:20)
	""" clang_Range_isNull
	export clang_Range_isNull
	@cextern clang_Range_isNull(range::CXSourceRange)::@Cint
	
	@doc raw"""
	\\brief Retrieve the file, line, column, and offset represented by
	the given source location.
	
	If the location refers into a macro expansion, retrieves the
	location of the macro expansion.
	
	\\param location the location within a source file that will be decomposed
	into its parts.
	
	\\param file [out] if non-NULL, will be set to the file to which the given
	source location points.
	
	\\param line [out] if non-NULL, will be set to the line to which the given
	source location points.
	
	\\param column [out] if non-NULL, will be set to the column to which the given
	source location points.
	
	\\param offset [out] if non-NULL, will be set to the offset into the
	buffer to which the given source location points.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:558:21)
	""" clang_getExpansionLocation
	export clang_getExpansionLocation
	@cextern clang_getExpansionLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the file, line and column represented by the given source
	location, as specified in a # line directive.
	
	Example: given the following source code in a file somefile.c
	
	\\code
	#123 "dummy.c" 1
	
	static int func(void)
	{
	return 0;
	}
	\\endcode
	
	the location information returned by this function would be
	
	File: dummy.c Line: 124 Column: 12
	
	whereas clang_getExpansionLocation would have returned
	
	File: somefile.c Line: 3 Column: 12
	
	\\param location the location within a source file that will be decomposed
	into its parts.
	
	\\param filename [out] if non-NULL, will be set to the filename of the
	source location. Note that filenames returned will be for "virtual" files,
	which don't necessarily exist on the machine running clang - e.g. when
	parsing preprocessed output obtained from a different environment. If
	a non-NULL value is passed in, remember to dispose of the returned value
	using \\c clang_disposeString() once you've finished with it. For an invalid
	source location, an empty string is returned.
	
	\\param line [out] if non-NULL, will be set to the line number of the
	source location. For an invalid source location, zero is returned.
	
	\\param column [out] if non-NULL, will be set to the column number of the
	source location. For an invalid source location, zero is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:604:21)
	""" clang_getPresumedLocation
	export clang_getPresumedLocation
	@cextern clang_getPresumedLocation(location::CXSourceLocation, filename::(@Ptr){CXString}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Legacy API to retrieve the file, line, column, and offset represented
	by the given source location.
	
	This interface has been replaced by the newer interface
	#clang_getExpansionLocation(). See that interface's documentation for
	details.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:617:21)
	""" clang_getInstantiationLocation
	export clang_getInstantiationLocation
	@cextern clang_getInstantiationLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the file, line, column, and offset represented by
	the given source location.
	
	If the location refers into a macro instantiation, return where the
	location was originally spelled in the source file.
	
	\\param location the location within a source file that will be decomposed
	into its parts.
	
	\\param file [out] if non-NULL, will be set to the file to which the given
	source location points.
	
	\\param line [out] if non-NULL, will be set to the line to which the given
	source location points.
	
	\\param column [out] if non-NULL, will be set to the column to which the given
	source location points.
	
	\\param offset [out] if non-NULL, will be set to the offset into the
	buffer to which the given source location points.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:645:21)
	""" clang_getSpellingLocation
	export clang_getSpellingLocation
	@cextern clang_getSpellingLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the file, line, column, and offset represented by
	the given source location.
	
	If the location refers into a macro expansion, return where the macro was
	expanded or where the macro argument was written, if the location points at
	a macro argument.
	
	\\param location the location within a source file that will be decomposed
	into its parts.
	
	\\param file [out] if non-NULL, will be set to the file to which the given
	source location points.
	
	\\param line [out] if non-NULL, will be set to the line to which the given
	source location points.
	
	\\param column [out] if non-NULL, will be set to the column to which the given
	source location points.
	
	\\param offset [out] if non-NULL, will be set to the offset into the
	buffer to which the given source location points.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:674:21)
	""" clang_getFileLocation
	export clang_getFileLocation
	@cextern clang_getFileLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve a source location representing the first character within a
	source range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:684:33)
	""" clang_getRangeStart
	export clang_getRangeStart
	@cextern clang_getRangeStart(range::CXSourceRange)::CXSourceLocation
	
	@doc raw"""
	\\brief Retrieve a source location representing the last character within a
	source range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:690:33)
	""" clang_getRangeEnd
	export clang_getRangeEnd
	@cextern clang_getRangeEnd(range::CXSourceRange)::CXSourceLocation
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:702:3)
	""" CXSourceRangeList
	export CXSourceRangeList
	@ctypedef CXSourceRangeList @cstruct {
		count::@Cuint
		ranges::(@Ptr){CXSourceRange}
	}
	
	@doc raw"""
	\\brief Retrieve all ranges that were skipped by the preprocessor.
	
	The preprocessor will skip lines when they are surrounded by an
	if/ifdef/ifndef directive whose condition does not evaluate to true.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:710:35)
	""" clang_getSkippedRanges
	export clang_getSkippedRanges
	@cextern clang_getSkippedRanges(tu::CXTranslationUnit, file::CXFile)::(@Ptr){CXSourceRangeList}
	
	@doc raw"""
	\\brief Retrieve all ranges from all files that were skipped by the
	preprocessor.
	
	The preprocessor will skip lines when they are surrounded by an
	if/ifdef/ifndef directive whose condition does not evaluate to true.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:720:35)
	""" clang_getAllSkippedRanges
	export clang_getAllSkippedRanges
	@cextern clang_getAllSkippedRanges(tu::CXTranslationUnit)::(@Ptr){CXSourceRangeList}
	
	@doc raw"""
	\\brief Destroy the given \\c CXSourceRangeList.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:725:21)
	""" clang_disposeSourceRangeList
	export clang_disposeSourceRangeList
	@cextern clang_disposeSourceRangeList(ranges::(@Ptr){CXSourceRangeList})::@Cvoid
	
	@doc raw"""
	\\brief Describes the severity of a particular diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:740:6)
	""" CXDiagnosticSeverity
	@doc raw"""
	\\brief This diagnostic is a note that should be attached to the
	previous (non-note) diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:751:3)
	""" CXDiagnostic_Note
	@doc raw"""
	\\brief This diagnostic indicates that the code is ill-formed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:762:3)
	""" CXDiagnostic_Error
	@doc raw"""
	\\brief A diagnostic that has been suppressed, e.g., by a command-line
	option.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:745:3)
	""" CXDiagnostic_Ignored
	@doc raw"""
	\\brief This diagnostic indicates suspicious code that may not be
	wrong.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:757:3)
	""" CXDiagnostic_Warning
	@doc raw"""
	\\brief This diagnostic indicates that the code is ill-formed such
	that future parser recovery is unlikely to produce useful
	results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:769:3)
	""" CXDiagnostic_Fatal
	export CXDiagnosticSeverity, CXDiagnostic_Error, CXDiagnostic_Fatal, CXDiagnostic_Ignored, CXDiagnostic_Note, CXDiagnostic_Warning
	@cenum CXDiagnosticSeverity {
		CXDiagnostic_Ignored = (@Cuint)(0)
		CXDiagnostic_Note = (@Cuint)(1)
		CXDiagnostic_Warning = (@Cuint)(2)
		CXDiagnostic_Error = (@Cuint)(3)
		CXDiagnostic_Fatal = (@Cuint)(4)
	}
	
	@doc raw"""
	\\brief A single diagnostic, containing the diagnostic's severity,
	location, text, source ranges, and fix-it hints.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:776:15)
	""" CXDiagnostic
	export CXDiagnostic
	@ctypedef CXDiagnostic (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief A group of CXDiagnostics.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:781:15)
	""" CXDiagnosticSet
	export CXDiagnosticSet
	@ctypedef CXDiagnosticSet (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Determine the number of diagnostics in a CXDiagnosticSet.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:786:25)
	""" clang_getNumDiagnosticsInSet
	export clang_getNumDiagnosticsInSet
	@cextern clang_getNumDiagnosticsInSet(Diags::CXDiagnosticSet)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a diagnostic associated with the given CXDiagnosticSet.
	
	\\param Diags the CXDiagnosticSet to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:797:29)
	""" clang_getDiagnosticInSet
	export clang_getDiagnosticInSet
	@cextern clang_getDiagnosticInSet(Diags::CXDiagnosticSet, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	\\brief Indicates that no error occurred.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:808:3)
	""" CXLoadDiag_None
	@doc raw"""
	\\brief Describes the kind of error that occurred (if any) in a call to
	\\c clang_loadDiagnostics.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:804:6)
	""" CXLoadDiag_Error
	@doc raw"""
	\\brief Indicates that the serialized diagnostics file is invalid or
	corrupt.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:826:3)
	""" CXLoadDiag_InvalidFile
	@doc raw"""
	\\brief Indicates that an unknown error occurred while attempting to
	deserialize diagnostics.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:814:3)
	""" CXLoadDiag_Unknown
	@doc raw"""
	\\brief Indicates that the file containing the serialized diagnostics
	could not be opened.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:820:3)
	""" CXLoadDiag_CannotLoad
	export CXLoadDiag_CannotLoad, CXLoadDiag_Error, CXLoadDiag_InvalidFile, CXLoadDiag_None, CXLoadDiag_Unknown
	@cenum CXLoadDiag_Error {
		CXLoadDiag_None = (@Cuint)(0)
		CXLoadDiag_Unknown = (@Cuint)(1)
		CXLoadDiag_CannotLoad = (@Cuint)(2)
		CXLoadDiag_InvalidFile = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Deserialize a set of diagnostics from a Clang diagnostics bitcode
	file.
	
	\\param file The name of the file to deserialize.
	\\param error A pointer to a enum value recording if there was a problem
	deserializing the diagnostics.
	\\param errorString A pointer to a CXString for recording the error string
	if the file was not successfully loaded.
	
	\\returns A loaded CXDiagnosticSet if successful, and NULL otherwise.  These
	diagnostics should be released using clang_disposeDiagnosticSet().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:842:32)
	""" clang_loadDiagnostics
	export clang_loadDiagnostics
	@cextern clang_loadDiagnostics(file::(@Ptr){(@Cconst)(@Cchar)}, error::(@Ptr){CXLoadDiag_Error}, errorString::(@Ptr){CXString})::CXDiagnosticSet
	
	@doc raw"""
	\\brief Release a CXDiagnosticSet and all of its contained diagnostics.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:849:21)
	""" clang_disposeDiagnosticSet
	export clang_disposeDiagnosticSet
	@cextern clang_disposeDiagnosticSet(Diags::CXDiagnosticSet)::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the child diagnostics of a CXDiagnostic. 
	
	This CXDiagnosticSet does not need to be released by
	clang_disposeDiagnosticSet.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:857:32)
	""" clang_getChildDiagnostics
	export clang_getChildDiagnostics
	@cextern clang_getChildDiagnostics(D::CXDiagnostic)::CXDiagnosticSet
	
	@doc raw"""
	\\brief Determine the number of diagnostics produced for the given
	translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:863:25)
	""" clang_getNumDiagnostics
	export clang_getNumDiagnostics
	@cextern clang_getNumDiagnostics(Unit::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a diagnostic associated with the given translation unit.
	
	\\param Unit the translation unit to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:874:29)
	""" clang_getDiagnostic
	export clang_getDiagnostic
	@cextern clang_getDiagnostic(Unit::CXTranslationUnit, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	\\brief Retrieve the complete set of diagnostics associated with a
	translation unit.
	
	\\param Unit the translation unit to query.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:884:3)
	""" clang_getDiagnosticSetFromTU
	export clang_getDiagnosticSetFromTU
	@cextern clang_getDiagnosticSetFromTU(Unit::CXTranslationUnit)::CXDiagnosticSet
	
	@doc raw"""
	\\brief Destroy a diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:889:21)
	""" clang_disposeDiagnostic
	export clang_disposeDiagnostic
	@cextern clang_disposeDiagnostic(Diagnostic::CXDiagnostic)::@Cvoid
	
	@doc raw"""
	\\brief Options to control the display of diagnostics.
	
	The values in this enum are meant to be combined to customize the
	behavior of \\c clang_formatDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:897:6)
	""" CXDiagnosticDisplayOptions
	@doc raw"""
	\\brief Display the source-location information where the
	diagnostic was located.
	
	When set, diagnostics will be prefixed by the file, line, and
	(optionally) column to which the diagnostic refers. For example,
	
	\\code
	test.c:28: warning: extra tokens at end of #endif directive
	\\endcode
	
	This option corresponds to the clang flag \\c -fshow-source-location.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:911:3)
	""" CXDiagnostic_DisplaySourceLocation
	@doc raw"""
	\\brief If displaying the source-location information of the
	diagnostic, also include the column number.
	
	This option corresponds to the clang flag \\c -fshow-column.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:919:3)
	""" CXDiagnostic_DisplayColumn
	@doc raw"""
	\\brief Display the option name associated with this diagnostic, if any.
	
	The option name displayed (e.g., -Wconversion) will be placed in brackets
	after the diagnostic text. This option corresponds to the clang flag
	\\c -fdiagnostics-show-option.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:938:3)
	""" CXDiagnostic_DisplayOption
	@doc raw"""
	\\brief Display the category number associated with this diagnostic, if any.
	
	The category number is displayed within brackets after the diagnostic text.
	This option corresponds to the clang flag 
	\\c -fdiagnostics-show-category=id.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:947:3)
	""" CXDiagnostic_DisplayCategoryId
	@doc raw"""
	\\brief If displaying the source-location information of the
	diagnostic, also include information about source ranges in a
	machine-parsable format.
	
	This option corresponds to the clang flag
	\\c -fdiagnostics-print-source-range-info.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:929:3)
	""" CXDiagnostic_DisplaySourceRanges
	@doc raw"""
	\\brief Display the category name associated with this diagnostic, if any.
	
	The category name is displayed within brackets after the diagnostic text.
	This option corresponds to the clang flag 
	\\c -fdiagnostics-show-category=name.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:956:3)
	""" CXDiagnostic_DisplayCategoryName
	export CXDiagnosticDisplayOptions, CXDiagnostic_DisplayCategoryId, CXDiagnostic_DisplayCategoryName, CXDiagnostic_DisplayColumn, CXDiagnostic_DisplayOption, CXDiagnostic_DisplaySourceLocation, CXDiagnostic_DisplaySourceRanges
	@cenum CXDiagnosticDisplayOptions {
		CXDiagnostic_DisplaySourceLocation = (@Cuint)(1)
		CXDiagnostic_DisplayColumn = (@Cuint)(2)
		CXDiagnostic_DisplaySourceRanges = (@Cuint)(4)
		CXDiagnostic_DisplayOption = (@Cuint)(8)
		CXDiagnostic_DisplayCategoryId = (@Cuint)(16)
		CXDiagnostic_DisplayCategoryName = (@Cuint)(32)
	}
	
	@doc raw"""
	\\brief Format the given diagnostic in a manner that is suitable for display.
	
	This routine will format the given diagnostic to a string, rendering
	the diagnostic according to the various options given. The
	\\c clang_defaultDiagnosticDisplayOptions() function returns the set of
	options that most closely mimics the behavior of the clang compiler.
	
	\\param Diagnostic The diagnostic to print.
	
	\\param Options A set of options that control the diagnostic display,
	created by combining \\c CXDiagnosticDisplayOptions values.
	
	\\returns A new string containing for formatted diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:974:25)
	""" clang_formatDiagnostic
	export clang_formatDiagnostic
	@cextern clang_formatDiagnostic(Diagnostic::CXDiagnostic, Options::(@Cuint))::CXString
	
	@doc raw"""
	\\brief Retrieve the set of display options most similar to the
	default behavior of the clang compiler.
	
	\\returns A set of display options suitable for use with \\c
	clang_formatDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:984:25)
	""" clang_defaultDiagnosticDisplayOptions
	export clang_defaultDiagnosticDisplayOptions
	@cextern clang_defaultDiagnosticDisplayOptions()::@Cuint
	
	@doc raw"""
	\\brief Determine the severity of the given diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:990:1)
	""" clang_getDiagnosticSeverity
	export clang_getDiagnosticSeverity
	@cextern clang_getDiagnosticSeverity(var"?1?"::CXDiagnostic)::CXDiagnosticSeverity
	
	@doc raw"""
	\\brief Retrieve the source location of the given diagnostic.
	
	This location is where Clang would print the caret ('^') when
	displaying the diagnostic on the command line.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:998:33)
	""" clang_getDiagnosticLocation
	export clang_getDiagnosticLocation
	@cextern clang_getDiagnosticLocation(var"?1?"::CXDiagnostic)::CXSourceLocation
	
	@doc raw"""
	\\brief Retrieve the text of the given diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1003:25)
	""" clang_getDiagnosticSpelling
	export clang_getDiagnosticSpelling
	@cextern clang_getDiagnosticSpelling(var"?1?"::CXDiagnostic)::CXString
	
	@doc raw"""
	\\brief Retrieve the name of the command-line option that enabled this
	diagnostic.
	
	\\param Diag The diagnostic to be queried.
	
	\\param Disable If non-NULL, will be set to the option that disables this
	diagnostic (if any).
	
	\\returns A string that contains the command-line option used to enable this
	warning, such as "-Wconversion" or "-pedantic".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1017:25)
	""" clang_getDiagnosticOption
	export clang_getDiagnosticOption
	@cextern clang_getDiagnosticOption(Diag::CXDiagnostic, Disable::(@Ptr){CXString})::CXString
	
	@doc raw"""
	\\brief Retrieve the category number for this diagnostic.
	
	Diagnostics can be categorized into groups along with other, related
	diagnostics (e.g., diagnostics under the same warning flag). This routine 
	retrieves the category number for the given diagnostic.
	
	\\returns The number of the category that contains this diagnostic, or zero
	if this diagnostic is uncategorized.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1030:25)
	""" clang_getDiagnosticCategory
	export clang_getDiagnosticCategory
	@cextern clang_getDiagnosticCategory(var"?1?"::CXDiagnostic)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the name of a particular diagnostic category.  This
	is now deprecated.  Use clang_getDiagnosticCategoryText()
	instead.
	
	\\param Category A diagnostic category number, as returned by 
	\\c clang_getDiagnosticCategory().
	
	\\returns The name of the given diagnostic category.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1043:10)
	""" clang_getDiagnosticCategoryName
	export clang_getDiagnosticCategoryName
	@cextern clang_getDiagnosticCategoryName(Category::@Cuint)::CXString
	
	@doc raw"""
	\\brief Retrieve the diagnostic category text for a given diagnostic.
	
	\\returns The text of the given diagnostic category.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1050:25)
	""" clang_getDiagnosticCategoryText
	export clang_getDiagnosticCategoryText
	@cextern clang_getDiagnosticCategoryText(var"?1?"::CXDiagnostic)::CXString
	
	@doc raw"""
	\\brief Determine the number of source ranges associated with the given
	diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1056:25)
	""" clang_getDiagnosticNumRanges
	export clang_getDiagnosticNumRanges
	@cextern clang_getDiagnosticNumRanges(var"?1?"::CXDiagnostic)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a source range associated with the diagnostic.
	
	A diagnostic's source ranges highlight important elements in the source
	code. On the command line, Clang displays source ranges by
	underlining them with '~' characters.
	
	\\param Diagnostic the diagnostic whose range is being extracted.
	
	\\param Range the zero-based index specifying which range to
	
	\\returns the requested source range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1071:30)
	""" clang_getDiagnosticRange
	export clang_getDiagnosticRange
	@cextern clang_getDiagnosticRange(Diagnostic::CXDiagnostic, Range::(@Cuint))::CXSourceRange
	
	@doc raw"""
	\\brief Determine the number of fix-it hints associated with the
	given diagnostic.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1078:25)
	""" clang_getDiagnosticNumFixIts
	export clang_getDiagnosticNumFixIts
	@cextern clang_getDiagnosticNumFixIts(Diagnostic::CXDiagnostic)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the replacement information for a given fix-it.
	
	Fix-its are described in terms of a source range whose contents
	should be replaced by a string. This approach generalizes over
	three kinds of operations: removal of source code (the range covers
	the code to be removed and the replacement string is empty),
	replacement of source code (the range covers the code to be
	replaced and the replacement string provides the new code), and
	insertion (both the start and end of the range point at the
	insertion location, and the replacement string provides the text to
	insert).
	
	\\param Diagnostic The diagnostic whose fix-its are being queried.
	
	\\param FixIt The zero-based index of the fix-it.
	
	\\param ReplacementRange The source range whose contents will be
	replaced with the returned replacement string. Note that source
	ranges are half-open ranges [a, b), so the source code should be
	replaced from a and up to (but not including) b.
	
	\\returns A string containing text that should be replace the source
	code indicated by the \\c ReplacementRange.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1105:25)
	""" clang_getDiagnosticFixIt
	export clang_getDiagnosticFixIt
	@cextern clang_getDiagnosticFixIt(Diagnostic::CXDiagnostic, FixIt::(@Cuint), ReplacementRange::(@Ptr){CXSourceRange})::CXString
	
	@doc raw"""
	\\brief Get the original translation unit source file name.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1127:1)
	""" clang_getTranslationUnitSpelling
	export clang_getTranslationUnitSpelling
	@cextern clang_getTranslationUnitSpelling(CTUnit::CXTranslationUnit)::CXString
	
	@doc raw"""
	\\brief Return the CXTranslationUnit for a given source file and the provided
	command line arguments one would pass to the compiler.
	
	Note: The 'source_filename' argument is optional.  If the caller provides a
	NULL pointer, the name of the source file is expected to reside in the
	specified command line arguments.
	
	Note: When encountered in 'clang_command_line_args', the following options
	are ignored:
	
	'-c'
	'-emit-ast'
	'-fsyntax-only'
	'-o \\<output file>'  (both '-o' and '\\<output file>' are ignored)
	
	\\param CIdx The index object with which the translation unit will be
	associated.
	
	\\param source_filename The name of the source file to load, or NULL if the
	source file is included in \\p clang_command_line_args.
	
	\\param num_clang_command_line_args The number of command-line arguments in
	\\p clang_command_line_args.
	
	\\param clang_command_line_args The command-line arguments that would be
	passed to the \\c clang executable if it were being invoked out-of-process.
	These command-line options will be parsed and will affect how the translation
	unit is parsed. Note that the following options are ignored: '-c',
	'-emit-ast', '-fsyntax-only' (which is the default), and '-o \\<output file>'.
	
	\\param num_unsaved_files the number of unsaved file entries in \\p
	unsaved_files.
	
	\\param unsaved_files the files that have not yet been saved to disk
	but may be required for code completion, including the contents of
	those files.  The contents and name of these files (as specified by
	CXUnsavedFile) are copied when necessary, so the client only needs to
	guarantee their validity until the call to this function returns.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1169:34)
	""" clang_createTranslationUnitFromSourceFile
	export clang_createTranslationUnitFromSourceFile
	@cextern clang_createTranslationUnitFromSourceFile(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, num_clang_command_line_args::(@Cint), clang_command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_unsaved_files::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile})::CXTranslationUnit
	
	@doc raw"""
	\\brief Same as \\c clang_createTranslationUnit2, but returns
	the \\c CXTranslationUnit instead of an error code.  In case of an error this
	routine returns a \\c NULL \\c CXTranslationUnit, without further detailed
	error codes.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1183:34)
	""" clang_createTranslationUnit
	export clang_createTranslationUnit
	@cextern clang_createTranslationUnit(CIdx::CXIndex, ast_filename::(@Ptr){(@Cconst)(@Cchar)})::CXTranslationUnit
	
	@doc raw"""
	\\brief Create a translation unit from an AST file (\\c -emit-ast).
	
	\\param[out] out_TU A non-NULL pointer to store the created
	\\c CXTranslationUnit.
	
	\\returns Zero on success, otherwise returns an error code.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1195:33)
	""" clang_createTranslationUnit2
	export clang_createTranslationUnit2
	@cextern clang_createTranslationUnit2(CIdx::CXIndex, ast_filename::(@Ptr){(@Cconst)(@Cchar)}, out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	\\brief Used to indicate that no special translation-unit options are
	needed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1212:3)
	""" CXTranslationUnit_None
	@doc raw"""
	\\brief DEPRECATED: Enabled chained precompiled preambles in C++.
	
	Note: this is a *temporary* option that is available only while
	we are testing C++ precompiled preamble support. It is deprecated.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1280:3)
	""" CXTranslationUnit_CXXChainedPCH
	@doc raw"""
	\\brief Used to indicate that the parser should construct a "detailed"
	preprocessing record, including all macro definitions and instantiations.
	
	Constructing a detailed preprocessing record requires more memory
	and time to parse, since the information contained in the record
	is usually not retained. However, it can be useful for
	applications that require more detailed information about the
	behavior of the preprocessor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1224:3)
	""" CXTranslationUnit_DetailedPreprocessingRecord
	@doc raw"""
	\\brief Flags that control the creation of translation units.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	constructing the translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1207:6)
	""" CXTranslationUnit_Flags
	@doc raw"""
	\\brief Sets the preprocessor in a mode for parsing a single file only.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1320:3)
	""" CXTranslationUnit_SingleFileParse
	@doc raw"""
	\\brief Used to indicate that brief documentation comments should be
	included into the set of code completions returned from this translation
	unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1296:3)
	""" CXTranslationUnit_IncludeBriefCommentsInCodeCompletion
	@doc raw"""
	\\brief Used to indicate that the translation unit should cache some
	code-completion results with each reparse of the source file.
	
	Caching of code-completion results is a performance optimization that
	introduces some overhead to reparsing but improves the performance of
	code-completion operations.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1263:3)
	""" CXTranslationUnit_CacheCompletionResults
	@doc raw"""
	\\brief Used to indicate that the translation unit will be serialized with
	\\c clang_saveTranslationUnit.
	
	This option is typically used when parsing a header with the intent of
	producing a precompiled header.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1272:3)
	""" CXTranslationUnit_ForSerialization
	@doc raw"""
	\\brief Used to indicate that the translation unit should be built with an 
	implicit precompiled header for the preamble.
	
	An implicit precompiled header is used as an optimization when a
	particular translation unit is likely to be reparsed many times
	when the sources aren't changing that often. In this case, an
	implicit precompiled header will be built containing all of the
	initial includes at the top of the main file (what we refer to as
	the "preamble" of the file). In subsequent parses, if the
	preamble or the files in it have not changed, \\c
	clang_reparseTranslationUnit() will re-use the implicit
	precompiled header to improve parsing performance.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1253:3)
	""" CXTranslationUnit_PrecompiledPreamble
	@doc raw"""
	\\brief Used to indicate that function/method bodies should be skipped while
	parsing.
	
	This option can be used to search for declarations/definitions while
	ignoring the usages.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1289:3)
	""" CXTranslationUnit_SkipFunctionBodies
	@doc raw"""
	\\brief Used to indicate that the translation unit is incomplete.
	
	When a translation unit is considered "incomplete", semantic
	analysis that is typically performed at the end of the
	translation unit will be suppressed. For example, this suppresses
	the completion of tentative declarations in C and of
	instantiation of implicitly-instantiation function templates in
	C++. This option is typically used when parsing a header with the
	intent of producing a precompiled header.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1237:3)
	""" CXTranslationUnit_Incomplete
	@doc raw"""
	\\brief Do not stop processing when fatal errors are encountered.
	
	When fatal errors are encountered while parsing a translation unit,
	semantic analysis is typically stopped early when compiling code. A common
	source for fatal errors are unresolvable include files. For the
	purposes of an IDE, this is undesirable behavior and as much information
	as possible should be reported. Use this flag to enable this behavior.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1315:3)
	""" CXTranslationUnit_KeepGoing
	@doc raw"""
	\\brief Used to indicate that the precompiled preamble should be created on
	the first parse. Otherwise it will be created on the first reparse. This
	trades runtime on the first parse (serializing the preamble takes time) for
	reduced runtime on the second parse (can now reuse the preamble).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1304:3)
	""" CXTranslationUnit_CreatePreambleOnFirstParse
	export CXTranslationUnit_CXXChainedPCH, CXTranslationUnit_CacheCompletionResults, CXTranslationUnit_CreatePreambleOnFirstParse, CXTranslationUnit_DetailedPreprocessingRecord, CXTranslationUnit_Flags, CXTranslationUnit_ForSerialization, CXTranslationUnit_IncludeBriefCommentsInCodeCompletion, CXTranslationUnit_Incomplete, CXTranslationUnit_KeepGoing, CXTranslationUnit_None, CXTranslationUnit_PrecompiledPreamble, CXTranslationUnit_SingleFileParse, CXTranslationUnit_SkipFunctionBodies
	@cenum CXTranslationUnit_Flags {
		CXTranslationUnit_None = (@Cuint)(0)
		CXTranslationUnit_DetailedPreprocessingRecord = (@Cuint)(1)
		CXTranslationUnit_Incomplete = (@Cuint)(2)
		CXTranslationUnit_PrecompiledPreamble = (@Cuint)(4)
		CXTranslationUnit_CacheCompletionResults = (@Cuint)(8)
		CXTranslationUnit_ForSerialization = (@Cuint)(16)
		CXTranslationUnit_CXXChainedPCH = (@Cuint)(32)
		CXTranslationUnit_SkipFunctionBodies = (@Cuint)(64)
		CXTranslationUnit_IncludeBriefCommentsInCodeCompletion = (@Cuint)(128)
		CXTranslationUnit_CreatePreambleOnFirstParse = (@Cuint)(256)
		CXTranslationUnit_KeepGoing = (@Cuint)(512)
		CXTranslationUnit_SingleFileParse = (@Cuint)(1024)
	}
	
	@doc raw"""
	\\brief Returns the set of flags that is suitable for parsing a translation
	unit that is being edited.
	
	The set of flags returned provide options for \\c clang_parseTranslationUnit()
	to indicate that the translation unit is likely to be reparsed many times,
	either explicitly (via \\c clang_reparseTranslationUnit()) or implicitly
	(e.g., by code completion (\\c clang_codeCompletionAt())). The returned flag
	set contains an unspecified set of optimizations (e.g., the precompiled 
	preamble) geared toward improving the performance of these routines. The
	set of optimizations enabled may change from one version to the next.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1335:25)
	""" clang_defaultEditingTranslationUnitOptions
	export clang_defaultEditingTranslationUnitOptions
	@cextern clang_defaultEditingTranslationUnitOptions()::@Cuint
	
	@doc raw"""
	\\brief Same as \\c clang_parseTranslationUnit2, but returns
	the \\c CXTranslationUnit instead of an error code.  In case of an error this
	routine returns a \\c NULL \\c CXTranslationUnit, without further detailed
	error codes.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1344:1)
	""" clang_parseTranslationUnit
	export clang_parseTranslationUnit
	@cextern clang_parseTranslationUnit(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint))::CXTranslationUnit
	
	@doc raw"""
	\\brief Parse the given source file and the translation unit corresponding
	to that file.
	
	This routine is the main entry point for the Clang C API, providing the
	ability to parse a source file into a translation unit that can then be
	queried by other functions in the API. This routine accepts a set of
	command-line arguments so that the compilation can be configured in the same
	way that the compiler is configured on the command line.
	
	\\param CIdx The index object with which the translation unit will be 
	associated.
	
	\\param source_filename The name of the source file to load, or NULL if the
	source file is included in \\c command_line_args.
	
	\\param command_line_args The command-line arguments that would be
	passed to the \\c clang executable if it were being invoked out-of-process.
	These command-line options will be parsed and will affect how the translation
	unit is parsed. Note that the following options are ignored: '-c', 
	'-emit-ast', '-fsyntax-only' (which is the default), and '-o \\<output file>'.
	
	\\param num_command_line_args The number of command-line arguments in
	\\c command_line_args.
	
	\\param unsaved_files the files that have not yet been saved to disk
	but may be required for parsing, including the contents of
	those files.  The contents and name of these files (as specified by
	CXUnsavedFile) are copied when necessary, so the client only needs to
	guarantee their validity until the call to this function returns.
	
	\\param num_unsaved_files the number of unsaved file entries in \\p
	unsaved_files.
	
	\\param options A bitmask of options that affects how the translation unit
	is managed but not its compilation. This should be a bitwise OR of the
	CXTranslationUnit_XXX flags.
	
	\\param[out] out_TU A non-NULL pointer to store the created
	\\c CXTranslationUnit, describing the parsed code and containing any
	diagnostics produced by the compiler.
	
	\\returns Zero on success, otherwise returns an error code.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1397:1)
	""" clang_parseTranslationUnit2
	export clang_parseTranslationUnit2
	@cextern clang_parseTranslationUnit2(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint), out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	\\brief Same as clang_parseTranslationUnit2 but requires a full command line
	for \\c command_line_args including argv[0]. This is useful if the standard
	library paths are relative to the binary.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1411:33)
	""" clang_parseTranslationUnit2FullArgv
	export clang_parseTranslationUnit2FullArgv
	@cextern clang_parseTranslationUnit2FullArgv(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint), out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	\\brief Flags that control how translation units are saved.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	saving the translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1424:6)
	""" CXSaveTranslationUnit_Flags
	@doc raw"""
	\\brief Used to indicate that no special saving options are needed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1428:3)
	""" CXSaveTranslationUnit_None
	export CXSaveTranslationUnit_Flags, CXSaveTranslationUnit_None
	@cenum CXSaveTranslationUnit_Flags {
		CXSaveTranslationUnit_None = (@Cuint)(0)
	}
	
	@doc raw"""
	\\brief Returns the set of flags that is suitable for saving a translation
	unit.
	
	The set of flags returned provide options for
	\\c clang_saveTranslationUnit() by default. The returned flag
	set contains an unspecified set of options that save translation units with
	the most commonly-requested data.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1440:25)
	""" clang_defaultSaveOptions
	export clang_defaultSaveOptions
	@cextern clang_defaultSaveOptions(TU::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	\\brief Indicates that no error occurred while saving a translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1450:3)
	""" CXSaveError_None
	@doc raw"""
	\\brief Indicates that errors during translation prevented this attempt
	to save the translation unit.
	
	Errors that prevent the translation unit from being saved can be
	extracted using \\c clang_getNumDiagnostics() and \\c clang_getDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1468:3)
	""" CXSaveError_TranslationErrors
	@doc raw"""
	\\brief Indicates that the translation unit to be saved was somehow
	invalid (e.g., NULL).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1474:3)
	""" CXSaveError_InvalidTU
	@doc raw"""
	\\brief Indicates that an unknown error occurred while attempting to save
	the file.
	
	This error typically indicates that file I/O failed when attempting to 
	write the file.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1459:3)
	""" CXSaveError_Unknown
	@doc raw"""
	\\brief Describes the kind of error that occurred (if any) in a call to
	\\c clang_saveTranslationUnit().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1446:6)
	""" CXSaveError
	export CXSaveError, CXSaveError_InvalidTU, CXSaveError_None, CXSaveError_TranslationErrors, CXSaveError_Unknown
	@cenum CXSaveError {
		CXSaveError_None = (@Cuint)(0)
		CXSaveError_Unknown = (@Cuint)(1)
		CXSaveError_TranslationErrors = (@Cuint)(2)
		CXSaveError_InvalidTU = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Saves a translation unit into a serialized representation of
	that translation unit on disk.
	
	Any translation unit that was parsed without error can be saved
	into a file. The translation unit can then be deserialized into a
	new \\c CXTranslationUnit with \\c clang_createTranslationUnit() or,
	if it is an incomplete translation unit that corresponds to a
	header, used as a precompiled header when parsing other translation
	units.
	
	\\param TU The translation unit to save.
	
	\\param FileName The file to which the translation unit will be saved.
	
	\\param options A bitmask of options that affects how the translation unit
	is saved. This should be a bitwise OR of the
	CXSaveTranslationUnit_XXX flags.
	
	\\returns A value that will match one of the enumerators of the CXSaveError
	enumeration. Zero (CXSaveError_None) indicates that the translation unit was 
	saved successfully, while a non-zero value indicates that a problem occurred.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1500:20)
	""" clang_saveTranslationUnit
	export clang_saveTranslationUnit
	@cextern clang_saveTranslationUnit(TU::CXTranslationUnit, FileName::(@Ptr){(@Cconst)(@Cchar)}, options::(@Cuint))::@Cint
	
	@doc raw"""
	\\brief Suspend a translation unit in order to free memory associated with it.
	
	A suspended translation unit uses significantly less memory but on the other
	side does not support any other calls than \\c clang_reparseTranslationUnit
	to resume it or \\c clang_disposeTranslationUnit to dispose it completely.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1511:25)
	""" clang_suspendTranslationUnit
	export clang_suspendTranslationUnit
	@cextern clang_suspendTranslationUnit(var"?1?"::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	\\brief Destroy the specified CXTranslationUnit object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1516:21)
	""" clang_disposeTranslationUnit
	export clang_disposeTranslationUnit
	@cextern clang_disposeTranslationUnit(var"?1?"::CXTranslationUnit)::@Cvoid
	
	@doc raw"""
	\\brief Used to indicate that no special reparsing options are needed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1529:3)
	""" CXReparse_None
	@doc raw"""
	\\brief Flags that control the reparsing of translation units.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	reparsing the translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1525:6)
	""" CXReparse_Flags
	export CXReparse_Flags, CXReparse_None
	@cenum CXReparse_Flags {
		CXReparse_None = (@Cuint)(0)
	}
	
	@doc raw"""
	\\brief Returns the set of flags that is suitable for reparsing a translation
	unit.
	
	The set of flags returned provide options for
	\\c clang_reparseTranslationUnit() by default. The returned flag
	set contains an unspecified set of optimizations geared toward common uses
	of reparsing. The set of optimizations enabled may change from one version 
	to the next.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1542:25)
	""" clang_defaultReparseOptions
	export clang_defaultReparseOptions
	@cextern clang_defaultReparseOptions(TU::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	\\brief Reparse the source files that produced this translation unit.
	
	This routine can be used to re-parse the source files that originally
	created the given translation unit, for example because those source files
	have changed (either on disk or as passed via \\p unsaved_files). The
	source code will be reparsed with the same command-line options as it
	was originally parsed. 
	
	Reparsing a translation unit invalidates all cursors and source locations
	that refer into that translation unit. This makes reparsing a translation
	unit semantically equivalent to destroying the translation unit and then
	creating a new translation unit with the same command-line arguments.
	However, it may be more efficient to reparse a translation 
	unit using this routine.
	
	\\param TU The translation unit whose contents will be re-parsed. The
	translation unit must originally have been built with 
	\\c clang_createTranslationUnitFromSourceFile().
	
	\\param num_unsaved_files The number of unsaved file entries in \\p
	unsaved_files.
	
	\\param unsaved_files The files that have not yet been saved to disk
	but may be required for parsing, including the contents of
	those files.  The contents and name of these files (as specified by
	CXUnsavedFile) are copied when necessary, so the client only needs to
	guarantee their validity until the call to this function returns.
	
	\\param options A bitset of options composed of the flags in CXReparse_Flags.
	The function \\c clang_defaultReparseOptions() produces a default set of
	options recommended for most uses, based on the translation unit.
	
	\\returns 0 if the sources could be reparsed.  A non-zero error code will be
	returned if reparsing was impossible, such that the translation unit is
	invalid. In such cases, the only valid call for \\c TU is
	\\c clang_disposeTranslationUnit(TU).  The error codes returned by this
	routine are described by the \\c CXErrorCode enum.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1583:20)
	""" clang_reparseTranslationUnit
	export clang_reparseTranslationUnit
	@cextern clang_reparseTranslationUnit(TU::CXTranslationUnit, num_unsaved_files::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile}, options::(@Cuint))::@Cint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1595:3)
	""" CXTUResourceUsage_GlobalCompletionResults
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1599:3)
	""" CXTUResourceUsage_SourceManager_Membuffer_MMap
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1606:3)
	""" CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1592:3)
	""" CXTUResourceUsage_AST
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1604:3)
	""" CXTUResourceUsage_SourceManager_DataStructures
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1611:3)
	""" CXTUResourceUsage_Last
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1603:3)
	""" CXTUResourceUsage_PreprocessingRecord
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1598:3)
	""" CXTUResourceUsage_SourceManager_Membuffer_Malloc
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1596:3)
	""" CXTUResourceUsage_SourceManagerContentCache
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1593:3)
	""" CXTUResourceUsage_Identifiers
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1597:3)
	""" CXTUResourceUsage_AST_SideTables
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1601:3)
	""" CXTUResourceUsage_ExternalASTSource_Membuffer_MMap
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1594:3)
	""" CXTUResourceUsage_Selectors
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1602:3)
	""" CXTUResourceUsage_Preprocessor
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1605:3)
	""" CXTUResourceUsage_Preprocessor_HeaderSearch
	@doc raw"""
	\\brief Categorizes how memory is being used by a translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1591:6)
	""" CXTUResourceUsageKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1607:3)
	""" CXTUResourceUsage_MEMORY_IN_BYTES_END
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1610:3)
	""" CXTUResourceUsage_First
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1600:3)
	""" CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc
	export CXTUResourceUsageKind, CXTUResourceUsage_AST, CXTUResourceUsage_AST_SideTables, CXTUResourceUsage_ExternalASTSource_Membuffer_MMap, CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc, CXTUResourceUsage_First, CXTUResourceUsage_GlobalCompletionResults, CXTUResourceUsage_Identifiers, CXTUResourceUsage_Last, CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN, CXTUResourceUsage_MEMORY_IN_BYTES_END, CXTUResourceUsage_PreprocessingRecord, CXTUResourceUsage_Preprocessor, CXTUResourceUsage_Preprocessor_HeaderSearch, CXTUResourceUsage_Selectors, CXTUResourceUsage_SourceManagerContentCache, CXTUResourceUsage_SourceManager_DataStructures, CXTUResourceUsage_SourceManager_Membuffer_MMap, CXTUResourceUsage_SourceManager_Membuffer_Malloc
	@cenum CXTUResourceUsageKind {
		CXTUResourceUsage_AST = (@Cuint)(1)
		CXTUResourceUsage_Identifiers = (@Cuint)(2)
		CXTUResourceUsage_Selectors = (@Cuint)(3)
		CXTUResourceUsage_GlobalCompletionResults = (@Cuint)(4)
		CXTUResourceUsage_SourceManagerContentCache = (@Cuint)(5)
		CXTUResourceUsage_AST_SideTables = (@Cuint)(6)
		CXTUResourceUsage_SourceManager_Membuffer_Malloc = (@Cuint)(7)
		CXTUResourceUsage_SourceManager_Membuffer_MMap = (@Cuint)(8)
		CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc = (@Cuint)(9)
		CXTUResourceUsage_ExternalASTSource_Membuffer_MMap = (@Cuint)(10)
		CXTUResourceUsage_Preprocessor = (@Cuint)(11)
		CXTUResourceUsage_PreprocessingRecord = (@Cuint)(12)
		CXTUResourceUsage_SourceManager_DataStructures = (@Cuint)(13)
		CXTUResourceUsage_Preprocessor_HeaderSearch = (@Cuint)(14)
		CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN = (@Cuint)(1)
		CXTUResourceUsage_MEMORY_IN_BYTES_END = (@Cuint)(14)
		CXTUResourceUsage_First = (@Cuint)(1)
		CXTUResourceUsage_Last = (@Cuint)(14)
	}
	
	@doc raw"""
	\\brief Returns the human-readable null-terminated C string that represents
	the name of the memory category.  This string should never be freed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1619:13)
	""" clang_getTUResourceUsageName
	export clang_getTUResourceUsageName
	@cextern clang_getTUResourceUsageName(kind::CXTUResourceUsageKind)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1621:16)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1627:3)
	""" CXTUResourceUsageEntry
	export CXTUResourceUsageEntry
	@ctypedef CXTUResourceUsageEntry @cstruct CXTUResourceUsageEntry {
		kind::CXTUResourceUsageKind
		amount::@Culong
	}
	
	@doc raw"""
	\\brief The memory usage of a CXTranslationUnit, broken into categories.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1632:16)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1643:3)
	""" CXTUResourceUsage
	export CXTUResourceUsage
	@ctypedef CXTUResourceUsage @cstruct CXTUResourceUsage {
		data::(@Ptr){@Cvoid}
		numEntries::@Cuint
		entries::(@Ptr){CXTUResourceUsageEntry}
	}
	
	@doc raw"""
	\\brief Return the memory usage of a translation unit.  This object
	should be released with clang_disposeCXTUResourceUsage().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1649:34)
	""" clang_getCXTUResourceUsage
	export clang_getCXTUResourceUsage
	@cextern clang_getCXTUResourceUsage(TU::CXTranslationUnit)::CXTUResourceUsage
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1651:21)
	""" clang_disposeCXTUResourceUsage
	export clang_disposeCXTUResourceUsage
	@cextern clang_disposeCXTUResourceUsage(usage::CXTUResourceUsage)::@Cvoid
	
	@doc raw"""
	\\brief Get target information for this translation unit.
	
	The CXTargetInfo object cannot outlive the CXTranslationUnit object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1659:1)
	""" clang_getTranslationUnitTargetInfo
	export clang_getTranslationUnitTargetInfo
	@cextern clang_getTranslationUnitTargetInfo(CTUnit::CXTranslationUnit)::CXTargetInfo
	
	@doc raw"""
	\\brief Destroy the CXTargetInfo object.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1665:1)
	""" clang_TargetInfo_dispose
	export clang_TargetInfo_dispose
	@cextern clang_TargetInfo_dispose(Info::CXTargetInfo)::@Cvoid
	
	@doc raw"""
	\\brief Get the normalized target triple as a string.
	
	Returns the empty string in case of any error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1673:1)
	""" clang_TargetInfo_getTriple
	export clang_TargetInfo_getTriple
	@cextern clang_TargetInfo_getTriple(Info::CXTargetInfo)::CXString
	
	@doc raw"""
	\\brief Get the pointer width of the target in bits.
	
	Returns -1 in case of error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1681:1)
	""" clang_TargetInfo_getPointerWidth
	export clang_TargetInfo_getPointerWidth
	@cextern clang_TargetInfo_getPointerWidth(Info::CXTargetInfo)::@Cint
	
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2530:3)
	""" CXCursor_PackedAttr
	@doc raw"""
	\\brief OpenMP target teams distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2499:3)
	""" CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2524:3)
	""" CXCursor_IBOutletAttr
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1788:3)
	""" CXCursor_ObjCProtocolRef
	@doc raw"""
	\\brief OpenMP atomic directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2383:3)
	""" CXCursor_OMPAtomicDirective
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1783:3)
	""" CXCursor_LastDecl
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2551:3)
	""" CXCursor_LastPreprocessing
	@doc raw"""
	\\brief OpenMP taskgroup directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2403:3)
	""" CXCursor_OMPTaskgroupDirective
	@doc raw"""
	\\brief A module import declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2558:3)
	""" CXCursor_TypeAliasTemplateDecl
	@doc raw"""
	\\brief A C++ template template parameter. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1760:3)
	""" CXCursor_TemplateTemplateParameter
	@doc raw"""
	\\brief Describes the kind of entity that a cursor refers to.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1690:6)
	""" CXCursorKind
	@doc raw"""
	\\brief A typedef. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1742:3)
	""" CXCursor_TypedefDecl
	@doc raw"""
	\\brief C++'s const_cast<> expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2027:3)
	""" CXCursor_CXXConstCastExpr
	@doc raw"""
	\\brief OpenMP parallel directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2315:3)
	""" CXCursor_OMPParallelDirective
	@doc raw"""
	\\brief OpenMP flush directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2371:3)
	""" CXCursor_OMPFlushDirective
	@doc raw"""
	\\brief A floating point number literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1934:3)
	""" CXCursor_FloatingLiteral
	@doc raw"""
	\\brief A parenthesized expression, e.g. "(1)".
	
	This AST node is only formed if full location information is requested.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1952:3)
	""" CXCursor_ParenExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2549:3)
	""" CXCursor_InclusionDirective
	@doc raw"""
	\\brief A reference to a namespace or namespace alias.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1815:3)
	""" CXCursor_NamespaceRef
	@doc raw"""
	\\brief OpenMP teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2475:3)
	""" CXCursor_OMPTeamsDistributeSimdDirective
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1789:3)
	""" CXCursor_ObjCClassRef
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1890:3)
	""" CXCursor_LastInvalid
	@doc raw"""
	\\brief OpenMP for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2323:3)
	""" CXCursor_OMPForDirective
	@doc raw"""
	\\brief A builtin binary operation expression such as "x + y" or
	"x <= y".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1966:3)
	""" CXCursor_BinaryOperator
	@doc raw"""
	\\brief OpenMP taskyield directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2359:3)
	""" CXCursor_OMPTaskyieldDirective
	@doc raw"""
	\\brief A character literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1946:3)
	""" CXCursor_CharacterLiteral
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1880:3)
	""" CXCursor_VariableRef
	@doc raw"""
	\\brief OpenMP barrier directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2363:3)
	""" CXCursor_OMPBarrierDirective
	@doc raw"""
	\\brief An expression that refers to some value declaration, such
	as a function, variable, or enumerator.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1910:3)
	""" CXCursor_DeclRefExpr
	@doc raw"""
	\\brief C++'s try statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2280:3)
	""" CXCursor_CXXTryStmt
	@doc raw"""
	\\brief A new expression for memory allocation and constructor calls, e.g:
	"new CXXNewExpr(foo)".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2065:3)
	""" CXCursor_CXXNewExpr
	@doc raw"""
	\\brief An integer literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1930:3)
	""" CXCursor_IntegerLiteral
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1887:3)
	""" CXCursor_NoDeclFound
	@doc raw"""
	\\brief An Objective-C \\@selector expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2086:3)
	""" CXCursor_ObjCSelectorExpr
	@doc raw"""
	\\brief This is the GNU Statement Expression extension: ({int X=4; X;})
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1997:3)
	""" CXCursor_StmtExpr
	@doc raw"""
	\\brief An Objective-C \\@protocol expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2090:3)
	""" CXCursor_ObjCProtocolExpr
	@doc raw"""
	\\brief Represents an @available(...) check.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2161:3)
	""" CXCursor_FirstStmt
	@doc raw"""
	\\brief C++'s dynamic_cast<> expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2019:3)
	""" CXCursor_CXXDynamicCastExpr
	@doc raw"""
	\\brief [C++ 15] C++ Throw Expression.
	
	This handles 'throw' and 'throw' assignment-expression. When
	assignment-expression isn't present, Op will be null.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2060:3)
	""" CXCursor_CXXThrowExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2542:3)
	""" CXCursor_LastAttr
	@doc raw"""
	\\brief An Objective-C instance method. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1734:3)
	""" CXCursor_ObjCInstanceMethodDecl
	@doc raw"""
	\\brief A default statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2199:3)
	""" CXCursor_DefaultStmt
	@doc raw"""
	\\brief A C++ conversion function. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1754:3)
	""" CXCursor_ConversionFunction
	@doc raw"""
	\\brief A variable. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1720:3)
	""" CXCursor_VarDecl
	@doc raw"""
	\\brief [C++ 2.13.5] C++ Boolean Literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2045:3)
	""" CXCursor_CXXBoolLiteralExpr
	@doc raw"""
	\\brief A continue statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2231:3)
	""" CXCursor_ContinueStmt
	@doc raw"""
	\\brief OpenMP parallel sections directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2343:3)
	""" CXCursor_OMPParallelSectionsDirective
	@doc raw"""
	\\brief Objective-C's \\@synchronized statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2264:3)
	""" CXCursor_ObjCAtSynchronizedStmt
	@doc raw"""
	\\brief An Objective-C \\@interface. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1724:3)
	""" CXCursor_ObjCInterfaceDecl
	@doc raw"""
	\\brief A C++ using declaration. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1772:3)
	""" CXCursor_UsingDeclaration
	@doc raw"""
	\\brief A C++ class template. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1764:3)
	""" CXCursor_ClassTemplate
	@doc raw"""
	\\brief Objective-C's \\@catch statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2252:3)
	""" CXCursor_ObjCAtCatchStmt
	@doc raw"""
	\\brief Represents an explicit C++ type conversion that uses "functional"
	notion (C++ [expr.type.conv]).
	
	Example:
	\\code
	x = int(0.5);
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2037:3)
	""" CXCursor_CXXFunctionalCastExpr
	@doc raw"""
	\\brief C++'s catch statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2276:3)
	""" CXCursor_CXXCatchStmt
	@doc raw"""
	\\brief OpenMP target parallel directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2439:3)
	""" CXCursor_OMPTargetParallelDirective
	@doc raw"""
	\\brief An enumerator constant. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1716:3)
	""" CXCursor_EnumConstantDecl
	@doc raw"""
	\\brief A C++ function template. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1762:3)
	""" CXCursor_FunctionTemplate
	@doc raw"""
	\\brief Windows Structured Exception Handling's except statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2292:3)
	""" CXCursor_SEHExceptStmt
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2533:3)
	""" CXCursor_NoDuplicateAttr
	@doc raw"""
	\\brief An Objective-C string literal i.e. @"foo".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2078:3)
	""" CXCursor_ObjCStringLiteral
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2523:3)
	""" CXCursor_IBActionAttr
	@doc raw"""
	\\brief A labelled statement in a function. 
	
	This cursor kind is used to describe the "start_over:" label statement in 
	the following example:
	
	\\code
	start_over:
	++counter;
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2184:3)
	""" CXCursor_LabelStmt
	@doc raw"""
	\\brief A for statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2219:3)
	""" CXCursor_ForStmt
	@doc raw"""
	\\brief Represents the "this" expression in C++
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2053:3)
	""" CXCursor_CXXThisExpr
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2140:3)
	""" CXCursor_LambdaExpr
	@doc raw"""
	\\brief A string literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1942:3)
	""" CXCursor_StringLiteral
	@doc raw"""
	\\brief OpenMP target parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2463:3)
	""" CXCursor_OMPTargetParallelForSimdDirective
	@doc raw"""
	\\brief A goto statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2223:3)
	""" CXCursor_GotoStmt
	@doc raw"""
	\\brief A return statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2239:3)
	""" CXCursor_ReturnStmt
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2548:3)
	""" CXCursor_MacroInstantiation
	@doc raw"""
	\\brief Represents an @available(...) check.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2156:3)
	""" CXCursor_ObjCAvailabilityCheckExpr
	@doc raw"""
	\\brief OpenMP target teams directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2487:3)
	""" CXCursor_OMPTargetTeamsDirective
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1786:3)
	""" CXCursor_FirstRef
	@doc raw"""
	\\brief An expression that represents a block literal. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1926:3)
	""" CXCursor_BlockExpr
	@doc raw"""
	\\brief An explicit cast in C (C99 6.5.4) or a C-style cast in C++
	(C++ [expr.cast]), which uses the syntax (Type)expr.
	
	For example: (int)f.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1981:3)
	""" CXCursor_CStyleCastExpr
	@doc raw"""
	\\brief A module import declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2557:3)
	""" CXCursor_ModuleImportDecl
	@doc raw"""
	\\brief A code completion overload candidate.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2573:3)
	""" CXCursor_OverloadCandidate
	@doc raw"""
	\\brief A C++ using directive. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1770:3)
	""" CXCursor_UsingDirective
	@doc raw"""
	\\brief A reference to a type declaration.
	
	A type reference occurs anywhere where a type is named but not
	declared. For example, given:
	
	\\code
	typedef unsigned size_type;
	size_type size;
	\\endcode
	
	The typedef is a declaration of size_type (CXCursor_TypedefDecl),
	while the type of the variable "size" is referenced. The cursor
	referenced by the type of size is the typedef for size_type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1805:3)
	""" CXCursor_TypeRef
	@doc raw"""
	\\brief Adaptor class for mixing declarations with statements and
	expressions.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2311:3)
	""" CXCursor_DeclStmt
	@doc raw"""
	\\brief Represents the "self" expression in an Objective-C method.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2148:3)
	""" CXCursor_ObjCSelfExpr
	@doc raw"""
	\\brief An Objective-C \\@implementation for a category. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1740:3)
	""" CXCursor_ObjCCategoryImplDecl
	@doc raw"""
	\\brief OpenMP target exit data directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2435:3)
	""" CXCursor_OMPTargetExitDataDirective
	@doc raw"""
	\\brief A GCC inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2244:3)
	""" CXCursor_AsmStmt
	@doc raw"""
	\\brief An expression that sends a message to an Objective-C
	   object or class. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1923:3)
	""" CXCursor_ObjCMessageExpr
	@doc raw"""
	\\brief An indirect goto statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2227:3)
	""" CXCursor_IndirectGotoStmt
	@doc raw"""
	\\brief OpenMP single directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2335:3)
	""" CXCursor_OMPSingleDirective
	@doc raw"""
	\\brief OpenMP parallel for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2339:3)
	""" CXCursor_OMPParallelForDirective
	@doc raw"""
	\\brief Objective-C's \\@finally statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2256:3)
	""" CXCursor_ObjCAtFinallyStmt
	@doc raw"""
	\\brief OpenMP ordered directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2379:3)
	""" CXCursor_OMPOrderedDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2532:3)
	""" CXCursor_ConstAttr
	@doc raw"""
	\\brief C++'s for (* : *) statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2284:3)
	""" CXCursor_CXXForRangeStmt
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2541:3)
	""" CXCursor_DLLImport
	@doc raw"""
	\\brief A linkage specification, e.g. 'extern "C"'. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1748:3)
	""" CXCursor_LinkageSpec
	@doc raw"""
	\\brief OpenMP distribute simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2459:3)
	""" CXCursor_OMPDistributeSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2536:3)
	""" CXCursor_CUDAGlobalAttr
	@doc raw"""
	\\brief A C++ typeid expression (C++ [expr.typeid]).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2041:3)
	""" CXCursor_CXXTypeidExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2538:3)
	""" CXCursor_CUDASharedAttr
	@doc raw"""
	\\brief A unary expression. (noexcept, sizeof, or other traits)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2074:3)
	""" CXCursor_UnaryExpr
	@doc raw"""
	\\brief Cursor that represents the translation unit itself.
	
	The translation unit cursor exists primarily to act as the root
	cursor for traversing the contents of a translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2516:3)
	""" CXCursor_FirstAttr
	@doc raw"""
	\\brief Represents a C11 generic selection.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2001:3)
	""" CXCursor_GenericSelectionExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2526:3)
	""" CXCursor_CXXFinalAttr
	@doc raw"""
	\\brief An Objective-C \\@synthesize definition. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1776:3)
	""" CXCursor_ObjCSynthesizeDecl
	@doc raw"""
	\\brief OpenMP distribute directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2427:3)
	""" CXCursor_OMPDistributeDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2539:3)
	""" CXCursor_VisibilityAttr
	@doc raw"""
	\\brief An enumeration. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1709:3)
	""" CXCursor_EnumDecl
	@doc raw"""
	\\brief The GNU address of label extension, representing &&label.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1993:3)
	""" CXCursor_AddrLabelExpr
	@doc raw"""
	\\brief An expression that refers to a member of a struct, union,
	class, Objective-C class, etc.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1916:3)
	""" CXCursor_MemberRefExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2528:3)
	""" CXCursor_AnnotateAttr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2540:3)
	""" CXCursor_DLLExport
	@doc raw"""
	\\brief A declaration whose specific kind is not exposed via this
	interface.
	
	Unexposed declarations have the same operations as any other kind
	of declaration; one can extract their location information,
	spelling, find their definitions, etc. However, the specific kind
	of the declaration is not reported.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1701:3)
	""" CXCursor_UnexposedDecl
	@doc raw"""
	\\brief [C99 6.5.2.1] Array Subscripting.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1961:3)
	""" CXCursor_ArraySubscriptExpr
	@doc raw"""
	\\brief Objective-C's collection statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2272:3)
	""" CXCursor_ObjCForCollectionStmt
	@doc raw"""
	\\brief OpenMP target simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2467:3)
	""" CXCursor_OMPTargetSimdDirective
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1780:3)
	""" CXCursor_CXXAccessSpecifier
	@doc raw"""
	\\brief A statement whose specific kind is not exposed via this
	interface.
	
	Unexposed statements have the same operations as any other kind of
	statement; one can extract their location information, spelling,
	children, etc. However, the specific kind of the statement is not
	reported.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2171:3)
	""" CXCursor_UnexposedStmt
	@doc raw"""
	\\brief An Objective-C class method. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1736:3)
	""" CXCursor_ObjCClassMethodDecl
	@doc raw"""
	\\brief Compound assignment such as "+=".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1970:3)
	""" CXCursor_CompoundAssignOperator
	@doc raw"""
	\\brief This represents the unary-expression's (except sizeof and
	alignof).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1957:3)
	""" CXCursor_UnaryOperator
	@doc raw"""
	\\brief OpenMP target data directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2415:3)
	""" CXCursor_OMPTargetDataDirective
	@doc raw"""
	\\brief OpenMP teams distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2483:3)
	""" CXCursor_OMPTeamsDistributeParallelForDirective
	@doc raw"""
	\\brief Describes an C or C++ initializer list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1989:3)
	""" CXCursor_InitListExpr
	@doc raw"""
	\\brief An Objective-C "bridged" cast expression, which casts between
	Objective-C pointers and C pointers, transferring ownership in the process.
	
	\\code
	NSString *str = (__bridge_transfer NSString *)CFCreateString();
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2099:3)
	""" CXCursor_ObjCBridgedCastExpr
	@doc raw"""
	\\brief An Objective-C instance variable. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1732:3)
	""" CXCursor_ObjCIvarDecl
	@doc raw"""
	\\brief Windows Structured Exception Handling's try statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2288:3)
	""" CXCursor_SEHTryStmt
	@doc raw"""
	\\brief An Objective-C \\@implementation. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1738:3)
	""" CXCursor_ObjCImplementationDecl
	@doc raw"""
	\\brief A break statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2235:3)
	""" CXCursor_BreakStmt
	@doc raw"""
	\\brief OpenMP SIMD directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2319:3)
	""" CXCursor_OMPSimdDirective
	@doc raw"""
	\\brief OpenMP taskloop simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2423:3)
	""" CXCursor_OMPTaskLoopSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2527:3)
	""" CXCursor_CXXOverrideAttr
	@doc raw"""
	\\brief An expression that calls a function. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1919:3)
	""" CXCursor_CallExpr
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1782:3)
	""" CXCursor_FirstDecl
	@doc raw"""
	\\brief A C++ template type parameter. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1756:3)
	""" CXCursor_TemplateTypeParameter
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1893:3)
	""" CXCursor_FirstExpr
	@doc raw"""
	\\brief OpenMP sections directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2327:3)
	""" CXCursor_OMPSectionsDirective
	@doc raw"""
	\\brief A C++ namespace alias declaration. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1768:3)
	""" CXCursor_NamespaceAlias
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1882:3)
	""" CXCursor_LastRef
	@doc raw"""
	\\brief OpenMP for SIMD directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2387:3)
	""" CXCursor_OMPForSimdDirective
	@doc raw"""
	\\brief A C++ destructor. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1752:3)
	""" CXCursor_Destructor
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1889:3)
	""" CXCursor_InvalidCode
	@doc raw"""
	\\brief OpenMP critical directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2355:3)
	""" CXCursor_OMPCriticalDirective
	@doc raw"""
	\\brief OpenMP target teams distribute directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2491:3)
	""" CXCursor_OMPTargetTeamsDistributeDirective
	@doc raw"""
	\\brief Cursor that represents the translation unit itself.
	
	The translation unit cursor exists primarily to act as the root
	cursor for traversing the contents of a translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2513:3)
	""" CXCursor_TranslationUnit
	@doc raw"""
	\\brief C++'s reinterpret_cast<> expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2023:3)
	""" CXCursor_CXXReinterpretCastExpr
	@doc raw"""
	\\brief A function or method parameter. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1722:3)
	""" CXCursor_ParmDecl
	@doc raw"""
	\\brief Windows Structured Exception Handling's leave statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2375:3)
	""" CXCursor_SEHLeaveStmt
	@doc raw"""
	\\brief OpenMP cancellation point directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2407:3)
	""" CXCursor_OMPCancellationPointDirective
	@doc raw"""
	\\brief A case statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2195:3)
	""" CXCursor_CaseStmt
	@doc raw"""
	\\brief OpenMP teams directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2399:3)
	""" CXCursor_OMPTeamsDirective
	@doc raw"""
	\\brief Implements the GNU __null extension, which is a name for a null
	pointer constant that has integral type (e.g., int or long) and is the same
	size and alignment as a pointer.
	
	The __null extension is typically only used by system headers, which define
	NULL as __null in C++ rather than using 0 (which is an integer that may not
	match the size of a pointer).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2011:3)
	""" CXCursor_GNUNullExpr
	@doc raw"""
	\\brief OpenMP teams distribute directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2471:3)
	""" CXCursor_OMPTeamsDistributeDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2529:3)
	""" CXCursor_AsmLabelAttr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2545:3)
	""" CXCursor_PreprocessingDirective
	@doc raw"""
	\\brief An imaginary number literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1938:3)
	""" CXCursor_ImaginaryLiteral
	@doc raw"""
	\\brief OpenMP target update directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2447:3)
	""" CXCursor_OMPTargetUpdateDirective
	@doc raw"""
	\\brief A field (in C) or non-static data member (in C++) in a
	struct, union, or C++ class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1714:3)
	""" CXCursor_FieldDecl
	@doc raw"""
	\\brief A function. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1718:3)
	""" CXCursor_FunctionDecl
	@doc raw"""
	\\brief OpenMP taskwait directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2367:3)
	""" CXCursor_OMPTaskwaitDirective
	@doc raw"""
	\\brief A delete expression for memory deallocation and destructor calls,
	e.g. "delete[] pArray".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2070:3)
	""" CXCursor_CXXDeleteExpr
	@doc raw"""
	\\brief A C++ constructor. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1750:3)
	""" CXCursor_Constructor
	@doc raw"""
	\\brief [C++0x 2.14.7] C++ Pointer Literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2049:3)
	""" CXCursor_CXXNullPtrLiteralExpr
	@doc raw"""
	\\brief Represents an @available(...) check.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2158:3)
	""" CXCursor_LastExpr
	@doc raw"""
	\\brief A switch statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2207:3)
	""" CXCursor_SwitchStmt
	@doc raw"""
	\\brief An if statement
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2203:3)
	""" CXCursor_IfStmt
	@doc raw"""
	\\brief OpenMP target teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2503:3)
	""" CXCursor_OMPTargetTeamsDistributeSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2525:3)
	""" CXCursor_IBOutletCollectionAttr
	@doc raw"""
	\\brief An access specifier. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1787:3)
	""" CXCursor_ObjCSuperClassRef
	@doc raw"""
	\\brief A do statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2215:3)
	""" CXCursor_DoStmt
	@doc raw"""
	\\brief OpenMP parallel for SIMD directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2391:3)
	""" CXCursor_OMPParallelForSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2521:3)
	""" CXCursor_UnexposedAttr
	@doc raw"""
	\\brief Represents an expression that computes the length of a parameter
	pack.
	
	\\code
	template<typename ...Types>
	struct count {
	static const unsigned value = sizeof...(Types);
	};
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2126:3)
	""" CXCursor_SizeOfPackExpr
	@doc raw"""
	\\brief OpenMP target teams distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2495:3)
	""" CXCursor_OMPTargetTeamsDistributeParallelForDirective
	@doc raw"""
	\\brief OpenMP 4.0 [2.4, Array Section].
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2152:3)
	""" CXCursor_OMPArraySectionExpr
	@doc raw"""
	\\brief A GCC inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2243:3)
	""" CXCursor_GCCAsmStmt
	@doc raw"""
	\\brief A MS inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2300:3)
	""" CXCursor_MSAsmStmt
	@doc raw"""
	\\brief An Objective-C \\@property declaration. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1730:3)
	""" CXCursor_ObjCPropertyDecl
	@doc raw"""
	\\brief A reference to a member of a struct, union, or class that occurs in 
	some non-expression context, e.g., a designated initializer.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1820:3)
	""" CXCursor_MemberRef
	@doc raw"""
	\\brief A C++ class template partial specialization. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1766:3)
	""" CXCursor_ClassTemplatePartialSpecialization
	@doc raw"""
	\\brief OpenMP target enter data directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2431:3)
	""" CXCursor_OMPTargetEnterDataDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2537:3)
	""" CXCursor_CUDAHostAttr
	@doc raw"""
	\\brief OpenMP target teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2505:3)
	""" CXCursor_LastStmt
	@doc raw"""
	\\brief A C++ namespace. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1746:3)
	""" CXCursor_Namespace
	@doc raw"""
	\\brief [C99 6.5.2.5]
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1985:3)
	""" CXCursor_CompoundLiteralExpr
	@doc raw"""
	\\brief An Objective-C \\@interface for a category. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1726:3)
	""" CXCursor_ObjCCategoryDecl
	@doc raw"""
	\\brief OpenMP teams distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2479:3)
	""" CXCursor_OMPTeamsDistributeParallelForSimdDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2547:3)
	""" CXCursor_MacroExpansion
	@doc raw"""
	\\brief The null statement ";": C99 6.8.3p3.
	
	This cursor kind is used to describe the null statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2306:3)
	""" CXCursor_NullStmt
	@doc raw"""
	\\brief A reference to a type declaration.
	
	A type reference occurs anywhere where a type is named but not
	declared. For example, given:
	
	\\code
	typedef unsigned size_type;
	size_type size;
	\\endcode
	
	The typedef is a declaration of size_type (CXCursor_TypedefDecl),
	while the type of the variable "size" is referenced. The cursor
	referenced by the type of size is the typedef for size_type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1806:3)
	""" CXCursor_CXXBaseSpecifier
	@doc raw"""
	\\brief Objective-C's autorelease pool statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2268:3)
	""" CXCursor_ObjCAutoreleasePoolStmt
	@doc raw"""
	\\brief a friend declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2567:3)
	""" CXCursor_FirstExtraDecl
	@doc raw"""
	\\brief A reference to a class template, function template, template
	template parameter, or class template partial specialization.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1811:3)
	""" CXCursor_TemplateRef
	@doc raw"""
	\\brief Objective-C's \\@throw statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2260:3)
	""" CXCursor_ObjCAtThrowStmt
	@doc raw"""
	\\brief OpenMP target directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2395:3)
	""" CXCursor_OMPTargetDirective
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2546:3)
	""" CXCursor_MacroDefinition
	@doc raw"""
	\\brief a friend declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2566:3)
	""" CXCursor_FriendDecl
	@doc raw"""
	\\brief An Objective-C \\@dynamic definition. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1778:3)
	""" CXCursor_ObjCDynamicDecl
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2534:3)
	""" CXCursor_CUDAConstantAttr
	@doc raw"""
	\\brief Represents a C++0x pack expansion that produces a sequence of
	expressions.
	
	A pack expansion expression contains a pattern (which itself is an
	expression) followed by an ellipsis. For example:
	
	\\code
	template<typename F, typename ...Types>
	void forward(F f, Types &&...args) {
	f(static_cast<Types&&>(args)...);
	}
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2114:3)
	""" CXCursor_PackExpansionExpr
	@doc raw"""
	\\brief An expression whose specific kind is not exposed via this
	interface.
	
	Unexposed expressions have the same operations as any other kind
	of expression; one can extract their location information,
	spelling, children, etc. However, the specific kind of the
	expression is not reported.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1904:3)
	""" CXCursor_UnexposedExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2531:3)
	""" CXCursor_PureAttr
	@doc raw"""
	\\brief Windows Structured Exception Handling's finally statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2296:3)
	""" CXCursor_SEHFinallyStmt
	@doc raw"""
	\\brief A reference to a labeled statement.
	
	This cursor kind is used to describe the jump to "start_over" in the 
	goto statement in the following example:
	
	\\code
	start_over:
	++counter;
	
	goto start_over;
	\\endcode
	
	A label reference cursor refers to a label statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1836:3)
	""" CXCursor_LabelRef
	@doc raw"""
	\\brief An Objective-C \\@encode expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2082:3)
	""" CXCursor_ObjCEncodeExpr
	@doc raw"""
	\\brief OpenMP taskloop directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2419:3)
	""" CXCursor_OMPTaskLoopDirective
	@doc raw"""
	\\brief A C++ class method. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1744:3)
	""" CXCursor_CXXMethod
	@doc raw"""
	\\brief OpenMP master directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2351:3)
	""" CXCursor_OMPMasterDirective
	@doc raw"""
	\\brief A C++ class. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1707:3)
	""" CXCursor_ClassDecl
	@doc raw"""
	\\brief OpenMP distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2455:3)
	""" CXCursor_OMPDistributeParallelForSimdDirective
	@doc raw"""
	\\brief The ?: ternary operator.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1974:3)
	""" CXCursor_ConditionalOperator
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2535:3)
	""" CXCursor_CUDADeviceAttr
	@doc raw"""
	\\brief OpenMP cancel directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2411:3)
	""" CXCursor_OMPCancelDirective
	@doc raw"""
	\\brief OpenMP distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2451:3)
	""" CXCursor_OMPDistributeParallelForDirective
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1886:3)
	""" CXCursor_InvalidFile
	@doc raw"""
	\\brief A C or C++ struct. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1703:3)
	""" CXCursor_StructDecl
	@doc raw"""
	\\brief A reference to a set of overloaded functions or function templates
	that has not yet been resolved to a specific function or function template.
	
	An overloaded declaration reference cursor occurs in C++ templates where
	a dependent name refers to a function. For example:
	
	\\code
	template<typename T> void swap(T&, T&);
	
	struct X { ... };
	void swap(X&, X&);
	
	template<typename T>
	void reverse(T* first, T* last) {
	while (first < last - 1) {
	swap(*first, *--last);
	++first;
	}
	}
	
	struct Y { };
	void swap(Y&, Y&);
	\\endcode
	
	Here, the identifier "swap" is associated with an overloaded declaration
	reference. In the template definition, "swap" refers to either of the two
	"swap" functions declared above, so both results will be available. At
	instantiation time, "swap" may also refer to other functions found via
	argument-dependent lookup (e.g., the "swap" function at the end of the
	example).
	
	The functions \\c clang_getNumOverloadedDecls() and 
	\\c clang_getOverloadedDecl() can be used to retrieve the definitions
	referenced by this cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1874:3)
	""" CXCursor_OverloadedDeclRef
	@doc raw"""
	\\brief An Objective-C \\@protocol declaration. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1728:3)
	""" CXCursor_ObjCProtocolDecl
	@doc raw"""
	\\brief OpenMP target parallel for directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2443:3)
	""" CXCursor_OMPTargetParallelForDirective
	@doc raw"""
	\\brief OpenMP section directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2331:3)
	""" CXCursor_OMPSectionDirective
	@doc raw"""
	\\brief A static_assert or _Static_assert node
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2562:3)
	""" CXCursor_StaticAssert
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1885:3)
	""" CXCursor_FirstInvalid
	@doc raw"""
	\\brief C++'s static_cast<> expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2015:3)
	""" CXCursor_CXXStaticCastExpr
	@doc raw"""
	\\brief Objective-c Boolean Literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2144:3)
	""" CXCursor_ObjCBoolLiteralExpr
	@doc raw"""
	\\brief An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2550:3)
	""" CXCursor_FirstPreprocessing
	@doc raw"""
	\\brief A while statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2211:3)
	""" CXCursor_WhileStmt
	@doc raw"""
	\\brief a friend declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2568:3)
	""" CXCursor_LastExtraDecl
	@doc raw"""
	\\brief A C++ non-type template parameter. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1758:3)
	""" CXCursor_NonTypeTemplateParameter
	@doc raw"""
	\\brief Objective-C's overall \\@try-\\@catch-\\@finally statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2248:3)
	""" CXCursor_ObjCAtTryStmt
	@doc raw"""
	\\brief A C or C++ union. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1705:3)
	""" CXCursor_UnionDecl
	@doc raw"""
	\\brief A C++ alias declaration */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1774:3)
	""" CXCursor_TypeAliasDecl
	@doc raw"""
	\\brief A group of statements like { stmt stmt }.
	
	This cursor kind is used to describe compound statements, e.g. function
	bodies.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2191:3)
	""" CXCursor_CompoundStmt
	@doc raw"""
	\\brief OpenMP task directive.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2347:3)
	""" CXCursor_OMPTaskDirective
	@doc raw"""
	\\brief A reference to a variable that occurs in some non-expression 
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:1888:3)
	""" CXCursor_NotImplemented
	export CXCursorKind, CXCursor_AddrLabelExpr, CXCursor_AnnotateAttr, CXCursor_ArraySubscriptExpr, CXCursor_AsmLabelAttr, CXCursor_AsmStmt, CXCursor_BinaryOperator, CXCursor_BlockExpr, CXCursor_BreakStmt, CXCursor_CStyleCastExpr, CXCursor_CUDAConstantAttr, CXCursor_CUDADeviceAttr, CXCursor_CUDAGlobalAttr, CXCursor_CUDAHostAttr, CXCursor_CUDASharedAttr, CXCursor_CXXAccessSpecifier, CXCursor_CXXBaseSpecifier, CXCursor_CXXBoolLiteralExpr, CXCursor_CXXCatchStmt, CXCursor_CXXConstCastExpr, CXCursor_CXXDeleteExpr, CXCursor_CXXDynamicCastExpr, CXCursor_CXXFinalAttr, CXCursor_CXXForRangeStmt, CXCursor_CXXFunctionalCastExpr, CXCursor_CXXMethod, CXCursor_CXXNewExpr, CXCursor_CXXNullPtrLiteralExpr, CXCursor_CXXOverrideAttr, CXCursor_CXXReinterpretCastExpr, CXCursor_CXXStaticCastExpr, CXCursor_CXXThisExpr, CXCursor_CXXThrowExpr, CXCursor_CXXTryStmt, CXCursor_CXXTypeidExpr, CXCursor_CallExpr, CXCursor_CaseStmt, CXCursor_CharacterLiteral, CXCursor_ClassDecl, CXCursor_ClassTemplate, CXCursor_ClassTemplatePartialSpecialization, CXCursor_CompoundAssignOperator, CXCursor_CompoundLiteralExpr, CXCursor_CompoundStmt, CXCursor_ConditionalOperator, CXCursor_ConstAttr, CXCursor_Constructor, CXCursor_ContinueStmt, CXCursor_ConversionFunction, CXCursor_DLLExport, CXCursor_DLLImport, CXCursor_DeclRefExpr, CXCursor_DeclStmt, CXCursor_DefaultStmt, CXCursor_Destructor, CXCursor_DoStmt, CXCursor_EnumConstantDecl, CXCursor_EnumDecl, CXCursor_FieldDecl, CXCursor_FirstAttr, CXCursor_FirstDecl, CXCursor_FirstExpr, CXCursor_FirstExtraDecl, CXCursor_FirstInvalid, CXCursor_FirstPreprocessing, CXCursor_FirstRef, CXCursor_FirstStmt, CXCursor_FloatingLiteral, CXCursor_ForStmt, CXCursor_FriendDecl, CXCursor_FunctionDecl, CXCursor_FunctionTemplate, CXCursor_GCCAsmStmt, CXCursor_GNUNullExpr, CXCursor_GenericSelectionExpr, CXCursor_GotoStmt, CXCursor_IBActionAttr, CXCursor_IBOutletAttr, CXCursor_IBOutletCollectionAttr, CXCursor_IfStmt, CXCursor_ImaginaryLiteral, CXCursor_InclusionDirective, CXCursor_IndirectGotoStmt, CXCursor_InitListExpr, CXCursor_IntegerLiteral, CXCursor_InvalidCode, CXCursor_InvalidFile, CXCursor_LabelRef, CXCursor_LabelStmt, CXCursor_LambdaExpr, CXCursor_LastAttr, CXCursor_LastDecl, CXCursor_LastExpr, CXCursor_LastExtraDecl, CXCursor_LastInvalid, CXCursor_LastPreprocessing, CXCursor_LastRef, CXCursor_LastStmt, CXCursor_LinkageSpec, CXCursor_MSAsmStmt, CXCursor_MacroDefinition, CXCursor_MacroExpansion, CXCursor_MacroInstantiation, CXCursor_MemberRef, CXCursor_MemberRefExpr, CXCursor_ModuleImportDecl, CXCursor_Namespace, CXCursor_NamespaceAlias, CXCursor_NamespaceRef, CXCursor_NoDeclFound, CXCursor_NoDuplicateAttr, CXCursor_NonTypeTemplateParameter, CXCursor_NotImplemented, CXCursor_NullStmt, CXCursor_OMPArraySectionExpr, CXCursor_OMPAtomicDirective, CXCursor_OMPBarrierDirective, CXCursor_OMPCancelDirective, CXCursor_OMPCancellationPointDirective, CXCursor_OMPCriticalDirective, CXCursor_OMPDistributeDirective, CXCursor_OMPDistributeParallelForDirective, CXCursor_OMPDistributeParallelForSimdDirective, CXCursor_OMPDistributeSimdDirective, CXCursor_OMPFlushDirective, CXCursor_OMPForDirective, CXCursor_OMPForSimdDirective, CXCursor_OMPMasterDirective, CXCursor_OMPOrderedDirective, CXCursor_OMPParallelDirective, CXCursor_OMPParallelForDirective, CXCursor_OMPParallelForSimdDirective, CXCursor_OMPParallelSectionsDirective, CXCursor_OMPSectionDirective, CXCursor_OMPSectionsDirective, CXCursor_OMPSimdDirective, CXCursor_OMPSingleDirective, CXCursor_OMPTargetDataDirective, CXCursor_OMPTargetDirective, CXCursor_OMPTargetEnterDataDirective, CXCursor_OMPTargetExitDataDirective, CXCursor_OMPTargetParallelDirective, CXCursor_OMPTargetParallelForDirective, CXCursor_OMPTargetParallelForSimdDirective, CXCursor_OMPTargetSimdDirective, CXCursor_OMPTargetTeamsDirective, CXCursor_OMPTargetTeamsDistributeDirective, CXCursor_OMPTargetTeamsDistributeParallelForDirective, CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective, CXCursor_OMPTargetTeamsDistributeSimdDirective, CXCursor_OMPTargetUpdateDirective, CXCursor_OMPTaskDirective, CXCursor_OMPTaskLoopDirective, CXCursor_OMPTaskLoopSimdDirective, CXCursor_OMPTaskgroupDirective, CXCursor_OMPTaskwaitDirective, CXCursor_OMPTaskyieldDirective, CXCursor_OMPTeamsDirective, CXCursor_OMPTeamsDistributeDirective, CXCursor_OMPTeamsDistributeParallelForDirective, CXCursor_OMPTeamsDistributeParallelForSimdDirective, CXCursor_OMPTeamsDistributeSimdDirective, CXCursor_ObjCAtCatchStmt, CXCursor_ObjCAtFinallyStmt, CXCursor_ObjCAtSynchronizedStmt, CXCursor_ObjCAtThrowStmt, CXCursor_ObjCAtTryStmt, CXCursor_ObjCAutoreleasePoolStmt, CXCursor_ObjCAvailabilityCheckExpr, CXCursor_ObjCBoolLiteralExpr, CXCursor_ObjCBridgedCastExpr, CXCursor_ObjCCategoryDecl, CXCursor_ObjCCategoryImplDecl, CXCursor_ObjCClassMethodDecl, CXCursor_ObjCClassRef, CXCursor_ObjCDynamicDecl, CXCursor_ObjCEncodeExpr, CXCursor_ObjCForCollectionStmt, CXCursor_ObjCImplementationDecl, CXCursor_ObjCInstanceMethodDecl, CXCursor_ObjCInterfaceDecl, CXCursor_ObjCIvarDecl, CXCursor_ObjCMessageExpr, CXCursor_ObjCPropertyDecl, CXCursor_ObjCProtocolDecl, CXCursor_ObjCProtocolExpr, CXCursor_ObjCProtocolRef, CXCursor_ObjCSelectorExpr, CXCursor_ObjCSelfExpr, CXCursor_ObjCStringLiteral, CXCursor_ObjCSuperClassRef, CXCursor_ObjCSynthesizeDecl, CXCursor_OverloadCandidate, CXCursor_OverloadedDeclRef, CXCursor_PackExpansionExpr, CXCursor_PackedAttr, CXCursor_ParenExpr, CXCursor_ParmDecl, CXCursor_PreprocessingDirective, CXCursor_PureAttr, CXCursor_ReturnStmt, CXCursor_SEHExceptStmt, CXCursor_SEHFinallyStmt, CXCursor_SEHLeaveStmt, CXCursor_SEHTryStmt, CXCursor_SizeOfPackExpr, CXCursor_StaticAssert, CXCursor_StmtExpr, CXCursor_StringLiteral, CXCursor_StructDecl, CXCursor_SwitchStmt, CXCursor_TemplateRef, CXCursor_TemplateTemplateParameter, CXCursor_TemplateTypeParameter, CXCursor_TranslationUnit, CXCursor_TypeAliasDecl, CXCursor_TypeAliasTemplateDecl, CXCursor_TypeRef, CXCursor_TypedefDecl, CXCursor_UnaryExpr, CXCursor_UnaryOperator, CXCursor_UnexposedAttr, CXCursor_UnexposedDecl, CXCursor_UnexposedExpr, CXCursor_UnexposedStmt, CXCursor_UnionDecl, CXCursor_UsingDeclaration, CXCursor_UsingDirective, CXCursor_VarDecl, CXCursor_VariableRef, CXCursor_VisibilityAttr, CXCursor_WhileStmt
	@cenum CXCursorKind {
		CXCursor_UnexposedDecl = (@Cuint)(1)
		CXCursor_StructDecl = (@Cuint)(2)
		CXCursor_UnionDecl = (@Cuint)(3)
		CXCursor_ClassDecl = (@Cuint)(4)
		CXCursor_EnumDecl = (@Cuint)(5)
		CXCursor_FieldDecl = (@Cuint)(6)
		CXCursor_EnumConstantDecl = (@Cuint)(7)
		CXCursor_FunctionDecl = (@Cuint)(8)
		CXCursor_VarDecl = (@Cuint)(9)
		CXCursor_ParmDecl = (@Cuint)(10)
		CXCursor_ObjCInterfaceDecl = (@Cuint)(11)
		CXCursor_ObjCCategoryDecl = (@Cuint)(12)
		CXCursor_ObjCProtocolDecl = (@Cuint)(13)
		CXCursor_ObjCPropertyDecl = (@Cuint)(14)
		CXCursor_ObjCIvarDecl = (@Cuint)(15)
		CXCursor_ObjCInstanceMethodDecl = (@Cuint)(16)
		CXCursor_ObjCClassMethodDecl = (@Cuint)(17)
		CXCursor_ObjCImplementationDecl = (@Cuint)(18)
		CXCursor_ObjCCategoryImplDecl = (@Cuint)(19)
		CXCursor_TypedefDecl = (@Cuint)(20)
		CXCursor_CXXMethod = (@Cuint)(21)
		CXCursor_Namespace = (@Cuint)(22)
		CXCursor_LinkageSpec = (@Cuint)(23)
		CXCursor_Constructor = (@Cuint)(24)
		CXCursor_Destructor = (@Cuint)(25)
		CXCursor_ConversionFunction = (@Cuint)(26)
		CXCursor_TemplateTypeParameter = (@Cuint)(27)
		CXCursor_NonTypeTemplateParameter = (@Cuint)(28)
		CXCursor_TemplateTemplateParameter = (@Cuint)(29)
		CXCursor_FunctionTemplate = (@Cuint)(30)
		CXCursor_ClassTemplate = (@Cuint)(31)
		CXCursor_ClassTemplatePartialSpecialization = (@Cuint)(32)
		CXCursor_NamespaceAlias = (@Cuint)(33)
		CXCursor_UsingDirective = (@Cuint)(34)
		CXCursor_UsingDeclaration = (@Cuint)(35)
		CXCursor_TypeAliasDecl = (@Cuint)(36)
		CXCursor_ObjCSynthesizeDecl = (@Cuint)(37)
		CXCursor_ObjCDynamicDecl = (@Cuint)(38)
		CXCursor_CXXAccessSpecifier = (@Cuint)(39)
		CXCursor_FirstDecl = (@Cuint)(1)
		CXCursor_LastDecl = (@Cuint)(39)
		CXCursor_FirstRef = (@Cuint)(40)
		CXCursor_ObjCSuperClassRef = (@Cuint)(40)
		CXCursor_ObjCProtocolRef = (@Cuint)(41)
		CXCursor_ObjCClassRef = (@Cuint)(42)
		CXCursor_TypeRef = (@Cuint)(43)
		CXCursor_CXXBaseSpecifier = (@Cuint)(44)
		CXCursor_TemplateRef = (@Cuint)(45)
		CXCursor_NamespaceRef = (@Cuint)(46)
		CXCursor_MemberRef = (@Cuint)(47)
		CXCursor_LabelRef = (@Cuint)(48)
		CXCursor_OverloadedDeclRef = (@Cuint)(49)
		CXCursor_VariableRef = (@Cuint)(50)
		CXCursor_LastRef = (@Cuint)(50)
		CXCursor_FirstInvalid = (@Cuint)(70)
		CXCursor_InvalidFile = (@Cuint)(70)
		CXCursor_NoDeclFound = (@Cuint)(71)
		CXCursor_NotImplemented = (@Cuint)(72)
		CXCursor_InvalidCode = (@Cuint)(73)
		CXCursor_LastInvalid = (@Cuint)(73)
		CXCursor_FirstExpr = (@Cuint)(100)
		CXCursor_UnexposedExpr = (@Cuint)(100)
		CXCursor_DeclRefExpr = (@Cuint)(101)
		CXCursor_MemberRefExpr = (@Cuint)(102)
		CXCursor_CallExpr = (@Cuint)(103)
		CXCursor_ObjCMessageExpr = (@Cuint)(104)
		CXCursor_BlockExpr = (@Cuint)(105)
		CXCursor_IntegerLiteral = (@Cuint)(106)
		CXCursor_FloatingLiteral = (@Cuint)(107)
		CXCursor_ImaginaryLiteral = (@Cuint)(108)
		CXCursor_StringLiteral = (@Cuint)(109)
		CXCursor_CharacterLiteral = (@Cuint)(110)
		CXCursor_ParenExpr = (@Cuint)(111)
		CXCursor_UnaryOperator = (@Cuint)(112)
		CXCursor_ArraySubscriptExpr = (@Cuint)(113)
		CXCursor_BinaryOperator = (@Cuint)(114)
		CXCursor_CompoundAssignOperator = (@Cuint)(115)
		CXCursor_ConditionalOperator = (@Cuint)(116)
		CXCursor_CStyleCastExpr = (@Cuint)(117)
		CXCursor_CompoundLiteralExpr = (@Cuint)(118)
		CXCursor_InitListExpr = (@Cuint)(119)
		CXCursor_AddrLabelExpr = (@Cuint)(120)
		CXCursor_StmtExpr = (@Cuint)(121)
		CXCursor_GenericSelectionExpr = (@Cuint)(122)
		CXCursor_GNUNullExpr = (@Cuint)(123)
		CXCursor_CXXStaticCastExpr = (@Cuint)(124)
		CXCursor_CXXDynamicCastExpr = (@Cuint)(125)
		CXCursor_CXXReinterpretCastExpr = (@Cuint)(126)
		CXCursor_CXXConstCastExpr = (@Cuint)(127)
		CXCursor_CXXFunctionalCastExpr = (@Cuint)(128)
		CXCursor_CXXTypeidExpr = (@Cuint)(129)
		CXCursor_CXXBoolLiteralExpr = (@Cuint)(130)
		CXCursor_CXXNullPtrLiteralExpr = (@Cuint)(131)
		CXCursor_CXXThisExpr = (@Cuint)(132)
		CXCursor_CXXThrowExpr = (@Cuint)(133)
		CXCursor_CXXNewExpr = (@Cuint)(134)
		CXCursor_CXXDeleteExpr = (@Cuint)(135)
		CXCursor_UnaryExpr = (@Cuint)(136)
		CXCursor_ObjCStringLiteral = (@Cuint)(137)
		CXCursor_ObjCEncodeExpr = (@Cuint)(138)
		CXCursor_ObjCSelectorExpr = (@Cuint)(139)
		CXCursor_ObjCProtocolExpr = (@Cuint)(140)
		CXCursor_ObjCBridgedCastExpr = (@Cuint)(141)
		CXCursor_PackExpansionExpr = (@Cuint)(142)
		CXCursor_SizeOfPackExpr = (@Cuint)(143)
		CXCursor_LambdaExpr = (@Cuint)(144)
		CXCursor_ObjCBoolLiteralExpr = (@Cuint)(145)
		CXCursor_ObjCSelfExpr = (@Cuint)(146)
		CXCursor_OMPArraySectionExpr = (@Cuint)(147)
		CXCursor_ObjCAvailabilityCheckExpr = (@Cuint)(148)
		CXCursor_LastExpr = (@Cuint)(148)
		CXCursor_FirstStmt = (@Cuint)(200)
		CXCursor_UnexposedStmt = (@Cuint)(200)
		CXCursor_LabelStmt = (@Cuint)(201)
		CXCursor_CompoundStmt = (@Cuint)(202)
		CXCursor_CaseStmt = (@Cuint)(203)
		CXCursor_DefaultStmt = (@Cuint)(204)
		CXCursor_IfStmt = (@Cuint)(205)
		CXCursor_SwitchStmt = (@Cuint)(206)
		CXCursor_WhileStmt = (@Cuint)(207)
		CXCursor_DoStmt = (@Cuint)(208)
		CXCursor_ForStmt = (@Cuint)(209)
		CXCursor_GotoStmt = (@Cuint)(210)
		CXCursor_IndirectGotoStmt = (@Cuint)(211)
		CXCursor_ContinueStmt = (@Cuint)(212)
		CXCursor_BreakStmt = (@Cuint)(213)
		CXCursor_ReturnStmt = (@Cuint)(214)
		CXCursor_GCCAsmStmt = (@Cuint)(215)
		CXCursor_AsmStmt = (@Cuint)(215)
		CXCursor_ObjCAtTryStmt = (@Cuint)(216)
		CXCursor_ObjCAtCatchStmt = (@Cuint)(217)
		CXCursor_ObjCAtFinallyStmt = (@Cuint)(218)
		CXCursor_ObjCAtThrowStmt = (@Cuint)(219)
		CXCursor_ObjCAtSynchronizedStmt = (@Cuint)(220)
		CXCursor_ObjCAutoreleasePoolStmt = (@Cuint)(221)
		CXCursor_ObjCForCollectionStmt = (@Cuint)(222)
		CXCursor_CXXCatchStmt = (@Cuint)(223)
		CXCursor_CXXTryStmt = (@Cuint)(224)
		CXCursor_CXXForRangeStmt = (@Cuint)(225)
		CXCursor_SEHTryStmt = (@Cuint)(226)
		CXCursor_SEHExceptStmt = (@Cuint)(227)
		CXCursor_SEHFinallyStmt = (@Cuint)(228)
		CXCursor_MSAsmStmt = (@Cuint)(229)
		CXCursor_NullStmt = (@Cuint)(230)
		CXCursor_DeclStmt = (@Cuint)(231)
		CXCursor_OMPParallelDirective = (@Cuint)(232)
		CXCursor_OMPSimdDirective = (@Cuint)(233)
		CXCursor_OMPForDirective = (@Cuint)(234)
		CXCursor_OMPSectionsDirective = (@Cuint)(235)
		CXCursor_OMPSectionDirective = (@Cuint)(236)
		CXCursor_OMPSingleDirective = (@Cuint)(237)
		CXCursor_OMPParallelForDirective = (@Cuint)(238)
		CXCursor_OMPParallelSectionsDirective = (@Cuint)(239)
		CXCursor_OMPTaskDirective = (@Cuint)(240)
		CXCursor_OMPMasterDirective = (@Cuint)(241)
		CXCursor_OMPCriticalDirective = (@Cuint)(242)
		CXCursor_OMPTaskyieldDirective = (@Cuint)(243)
		CXCursor_OMPBarrierDirective = (@Cuint)(244)
		CXCursor_OMPTaskwaitDirective = (@Cuint)(245)
		CXCursor_OMPFlushDirective = (@Cuint)(246)
		CXCursor_SEHLeaveStmt = (@Cuint)(247)
		CXCursor_OMPOrderedDirective = (@Cuint)(248)
		CXCursor_OMPAtomicDirective = (@Cuint)(249)
		CXCursor_OMPForSimdDirective = (@Cuint)(250)
		CXCursor_OMPParallelForSimdDirective = (@Cuint)(251)
		CXCursor_OMPTargetDirective = (@Cuint)(252)
		CXCursor_OMPTeamsDirective = (@Cuint)(253)
		CXCursor_OMPTaskgroupDirective = (@Cuint)(254)
		CXCursor_OMPCancellationPointDirective = (@Cuint)(255)
		CXCursor_OMPCancelDirective = (@Cuint)(256)
		CXCursor_OMPTargetDataDirective = (@Cuint)(257)
		CXCursor_OMPTaskLoopDirective = (@Cuint)(258)
		CXCursor_OMPTaskLoopSimdDirective = (@Cuint)(259)
		CXCursor_OMPDistributeDirective = (@Cuint)(260)
		CXCursor_OMPTargetEnterDataDirective = (@Cuint)(261)
		CXCursor_OMPTargetExitDataDirective = (@Cuint)(262)
		CXCursor_OMPTargetParallelDirective = (@Cuint)(263)
		CXCursor_OMPTargetParallelForDirective = (@Cuint)(264)
		CXCursor_OMPTargetUpdateDirective = (@Cuint)(265)
		CXCursor_OMPDistributeParallelForDirective = (@Cuint)(266)
		CXCursor_OMPDistributeParallelForSimdDirective = (@Cuint)(267)
		CXCursor_OMPDistributeSimdDirective = (@Cuint)(268)
		CXCursor_OMPTargetParallelForSimdDirective = (@Cuint)(269)
		CXCursor_OMPTargetSimdDirective = (@Cuint)(270)
		CXCursor_OMPTeamsDistributeDirective = (@Cuint)(271)
		CXCursor_OMPTeamsDistributeSimdDirective = (@Cuint)(272)
		CXCursor_OMPTeamsDistributeParallelForSimdDirective = (@Cuint)(273)
		CXCursor_OMPTeamsDistributeParallelForDirective = (@Cuint)(274)
		CXCursor_OMPTargetTeamsDirective = (@Cuint)(275)
		CXCursor_OMPTargetTeamsDistributeDirective = (@Cuint)(276)
		CXCursor_OMPTargetTeamsDistributeParallelForDirective = (@Cuint)(277)
		CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective = (@Cuint)(278)
		CXCursor_OMPTargetTeamsDistributeSimdDirective = (@Cuint)(279)
		CXCursor_LastStmt = (@Cuint)(279)
		CXCursor_TranslationUnit = (@Cuint)(300)
		CXCursor_FirstAttr = (@Cuint)(400)
		CXCursor_UnexposedAttr = (@Cuint)(400)
		CXCursor_IBActionAttr = (@Cuint)(401)
		CXCursor_IBOutletAttr = (@Cuint)(402)
		CXCursor_IBOutletCollectionAttr = (@Cuint)(403)
		CXCursor_CXXFinalAttr = (@Cuint)(404)
		CXCursor_CXXOverrideAttr = (@Cuint)(405)
		CXCursor_AnnotateAttr = (@Cuint)(406)
		CXCursor_AsmLabelAttr = (@Cuint)(407)
		CXCursor_PackedAttr = (@Cuint)(408)
		CXCursor_PureAttr = (@Cuint)(409)
		CXCursor_ConstAttr = (@Cuint)(410)
		CXCursor_NoDuplicateAttr = (@Cuint)(411)
		CXCursor_CUDAConstantAttr = (@Cuint)(412)
		CXCursor_CUDADeviceAttr = (@Cuint)(413)
		CXCursor_CUDAGlobalAttr = (@Cuint)(414)
		CXCursor_CUDAHostAttr = (@Cuint)(415)
		CXCursor_CUDASharedAttr = (@Cuint)(416)
		CXCursor_VisibilityAttr = (@Cuint)(417)
		CXCursor_DLLExport = (@Cuint)(418)
		CXCursor_DLLImport = (@Cuint)(419)
		CXCursor_LastAttr = (@Cuint)(419)
		CXCursor_PreprocessingDirective = (@Cuint)(500)
		CXCursor_MacroDefinition = (@Cuint)(501)
		CXCursor_MacroExpansion = (@Cuint)(502)
		CXCursor_MacroInstantiation = (@Cuint)(502)
		CXCursor_InclusionDirective = (@Cuint)(503)
		CXCursor_FirstPreprocessing = (@Cuint)(500)
		CXCursor_LastPreprocessing = (@Cuint)(503)
		CXCursor_ModuleImportDecl = (@Cuint)(600)
		CXCursor_TypeAliasTemplateDecl = (@Cuint)(601)
		CXCursor_StaticAssert = (@Cuint)(602)
		CXCursor_FriendDecl = (@Cuint)(603)
		CXCursor_FirstExtraDecl = (@Cuint)(600)
		CXCursor_LastExtraDecl = (@Cuint)(603)
		CXCursor_OverloadCandidate = (@Cuint)(700)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2598:3)
	""" CXCursor
	export CXCursor
	@ctypedef CXCursor @cstruct {
		kind::CXCursorKind
		xdata::@Cint
		data::((@Ptr){(@Cconst)(@Cvoid)})[3]
	}
	
	@doc raw"""
	\\brief Retrieve the NULL cursor, which represents no entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2609:25)
	""" clang_getNullCursor
	export clang_getNullCursor
	@cextern clang_getNullCursor()::CXCursor
	
	@doc raw"""
	\\brief Retrieve the cursor that represents the given translation unit.
	
	The translation unit cursor can be used to start traversing the
	various declarations within the given translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2617:25)
	""" clang_getTranslationUnitCursor
	export clang_getTranslationUnitCursor
	@cextern clang_getTranslationUnitCursor(var"?1?"::CXTranslationUnit)::CXCursor
	
	@doc raw"""
	\\brief Determine whether two cursors are equivalent.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2622:25)
	""" clang_equalCursors
	export clang_equalCursors
	@cextern clang_equalCursors(var"?1?"::CXCursor, var"?2?"::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Returns non-zero if \\p cursor is null.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2627:20)
	""" clang_Cursor_isNull
	export clang_Cursor_isNull
	@cextern clang_Cursor_isNull(cursor::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Compute a hash value for the given cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2632:25)
	""" clang_hashCursor
	export clang_hashCursor
	@cextern clang_hashCursor(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the kind of the given cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2637:34)
	""" clang_getCursorKind
	export clang_getCursorKind
	@cextern clang_getCursorKind(var"?1?"::CXCursor)::CXCursorKind
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents a declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2642:25)
	""" clang_isDeclaration
	export clang_isDeclaration
	@cextern clang_isDeclaration(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents a simple
	reference.
	
	Note that other kinds of cursors (such as expressions) can also refer to
	other cursors. Use clang_getCursorReferenced() to determine whether a
	particular cursor refers to another entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2652:25)
	""" clang_isReference
	export clang_isReference
	@cextern clang_isReference(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents an expression.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2657:25)
	""" clang_isExpression
	export clang_isExpression
	@cextern clang_isExpression(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents a statement.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2662:25)
	""" clang_isStatement
	export clang_isStatement
	@cextern clang_isStatement(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents an attribute.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2667:25)
	""" clang_isAttribute
	export clang_isAttribute
	@cextern clang_isAttribute(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor has any attributes.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2672:25)
	""" clang_Cursor_hasAttrs
	export clang_Cursor_hasAttrs
	@cextern clang_Cursor_hasAttrs(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents an invalid
	cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2678:25)
	""" clang_isInvalid
	export clang_isInvalid
	@cextern clang_isInvalid(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor kind represents a translation
	unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2684:25)
	""" clang_isTranslationUnit
	export clang_isTranslationUnit
	@cextern clang_isTranslationUnit(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor represents a preprocessing
	element, such as a preprocessor directive or macro instantiation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2690:25)
	""" clang_isPreprocessing
	export clang_isPreprocessing
	@cextern clang_isPreprocessing(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief Determine whether the given cursor represents a currently
	unexposed piece of the AST (e.g., CXCursor_UnexposedStmt).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2696:25)
	""" clang_isUnexposed
	export clang_isUnexposed
	@cextern clang_isUnexposed(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	\\brief This is the linkage for static variables and static functions. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2711:3)
	""" CXLinkage_Internal
	@doc raw"""
	\\brief This is the linkage for entities with external linkage that live
	in C++ anonymous namespaces.*/
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2714:3)
	""" CXLinkage_UniqueExternal
	@doc raw"""
	\\brief This is the linkage for entities with true, external linkage. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2716:3)
	""" CXLinkage_External
	@doc raw"""
	\\brief This value indicates that no linkage information is available
	for a provided CXCursor. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2704:3)
	""" CXLinkage_Invalid
	@doc raw"""
	\\brief This is the linkage for variables, parameters, and so on that
	have automatic storage.  This covers normal (non-extern) local variables.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2709:3)
	""" CXLinkage_NoLinkage
	@doc raw"""
	\\brief Describe the linkage of the entity referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2701:6)
	""" CXLinkageKind
	export CXLinkageKind, CXLinkage_External, CXLinkage_Internal, CXLinkage_Invalid, CXLinkage_NoLinkage, CXLinkage_UniqueExternal
	@cenum CXLinkageKind {
		CXLinkage_Invalid = (@Cuint)(0)
		CXLinkage_NoLinkage = (@Cuint)(1)
		CXLinkage_Internal = (@Cuint)(2)
		CXLinkage_UniqueExternal = (@Cuint)(3)
		CXLinkage_External = (@Cuint)(4)
	}
	
	@doc raw"""
	\\brief Determine the linkage of the entity referred to by a given cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2722:35)
	""" clang_getCursorLinkage
	export clang_getCursorLinkage
	@cextern clang_getCursorLinkage(cursor::CXCursor)::CXLinkageKind
	
	@doc raw"""
	\\brief Symbol seen by the linker but resolves to a symbol inside this object. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2732:3)
	""" CXVisibility_Protected
	@doc raw"""
	\\brief This value indicates that no visibility information is available
	for a provided CXCursor. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2727:3)
	""" CXVisibility_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2724:6)
	""" CXVisibilityKind
	@doc raw"""
	\\brief Symbol not seen by the linker. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2730:3)
	""" CXVisibility_Hidden
	@doc raw"""
	\\brief Symbol seen by the linker and acts like a normal symbol. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2734:3)
	""" CXVisibility_Default
	export CXVisibilityKind, CXVisibility_Default, CXVisibility_Hidden, CXVisibility_Invalid, CXVisibility_Protected
	@cenum CXVisibilityKind {
		CXVisibility_Invalid = (@Cuint)(0)
		CXVisibility_Hidden = (@Cuint)(1)
		CXVisibility_Protected = (@Cuint)(2)
		CXVisibility_Default = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Describe the visibility of the entity referred to by a cursor.
	
	This returns the default visibility if not explicitly specified by
	a visibility attribute. The default visibility may be changed by
	commandline arguments.
	
	\\param cursor The cursor to query.
	
	\\returns The visibility of the cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2748:38)
	""" clang_getCursorVisibility
	export clang_getCursorVisibility
	@cextern clang_getCursorVisibility(cursor::CXCursor)::CXVisibilityKind
	
	@doc raw"""
	\\brief Determine the availability of the entity that this cursor refers to,
	taking the current target platform into account.
	
	\\param cursor The cursor to query.
	
	\\returns The availability of the cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2759:1)
	""" clang_getCursorAvailability
	export clang_getCursorAvailability
	@cextern clang_getCursorAvailability(cursor::CXCursor)::CXAvailabilityKind
	
	@doc raw"""
	Describes the availability of a given entity on a particular platform, e.g.,
	a particular class might only be available on Mac OS 10.7 or newer.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2765:16)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2796:3)
	""" CXPlatformAvailability
	export CXPlatformAvailability
	@ctypedef CXPlatformAvailability @cstruct CXPlatformAvailability {
		Platform::CXString
		Introduced::CXVersion
		Deprecated::CXVersion
		Obsoleted::CXVersion
		Unavailable::@Cint
		Message::CXString
	}
	
	@doc raw"""
	\\brief Determine the availability of the entity that this cursor refers to
	on any platforms for which availability information is known.
	
	\\param cursor The cursor to query.
	
	\\param always_deprecated If non-NULL, will be set to indicate whether the 
	entity is deprecated on all platforms.
	
	\\param deprecated_message If non-NULL, will be set to the message text 
	provided along with the unconditional deprecation of this entity. The client
	is responsible for deallocating this string.
	
	\\param always_unavailable If non-NULL, will be set to indicate whether the
	entity is unavailable on all platforms.
	
	\\param unavailable_message If non-NULL, will be set to the message text
	provided along with the unconditional unavailability of this entity. The 
	client is responsible for deallocating this string.
	
	\\param availability If non-NULL, an array of CXPlatformAvailability instances
	that will be populated with platform availability information, up to either
	the number of platforms for which availability information is available (as
	returned by this function) or \\c availability_size, whichever is smaller.
	
	\\param availability_size The number of elements available in the 
	\\c availability array.
	
	\\returns The number of platforms (N) for which availability information is
	available (which is unrelated to \\c availability_size).
	
	Note that the client is responsible for calling 
	\\c clang_disposeCXPlatformAvailability to free each of the 
	platform-availability structures returned. There are 
	\\c min(N, availability_size) such structures.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2835:1)
	""" clang_getCursorPlatformAvailability
	export clang_getCursorPlatformAvailability
	@cextern clang_getCursorPlatformAvailability(cursor::CXCursor, always_deprecated::(@Ptr){@Cint}, deprecated_message::(@Ptr){CXString}, always_unavailable::(@Ptr){@Cint}, unavailable_message::(@Ptr){CXString}, availability::(@Ptr){CXPlatformAvailability}, availability_size::(@Cint))::@Cint
	
	@doc raw"""
	\\brief Free the memory associated with a \\c CXPlatformAvailability structure.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2847:1)
	""" clang_disposeCXPlatformAvailability
	export clang_disposeCXPlatformAvailability
	@cextern clang_disposeCXPlatformAvailability(availability::(@Ptr){CXPlatformAvailability})::@Cvoid
	
	@doc raw"""
	\\brief Describe the "language" of the entity referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2852:6)
	""" CXLanguageKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2856:3)
	""" CXLanguage_CPlusPlus
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2855:3)
	""" CXLanguage_ObjC
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2853:3)
	""" CXLanguage_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2854:3)
	""" CXLanguage_C
	export CXLanguageKind, CXLanguage_C, CXLanguage_CPlusPlus, CXLanguage_Invalid, CXLanguage_ObjC
	@cenum CXLanguageKind {
		CXLanguage_Invalid = (@Cuint)(0)
		CXLanguage_C = (@Cuint)(1)
		CXLanguage_ObjC = (@Cuint)(2)
		CXLanguage_CPlusPlus = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Determine the "language" of the entity referred to by a given cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2862:36)
	""" clang_getCursorLanguage
	export clang_getCursorLanguage
	@cextern clang_getCursorLanguage(cursor::CXCursor)::CXLanguageKind
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2870:3)
	""" CXTLS_Dynamic
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2871:3)
	""" CXTLS_Static
	@doc raw"""
	\\brief Describe the "thread-local storage (TLS) kind" of the declaration
	referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2868:6)
	""" CXTLSKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2869:3)
	""" CXTLS_None
	export CXTLSKind, CXTLS_Dynamic, CXTLS_None, CXTLS_Static
	@cenum CXTLSKind {
		CXTLS_None = (@Cuint)(0)
		CXTLS_Dynamic = (@Cuint)(1)
		CXTLS_Static = (@Cuint)(2)
	}
	
	@doc raw"""
	\\brief Determine the "thread-local storage (TLS) kind" of the declaration
	referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2878:31)
	""" clang_getCursorTLSKind
	export clang_getCursorTLSKind
	@cextern clang_getCursorTLSKind(cursor::CXCursor)::CXTLSKind
	
	@doc raw"""
	\\brief Returns the translation unit that a cursor originated from.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2883:34)
	""" clang_Cursor_getTranslationUnit
	export clang_Cursor_getTranslationUnit
	@cextern clang_Cursor_getTranslationUnit(var"?1?"::CXCursor)::CXTranslationUnit
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2888:16)
	""" CXCursorSetImpl
	@doc raw"""
	\\brief A fast container representing a set of CXCursors.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2888:33)
	""" CXCursorSet
	export CXCursorSet, CXCursorSetImpl
	@ctypedef CXCursorSet (@Ptr){@cstruct CXCursorSetImpl}
	
	@doc raw"""
	\\brief Creates an empty CXCursorSet.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2893:28)
	""" clang_createCXCursorSet
	export clang_createCXCursorSet
	@cextern clang_createCXCursorSet()::CXCursorSet
	
	@doc raw"""
	\\brief Disposes a CXCursorSet and releases its associated memory.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2898:21)
	""" clang_disposeCXCursorSet
	export clang_disposeCXCursorSet
	@cextern clang_disposeCXCursorSet(cset::CXCursorSet)::@Cvoid
	
	@doc raw"""
	\\brief Queries a CXCursorSet to see if it contains a specific CXCursor.
	
	\\returns non-zero if the set contains the specified cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2905:25)
	""" clang_CXCursorSet_contains
	export clang_CXCursorSet_contains
	@cextern clang_CXCursorSet_contains(cset::CXCursorSet, cursor::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Inserts a CXCursor into a CXCursorSet.
	
	\\returns zero if the CXCursor was already in the set, and non-zero otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2913:25)
	""" clang_CXCursorSet_insert
	export clang_CXCursorSet_insert
	@cextern clang_CXCursorSet_insert(cset::CXCursorSet, cursor::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine the semantic parent of the given cursor.
	
	The semantic parent of a cursor is the cursor that semantically contains
	the given \\p cursor. For many declarations, the lexical and semantic parents
	are equivalent (the lexical parent is returned by 
	\\c clang_getCursorLexicalParent()). They diverge when declarations or
	definitions are provided out-of-line. For example:
	
	\\code
	class C {
	void f();
	};
	
	void C::f() { }
	\\endcode
	
	In the out-of-line definition of \\c C::f, the semantic parent is
	the class \\c C, of which this function is a member. The lexical parent is
	the place where the declaration actually occurs in the source code; in this
	case, the definition occurs in the translation unit. In general, the
	lexical parent for a given entity can change without affecting the semantics
	of the program, and the lexical parent of different declarations of the
	same entity may be different. Changing the semantic parent of a declaration,
	on the other hand, can have a major impact on semantics, and redeclarations
	of a particular entity should all have the same semantic context.
	
	In the example above, both declarations of \\c C::f have \\c C as their
	semantic context, while the lexical context of the first \\c C::f is \\c C
	and the lexical context of the second \\c C::f is the translation unit.
	
	For global declarations, the semantic parent is the translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2949:25)
	""" clang_getCursorSemanticParent
	export clang_getCursorSemanticParent
	@cextern clang_getCursorSemanticParent(cursor::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief Determine the lexical parent of the given cursor.
	
	The lexical parent of a cursor is the cursor in which the given \\p cursor
	was actually written. For many declarations, the lexical and semantic parents
	are equivalent (the semantic parent is returned by 
	\\c clang_getCursorSemanticParent()). They diverge when declarations or
	definitions are provided out-of-line. For example:
	
	\\code
	class C {
	void f();
	};
	
	void C::f() { }
	\\endcode
	
	In the out-of-line definition of \\c C::f, the semantic parent is
	the class \\c C, of which this function is a member. The lexical parent is
	the place where the declaration actually occurs in the source code; in this
	case, the definition occurs in the translation unit. In general, the
	lexical parent for a given entity can change without affecting the semantics
	of the program, and the lexical parent of different declarations of the
	same entity may be different. Changing the semantic parent of a declaration,
	on the other hand, can have a major impact on semantics, and redeclarations
	of a particular entity should all have the same semantic context.
	
	In the example above, both declarations of \\c C::f have \\c C as their
	semantic context, while the lexical context of the first \\c C::f is \\c C
	and the lexical context of the second \\c C::f is the translation unit.
	
	For declarations written in the global scope, the lexical parent is
	the translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:2985:25)
	""" clang_getCursorLexicalParent
	export clang_getCursorLexicalParent
	@cextern clang_getCursorLexicalParent(cursor::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief Determine the set of methods that are overridden by the given
	method.
	
	In both Objective-C and C++, a method (aka virtual member function,
	in C++) can override a virtual method in a base class. For
	Objective-C, a method is said to override any method in the class's
	base class, its protocols, or its categories' protocols, that has the same
	selector and is of the same kind (class or instance).
	If no such method exists, the search continues to the class's superclass,
	its protocols, and its categories, and so on. A method from an Objective-C
	implementation is considered to override the same methods as its
	corresponding method in the interface.
	
	For C++, a virtual member function overrides any virtual member
	function with the same signature that occurs in its base
	classes. With multiple inheritance, a virtual member function can
	override several virtual member functions coming from different
	base classes.
	
	In all cases, this function determines the immediate overridden
	method, rather than all of the overridden methods. For example, if
	a method is originally declared in a class A, then overridden in B
	(which in inherits from A) and also in C (which inherited from B),
	then the only overridden method returned from this function when
	invoked on C's method will be B's method. The client may then
	invoke this function again, given the previously-found overridden
	methods, to map out the complete method-override set.
	
	\\param cursor A cursor representing an Objective-C or C++
	method. This routine will compute the set of methods that this
	method overrides.
	
	\\param overridden A pointer whose pointee will be replaced with a
	pointer to an array of cursors, representing the set of overridden
	methods. If there are no overridden methods, the pointee will be
	set to NULL. The pointee must be freed via a call to 
	\\c clang_disposeOverriddenCursors().
	
	\\param num_overridden A pointer to the number of overridden
	functions, will be set to the number of overridden functions in the
	array pointed to by \\p overridden.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3030:21)
	""" clang_getOverriddenCursors
	export clang_getOverriddenCursors
	@cextern clang_getOverriddenCursors(cursor::CXCursor, overridden::(@Ptr){(@Ptr){CXCursor}}, num_overridden::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Free the set of overridden cursors returned by \\c
	clang_getOverriddenCursors().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3038:21)
	""" clang_disposeOverriddenCursors
	export clang_disposeOverriddenCursors
	@cextern clang_disposeOverriddenCursors(overridden::(@Ptr){CXCursor})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the file that is included by the given inclusion directive
	cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3044:23)
	""" clang_getIncludedFile
	export clang_getIncludedFile
	@cextern clang_getIncludedFile(cursor::CXCursor)::CXFile
	
	@doc raw"""
	\\brief Map a source location to the cursor that describes the entity at that
	location in the source code.
	
	clang_getCursor() maps an arbitrary source location within a translation
	unit down to the most specific cursor that describes the entity at that
	location. For example, given an expression \\c x + y, invoking
	clang_getCursor() with a source location pointing to "x" will return the
	cursor for "x"; similarly for "y". If the cursor points anywhere between
	"x" or "y" (e.g., on the + or the whitespace around it), clang_getCursor()
	will return a cursor referring to the "+" expression.
	
	\\returns a cursor representing the entity at the given source location, or
	a NULL cursor if no such entity can be found.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3076:25)
	""" clang_getCursor
	export clang_getCursor
	@cextern clang_getCursor(var"?1?"::CXTranslationUnit, var"?2?"::CXSourceLocation)::CXCursor
	
	@doc raw"""
	\\brief Retrieve the physical location of the source constructor referenced
	by the given cursor.
	
	The location of a declaration is typically the location of the name of that
	declaration, where the name of that declaration would occur if it is
	unnamed, or some keyword that introduces that particular declaration.
	The location of a reference is where that reference occurs within the
	source code.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3088:33)
	""" clang_getCursorLocation
	export clang_getCursorLocation
	@cextern clang_getCursorLocation(var"?1?"::CXCursor)::CXSourceLocation
	
	@doc raw"""
	\\brief Retrieve the physical extent of the source construct referenced by
	the given cursor.
	
	The extent of a cursor starts with the file/line/column pointing at the
	first character within the source construct that the cursor refers to and
	ends with the last character within that source construct. For a
	declaration, the extent covers the declaration itself. For a reference,
	the extent covers the location of the reference (e.g., where the referenced
	entity was actually used).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3101:30)
	""" clang_getCursorExtent
	export clang_getCursorExtent
	@cextern clang_getCursorExtent(var"?1?"::CXCursor)::CXSourceRange
	
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3181:3)
	""" CXType_Auto
	@doc raw"""
	\\brief Describes the kind of type
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3116:6)
	""" CXTypeKind
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3166:3)
	""" CXType_LValueReference
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3161:3)
	""" CXType_LastBuiltin
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3194:3)
	""" CXType_OCLImage1dRO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3169:3)
	""" CXType_Enum
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3153:3)
	""" CXType_Dependent
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3222:3)
	""" CXType_OCLImage2dArrayRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3156:3)
	""" CXType_ObjCSel
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3165:3)
	""" CXType_BlockPointer
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3201:3)
	""" CXType_OCLImage2dMSAARO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3137:3)
	""" CXType_ULong
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3149:3)
	""" CXType_Double
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3148:3)
	""" CXType_Float
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3213:3)
	""" CXType_OCLImage2dMSAAWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3135:3)
	""" CXType_UShort
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3228:3)
	""" CXType_OCLImage2dArrayMSAADepthRW
	@doc raw"""
	\\brief Represents an invalid type (e.g., where no type is available).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3120:3)
	""" CXType_Invalid
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3231:3)
	""" CXType_OCLEvent
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3209:3)
	""" CXType_OCLImage2dWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3141:3)
	""" CXType_SChar
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3168:3)
	""" CXType_Record
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3206:3)
	""" CXType_OCLImage1dWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3145:3)
	""" CXType_Long
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3212:3)
	""" CXType_OCLImage2dArrayDepthWO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3211:3)
	""" CXType_OCLImage2dDepthWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3130:3)
	""" CXType_Bool
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3220:3)
	""" CXType_OCLImage1dBufferRW
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3207:3)
	""" CXType_OCLImage1dArrayWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3177:3)
	""" CXType_IncompleteArray
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3133:3)
	""" CXType_Char16
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3202:3)
	""" CXType_OCLImage2dArrayMSAARO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3215:3)
	""" CXType_OCLImage2dMSAADepthWO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3197:3)
	""" CXType_OCLImage2dRO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3171:3)
	""" CXType_ObjCInterface
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3229:3)
	""" CXType_OCLImage3dRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3178:3)
	""" CXType_VariableArray
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3167:3)
	""" CXType_RValueReference
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3170:3)
	""" CXType_Typedef
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3217:3)
	""" CXType_OCLImage3dWO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3208:3)
	""" CXType_OCLImage1dBufferWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3126:3)
	""" CXType_Unexposed
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3136:3)
	""" CXType_UInt
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3132:3)
	""" CXType_UChar
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3140:3)
	""" CXType_Char_S
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3131:3)
	""" CXType_Char_U
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3158:3)
	""" CXType_Half
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3150:3)
	""" CXType_LongDouble
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3195:3)
	""" CXType_OCLImage1dArrayRO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3218:3)
	""" CXType_OCLImage1dRW
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3226:3)
	""" CXType_OCLImage2dArrayMSAARW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3147:3)
	""" CXType_Int128
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3139:3)
	""" CXType_UInt128
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3157:3)
	""" CXType_Float128
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3196:3)
	""" CXType_OCLImage1dBufferRO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3134:3)
	""" CXType_Char32
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3221:3)
	""" CXType_OCLImage2dRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3172:3)
	""" CXType_ObjCObjectPointer
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3203:3)
	""" CXType_OCLImage2dMSAADepthRO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3227:3)
	""" CXType_OCLImage2dMSAADepthRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3164:3)
	""" CXType_Pointer
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3198:3)
	""" CXType_OCLImage2dArrayRO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3219:3)
	""" CXType_OCLImage1dArrayRW
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3223:3)
	""" CXType_OCLImage2dDepthRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3173:3)
	""" CXType_FunctionNoProto
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3138:3)
	""" CXType_ULongLong
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3191:3)
	""" CXType_Pipe
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3143:3)
	""" CXType_Short
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3129:3)
	""" CXType_Void
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3188:3)
	""" CXType_Elaborated
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3154:3)
	""" CXType_ObjCId
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3163:3)
	""" CXType_Complex
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3179:3)
	""" CXType_DependentSizedArray
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3232:3)
	""" CXType_OCLQueue
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3214:3)
	""" CXType_OCLImage2dArrayMSAAWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3175:3)
	""" CXType_ConstantArray
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3152:3)
	""" CXType_Overload
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3216:3)
	""" CXType_OCLImage2dArrayMSAADepthWO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3233:3)
	""" CXType_OCLReserveID
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3204:3)
	""" CXType_OCLImage2dArrayMSAADepthRO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3225:3)
	""" CXType_OCLImage2dMSAARW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3174:3)
	""" CXType_FunctionProto
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3205:3)
	""" CXType_OCLImage3dRO
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3230:3)
	""" CXType_OCLSampler
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3159:3)
	""" CXType_Float16
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3224:3)
	""" CXType_OCLImage2dArrayDepthRW
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3146:3)
	""" CXType_LongLong
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3200:3)
	""" CXType_OCLImage2dArrayDepthRO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3180:3)
	""" CXType_MemberPointer
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3160:3)
	""" CXType_FirstBuiltin
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3210:3)
	""" CXType_OCLImage2dArrayWO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3151:3)
	""" CXType_NullPtr
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3144:3)
	""" CXType_Int
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3155:3)
	""" CXType_ObjCClass
	@doc raw"""
	\\brief Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3199:3)
	""" CXType_OCLImage2dDepthRO
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3142:3)
	""" CXType_WChar
	@doc raw"""
	\\brief A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3176:3)
	""" CXType_Vector
	export CXTypeKind, CXType_Auto, CXType_BlockPointer, CXType_Bool, CXType_Char16, CXType_Char32, CXType_Char_S, CXType_Char_U, CXType_Complex, CXType_ConstantArray, CXType_Dependent, CXType_DependentSizedArray, CXType_Double, CXType_Elaborated, CXType_Enum, CXType_FirstBuiltin, CXType_Float, CXType_Float128, CXType_Float16, CXType_FunctionNoProto, CXType_FunctionProto, CXType_Half, CXType_IncompleteArray, CXType_Int, CXType_Int128, CXType_Invalid, CXType_LValueReference, CXType_LastBuiltin, CXType_Long, CXType_LongDouble, CXType_LongLong, CXType_MemberPointer, CXType_NullPtr, CXType_OCLEvent, CXType_OCLImage1dArrayRO, CXType_OCLImage1dArrayRW, CXType_OCLImage1dArrayWO, CXType_OCLImage1dBufferRO, CXType_OCLImage1dBufferRW, CXType_OCLImage1dBufferWO, CXType_OCLImage1dRO, CXType_OCLImage1dRW, CXType_OCLImage1dWO, CXType_OCLImage2dArrayDepthRO, CXType_OCLImage2dArrayDepthRW, CXType_OCLImage2dArrayDepthWO, CXType_OCLImage2dArrayMSAADepthRO, CXType_OCLImage2dArrayMSAADepthRW, CXType_OCLImage2dArrayMSAADepthWO, CXType_OCLImage2dArrayMSAARO, CXType_OCLImage2dArrayMSAARW, CXType_OCLImage2dArrayMSAAWO, CXType_OCLImage2dArrayRO, CXType_OCLImage2dArrayRW, CXType_OCLImage2dArrayWO, CXType_OCLImage2dDepthRO, CXType_OCLImage2dDepthRW, CXType_OCLImage2dDepthWO, CXType_OCLImage2dMSAADepthRO, CXType_OCLImage2dMSAADepthRW, CXType_OCLImage2dMSAADepthWO, CXType_OCLImage2dMSAARO, CXType_OCLImage2dMSAARW, CXType_OCLImage2dMSAAWO, CXType_OCLImage2dRO, CXType_OCLImage2dRW, CXType_OCLImage2dWO, CXType_OCLImage3dRO, CXType_OCLImage3dRW, CXType_OCLImage3dWO, CXType_OCLQueue, CXType_OCLReserveID, CXType_OCLSampler, CXType_ObjCClass, CXType_ObjCId, CXType_ObjCInterface, CXType_ObjCObjectPointer, CXType_ObjCSel, CXType_Overload, CXType_Pipe, CXType_Pointer, CXType_RValueReference, CXType_Record, CXType_SChar, CXType_Short, CXType_Typedef, CXType_UChar, CXType_UInt, CXType_UInt128, CXType_ULong, CXType_ULongLong, CXType_UShort, CXType_Unexposed, CXType_VariableArray, CXType_Vector, CXType_Void, CXType_WChar
	@cenum CXTypeKind {
		CXType_Invalid = (@Cuint)(0)
		CXType_Unexposed = (@Cuint)(1)
		CXType_Void = (@Cuint)(2)
		CXType_Bool = (@Cuint)(3)
		CXType_Char_U = (@Cuint)(4)
		CXType_UChar = (@Cuint)(5)
		CXType_Char16 = (@Cuint)(6)
		CXType_Char32 = (@Cuint)(7)
		CXType_UShort = (@Cuint)(8)
		CXType_UInt = (@Cuint)(9)
		CXType_ULong = (@Cuint)(10)
		CXType_ULongLong = (@Cuint)(11)
		CXType_UInt128 = (@Cuint)(12)
		CXType_Char_S = (@Cuint)(13)
		CXType_SChar = (@Cuint)(14)
		CXType_WChar = (@Cuint)(15)
		CXType_Short = (@Cuint)(16)
		CXType_Int = (@Cuint)(17)
		CXType_Long = (@Cuint)(18)
		CXType_LongLong = (@Cuint)(19)
		CXType_Int128 = (@Cuint)(20)
		CXType_Float = (@Cuint)(21)
		CXType_Double = (@Cuint)(22)
		CXType_LongDouble = (@Cuint)(23)
		CXType_NullPtr = (@Cuint)(24)
		CXType_Overload = (@Cuint)(25)
		CXType_Dependent = (@Cuint)(26)
		CXType_ObjCId = (@Cuint)(27)
		CXType_ObjCClass = (@Cuint)(28)
		CXType_ObjCSel = (@Cuint)(29)
		CXType_Float128 = (@Cuint)(30)
		CXType_Half = (@Cuint)(31)
		CXType_Float16 = (@Cuint)(32)
		CXType_FirstBuiltin = (@Cuint)(2)
		CXType_LastBuiltin = (@Cuint)(32)
		CXType_Complex = (@Cuint)(100)
		CXType_Pointer = (@Cuint)(101)
		CXType_BlockPointer = (@Cuint)(102)
		CXType_LValueReference = (@Cuint)(103)
		CXType_RValueReference = (@Cuint)(104)
		CXType_Record = (@Cuint)(105)
		CXType_Enum = (@Cuint)(106)
		CXType_Typedef = (@Cuint)(107)
		CXType_ObjCInterface = (@Cuint)(108)
		CXType_ObjCObjectPointer = (@Cuint)(109)
		CXType_FunctionNoProto = (@Cuint)(110)
		CXType_FunctionProto = (@Cuint)(111)
		CXType_ConstantArray = (@Cuint)(112)
		CXType_Vector = (@Cuint)(113)
		CXType_IncompleteArray = (@Cuint)(114)
		CXType_VariableArray = (@Cuint)(115)
		CXType_DependentSizedArray = (@Cuint)(116)
		CXType_MemberPointer = (@Cuint)(117)
		CXType_Auto = (@Cuint)(118)
		CXType_Elaborated = (@Cuint)(119)
		CXType_Pipe = (@Cuint)(120)
		CXType_OCLImage1dRO = (@Cuint)(121)
		CXType_OCLImage1dArrayRO = (@Cuint)(122)
		CXType_OCLImage1dBufferRO = (@Cuint)(123)
		CXType_OCLImage2dRO = (@Cuint)(124)
		CXType_OCLImage2dArrayRO = (@Cuint)(125)
		CXType_OCLImage2dDepthRO = (@Cuint)(126)
		CXType_OCLImage2dArrayDepthRO = (@Cuint)(127)
		CXType_OCLImage2dMSAARO = (@Cuint)(128)
		CXType_OCLImage2dArrayMSAARO = (@Cuint)(129)
		CXType_OCLImage2dMSAADepthRO = (@Cuint)(130)
		CXType_OCLImage2dArrayMSAADepthRO = (@Cuint)(131)
		CXType_OCLImage3dRO = (@Cuint)(132)
		CXType_OCLImage1dWO = (@Cuint)(133)
		CXType_OCLImage1dArrayWO = (@Cuint)(134)
		CXType_OCLImage1dBufferWO = (@Cuint)(135)
		CXType_OCLImage2dWO = (@Cuint)(136)
		CXType_OCLImage2dArrayWO = (@Cuint)(137)
		CXType_OCLImage2dDepthWO = (@Cuint)(138)
		CXType_OCLImage2dArrayDepthWO = (@Cuint)(139)
		CXType_OCLImage2dMSAAWO = (@Cuint)(140)
		CXType_OCLImage2dArrayMSAAWO = (@Cuint)(141)
		CXType_OCLImage2dMSAADepthWO = (@Cuint)(142)
		CXType_OCLImage2dArrayMSAADepthWO = (@Cuint)(143)
		CXType_OCLImage3dWO = (@Cuint)(144)
		CXType_OCLImage1dRW = (@Cuint)(145)
		CXType_OCLImage1dArrayRW = (@Cuint)(146)
		CXType_OCLImage1dBufferRW = (@Cuint)(147)
		CXType_OCLImage2dRW = (@Cuint)(148)
		CXType_OCLImage2dArrayRW = (@Cuint)(149)
		CXType_OCLImage2dDepthRW = (@Cuint)(150)
		CXType_OCLImage2dArrayDepthRW = (@Cuint)(151)
		CXType_OCLImage2dMSAARW = (@Cuint)(152)
		CXType_OCLImage2dArrayMSAARW = (@Cuint)(153)
		CXType_OCLImage2dMSAADepthRW = (@Cuint)(154)
		CXType_OCLImage2dArrayMSAADepthRW = (@Cuint)(155)
		CXType_OCLImage3dRW = (@Cuint)(156)
		CXType_OCLSampler = (@Cuint)(157)
		CXType_OCLEvent = (@Cuint)(158)
		CXType_OCLQueue = (@Cuint)(159)
		CXType_OCLReserveID = (@Cuint)(160)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3250:3)
	""" CXCallingConv_Win64
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3243:3)
	""" CXCallingConv_X86FastCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3255:3)
	""" CXCallingConv_Swift
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3240:3)
	""" CXCallingConv_Default
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3246:3)
	""" CXCallingConv_AAPCS
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3254:3)
	""" CXCallingConv_X86VectorCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3253:3)
	""" CXCallingConv_X86_64SysV
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3257:3)
	""" CXCallingConv_PreserveAll
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3248:3)
	""" CXCallingConv_X86RegCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3249:3)
	""" CXCallingConv_IntelOclBicc
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3259:3)
	""" CXCallingConv_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3244:3)
	""" CXCallingConv_X86ThisCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3241:3)
	""" CXCallingConv_C
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3245:3)
	""" CXCallingConv_X86Pascal
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3247:3)
	""" CXCallingConv_AAPCS_VFP
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3252:3)
	""" CXCallingConv_X86_64Win64
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3242:3)
	""" CXCallingConv_X86StdCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3256:3)
	""" CXCallingConv_PreserveMost
	@doc raw"""
	\\brief Describes the calling convention of a function type
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3239:6)
	""" CXCallingConv
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3260:3)
	""" CXCallingConv_Unexposed
	export CXCallingConv, CXCallingConv_AAPCS, CXCallingConv_AAPCS_VFP, CXCallingConv_C, CXCallingConv_Default, CXCallingConv_IntelOclBicc, CXCallingConv_Invalid, CXCallingConv_PreserveAll, CXCallingConv_PreserveMost, CXCallingConv_Swift, CXCallingConv_Unexposed, CXCallingConv_Win64, CXCallingConv_X86FastCall, CXCallingConv_X86Pascal, CXCallingConv_X86RegCall, CXCallingConv_X86StdCall, CXCallingConv_X86ThisCall, CXCallingConv_X86VectorCall, CXCallingConv_X86_64SysV, CXCallingConv_X86_64Win64
	@cenum CXCallingConv {
		CXCallingConv_Default = (@Cuint)(0)
		CXCallingConv_C = (@Cuint)(1)
		CXCallingConv_X86StdCall = (@Cuint)(2)
		CXCallingConv_X86FastCall = (@Cuint)(3)
		CXCallingConv_X86ThisCall = (@Cuint)(4)
		CXCallingConv_X86Pascal = (@Cuint)(5)
		CXCallingConv_AAPCS = (@Cuint)(6)
		CXCallingConv_AAPCS_VFP = (@Cuint)(7)
		CXCallingConv_X86RegCall = (@Cuint)(8)
		CXCallingConv_IntelOclBicc = (@Cuint)(9)
		CXCallingConv_Win64 = (@Cuint)(10)
		CXCallingConv_X86_64Win64 = (@Cuint)(10)
		CXCallingConv_X86_64SysV = (@Cuint)(11)
		CXCallingConv_X86VectorCall = (@Cuint)(12)
		CXCallingConv_Swift = (@Cuint)(13)
		CXCallingConv_PreserveMost = (@Cuint)(14)
		CXCallingConv_PreserveAll = (@Cuint)(15)
		CXCallingConv_Invalid = (@Cuint)(100)
		CXCallingConv_Unexposed = (@Cuint)(200)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3270:3)
	""" CXType
	export CXType
	@ctypedef CXType @cstruct {
		kind::CXTypeKind
		data::((@Ptr){@Cvoid})[2]
	}
	
	@doc raw"""
	\\brief Retrieve the type of a CXCursor (if any).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3275:23)
	""" clang_getCursorType
	export clang_getCursorType
	@cextern clang_getCursorType(C::CXCursor)::CXType
	
	@doc raw"""
	\\brief Pretty-print the underlying type using the rules of the
	language of the translation unit from which it came.
	
	If the type is invalid, an empty string is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3283:25)
	""" clang_getTypeSpelling
	export clang_getTypeSpelling
	@cextern clang_getTypeSpelling(CT::CXType)::CXString
	
	@doc raw"""
	\\brief Retrieve the underlying type of a typedef declaration.
	
	If the cursor does not reference a typedef declaration, an invalid type is
	returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3291:23)
	""" clang_getTypedefDeclUnderlyingType
	export clang_getTypedefDeclUnderlyingType
	@cextern clang_getTypedefDeclUnderlyingType(C::CXCursor)::CXType
	
	@doc raw"""
	\\brief Retrieve the integer type of an enum declaration.
	
	If the cursor does not reference an enum declaration, an invalid type is
	returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3299:23)
	""" clang_getEnumDeclIntegerType
	export clang_getEnumDeclIntegerType
	@cextern clang_getEnumDeclIntegerType(C::CXCursor)::CXType
	
	@doc raw"""
	\\brief Retrieve the integer value of an enum constant declaration as a signed
	long long.
	
	If the cursor does not reference an enum constant declaration, LLONG_MIN is returned.
	Since this is also potentially a valid constant value, the kind of the cursor
	must be verified before calling this function.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3309:26)
	""" clang_getEnumConstantDeclValue
	export clang_getEnumConstantDeclValue
	@cextern clang_getEnumConstantDeclValue(C::CXCursor)::@Clonglong
	
	@doc raw"""
	\\brief Retrieve the integer value of an enum constant declaration as an unsigned
	long long.
	
	If the cursor does not reference an enum constant declaration, ULLONG_MAX is returned.
	Since this is also potentially a valid constant value, the kind of the cursor
	must be verified before calling this function.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3319:35)
	""" clang_getEnumConstantDeclUnsignedValue
	export clang_getEnumConstantDeclUnsignedValue
	@cextern clang_getEnumConstantDeclUnsignedValue(C::CXCursor)::@Culonglong
	
	@doc raw"""
	\\brief Retrieve the bit width of a bit field declaration as an integer.
	
	If a cursor that is not a bit field declaration is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3326:20)
	""" clang_getFieldDeclBitWidth
	export clang_getFieldDeclBitWidth
	@cextern clang_getFieldDeclBitWidth(C::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Retrieve the number of non-variadic arguments associated with a given
	cursor.
	
	The number of arguments can be determined for calls as well as for
	declarations of functions or methods. For other cursors -1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3335:20)
	""" clang_Cursor_getNumArguments
	export clang_Cursor_getNumArguments
	@cextern clang_Cursor_getNumArguments(C::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Retrieve the argument cursor of a function or method.
	
	The argument cursor can be determined for calls as well as for declarations
	of functions or methods. For other cursors and for invalid indices, an
	invalid cursor is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3344:25)
	""" clang_Cursor_getArgument
	export clang_Cursor_getArgument
	@cextern clang_Cursor_getArgument(C::CXCursor, i::(@Cuint))::CXCursor
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3354:3)
	""" CXTemplateArgumentKind_Type
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3355:3)
	""" CXTemplateArgumentKind_Declaration
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3361:3)
	""" CXTemplateArgumentKind_Pack
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3360:3)
	""" CXTemplateArgumentKind_Expression
	@doc raw"""
	\\brief Describes the kind of a template argument.
	
	See the definition of llvm::clang::TemplateArgument::ArgKind for full
	element descriptions.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3352:6)
	""" CXTemplateArgumentKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3358:3)
	""" CXTemplateArgumentKind_Template
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3353:3)
	""" CXTemplateArgumentKind_Null
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3359:3)
	""" CXTemplateArgumentKind_TemplateExpansion
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3363:3)
	""" CXTemplateArgumentKind_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3356:3)
	""" CXTemplateArgumentKind_NullPtr
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3357:3)
	""" CXTemplateArgumentKind_Integral
	export CXTemplateArgumentKind, CXTemplateArgumentKind_Declaration, CXTemplateArgumentKind_Expression, CXTemplateArgumentKind_Integral, CXTemplateArgumentKind_Invalid, CXTemplateArgumentKind_Null, CXTemplateArgumentKind_NullPtr, CXTemplateArgumentKind_Pack, CXTemplateArgumentKind_Template, CXTemplateArgumentKind_TemplateExpansion, CXTemplateArgumentKind_Type
	@cenum CXTemplateArgumentKind {
		CXTemplateArgumentKind_Null = (@Cuint)(0)
		CXTemplateArgumentKind_Type = (@Cuint)(1)
		CXTemplateArgumentKind_Declaration = (@Cuint)(2)
		CXTemplateArgumentKind_NullPtr = (@Cuint)(3)
		CXTemplateArgumentKind_Integral = (@Cuint)(4)
		CXTemplateArgumentKind_Template = (@Cuint)(5)
		CXTemplateArgumentKind_TemplateExpansion = (@Cuint)(6)
		CXTemplateArgumentKind_Expression = (@Cuint)(7)
		CXTemplateArgumentKind_Pack = (@Cuint)(8)
		CXTemplateArgumentKind_Invalid = (@Cuint)(9)
	}
	
	@doc raw"""
	\\brief Returns the number of template args of a function decl representing a
	template specialization.
	
	If the argument cursor cannot be converted into a template function
	declaration, -1 is returned.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	The value 3 would be returned from this call.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3382:20)
	""" clang_Cursor_getNumTemplateArguments
	export clang_Cursor_getNumTemplateArguments
	@cextern clang_Cursor_getNumTemplateArguments(C::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Retrieve the kind of the I'th template argument of the CXCursor C.
	
	If the argument CXCursor does not represent a FunctionDecl, an invalid
	template argument kind is returned.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	For I = 0, 1, and 2, Type, Integral, and Integral will be returned,
	respectively.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3400:44)
	""" clang_Cursor_getTemplateArgumentKind
	export clang_Cursor_getTemplateArgumentKind
	@cextern clang_Cursor_getTemplateArgumentKind(C::CXCursor, I::(@Cuint))::CXTemplateArgumentKind
	
	@doc raw"""
	\\brief Retrieve a CXType representing the type of a TemplateArgument of a
	function decl representing a template specialization.
	
	If the argument CXCursor does not represent a FunctionDecl whose I'th
	template argument has a kind of CXTemplateArgKind_Integral, an invalid type
	is returned.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	If called with I = 0, "float", will be returned.
	Invalid types will be returned for I == 1 or 2.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3421:23)
	""" clang_Cursor_getTemplateArgumentType
	export clang_Cursor_getTemplateArgumentType
	@cextern clang_Cursor_getTemplateArgumentType(C::CXCursor, I::(@Cuint))::CXType
	
	@doc raw"""
	\\brief Retrieve the value of an Integral TemplateArgument (of a function
	decl representing a template specialization) as a signed long long.
	
	It is undefined to call this function on a CXCursor that does not represent a
	FunctionDecl or whose I'th template argument is not an integral value.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	If called with I = 1 or 2, -7 or true will be returned, respectively.
	For I == 0, this function's behavior is undefined.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3441:26)
	""" clang_Cursor_getTemplateArgumentValue
	export clang_Cursor_getTemplateArgumentValue
	@cextern clang_Cursor_getTemplateArgumentValue(C::CXCursor, I::(@Cuint))::@Clonglong
	
	@doc raw"""
	\\brief Retrieve the value of an Integral TemplateArgument (of a function
	decl representing a template specialization) as an unsigned long long.
	
	It is undefined to call this function on a CXCursor that does not represent a
	FunctionDecl or whose I'th template argument is not an integral value.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, 2147483649, true>();
	
	If called with I = 1 or 2, 2147483649 or true will be returned, respectively.
	For I == 0, this function's behavior is undefined.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3461:35)
	""" clang_Cursor_getTemplateArgumentUnsignedValue
	export clang_Cursor_getTemplateArgumentUnsignedValue
	@cextern clang_Cursor_getTemplateArgumentUnsignedValue(C::CXCursor, I::(@Cuint))::@Culonglong
	
	@doc raw"""
	\\brief Determine whether two CXTypes represent the same type.
	
	\\returns non-zero if the CXTypes represent the same type and
	zero otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3470:25)
	""" clang_equalTypes
	export clang_equalTypes
	@cextern clang_equalTypes(A::CXType, B::CXType)::@Cuint
	
	@doc raw"""
	\\brief Return the canonical type for a CXType.
	
	Clang's type system explicitly models typedefs and all the ways
	a specific type can be represented.  The canonical type is the underlying
	type with all the "sugar" removed.  For example, if 'T' is a typedef
	for 'int', the canonical type for 'T' would be 'int'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3480:23)
	""" clang_getCanonicalType
	export clang_getCanonicalType
	@cextern clang_getCanonicalType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Determine whether a CXType has the "const" qualifier set,
	without looking through typedefs that may have added "const" at a
	different level.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3487:25)
	""" clang_isConstQualifiedType
	export clang_isConstQualifiedType
	@cextern clang_isConstQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Determine whether a  CXCursor that is a macro, is
	function like.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3493:25)
	""" clang_Cursor_isMacroFunctionLike
	export clang_Cursor_isMacroFunctionLike
	@cextern clang_Cursor_isMacroFunctionLike(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine whether a  CXCursor that is a macro, is a
	builtin one.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3499:25)
	""" clang_Cursor_isMacroBuiltin
	export clang_Cursor_isMacroBuiltin
	@cextern clang_Cursor_isMacroBuiltin(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine whether a  CXCursor that is a function declaration, is an
	inline declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3505:25)
	""" clang_Cursor_isFunctionInlined
	export clang_Cursor_isFunctionInlined
	@cextern clang_Cursor_isFunctionInlined(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine whether a CXType has the "volatile" qualifier set,
	without looking through typedefs that may have added "volatile" at
	a different level.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3512:25)
	""" clang_isVolatileQualifiedType
	export clang_isVolatileQualifiedType
	@cextern clang_isVolatileQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Determine whether a CXType has the "restrict" qualifier set,
	without looking through typedefs that may have added "restrict" at a
	different level.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3519:25)
	""" clang_isRestrictQualifiedType
	export clang_isRestrictQualifiedType
	@cextern clang_isRestrictQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Returns the address space of the given type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3524:25)
	""" clang_getAddressSpace
	export clang_getAddressSpace
	@cextern clang_getAddressSpace(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Returns the typedef name of the given type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3529:25)
	""" clang_getTypedefName
	export clang_getTypedefName
	@cextern clang_getTypedefName(CT::CXType)::CXString
	
	@doc raw"""
	\\brief For pointer types, returns the type of the pointee.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3534:23)
	""" clang_getPointeeType
	export clang_getPointeeType
	@cextern clang_getPointeeType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Return the cursor for the declaration of the given type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3539:25)
	""" clang_getTypeDeclaration
	export clang_getTypeDeclaration
	@cextern clang_getTypeDeclaration(T::CXType)::CXCursor
	
	@doc raw"""
	Returns the Objective-C type encoding for the specified declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3544:25)
	""" clang_getDeclObjCTypeEncoding
	export clang_getDeclObjCTypeEncoding
	@cextern clang_getDeclObjCTypeEncoding(C::CXCursor)::CXString
	
	@doc raw"""
	Returns the Objective-C type encoding for the specified CXType.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3549:25)
	""" clang_Type_getObjCEncoding
	export clang_Type_getObjCEncoding
	@cextern clang_Type_getObjCEncoding(var"type"::CXType)::CXString
	
	@doc raw"""
	\\brief Retrieve the spelling of a given CXTypeKind.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3554:25)
	""" clang_getTypeKindSpelling
	export clang_getTypeKindSpelling
	@cextern clang_getTypeKindSpelling(K::CXTypeKind)::CXString
	
	@doc raw"""
	\\brief Retrieve the calling convention associated with a function type.
	
	If a non-function type is passed in, CXCallingConv_Invalid is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3561:35)
	""" clang_getFunctionTypeCallingConv
	export clang_getFunctionTypeCallingConv
	@cextern clang_getFunctionTypeCallingConv(T::CXType)::CXCallingConv
	
	@doc raw"""
	\\brief Retrieve the return type associated with a function type.
	
	If a non-function type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3568:23)
	""" clang_getResultType
	export clang_getResultType
	@cextern clang_getResultType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Retrieve the exception specification type associated with a function type.
	
	If a non-function type is passed in, an error code of -1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3575:20)
	""" clang_getExceptionSpecificationType
	export clang_getExceptionSpecificationType
	@cextern clang_getExceptionSpecificationType(T::CXType)::@Cint
	
	@doc raw"""
	\\brief Retrieve the number of non-variadic parameters associated with a
	function type.
	
	If a non-function type is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3583:20)
	""" clang_getNumArgTypes
	export clang_getNumArgTypes
	@cextern clang_getNumArgTypes(T::CXType)::@Cint
	
	@doc raw"""
	\\brief Retrieve the type of a parameter of a function type.
	
	If a non-function type is passed in or the function does not have enough
	parameters, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3591:23)
	""" clang_getArgType
	export clang_getArgType
	@cextern clang_getArgType(T::CXType, i::(@Cuint))::CXType
	
	@doc raw"""
	\\brief Return 1 if the CXType is a variadic function type, and 0 otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3596:25)
	""" clang_isFunctionTypeVariadic
	export clang_isFunctionTypeVariadic
	@cextern clang_isFunctionTypeVariadic(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the return type associated with a given cursor.
	
	This only returns a valid type if the cursor refers to a function or method.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3603:23)
	""" clang_getCursorResultType
	export clang_getCursorResultType
	@cextern clang_getCursorResultType(C::CXCursor)::CXType
	
	@doc raw"""
	\\brief Retrieve the exception specification type associated with a given cursor.
	
	This only returns a valid result if the cursor refers to a function or method.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3610:20)
	""" clang_getCursorExceptionSpecificationType
	export clang_getCursorExceptionSpecificationType
	@cextern clang_getCursorExceptionSpecificationType(C::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Return 1 if the CXType is a POD (plain old data) type, and 0
	otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3616:25)
	""" clang_isPODType
	export clang_isPODType
	@cextern clang_isPODType(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief Return the element type of an array, complex, or vector type.
	
	If a type is passed in that is not an array, complex, or vector type,
	an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3624:23)
	""" clang_getElementType
	export clang_getElementType
	@cextern clang_getElementType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Return the number of elements of an array or vector type.
	
	If a type is passed in that is not an array or vector type,
	-1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3632:26)
	""" clang_getNumElements
	export clang_getNumElements
	@cextern clang_getNumElements(T::CXType)::@Clonglong
	
	@doc raw"""
	\\brief Return the element type of an array type.
	
	If a non-array type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3639:23)
	""" clang_getArrayElementType
	export clang_getArrayElementType
	@cextern clang_getArrayElementType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Return the array size of a constant array.
	
	If a non-array type is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3646:26)
	""" clang_getArraySize
	export clang_getArraySize
	@cextern clang_getArraySize(T::CXType)::@Clonglong
	
	@doc raw"""
	\\brief Retrieve the type named by the qualified-id.
	
	If a non-elaborated type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3653:23)
	""" clang_Type_getNamedType
	export clang_Type_getNamedType
	@cextern clang_Type_getNamedType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Determine if a typedef is 'transparent' tag.
	
	A typedef is considered 'transparent' if it shares a name and spelling
	location with its underlying tag type, as is the case with the NS_ENUM macro.
	
	\\returns non-zero if transparent and zero otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3663:25)
	""" clang_Type_isTransparentTagTypedef
	export clang_Type_isTransparentTagTypedef
	@cextern clang_Type_isTransparentTagTypedef(T::CXType)::@Cuint
	
	@doc raw"""
	\\brief The type is a dependent Type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3685:3)
	""" CXTypeLayoutError_Dependent
	@doc raw"""
	\\brief List the possible error codes for \\c clang_Type_getSizeOf,
	\\c clang_Type_getAlignOf, \\c clang_Type_getOffsetOf and
	\\c clang_Cursor_getOffsetOf.
	
	A value of this enumeration type can be returned if the target type is not
	a valid argument to sizeof, alignof or offsetof.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3673:6)
	""" CXTypeLayoutError
	@doc raw"""
	\\brief The Field name is not valid for this record.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3693:3)
	""" CXTypeLayoutError_InvalidFieldName
	@doc raw"""
	\\brief The type is not a constant size type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3689:3)
	""" CXTypeLayoutError_NotConstantSize
	@doc raw"""
	\\brief Type is of kind CXType_Invalid.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3677:3)
	""" CXTypeLayoutError_Invalid
	@doc raw"""
	\\brief The type is an incomplete Type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3681:3)
	""" CXTypeLayoutError_Incomplete
	export CXTypeLayoutError, CXTypeLayoutError_Dependent, CXTypeLayoutError_Incomplete, CXTypeLayoutError_Invalid, CXTypeLayoutError_InvalidFieldName, CXTypeLayoutError_NotConstantSize
	@cenum CXTypeLayoutError {
		CXTypeLayoutError_Invalid = (@Cint)(-1)
		CXTypeLayoutError_Incomplete = (@Cint)(-2)
		CXTypeLayoutError_Dependent = (@Cint)(-3)
		CXTypeLayoutError_NotConstantSize = (@Cint)(-4)
		CXTypeLayoutError_InvalidFieldName = (@Cint)(-5)
	}
	
	@doc raw"""
	\\brief Return the alignment of a type in bytes as per C++[expr.alignof]
	standard.
	
	If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
	If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
	is returned.
	If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
	returned.
	If the type declaration is not a constant size type,
	CXTypeLayoutError_NotConstantSize is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3708:26)
	""" clang_Type_getAlignOf
	export clang_Type_getAlignOf
	@cextern clang_Type_getAlignOf(T::CXType)::@Clonglong
	
	@doc raw"""
	\\brief Return the class type of an member pointer type.
	
	If a non-member-pointer type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3715:23)
	""" clang_Type_getClassType
	export clang_Type_getClassType
	@cextern clang_Type_getClassType(T::CXType)::CXType
	
	@doc raw"""
	\\brief Return the size of a type in bytes as per C++[expr.sizeof] standard.
	
	If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
	If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
	is returned.
	If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
	returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3726:26)
	""" clang_Type_getSizeOf
	export clang_Type_getSizeOf
	@cextern clang_Type_getSizeOf(T::CXType)::@Clonglong
	
	@doc raw"""
	\\brief Return the offset of a field named S in a record of type T in bits
	as it would be returned by __offsetof__ as per C++11[18.2p4]
	
	If the cursor is not a record field declaration, CXTypeLayoutError_Invalid
	is returned.
	If the field's type declaration is an incomplete type,
	CXTypeLayoutError_Incomplete is returned.
	If the field's type declaration is a dependent type,
	CXTypeLayoutError_Dependent is returned.
	If the field's name S is not found,
	CXTypeLayoutError_InvalidFieldName is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3741:26)
	""" clang_Type_getOffsetOf
	export clang_Type_getOffsetOf
	@cextern clang_Type_getOffsetOf(T::CXType, S::(@Ptr){(@Cconst)(@Cchar)})::@Clonglong
	
	@doc raw"""
	\\brief Return the offset of the field represented by the Cursor.
	
	If the cursor is not a field declaration, -1 is returned.
	If the cursor semantic parent is not a record field declaration,
	CXTypeLayoutError_Invalid is returned.
	If the field's type declaration is an incomplete type,
	CXTypeLayoutError_Incomplete is returned.
	If the field's type declaration is a dependent type,
	CXTypeLayoutError_Dependent is returned.
	If the field's name S is not found,
	CXTypeLayoutError_InvalidFieldName is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3756:26)
	""" clang_Cursor_getOffsetOfField
	export clang_Cursor_getOffsetOfField
	@cextern clang_Cursor_getOffsetOfField(C::CXCursor)::@Clonglong
	
	@doc raw"""
	\\brief Determine whether the given cursor represents an anonymous record
	declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3762:25)
	""" clang_Cursor_isAnonymous
	export clang_Cursor_isAnonymous
	@cextern clang_Cursor_isAnonymous(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief An rvalue ref-qualifier was provided (\\c &&). */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3770:3)
	""" CXRefQualifier_RValue
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3764:6)
	""" CXRefQualifierKind
	@doc raw"""
	\\brief An lvalue ref-qualifier was provided (\\c &). */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3768:3)
	""" CXRefQualifier_LValue
	@doc raw"""
	\\brief No ref-qualifier was provided. */
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3766:3)
	""" CXRefQualifier_None
	export CXRefQualifierKind, CXRefQualifier_LValue, CXRefQualifier_None, CXRefQualifier_RValue
	@cenum CXRefQualifierKind {
		CXRefQualifier_None = (@Cuint)(0)
		CXRefQualifier_LValue = (@Cuint)(1)
		CXRefQualifier_RValue = (@Cuint)(2)
	}
	
	@doc raw"""
	\\brief Returns the number of template arguments for given template
	specialization, or -1 if type \\c T is not a template specialization.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3777:20)
	""" clang_Type_getNumTemplateArguments
	export clang_Type_getNumTemplateArguments
	@cextern clang_Type_getNumTemplateArguments(T::CXType)::@Cint
	
	@doc raw"""
	\\brief Returns the type template argument of a template class specialization
	at given index.
	
	This function only returns template type arguments and does not handle
	template template arguments or variadic packs.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3786:23)
	""" clang_Type_getTemplateArgumentAsType
	export clang_Type_getTemplateArgumentAsType
	@cextern clang_Type_getTemplateArgumentAsType(T::CXType, i::(@Cuint))::CXType
	
	@doc raw"""
	\\brief Retrieve the ref-qualifier kind of a function or method.
	
	The ref-qualifier is returned for C++ functions or methods. For other types
	or non-C++ declarations, CXRefQualifier_None is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3794:40)
	""" clang_Type_getCXXRefQualifier
	export clang_Type_getCXXRefQualifier
	@cextern clang_Type_getCXXRefQualifier(T::CXType)::CXRefQualifierKind
	
	@doc raw"""
	\\brief Returns non-zero if the cursor specifies a Record member that is a
	bitfield.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3800:25)
	""" clang_Cursor_isBitField
	export clang_Cursor_isBitField
	@cextern clang_Cursor_isBitField(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Returns 1 if the base class specified by the cursor with kind
	CX_CXXBaseSpecifier is virtual.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3806:25)
	""" clang_isVirtualBase
	export clang_isVirtualBase
	@cextern clang_isVirtualBase(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3814:3)
	""" CX_CXXPublic
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3816:3)
	""" CX_CXXPrivate
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3813:3)
	""" CX_CXXInvalidAccessSpecifier
	@doc raw"""
	\\brief Represents the C++ access control level to a base class for a
	cursor with kind CX_CXXBaseSpecifier.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3812:6)
	""" CX_CXXAccessSpecifier
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3815:3)
	""" CX_CXXProtected
	export CX_CXXAccessSpecifier, CX_CXXInvalidAccessSpecifier, CX_CXXPrivate, CX_CXXProtected, CX_CXXPublic
	@cenum CX_CXXAccessSpecifier {
		CX_CXXInvalidAccessSpecifier = (@Cuint)(0)
		CX_CXXPublic = (@Cuint)(1)
		CX_CXXProtected = (@Cuint)(2)
		CX_CXXPrivate = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief Returns the access control level for the referenced object.
	
	If the cursor refers to a C++ declaration, its access control level within its
	parent scope is returned. Otherwise, if the cursor refers to a base specifier or
	access specifier, the specifier itself is returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3826:43)
	""" clang_getCXXAccessSpecifier
	export clang_getCXXAccessSpecifier
	@cextern clang_getCXXAccessSpecifier(var"?1?"::CXCursor)::CX_CXXAccessSpecifier
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3838:3)
	""" CX_SC_OpenCLWorkGroupLocal
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3835:3)
	""" CX_SC_Extern
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3837:3)
	""" CX_SC_PrivateExtern
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3834:3)
	""" CX_SC_None
	@doc raw"""
	\\brief Represents the storage classes as declared in the source. CX_SC_Invalid
	was added for the case that the passed cursor in not a declaration.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3832:6)
	""" CX_StorageClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3840:3)
	""" CX_SC_Register
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3839:3)
	""" CX_SC_Auto
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3833:3)
	""" CX_SC_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3836:3)
	""" CX_SC_Static
	export CX_SC_Auto, CX_SC_Extern, CX_SC_Invalid, CX_SC_None, CX_SC_OpenCLWorkGroupLocal, CX_SC_PrivateExtern, CX_SC_Register, CX_SC_Static, CX_StorageClass
	@cenum CX_StorageClass {
		CX_SC_Invalid = (@Cuint)(0)
		CX_SC_None = (@Cuint)(1)
		CX_SC_Extern = (@Cuint)(2)
		CX_SC_Static = (@Cuint)(3)
		CX_SC_PrivateExtern = (@Cuint)(4)
		CX_SC_OpenCLWorkGroupLocal = (@Cuint)(5)
		CX_SC_Auto = (@Cuint)(6)
		CX_SC_Register = (@Cuint)(7)
	}
	
	@doc raw"""
	\\brief Returns the storage class for a function or variable declaration.
	
	If the passed in Cursor is not a function or variable declaration,
	CX_SC_Invalid is returned else the storage class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3849:37)
	""" clang_Cursor_getStorageClass
	export clang_Cursor_getStorageClass
	@cextern clang_Cursor_getStorageClass(var"?1?"::CXCursor)::CX_StorageClass
	
	@doc raw"""
	\\brief Determine the number of overloaded declarations referenced by a 
	\\c CXCursor_OverloadedDeclRef cursor.
	
	\\param cursor The cursor whose overloaded declarations are being queried.
	
	\\returns The number of overloaded declarations referenced by \\c cursor. If it
	is not a \\c CXCursor_OverloadedDeclRef cursor, returns 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3860:25)
	""" clang_getNumOverloadedDecls
	export clang_getNumOverloadedDecls
	@cextern clang_getNumOverloadedDecls(cursor::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a cursor for one of the overloaded declarations referenced
	by a \\c CXCursor_OverloadedDeclRef cursor.
	
	\\param cursor The cursor whose overloaded declarations are being queried.
	
	\\param index The zero-based index into the set of overloaded declarations in
	the cursor.
	
	\\returns A cursor representing the declaration referenced by the given 
	\\c cursor at the specified \\c index. If the cursor does not have an 
	associated set of overloaded declarations, or if the index is out of bounds,
	returns \\c clang_getNullCursor();
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3876:25)
	""" clang_getOverloadedDecl
	export clang_getOverloadedDecl
	@cextern clang_getOverloadedDecl(cursor::CXCursor, index::(@Cuint))::CXCursor
	
	@doc raw"""
	\\brief For cursors representing an iboutletcollection attribute,
	this function returns the collection element type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3894:23)
	""" clang_getIBOutletCollectionType
	export clang_getIBOutletCollectionType
	@cextern clang_getIBOutletCollectionType(var"?1?"::CXCursor)::CXType
	
	@doc raw"""
	\\brief Recursively traverse the children of this cursor, using
	the same visitor and client data.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3930:3)
	""" CXChildVisit_Recurse
	@doc raw"""
	\\brief Terminates the cursor traversal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3920:3)
	""" CXChildVisit_Break
	@doc raw"""
	\\brief Continues the cursor traversal with the next sibling of
	the cursor just visited, without visiting its children.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3925:3)
	""" CXChildVisit_Continue
	@doc raw"""
	\\brief Describes how the traversal of the children of a particular
	cursor should proceed after visiting a particular child cursor.
	
	A value of this enumeration type should be returned by each
	\\c CXCursorVisitor to indicate how clang_visitChildren() proceed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3916:6)
	""" CXChildVisitResult
	export CXChildVisitResult, CXChildVisit_Break, CXChildVisit_Continue, CXChildVisit_Recurse
	@cenum CXChildVisitResult {
		CXChildVisit_Break = (@Cuint)(0)
		CXChildVisit_Continue = (@Cuint)(1)
		CXChildVisit_Recurse = (@Cuint)(2)
	}
	
	@doc raw"""
	\\brief Visitor invoked for each cursor found by a traversal.
	
	This visitor function will be invoked for each cursor found by
	clang_visitCursorChildren(). Its first argument is the cursor being
	visited, its second argument is the parent visitor for that cursor,
	and its third argument is the client data provided to
	clang_visitCursorChildren().
	
	The visitor should return one of the \\c CXChildVisitResult values
	to direct clang_visitCursorChildren().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3945:35)
	""" CXCursorVisitor
	export CXCursorVisitor
	@ctypedef CXCursorVisitor (@Ptr){(@Cfunction){(CXChildVisitResult), (@Tuple){(CXCursor), (CXCursor), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	\\brief Visit the children of a particular cursor.
	
	This function visits all the direct children of the given cursor,
	invoking the given \\p visitor function with the cursors of each
	visited child. The traversal may be recursive, if the visitor returns
	\\c CXChildVisit_Recurse. The traversal may also be ended prematurely, if
	the visitor returns \\c CXChildVisit_Break.
	
	\\param parent the cursor whose child may be visited. All kinds of
	cursors can be visited, including invalid cursors (which, by
	definition, have no children).
	
	\\param visitor the visitor function that will be invoked for each
	child of \\p parent.
	
	\\param client_data pointer data supplied by the client, which will
	be passed to the visitor each time it is invoked.
	
	\\returns a non-zero value if the traversal was terminated
	prematurely by the visitor returning \\c CXChildVisit_Break.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:3971:25)
	""" clang_visitChildren
	export clang_visitChildren
	@cextern clang_visitChildren(parent::CXCursor, visitor::CXCursorVisitor, client_data::CXClientData)::@Cuint
	
	@doc raw"""
	\\brief Retrieve a Unified Symbol Resolution (USR) for the entity referenced
	by the given cursor.
	
	A Unified Symbol Resolution (USR) is a string that identifies a particular
	entity (function, class, variable, etc.) within a program. USRs can be
	compared across translation units to determine, e.g., when references in
	one translation refer to an entity defined in another translation unit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4022:25)
	""" clang_getCursorUSR
	export clang_getCursorUSR
	@cextern clang_getCursorUSR(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4027:25)
	""" clang_constructUSR_ObjCClass
	export clang_constructUSR_ObjCClass
	@cextern clang_constructUSR_ObjCClass(class_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C category.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4033:3)
	""" clang_constructUSR_ObjCCategory
	export clang_constructUSR_ObjCCategory
	@cextern clang_constructUSR_ObjCCategory(class_name::(@Ptr){(@Cconst)(@Cchar)}, category_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C protocol.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4040:3)
	""" clang_constructUSR_ObjCProtocol
	export clang_constructUSR_ObjCProtocol
	@cextern clang_constructUSR_ObjCProtocol(protocol_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C instance variable and
	the USR for its containing class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4046:25)
	""" clang_constructUSR_ObjCIvar
	export clang_constructUSR_ObjCIvar
	@cextern clang_constructUSR_ObjCIvar(name::(@Ptr){(@Cconst)(@Cchar)}, classUSR::CXString)::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C method and
	the USR for its containing class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4053:25)
	""" clang_constructUSR_ObjCMethod
	export clang_constructUSR_ObjCMethod
	@cextern clang_constructUSR_ObjCMethod(name::(@Ptr){(@Cconst)(@Cchar)}, isInstanceMethod::(@Cuint), classUSR::CXString)::CXString
	
	@doc raw"""
	\\brief Construct a USR for a specified Objective-C property and the USR
	for its containing class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4061:25)
	""" clang_constructUSR_ObjCProperty
	export clang_constructUSR_ObjCProperty
	@cextern clang_constructUSR_ObjCProperty(property::(@Ptr){(@Cconst)(@Cchar)}, classUSR::CXString)::CXString
	
	@doc raw"""
	\\brief Retrieve a name for the entity referenced by this cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4067:25)
	""" clang_getCursorSpelling
	export clang_getCursorSpelling
	@cextern clang_getCursorSpelling(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	\\brief Retrieve a range for a piece that forms the cursors spelling name.
	Most of the times there is only one range for the complete spelling but for
	Objective-C methods and Objective-C message expressions, there are multiple
	pieces for each selector identifier.
	
	\\param pieceIndex the index of the spelling name piece. If this is greater
	than the actual number of pieces, it will return a NULL (invalid) range.
	
	\\param options Reserved.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4080:30)
	""" clang_Cursor_getSpellingNameRange
	export clang_Cursor_getSpellingNameRange
	@cextern clang_Cursor_getSpellingNameRange(var"?1?"::CXCursor, pieceIndex::(@Cuint), options::(@Cuint))::CXSourceRange
	
	@doc raw"""
	\\brief Retrieve the display name for the entity referenced by this cursor.
	
	The display name contains extra information that helps identify the cursor,
	such as the parameters of a function or template or the arguments of a 
	class template specialization.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4091:25)
	""" clang_getCursorDisplayName
	export clang_getCursorDisplayName
	@cextern clang_getCursorDisplayName(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	\\brief For a cursor that is a reference, retrieve a cursor representing the
	entity that it references.
	
	Reference cursors refer to other entities in the AST. For example, an
	Objective-C superclass reference cursor refers to an Objective-C class.
	This function produces the cursor for the Objective-C class from the
	cursor for the superclass reference. If the input cursor is a declaration or
	definition, it returns that declaration or definition unchanged.
	Otherwise, returns the NULL cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4103:25)
	""" clang_getCursorReferenced
	export clang_getCursorReferenced
	@cextern clang_getCursorReferenced(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief For a cursor that is either a reference to or a declaration
	of some entity, retrieve a cursor that describes the definition of
	that entity.
	
	Some entities can be declared multiple times within a translation
	unit, but only one of those declarations can also be a
	definition. For example, given:
	
	\\code
	int f(int, int);
	int g(int x, int y) { return f(x, y); }
	int f(int a, int b) { return a + b; }
	int f(int, int);
	\\endcode
	
	there are three declarations of the function "f", but only the
	second one is a definition. The clang_getCursorDefinition()
	function will take any cursor pointing to a declaration of "f"
	(the first or fourth lines of the example) or a cursor referenced
	that uses "f" (the call to "f' inside "g") and will return a
	declaration cursor pointing to the definition (the second "f"
	declaration).
	
	If given a cursor for which there is no corresponding definition,
	e.g., because there is no definition of that entity within this
	translation unit, returns a NULL cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4133:25)
	""" clang_getCursorDefinition
	export clang_getCursorDefinition
	@cextern clang_getCursorDefinition(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief Determine whether the declaration pointed to by this cursor
	is also a definition of that entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4139:25)
	""" clang_isCursorDefinition
	export clang_isCursorDefinition
	@cextern clang_isCursorDefinition(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the canonical cursor corresponding to the given cursor.
	
	In the C family of languages, many kinds of entities can be declared several
	times within a single translation unit. For example, a structure type can
	be forward-declared (possibly multiple times) and later defined:
	
	\\code
	struct X;
	struct X;
	struct X {
	int member;
	};
	\\endcode
	
	The declarations and the definition of \\c X are represented by three 
	different cursors, all of which are declarations of the same underlying 
	entity. One of these cursor is considered the "canonical" cursor, which
	is effectively the representative for the underlying entity. One can 
	determine if two cursors are declarations of the same underlying entity by
	comparing their canonical cursors.
	
	\\returns The canonical cursor for the entity referred to by the given cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4165:25)
	""" clang_getCanonicalCursor
	export clang_getCanonicalCursor
	@cextern clang_getCanonicalCursor(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief If the cursor points to a selector identifier in an Objective-C
	method or message expression, this returns the selector index.
	
	After getting a cursor with #clang_getCursor, this can be called to
	determine if the location points to a selector identifier.
	
	\\returns The selector index if the cursor is an Objective-C method or message
	expression and the cursor is pointing to a selector identifier, or -1
	otherwise.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4178:20)
	""" clang_Cursor_getObjCSelectorIndex
	export clang_Cursor_getObjCSelectorIndex
	@cextern clang_Cursor_getObjCSelectorIndex(var"?1?"::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Given a cursor pointing to a C++ method call or an Objective-C
	message, returns non-zero if the method/message is "dynamic", meaning:
	
	For a C++ method: the call is virtual.
	For an Objective-C message: the receiver is an object instance, not 'super'
	or a specific class.
	
	If the method/message is "static" or the cursor does not point to a
	method/message, it will return zero.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4191:20)
	""" clang_Cursor_isDynamicCall
	export clang_Cursor_isDynamicCall
	@cextern clang_Cursor_isDynamicCall(C::CXCursor)::@Cint
	
	@doc raw"""
	\\brief Given a cursor pointing to an Objective-C message or property
	reference, or C++ method call, returns the CXType of the receiver.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4197:23)
	""" clang_Cursor_getReceiverType
	export clang_Cursor_getReceiverType
	@cextern clang_Cursor_getReceiverType(C::CXCursor)::CXType
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4206:3)
	""" CXObjCPropertyAttr_assign
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4207:3)
	""" CXObjCPropertyAttr_readwrite
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4217:3)
	""" CXObjCPropertyAttrKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4204:3)
	""" CXObjCPropertyAttr_readonly
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4210:3)
	""" CXObjCPropertyAttr_nonatomic
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4212:3)
	""" CXObjCPropertyAttr_atomic
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4203:3)
	""" CXObjCPropertyAttr_noattr
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4205:3)
	""" CXObjCPropertyAttr_getter
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4209:3)
	""" CXObjCPropertyAttr_copy
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4214:3)
	""" CXObjCPropertyAttr_strong
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4213:3)
	""" CXObjCPropertyAttr_weak
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4211:3)
	""" CXObjCPropertyAttr_setter
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4215:3)
	""" CXObjCPropertyAttr_unsafe_unretained
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4208:3)
	""" CXObjCPropertyAttr_retain
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4216:3)
	""" CXObjCPropertyAttr_class
	export CXObjCPropertyAttrKind, CXObjCPropertyAttr_assign, CXObjCPropertyAttr_atomic, CXObjCPropertyAttr_class, CXObjCPropertyAttr_copy, CXObjCPropertyAttr_getter, CXObjCPropertyAttr_noattr, CXObjCPropertyAttr_nonatomic, CXObjCPropertyAttr_readonly, CXObjCPropertyAttr_readwrite, CXObjCPropertyAttr_retain, CXObjCPropertyAttr_setter, CXObjCPropertyAttr_strong, CXObjCPropertyAttr_unsafe_unretained, CXObjCPropertyAttr_weak
	@ctypedef CXObjCPropertyAttrKind @cenum {
		CXObjCPropertyAttr_noattr = (@Cuint)(0)
		CXObjCPropertyAttr_readonly = (@Cuint)(1)
		CXObjCPropertyAttr_getter = (@Cuint)(2)
		CXObjCPropertyAttr_assign = (@Cuint)(4)
		CXObjCPropertyAttr_readwrite = (@Cuint)(8)
		CXObjCPropertyAttr_retain = (@Cuint)(16)
		CXObjCPropertyAttr_copy = (@Cuint)(32)
		CXObjCPropertyAttr_nonatomic = (@Cuint)(64)
		CXObjCPropertyAttr_setter = (@Cuint)(128)
		CXObjCPropertyAttr_atomic = (@Cuint)(256)
		CXObjCPropertyAttr_weak = (@Cuint)(512)
		CXObjCPropertyAttr_strong = (@Cuint)(1024)
		CXObjCPropertyAttr_unsafe_unretained = (@Cuint)(2048)
		CXObjCPropertyAttr_class = (@Cuint)(4096)
	}
	
	@doc raw"""
	\\brief Given a cursor that represents a property declaration, return the
	associated property attributes. The bits are formed from
	\\c CXObjCPropertyAttrKind.
	
	\\param reserved Reserved for future use, pass 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4226:25)
	""" clang_Cursor_getObjCPropertyAttributes
	export clang_Cursor_getObjCPropertyAttributes
	@cextern clang_Cursor_getObjCPropertyAttributes(C::CXCursor, reserved::(@Cuint))::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4240:3)
	""" CXObjCDeclQualifier_Oneway
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4235:3)
	""" CXObjCDeclQualifier_In
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4234:3)
	""" CXObjCDeclQualifier_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4236:3)
	""" CXObjCDeclQualifier_Inout
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4237:3)
	""" CXObjCDeclQualifier_Out
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4241:3)
	""" CXObjCDeclQualifierKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4238:3)
	""" CXObjCDeclQualifier_Bycopy
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4239:3)
	""" CXObjCDeclQualifier_Byref
	export CXObjCDeclQualifierKind, CXObjCDeclQualifier_Bycopy, CXObjCDeclQualifier_Byref, CXObjCDeclQualifier_In, CXObjCDeclQualifier_Inout, CXObjCDeclQualifier_None, CXObjCDeclQualifier_Oneway, CXObjCDeclQualifier_Out
	@ctypedef CXObjCDeclQualifierKind @cenum {
		CXObjCDeclQualifier_None = (@Cuint)(0)
		CXObjCDeclQualifier_In = (@Cuint)(1)
		CXObjCDeclQualifier_Inout = (@Cuint)(2)
		CXObjCDeclQualifier_Out = (@Cuint)(4)
		CXObjCDeclQualifier_Bycopy = (@Cuint)(8)
		CXObjCDeclQualifier_Byref = (@Cuint)(16)
		CXObjCDeclQualifier_Oneway = (@Cuint)(32)
	}
	
	@doc raw"""
	\\brief Given a cursor that represents an Objective-C method or parameter
	declaration, return the associated Objective-C qualifiers for the return
	type or the parameter respectively. The bits are formed from
	CXObjCDeclQualifierKind.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4249:25)
	""" clang_Cursor_getObjCDeclQualifiers
	export clang_Cursor_getObjCDeclQualifiers
	@cextern clang_Cursor_getObjCDeclQualifiers(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Given a cursor that represents an Objective-C method or property
	declaration, return non-zero if the declaration was affected by "\\@optional".
	Returns zero if the cursor is not such a declaration or it is "\\@required".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4256:25)
	""" clang_Cursor_isObjCOptional
	export clang_Cursor_isObjCOptional
	@cextern clang_Cursor_isObjCOptional(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Returns non-zero if the given cursor is a variadic function or method.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4261:25)
	""" clang_Cursor_isVariadic
	export clang_Cursor_isVariadic
	@cextern clang_Cursor_isVariadic(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Returns non-zero if the given cursor points to a symbol marked with
	external_source_symbol attribute.
	
	\\param language If non-NULL, and the attribute is present, will be set to
	the 'language' string from the attribute.
	
	\\param definedIn If non-NULL, and the attribute is present, will be set to
	the 'definedIn' string from the attribute.
	
	\\param isGenerated If non-NULL, and the attribute is present, will be set to
	non-zero if the 'generated_declaration' is set in the attribute.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4276:25)
	""" clang_Cursor_isExternalSymbol
	export clang_Cursor_isExternalSymbol
	@cextern clang_Cursor_isExternalSymbol(C::CXCursor, language::(@Ptr){CXString}, definedIn::(@Ptr){CXString}, isGenerated::(@Ptr){@Cuint})::@Cuint
	
	@doc raw"""
	\\brief Given a cursor that represents a declaration, return the associated
	comment's source range.  The range may include multiple consecutive comments
	with whitespace in between.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4285:30)
	""" clang_Cursor_getCommentRange
	export clang_Cursor_getCommentRange
	@cextern clang_Cursor_getCommentRange(C::CXCursor)::CXSourceRange
	
	@doc raw"""
	\\brief Given a cursor that represents a declaration, return the associated
	comment text, including comment markers.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4291:25)
	""" clang_Cursor_getRawCommentText
	export clang_Cursor_getRawCommentText
	@cextern clang_Cursor_getRawCommentText(C::CXCursor)::CXString
	
	@doc raw"""
	\\brief Given a cursor that represents a documentable entity (e.g.,
	declaration), return the associated \\\\brief paragraph; otherwise return the
	first paragraph.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4298:25)
	""" clang_Cursor_getBriefCommentText
	export clang_Cursor_getBriefCommentText
	@cextern clang_Cursor_getBriefCommentText(C::CXCursor)::CXString
	
	@doc raw"""
	\\brief Retrieve the CXString representing the mangled name of the cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4312:25)
	""" clang_Cursor_getMangling
	export clang_Cursor_getMangling
	@cextern clang_Cursor_getMangling(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	\\brief Retrieve the CXStrings representing the mangled symbols of the C++
	constructor or destructor at the cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4318:29)
	""" clang_Cursor_getCXXManglings
	export clang_Cursor_getCXXManglings
	@cextern clang_Cursor_getCXXManglings(var"?1?"::CXCursor)::(@Ptr){CXStringSet}
	
	@doc raw"""
	\\brief Retrieve the CXStrings representing the mangled symbols of the ObjC
	class interface or implementation at the cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4324:29)
	""" clang_Cursor_getObjCManglings
	export clang_Cursor_getObjCManglings
	@cextern clang_Cursor_getObjCManglings(var"?1?"::CXCursor)::(@Ptr){CXStringSet}
	
	@doc raw"""
	\\defgroup CINDEX_MODULE Module introspection
	
	The functions in this group provide access to information about modules.
	
	@{
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4338:15)
	""" CXModule
	export CXModule
	@ctypedef CXModule (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Given a CXCursor_ModuleImportDecl cursor, return the associated module.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4343:25)
	""" clang_Cursor_getModule
	export clang_Cursor_getModule
	@cextern clang_Cursor_getModule(C::CXCursor)::CXModule
	
	@doc raw"""
	\\brief Given a CXFile header file, return the module that contains it, if one
	exists.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4349:25)
	""" clang_getModuleForFile
	export clang_getModuleForFile
	@cextern clang_getModuleForFile(var"?1?"::CXTranslationUnit, var"?2?"::CXFile)::CXModule
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the module file where the provided module object came from.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4356:23)
	""" clang_Module_getASTFile
	export clang_Module_getASTFile
	@cextern clang_Module_getASTFile(Module::CXModule)::CXFile
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the parent of a sub-module or NULL if the given module is top-level,
	e.g. for 'std.vector' it will return the 'std' module.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4364:25)
	""" clang_Module_getParent
	export clang_Module_getParent
	@cextern clang_Module_getParent(Module::CXModule)::CXModule
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the name of the module, e.g. for the 'std.vector' sub-module it
	will return "vector".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4372:25)
	""" clang_Module_getName
	export clang_Module_getName
	@cextern clang_Module_getName(Module::CXModule)::CXString
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the full name of the module, e.g. "std.vector".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4379:25)
	""" clang_Module_getFullName
	export clang_Module_getFullName
	@cextern clang_Module_getFullName(Module::CXModule)::CXString
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns non-zero if the module is a system one.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4386:20)
	""" clang_Module_isSystem
	export clang_Module_isSystem
	@cextern clang_Module_isSystem(Module::CXModule)::@Cint
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the number of top level headers associated with this module.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4393:25)
	""" clang_Module_getNumTopLevelHeaders
	export clang_Module_getNumTopLevelHeaders
	@cextern clang_Module_getNumTopLevelHeaders(var"?1?"::CXTranslationUnit, Module::CXModule)::@Cuint
	
	@doc raw"""
	\\param Module a module object.
	
	\\param Index top level header index (zero-based).
	
	\\returns the specified top level header associated with the module.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4404:8)
	""" clang_Module_getTopLevelHeader
	export clang_Module_getTopLevelHeader
	@cextern clang_Module_getTopLevelHeader(var"?1?"::CXTranslationUnit, Module::CXModule, Index::(@Cuint))::CXFile
	
	@doc raw"""
	\\brief Determine if a C++ constructor is a converting constructor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4423:25)
	""" clang_CXXConstructor_isConvertingConstructor
	export clang_CXXConstructor_isConvertingConstructor
	@cextern clang_CXXConstructor_isConvertingConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ constructor is a copy constructor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4428:25)
	""" clang_CXXConstructor_isCopyConstructor
	export clang_CXXConstructor_isCopyConstructor
	@cextern clang_CXXConstructor_isCopyConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ constructor is the default constructor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4433:25)
	""" clang_CXXConstructor_isDefaultConstructor
	export clang_CXXConstructor_isDefaultConstructor
	@cextern clang_CXXConstructor_isDefaultConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ constructor is a move constructor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4438:25)
	""" clang_CXXConstructor_isMoveConstructor
	export clang_CXXConstructor_isMoveConstructor
	@cextern clang_CXXConstructor_isMoveConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ field is declared 'mutable'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4443:25)
	""" clang_CXXField_isMutable
	export clang_CXXField_isMutable
	@cextern clang_CXXField_isMutable(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ method is declared '= default'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4448:25)
	""" clang_CXXMethod_isDefaulted
	export clang_CXXMethod_isDefaulted
	@cextern clang_CXXMethod_isDefaulted(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ member function or member function template is
	pure virtual.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4454:25)
	""" clang_CXXMethod_isPureVirtual
	export clang_CXXMethod_isPureVirtual
	@cextern clang_CXXMethod_isPureVirtual(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ member function or member function template is 
	declared 'static'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4460:25)
	""" clang_CXXMethod_isStatic
	export clang_CXXMethod_isStatic
	@cextern clang_CXXMethod_isStatic(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ member function or member function template is
	explicitly declared 'virtual' or if it overrides a virtual method from
	one of the base classes.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4467:25)
	""" clang_CXXMethod_isVirtual
	export clang_CXXMethod_isVirtual
	@cextern clang_CXXMethod_isVirtual(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ record is abstract, i.e. whether a class or struct
	has a pure virtual member function.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4473:25)
	""" clang_CXXRecord_isAbstract
	export clang_CXXRecord_isAbstract
	@cextern clang_CXXRecord_isAbstract(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if an enum declaration refers to a scoped enum.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4478:25)
	""" clang_EnumDecl_isScoped
	export clang_EnumDecl_isScoped
	@cextern clang_EnumDecl_isScoped(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Determine if a C++ member function or member function template is
	declared 'const'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4484:25)
	""" clang_CXXMethod_isConst
	export clang_CXXMethod_isConst
	@cextern clang_CXXMethod_isConst(C::CXCursor)::@Cuint
	
	@doc raw"""
	\\brief Given a cursor that represents a template, determine
	the cursor kind of the specializations would be generated by instantiating
	the template.
	
	This routine can be used to determine what flavor of function template,
	class template, or class template partial specialization is stored in the
	cursor. For example, it can describe whether a class template cursor is
	declared with "struct", "class" or "union".
	
	\\param C The cursor to query. This cursor should represent a template
	declaration.
	
	\\returns The cursor kind of the specializations that would be generated
	by instantiating the template \\p C. If \\p C is not a template, returns
	\\c CXCursor_NoDeclFound.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4503:34)
	""" clang_getTemplateCursorKind
	export clang_getTemplateCursorKind
	@cextern clang_getTemplateCursorKind(C::CXCursor)::CXCursorKind
	
	@doc raw"""
	\\brief Given a cursor that may represent a specialization or instantiation
	of a template, retrieve the cursor that represents the template that it
	specializes or from which it was instantiated.
	
	This routine determines the template involved both for explicit 
	specializations of templates and for implicit instantiations of the template,
	both of which are referred to as "specializations". For a class template
	specialization (e.g., \\c std::vector<bool>), this routine will return 
	either the primary template (\\c std::vector) or, if the specialization was
	instantiated from a class template partial specialization, the class template
	partial specialization. For a class template partial specialization and a
	function template specialization (including instantiations), this
	this routine will return the specialized template.
	
	For members of a class template (e.g., member functions, member classes, or
	static data members), returns the specialized or instantiated member. 
	Although not strictly "templates" in the C++ language, members of class
	templates have the same notions of specializations and instantiations that
	templates do, so this routine treats them similarly.
	
	\\param C A cursor that may be a specialization of a template or a member
	of a template.
	
	\\returns If the given cursor is a specialization or instantiation of a 
	template or a member thereof, the template or member that it specializes or
	from which it was instantiated. Otherwise, returns a NULL cursor.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4533:25)
	""" clang_getSpecializedCursorTemplate
	export clang_getSpecializedCursorTemplate
	@cextern clang_getSpecializedCursorTemplate(C::CXCursor)::CXCursor
	
	@doc raw"""
	\\brief Given a cursor that references something else, return the source range
	covering that reference.
	
	\\param C A cursor pointing to a member reference, a declaration reference, or
	an operator call.
	\\param NameFlags A bitset with three independent flags: 
	CXNameRange_WantQualifier, CXNameRange_WantTemplateArgs, and
	CXNameRange_WantSinglePiece.
	\\param PieceIndex For contiguous names or when passing the flag 
	CXNameRange_WantSinglePiece, only one piece with index 0 is 
	available. When the CXNameRange_WantSinglePiece flag is not passed for a
	non-contiguous names, this index can be used to retrieve the individual
	pieces of the name. See also CXNameRange_WantSinglePiece.
	
	\\returns The piece of the name pointed to by the given cursor. If there is no
	name, or if the PieceIndex is out-of-range, a null-cursor will be returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4553:30)
	""" clang_getCursorReferenceNameRange
	export clang_getCursorReferenceNameRange
	@cextern clang_getCursorReferenceNameRange(C::CXCursor, NameFlags::(@Cuint), PieceIndex::(@Cuint))::CXSourceRange
	
	@doc raw"""
	\\brief Include the nested-name-specifier, e.g. Foo:: in x.Foo::y, in the
	range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4562:3)
	""" CXNameRange_WantQualifier
	@doc raw"""
	\\brief If the name is non-contiguous, return the full spanning range.
	
	Non-contiguous names occur in Objective-C when a selector with two or more
	parameters is used, or in C++ when using an operator:
	\\code
	[object doSomething:here withValue:there]; // Objective-C
	return some_vector[1]; // C++
	\\endcode
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4580:3)
	""" CXNameRange_WantSinglePiece
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4557:6)
	""" CXNameRefFlags
	@doc raw"""
	\\brief Include the explicit template arguments, e.g. \\<int> in x.f<int>,
	in the range.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4568:3)
	""" CXNameRange_WantTemplateArgs
	export CXNameRange_WantQualifier, CXNameRange_WantSinglePiece, CXNameRange_WantTemplateArgs, CXNameRefFlags
	@cenum CXNameRefFlags {
		CXNameRange_WantQualifier = (@Cuint)(1)
		CXNameRange_WantTemplateArgs = (@Cuint)(2)
		CXNameRange_WantSinglePiece = (@Cuint)(4)
	}
	
	@doc raw"""
	\\brief Describes a kind of token.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4600:14)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4625:3)
	""" CXTokenKind
	@doc raw"""
	\\brief A comment.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4624:3)
	""" CXToken_Comment
	@doc raw"""
	\\brief An identifier (that is not a keyword).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4614:3)
	""" CXToken_Identifier
	@doc raw"""
	\\brief A language keyword.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4609:3)
	""" CXToken_Keyword
	@doc raw"""
	\\brief A numeric, string, or character literal.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4619:3)
	""" CXToken_Literal
	@doc raw"""
	\\brief A token that contains some kind of punctuation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4604:3)
	""" CXToken_Punctuation
	export CXTokenKind, CXToken_Comment, CXToken_Identifier, CXToken_Keyword, CXToken_Literal, CXToken_Punctuation
	@ctypedef CXTokenKind @cenum CXTokenKind {
		CXToken_Punctuation = (@Cuint)(0)
		CXToken_Keyword = (@Cuint)(1)
		CXToken_Identifier = (@Cuint)(2)
		CXToken_Literal = (@Cuint)(3)
		CXToken_Comment = (@Cuint)(4)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4633:3)
	""" CXToken
	export CXToken
	@ctypedef CXToken @cstruct {
		int_data::(@Cuint)[4]
		ptr_data::(@Ptr){@Cvoid}
	}
	
	@doc raw"""
	\\brief Determine the kind of the given token.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4638:28)
	""" clang_getTokenKind
	export clang_getTokenKind
	@cextern clang_getTokenKind(var"?1?"::CXToken)::CXTokenKind
	
	@doc raw"""
	\\brief Determine the spelling of the given token.
	
	The spelling of a token is the textual representation of that token, e.g.,
	the text of an identifier or keyword.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4646:25)
	""" clang_getTokenSpelling
	export clang_getTokenSpelling
	@cextern clang_getTokenSpelling(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXString
	
	@doc raw"""
	\\brief Retrieve the source location of the given token.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4651:33)
	""" clang_getTokenLocation
	export clang_getTokenLocation
	@cextern clang_getTokenLocation(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXSourceLocation
	
	@doc raw"""
	\\brief Retrieve a source range that covers the given token.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4657:30)
	""" clang_getTokenExtent
	export clang_getTokenExtent
	@cextern clang_getTokenExtent(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXSourceRange
	
	@doc raw"""
	\\brief Tokenize the source code described by the given range into raw
	lexical tokens.
	
	\\param TU the translation unit whose text is being tokenized.
	
	\\param Range the source range in which text should be tokenized. All of the
	tokens produced by tokenization will fall within this source range,
	
	\\param Tokens this pointer will be set to point to the array of tokens
	that occur within the given source range. The returned pointer must be
	freed with clang_disposeTokens() before the translation unit is destroyed.
	
	\\param NumTokens will be set to the number of tokens in the \\c *Tokens
	array.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4676:21)
	""" clang_tokenize
	export clang_tokenize
	@cextern clang_tokenize(TU::CXTranslationUnit, Range::CXSourceRange, Tokens::(@Ptr){(@Ptr){CXToken}}, NumTokens::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Annotate the given set of tokens by providing cursors for each token
	that can be mapped to a specific entity within the abstract syntax tree.
	
	This token-annotation routine is equivalent to invoking
	clang_getCursor() for the source locations of each of the
	tokens. The cursors provided are filtered, so that only those
	cursors that have a direct correspondence to the token are
	accepted. For example, given a function call \\c f(x),
	clang_getCursor() would provide the following cursors:
	
	* when the cursor is over the 'f', a DeclRefExpr cursor referring to 'f'.
	* when the cursor is over the '(' or the ')', a CallExpr referring to 'f'.
	* when the cursor is over the 'x', a DeclRefExpr cursor referring to 'x'.
	
	Only the first and last of these cursors will occur within the
	annotate, since the tokens "f" and "x' directly refer to a function
	and a variable, respectively, but the parentheses are just a small
	part of the full syntax of the function call expression, which is
	not provided as an annotation.
	
	\\param TU the translation unit that owns the given tokens.
	
	\\param Tokens the set of tokens to annotate.
	
	\\param NumTokens the number of tokens in \\p Tokens.
	
	\\param Cursors an array of \\p NumTokens cursors, whose contents will be
	replaced with the cursors corresponding to each token.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4709:21)
	""" clang_annotateTokens
	export clang_annotateTokens
	@cextern clang_annotateTokens(TU::CXTranslationUnit, Tokens::(@Ptr){CXToken}, NumTokens::(@Cuint), Cursors::(@Ptr){CXCursor})::@Cvoid
	
	@doc raw"""
	\\brief Free the given set of tokens.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4716:21)
	""" clang_disposeTokens
	export clang_disposeTokens
	@cextern clang_disposeTokens(TU::CXTranslationUnit, Tokens::(@Ptr){CXToken}, NumTokens::(@Cuint))::@Cvoid
	
	@doc raw"""
	\\defgroup CINDEX_DEBUG Debugging facilities
	
	These routines are used for testing and debugging, only, and should not
	be relied upon.
	
	@{
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4733:25)
	""" clang_getCursorKindSpelling
	export clang_getCursorKindSpelling
	@cextern clang_getCursorKindSpelling(Kind::CXCursorKind)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4734:21)
	""" clang_getDefinitionSpellingAndExtent
	export clang_getDefinitionSpellingAndExtent
	@cextern clang_getDefinitionSpellingAndExtent(var"?1?"::CXCursor, startBuf::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, endBuf::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, startLine::(@Ptr){@Cuint}, startColumn::(@Ptr){@Cuint}, endLine::(@Ptr){@Cuint}, endColumn::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4741:21)
	""" clang_enableStackTraces
	export clang_enableStackTraces
	@cextern clang_enableStackTraces()::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4742:21)
	""" clang_executeOnThread
	export clang_executeOnThread
	@cextern clang_executeOnThread(fn::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){((@Ptr){@Cvoid})}, (@CDECL)}}, user_data::(@Ptr){@Cvoid}, stack_size::(@Cuint))::@Cvoid
	
	@doc raw"""
	\\brief A semantic string that describes a code-completion result.
	
	A semantic string that describes the formatting of a code-completion
	result as a single "template" of text that should be inserted into the
	source buffer when a particular code-completion result is selected.
	Each semantic string is made up of some number of "chunks", each of which
	contains some text along with a description of what that text means, e.g.,
	the name of the entity being referenced, whether the text chunk is part of
	the template, or whether it is a "placeholder" that the user should replace
	with actual code,of a specific kind. See \\c CXCompletionChunkKind for a
	description of the different kinds of chunks.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4774:15)
	""" CXCompletionString
	export CXCompletionString
	@ctypedef CXCompletionString (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4797:3)
	""" CXCompletionResult
	export CXCompletionResult
	@ctypedef CXCompletionResult @cstruct {
		CursorKind::CXCursorKind
		CompletionString::CXCompletionString
	}
	
	@doc raw"""
	\\brief A semicolon (';').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4954:3)
	""" CXCompletionChunk_SemiColon
	@doc raw"""
	\\brief A comma separator (',').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4938:3)
	""" CXCompletionChunk_Comma
	@doc raw"""
	\\brief A code-completion string that describes "optional" text that
	could be a part of the template (but is not required).
	
	The Optional chunk is the only kind of chunk that has a code-completion
	string for its representation, which is accessible via
	\\c clang_getCompletionChunkCompletionString(). The code-completion string
	describes an additional part of the template that is completely optional.
	For example, optional chunks can be used to describe the placeholders for
	arguments that match up with defaulted function parameters, e.g. given:
	
	\\code
	void f(int x, float y = 3.14, double z = 2.71828);
	\\endcode
	
	The code-completion string for this function would contain:
	- a TypedText chunk for "f".
	- a LeftParen chunk for "(".
	- a Placeholder chunk for "int x"
	- an Optional chunk containing the remaining defaulted arguments, e.g.,
	- a Comma chunk for ","
	- a Placeholder chunk for "float y"
	- an Optional chunk containing the last defaulted argument:
	- a Comma chunk for ","
	- a Placeholder chunk for "double z"
	- a RightParen chunk for ")"
	
	There are many ways to handle Optional chunks. Two simple approaches are:
	- Completely ignore optional chunks, in which case the template for the
	function "f" would only include the first parameter ("int x").
	- Fully expand all optional chunks, in which case the template for the
	function "f" would have all of the parameters.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4840:3)
	""" CXCompletionChunk_Optional
	@doc raw"""
	\\brief An '=' sign.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4958:3)
	""" CXCompletionChunk_Equal
	@doc raw"""
	\\brief Text that a user would be expected to type to get this
	code-completion result.
	
	There will be exactly one "typed text" chunk in a semantic string, which
	will typically provide the spelling of a keyword or the name of a
	declaration that could be used at the current code point. Clients are
	expected to filter the code-completion results based on the text in this
	chunk.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4851:3)
	""" CXCompletionChunk_TypedText
	@doc raw"""
	\\brief Text that describes the current parameter when code-completion is
	referring to function call, message send, or template specialization.
	
	A "current parameter" chunk occurs when code-completion is providing
	information about a parameter corresponding to the argument at the
	code-completion point. For example, given a function
	
	\\code
	int add(int x, int y);
	\\endcode
	
	and the source code \\c add(, where the code-completion point is after the
	"(", the code-completion string will contain a "current parameter" chunk
	for "int x", indicating that the current argument will initialize that
	parameter. After typing further, to \\c add(17, (where the code-completion
	point is after the ","), the code-completion string will contain a
	"current paremeter" chunk to "int y".
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4900:3)
	""" CXCompletionChunk_CurrentParameter
	@doc raw"""
	\\brief A left parenthesis ('('), used to initiate a function call or
	signal the beginning of a function parameter list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4905:3)
	""" CXCompletionChunk_LeftParen
	@doc raw"""
	\\brief A right bracket (']').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4918:3)
	""" CXCompletionChunk_RightBracket
	@doc raw"""
	Vertical space ('\\\\n'), after which it is generally a good idea to
	perform indentation.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4967:3)
	""" CXCompletionChunk_VerticalSpace
	@doc raw"""
	\\brief A right brace ('}').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4926:3)
	""" CXCompletionChunk_RightBrace
	@doc raw"""
	\\brief A left bracket ('[').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4914:3)
	""" CXCompletionChunk_LeftBracket
	@doc raw"""
	\\brief A right parenthesis (')'), used to finish a function call or
	signal the end of a function parameter list.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4910:3)
	""" CXCompletionChunk_RightParen
	@doc raw"""
	\\brief Text that specifies the result type of a given result.
	
	This special kind of informative chunk is not meant to be inserted into
	the text buffer. Rather, it is meant to illustrate the type that an
	expression using the given completion string would have.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4946:3)
	""" CXCompletionChunk_ResultType
	@doc raw"""
	Horizontal space (' ').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4962:3)
	""" CXCompletionChunk_HorizontalSpace
	@doc raw"""
	\\brief A colon (':').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4950:3)
	""" CXCompletionChunk_Colon
	@doc raw"""
	\\brief Text that should be inserted as part of a code-completion result.
	
	A "text" chunk represents text that is part of the template to be
	inserted into user code should this particular code-completion result
	be selected.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4859:3)
	""" CXCompletionChunk_Text
	@doc raw"""
	\\brief Placeholder text that should be replaced by the user.
	
	A "placeholder" chunk marks a place where the user should insert text
	into the code-completion template. For example, placeholders might mark
	the function parameters for a function declaration, to indicate that the
	user should provide arguments for each of those parameters. The actual
	text in a placeholder is a suggestion for the text to display before
	the user replaces the placeholder with real code.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4870:3)
	""" CXCompletionChunk_Placeholder
	@doc raw"""
	\\brief A left brace ('{').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4922:3)
	""" CXCompletionChunk_LeftBrace
	@doc raw"""
	\\brief A left angle bracket ('<').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4930:3)
	""" CXCompletionChunk_LeftAngle
	@doc raw"""
	\\brief Describes a single piece of text within a code-completion string.
	
	Each "chunk" within a code-completion string (\\c CXCompletionString) is
	either a piece of text with a specific "kind" that describes how that text
	should be interpreted by the client or is another completion string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4806:6)
	""" CXCompletionChunkKind
	@doc raw"""
	\\brief Informative text that should be displayed but never inserted as
	part of the template.
	
	An "informative" chunk contains annotations that can be displayed to
	help the user decide whether a particular code-completion result is the
	right option, but which is not part of the actual template to be inserted
	by code completion.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4880:3)
	""" CXCompletionChunk_Informative
	@doc raw"""
	\\brief A right angle bracket ('>').
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4934:3)
	""" CXCompletionChunk_RightAngle
	export CXCompletionChunkKind, CXCompletionChunk_Colon, CXCompletionChunk_Comma, CXCompletionChunk_CurrentParameter, CXCompletionChunk_Equal, CXCompletionChunk_HorizontalSpace, CXCompletionChunk_Informative, CXCompletionChunk_LeftAngle, CXCompletionChunk_LeftBrace, CXCompletionChunk_LeftBracket, CXCompletionChunk_LeftParen, CXCompletionChunk_Optional, CXCompletionChunk_Placeholder, CXCompletionChunk_ResultType, CXCompletionChunk_RightAngle, CXCompletionChunk_RightBrace, CXCompletionChunk_RightBracket, CXCompletionChunk_RightParen, CXCompletionChunk_SemiColon, CXCompletionChunk_Text, CXCompletionChunk_TypedText, CXCompletionChunk_VerticalSpace
	@cenum CXCompletionChunkKind {
		CXCompletionChunk_Optional = (@Cuint)(0)
		CXCompletionChunk_TypedText = (@Cuint)(1)
		CXCompletionChunk_Text = (@Cuint)(2)
		CXCompletionChunk_Placeholder = (@Cuint)(3)
		CXCompletionChunk_Informative = (@Cuint)(4)
		CXCompletionChunk_CurrentParameter = (@Cuint)(5)
		CXCompletionChunk_LeftParen = (@Cuint)(6)
		CXCompletionChunk_RightParen = (@Cuint)(7)
		CXCompletionChunk_LeftBracket = (@Cuint)(8)
		CXCompletionChunk_RightBracket = (@Cuint)(9)
		CXCompletionChunk_LeftBrace = (@Cuint)(10)
		CXCompletionChunk_RightBrace = (@Cuint)(11)
		CXCompletionChunk_LeftAngle = (@Cuint)(12)
		CXCompletionChunk_RightAngle = (@Cuint)(13)
		CXCompletionChunk_Comma = (@Cuint)(14)
		CXCompletionChunk_ResultType = (@Cuint)(15)
		CXCompletionChunk_Colon = (@Cuint)(16)
		CXCompletionChunk_SemiColon = (@Cuint)(17)
		CXCompletionChunk_Equal = (@Cuint)(18)
		CXCompletionChunk_HorizontalSpace = (@Cuint)(19)
		CXCompletionChunk_VerticalSpace = (@Cuint)(20)
	}
	
	@doc raw"""
	\\brief Determine the kind of a particular chunk within a completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the kind of the chunk at the index \\c chunk_number.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4980:1)
	""" clang_getCompletionChunkKind
	export clang_getCompletionChunkKind
	@cextern clang_getCompletionChunkKind(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXCompletionChunkKind
	
	@doc raw"""
	\\brief Retrieve the text associated with a particular chunk within a
	completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the text associated with the chunk at index \\c chunk_number.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:4994:1)
	""" clang_getCompletionChunkText
	export clang_getCompletionChunkText
	@cextern clang_getCompletionChunkText(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXString
	
	@doc raw"""
	\\brief Retrieve the completion string associated with a particular chunk
	within a completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the completion string associated with the chunk at index
	\\c chunk_number.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5009:1)
	""" clang_getCompletionChunkCompletionString
	export clang_getCompletionChunkCompletionString
	@cextern clang_getCompletionChunkCompletionString(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXCompletionString
	
	@doc raw"""
	\\brief Retrieve the number of chunks in the given code-completion string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5016:1)
	""" clang_getNumCompletionChunks
	export clang_getNumCompletionChunks
	@cextern clang_getNumCompletionChunks(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	\\brief Determine the priority of this code completion.
	
	The priority of a code completion indicates how likely it is that this 
	particular completion is the completion that the user will select. The
	priority is selected by various internal heuristics.
	
	\\param completion_string The completion string to query.
	
	\\returns The priority of this completion string. Smaller values indicate
	higher-priority (more likely) completions.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5031:1)
	""" clang_getCompletionPriority
	export clang_getCompletionPriority
	@cextern clang_getCompletionPriority(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	\\brief Determine the availability of the entity that this code-completion
	string refers to.
	
	\\param completion_string The completion string to query.
	
	\\returns The availability of the completion string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5042:1)
	""" clang_getCompletionAvailability
	export clang_getCompletionAvailability
	@cextern clang_getCompletionAvailability(completion_string::CXCompletionString)::CXAvailabilityKind
	
	@doc raw"""
	\\brief Retrieve the number of annotations associated with the given
	completion string.
	
	\\param completion_string the completion string to query.
	
	\\returns the number of annotations associated with the given completion
	string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5054:1)
	""" clang_getCompletionNumAnnotations
	export clang_getCompletionNumAnnotations
	@cextern clang_getCompletionNumAnnotations(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	\\brief Retrieve the annotation associated with the given completion string.
	
	\\param completion_string the completion string to query.
	
	\\param annotation_number the 0-based index of the annotation of the
	completion string.
	
	\\returns annotation string associated with the completion at index
	\\c annotation_number, or a NULL string if that annotation is not available.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5068:1)
	""" clang_getCompletionAnnotation
	export clang_getCompletionAnnotation
	@cextern clang_getCompletionAnnotation(completion_string::CXCompletionString, annotation_number::(@Cuint))::CXString
	
	@doc raw"""
	\\brief Retrieve the parent context of the given completion string.
	
	The parent context of a completion string is the semantic parent of 
	the declaration (if any) that the code completion represents. For example,
	a code completion for an Objective-C method would have the method's class
	or protocol as its context.
	
	\\param completion_string The code completion string whose parent is
	being queried.
	
	\\param kind DEPRECATED: always set to CXCursor_NotImplemented if non-NULL.
	
	\\returns The name of the completion parent, e.g., "NSObject" if
	the completion string represents a method in the NSObject class.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5088:1)
	""" clang_getCompletionParent
	export clang_getCompletionParent
	@cextern clang_getCompletionParent(completion_string::CXCompletionString, kind::(@Ptr){CXCursorKind})::CXString
	
	@doc raw"""
	\\brief Retrieve the brief documentation comment attached to the declaration
	that corresponds to the given completion string.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5096:1)
	""" clang_getCompletionBriefComment
	export clang_getCompletionBriefComment
	@cextern clang_getCompletionBriefComment(completion_string::CXCompletionString)::CXString
	
	@doc raw"""
	\\brief Retrieve a completion string for an arbitrary declaration or macro
	definition cursor.
	
	\\param cursor The cursor to query.
	
	\\returns A non-context-sensitive completion string for declaration and macro
	definition cursors, or NULL for other kinds of cursors.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5108:1)
	""" clang_getCursorCompletionString
	export clang_getCursorCompletionString
	@cextern clang_getCursorCompletionString(cursor::CXCursor)::CXCompletionString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5128:3)
	""" CXCodeCompleteResults
	export CXCodeCompleteResults
	@ctypedef CXCodeCompleteResults @cstruct {
		Results::(@Ptr){CXCompletionResult}
		NumResults::@Cuint
	}
	
	@doc raw"""
	\\brief Flags that can be passed to \\c clang_codeCompleteAt() to
	modify its behavior.
	
	The enumerators in this enumeration can be bitwise-OR'd together to
	provide multiple options to \\c clang_codeCompleteAt().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5137:6)
	""" CXCodeComplete_Flags
	@doc raw"""
	\\brief Whether to include macros within the set of code
	completions returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5142:3)
	""" CXCodeComplete_IncludeMacros
	@doc raw"""
	\\brief Whether to include brief documentation within the set of code
	completions returned.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5154:3)
	""" CXCodeComplete_IncludeBriefComments
	@doc raw"""
	\\brief Whether to include code patterns for language constructs
	within the set of code completions, e.g., for loops.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5148:3)
	""" CXCodeComplete_IncludeCodePatterns
	export CXCodeComplete_Flags, CXCodeComplete_IncludeBriefComments, CXCodeComplete_IncludeCodePatterns, CXCodeComplete_IncludeMacros
	@cenum CXCodeComplete_Flags {
		CXCodeComplete_IncludeMacros = (@Cuint)(1)
		CXCodeComplete_IncludeCodePatterns = (@Cuint)(2)
		CXCodeComplete_IncludeBriefComments = (@Cuint)(4)
	}
	
	@doc raw"""
	\\brief Completions for Objective-C class messages should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5264:3)
	""" CXCompletionContext_ObjCClassMessage
	@doc raw"""
	\\brief Completions for any possible value (variables, function calls, etc.)
	should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5179:3)
	""" CXCompletionContext_AnyValue
	@doc raw"""
	\\brief Bits that represent the context under which completion is occurring.
	
	The enumerators in this enumeration may be bitwise-OR'd together if multiple
	contexts are occurring simultaneously.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5163:6)
	""" CXCompletionContext
	@doc raw"""
	\\brief Natural language completions should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5280:3)
	""" CXCompletionContext_NaturalLanguage
	@doc raw"""
	\\brief Completions for fields of the member being accessed using the arrow
	operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5205:3)
	""" CXCompletionContext_ArrowMemberAccess
	@doc raw"""
	\\brief Completions for Objective-C instance messages should be included
	in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5259:3)
	""" CXCompletionContext_ObjCInstanceMessage
	@doc raw"""
	\\brief Completions for values that resolve to an Objective-C object should
	be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5184:3)
	""" CXCompletionContext_ObjCObjectValue
	@doc raw"""
	\\brief Completions for any possible type should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5173:3)
	""" CXCompletionContext_AnyType
	@doc raw"""
	\\brief Completions for values that resolve to a C++ class type should be
	included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5194:3)
	""" CXCompletionContext_CXXClassTypeValue
	@doc raw"""
	\\brief Completions for enum tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5215:3)
	""" CXCompletionContext_EnumTag
	@doc raw"""
	\\brief Completions for C++ namespaces and namespace aliases should be
	included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5233:3)
	""" CXCompletionContext_Namespace
	@doc raw"""
	\\brief Completions for Objective-C selector names should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5269:3)
	""" CXCompletionContext_ObjCSelectorName
	@doc raw"""
	\\brief Completions for C++ class names should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5228:3)
	""" CXCompletionContext_ClassTag
	@doc raw"""
	\\brief Completions for fields of the member being accessed using the dot
	operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5200:3)
	""" CXCompletionContext_DotMemberAccess
	@doc raw"""
	\\brief Completions for Objective-C interfaces (classes) should be included
	in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5244:3)
	""" CXCompletionContext_ObjCInterface
	@doc raw"""
	\\brief Completions for preprocessor macro names should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5275:3)
	""" CXCompletionContext_MacroName
	@doc raw"""
	\\brief The current context is unknown, so set all contexts.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5285:3)
	""" CXCompletionContext_Unknown
	@doc raw"""
	\\brief Completions for C++ nested name specifiers should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5238:3)
	""" CXCompletionContext_NestedNameSpecifier
	@doc raw"""
	\\brief Completions for Objective-C protocols should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5249:3)
	""" CXCompletionContext_ObjCProtocol
	@doc raw"""
	\\brief Completions for struct tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5223:3)
	""" CXCompletionContext_StructTag
	@doc raw"""
	\\brief The context for completions is unexposed, as only Clang results
	should be included. (This is equivalent to having no context bits set.)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5168:3)
	""" CXCompletionContext_Unexposed
	@doc raw"""
	\\brief Completions for values that resolve to an Objective-C selector
	should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5189:3)
	""" CXCompletionContext_ObjCSelectorValue
	@doc raw"""
	\\brief Completions for properties of the Objective-C object being accessed
	using the dot operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5210:3)
	""" CXCompletionContext_ObjCPropertyAccess
	@doc raw"""
	\\brief Completions for Objective-C categories should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5254:3)
	""" CXCompletionContext_ObjCCategory
	@doc raw"""
	\\brief Completions for union tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5219:3)
	""" CXCompletionContext_UnionTag
	export CXCompletionContext, CXCompletionContext_AnyType, CXCompletionContext_AnyValue, CXCompletionContext_ArrowMemberAccess, CXCompletionContext_CXXClassTypeValue, CXCompletionContext_ClassTag, CXCompletionContext_DotMemberAccess, CXCompletionContext_EnumTag, CXCompletionContext_MacroName, CXCompletionContext_Namespace, CXCompletionContext_NaturalLanguage, CXCompletionContext_NestedNameSpecifier, CXCompletionContext_ObjCCategory, CXCompletionContext_ObjCClassMessage, CXCompletionContext_ObjCInstanceMessage, CXCompletionContext_ObjCInterface, CXCompletionContext_ObjCObjectValue, CXCompletionContext_ObjCPropertyAccess, CXCompletionContext_ObjCProtocol, CXCompletionContext_ObjCSelectorName, CXCompletionContext_ObjCSelectorValue, CXCompletionContext_StructTag, CXCompletionContext_Unexposed, CXCompletionContext_UnionTag, CXCompletionContext_Unknown
	@cenum CXCompletionContext {
		CXCompletionContext_Unexposed = (@Cuint)(0)
		CXCompletionContext_AnyType = (@Cuint)(1)
		CXCompletionContext_AnyValue = (@Cuint)(2)
		CXCompletionContext_ObjCObjectValue = (@Cuint)(4)
		CXCompletionContext_ObjCSelectorValue = (@Cuint)(8)
		CXCompletionContext_CXXClassTypeValue = (@Cuint)(16)
		CXCompletionContext_DotMemberAccess = (@Cuint)(32)
		CXCompletionContext_ArrowMemberAccess = (@Cuint)(64)
		CXCompletionContext_ObjCPropertyAccess = (@Cuint)(128)
		CXCompletionContext_EnumTag = (@Cuint)(256)
		CXCompletionContext_UnionTag = (@Cuint)(512)
		CXCompletionContext_StructTag = (@Cuint)(1024)
		CXCompletionContext_ClassTag = (@Cuint)(2048)
		CXCompletionContext_Namespace = (@Cuint)(4096)
		CXCompletionContext_NestedNameSpecifier = (@Cuint)(8192)
		CXCompletionContext_ObjCInterface = (@Cuint)(16384)
		CXCompletionContext_ObjCProtocol = (@Cuint)(32768)
		CXCompletionContext_ObjCCategory = (@Cuint)(65536)
		CXCompletionContext_ObjCInstanceMessage = (@Cuint)(131072)
		CXCompletionContext_ObjCClassMessage = (@Cuint)(262144)
		CXCompletionContext_ObjCSelectorName = (@Cuint)(524288)
		CXCompletionContext_MacroName = (@Cuint)(1048576)
		CXCompletionContext_NaturalLanguage = (@Cuint)(2097152)
		CXCompletionContext_Unknown = (@Cuint)(4194303)
	}
	
	@doc raw"""
	\\brief Returns a default set of code-completion options that can be
	passed to\\c clang_codeCompleteAt().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5292:25)
	""" clang_defaultCodeCompleteOptions
	export clang_defaultCodeCompleteOptions
	@cextern clang_defaultCodeCompleteOptions()::@Cuint
	
	@doc raw"""
	\\brief Perform code completion at a given location in a translation unit.
	
	This function performs code completion at a particular file, line, and
	column within source code, providing results that suggest potential
	code snippets based on the context of the completion. The basic model
	for code completion is that Clang will parse a complete source file,
	performing syntax checking up to the location where code-completion has
	been requested. At that point, a special code-completion token is passed
	to the parser, which recognizes this token and determines, based on the
	current location in the C/Objective-C/C++ grammar and the state of
	semantic analysis, what completions to provide. These completions are
	returned via a new \\c CXCodeCompleteResults structure.
	
	Code completion itself is meant to be triggered by the client when the
	user types punctuation characters or whitespace, at which point the
	code-completion location will coincide with the cursor. For example, if \\c p
	is a pointer, code-completion might be triggered after the "-" and then
	after the ">" in \\c p->. When the code-completion location is afer the ">",
	the completion results will provide, e.g., the members of the struct that
	"p" points to. The client is responsible for placing the cursor at the
	beginning of the token currently being typed, then filtering the results
	based on the contents of the token. For example, when code-completing for
	the expression \\c p->get, the client should provide the location just after
	the ">" (e.g., pointing at the "g") to this code-completion hook. Then, the
	client can filter the results based on the current token text ("get"), only
	showing those results that start with "get". The intent of this interface
	is to separate the relatively high-latency acquisition of code-completion
	results from the filtering of results on a per-character basis, which must
	have a lower latency.
	
	\\param TU The translation unit in which code-completion should
	occur. The source files for this translation unit need not be
	completely up-to-date (and the contents of those source files may
	be overridden via \\p unsaved_files). Cursors referring into the
	translation unit may be invalidated by this invocation.
	
	\\param complete_filename The name of the source file where code
	completion should be performed. This filename may be any file
	included in the translation unit.
	
	\\param complete_line The line at which code-completion should occur.
	
	\\param complete_column The column at which code-completion should occur.
	Note that the column should point just after the syntactic construct that
	initiated code completion, and not in the middle of a lexical token.
	
	\\param unsaved_files the Files that have not yet been saved to disk
	but may be required for parsing or code completion, including the
	contents of those files.  The contents and name of these files (as
	specified by CXUnsavedFile) are copied when necessary, so the
	client only needs to guarantee their validity until the call to
	this function returns.
	
	\\param num_unsaved_files The number of unsaved file entries in \\p
	unsaved_files.
	
	\\param options Extra options that control the behavior of code
	completion, expressed as a bitwise OR of the enumerators of the
	CXCodeComplete_Flags enumeration. The 
	\\c clang_defaultCodeCompleteOptions() function returns a default set
	of code-completion options.
	
	\\returns If successful, a new \\c CXCodeCompleteResults structure
	containing code-completion results, which should eventually be
	freed with \\c clang_disposeCodeCompleteResults(). If code
	completion fails, returns NULL.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5363:24)
	""" clang_codeCompleteAt
	export clang_codeCompleteAt
	@cextern clang_codeCompleteAt(TU::CXTranslationUnit, complete_filename::(@Ptr){(@Cconst)(@Cchar)}, complete_line::(@Cuint), complete_column::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint))::(@Ptr){CXCodeCompleteResults}
	
	@doc raw"""
	\\brief Sort the code-completion results in case-insensitive alphabetical 
	order.
	
	\\param Results The set of results to sort.
	\\param NumResults The number of results in \\p Results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5379:6)
	""" clang_sortCodeCompletionResults
	export clang_sortCodeCompletionResults
	@cextern clang_sortCodeCompletionResults(Results::(@Ptr){CXCompletionResult}, NumResults::(@Cuint))::@Cvoid
	
	@doc raw"""
	\\brief Free the given set of code-completion results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5386:6)
	""" clang_disposeCodeCompleteResults
	export clang_disposeCodeCompleteResults
	@cextern clang_disposeCodeCompleteResults(Results::(@Ptr){CXCodeCompleteResults})::@Cvoid
	
	@doc raw"""
	\\brief Determine the number of diagnostics produced prior to the
	location where code completion was performed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5393:10)
	""" clang_codeCompleteGetNumDiagnostics
	export clang_codeCompleteGetNumDiagnostics
	@cextern clang_codeCompleteGetNumDiagnostics(Results::(@Ptr){CXCodeCompleteResults})::@Cuint
	
	@doc raw"""
	\\brief Retrieve a diagnostic associated with the given code completion.
	
	\\param Results the code completion results to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5405:14)
	""" clang_codeCompleteGetDiagnostic
	export clang_codeCompleteGetDiagnostic
	@cextern clang_codeCompleteGetDiagnostic(Results::(@Ptr){CXCodeCompleteResults}, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	\\brief Determines what completions are appropriate for the context
	the given code completion.
	
	\\param Results the code completion results to query
	
	\\returns the kinds of completions that are appropriate for use
	along with the given code completion results.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5418:20)
	""" clang_codeCompleteGetContexts
	export clang_codeCompleteGetContexts
	@cextern clang_codeCompleteGetContexts(Results::(@Ptr){CXCodeCompleteResults})::@Culonglong
	
	@doc raw"""
	\\brief Returns the cursor kind for the container for the current code
	completion context. The container is only guaranteed to be set for
	contexts where a container exists (i.e. member accesses or Objective-C
	message sends); if there is not a container, this function will return
	CXCursor_InvalidCode.
	
	\\param Results the code completion results to query
	
	\\param IsIncomplete on return, this value will be false if Clang has complete
	information about the container. If Clang does not have complete
	information, this value will be true.
	
	\\returns the container kind, or CXCursor_InvalidCode if there is not a
	container
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5438:19)
	""" clang_codeCompleteGetContainerKind
	export clang_codeCompleteGetContainerKind
	@cextern clang_codeCompleteGetContainerKind(Results::(@Ptr){CXCodeCompleteResults}, IsIncomplete::(@Ptr){@Cuint})::CXCursorKind
	
	@doc raw"""
	\\brief Returns the USR for the container for the current code completion
	context. If there is not a container for the current context, this
	function will return the empty string.
	
	\\param Results the code completion results to query
	
	\\returns the USR for the container
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5452:10)
	""" clang_codeCompleteGetContainerUSR
	export clang_codeCompleteGetContainerUSR
	@cextern clang_codeCompleteGetContainerUSR(Results::(@Ptr){CXCodeCompleteResults})::CXString
	
	@doc raw"""
	\\brief Returns the currently-entered selector for an Objective-C message
	send, formatted like "initWithFoo:bar:". Only guaranteed to return a
	non-empty string for CXCompletionContext_ObjCInstanceMessage and
	CXCompletionContext_ObjCClassMessage.
	
	\\param Results the code completion results to query
	
	\\returns the selector (or partial selector) that has been entered thus far
	for an Objective-C message send.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5466:10)
	""" clang_codeCompleteGetObjCSelector
	export clang_codeCompleteGetObjCSelector
	@cextern clang_codeCompleteGetObjCSelector(Results::(@Ptr){CXCodeCompleteResults})::CXString
	
	@doc raw"""
	\\brief Return a version string, suitable for showing to a user, but not
	intended to be parsed (the format is not guaranteed to be stable).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5482:25)
	""" clang_getClangVersion
	export clang_getClangVersion
	@cextern clang_getClangVersion()::CXString
	
	@doc raw"""
	\\brief Enable/disable crash recovery.
	
	\\param isEnabled Flag to indicate if crash recovery is enabled.  A non-zero
	value enables crash recovery, while 0 disables it.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5490:21)
	""" clang_toggleCrashRecovery
	export clang_toggleCrashRecovery
	@cextern clang_toggleCrashRecovery(isEnabled::@Cuint)::@Cvoid
	
	@doc raw"""
	\\brief Visitor invoked for each file in a translation unit
	(used with clang_getInclusions()).
	
	This visitor function will be invoked by clang_getInclusions() for each
	file included (either at the top-level or by \\#include directives) within
	a translation unit.  The first argument is the file being included, and
	the second and third arguments provide the inclusion stack.  The
	array is sorted in order of immediate inclusion.  For example,
	the first element refers to the location that included 'included_file'.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5503:16)
	""" CXInclusionVisitor
	export CXInclusionVisitor
	@ctypedef CXInclusionVisitor (@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(CXFile), ((@Ptr){CXSourceLocation}), (@Cuint), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	\\brief Visit the set of preprocessor inclusions in a translation unit.
	The visitor function is called with the provided data for every included
	file.  This does not include headers included by the PCH file (unless one
	is inspecting the inclusions in the PCH file itself).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5514:21)
	""" clang_getInclusions
	export clang_getInclusions
	@cextern clang_getInclusions(tu::CXTranslationUnit, visitor::CXInclusionVisitor, client_data::CXClientData)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5524:3)
	""" CXEval_Other
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5521:3)
	""" CXEval_ObjCStrLiteral
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5522:3)
	""" CXEval_StrLiteral
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5528:3)
	""" CXEvalResultKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5519:3)
	""" CXEval_Int
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5526:3)
	""" CXEval_UnExposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5523:3)
	""" CXEval_CFStr
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5520:3)
	""" CXEval_Float
	export CXEvalResultKind, CXEval_CFStr, CXEval_Float, CXEval_Int, CXEval_ObjCStrLiteral, CXEval_Other, CXEval_StrLiteral, CXEval_UnExposed
	@ctypedef CXEvalResultKind @cenum {
		CXEval_Int = (@Cuint)(1)
		CXEval_Float = (@Cuint)(2)
		CXEval_ObjCStrLiteral = (@Cuint)(3)
		CXEval_StrLiteral = (@Cuint)(4)
		CXEval_CFStr = (@Cuint)(5)
		CXEval_Other = (@Cuint)(6)
		CXEval_UnExposed = (@Cuint)(0)
	}
	
	@doc raw"""
	\\brief Evaluation result of a cursor
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5533:16)
	""" CXEvalResult
	export CXEvalResult
	@ctypedef CXEvalResult (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief If cursor is a statement declaration tries to evaluate the 
	statement and if its variable, tries to evaluate its initializer,
	into its corresponding type.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5540:29)
	""" clang_Cursor_Evaluate
	export clang_Cursor_Evaluate
	@cextern clang_Cursor_Evaluate(C::CXCursor)::CXEvalResult
	
	@doc raw"""
	\\brief Returns the kind of the evaluated result.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5545:33)
	""" clang_EvalResult_getKind
	export clang_EvalResult_getKind
	@cextern clang_EvalResult_getKind(E::CXEvalResult)::CXEvalResultKind
	
	@doc raw"""
	\\brief Returns the evaluation result as integer if the
	kind is Int.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5551:20)
	""" clang_EvalResult_getAsInt
	export clang_EvalResult_getAsInt
	@cextern clang_EvalResult_getAsInt(E::CXEvalResult)::@Cint
	
	@doc raw"""
	\\brief Returns the evaluation result as a long long integer if the
	kind is Int. This prevents overflows that may happen if the result is
	returned with clang_EvalResult_getAsInt.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5558:26)
	""" clang_EvalResult_getAsLongLong
	export clang_EvalResult_getAsLongLong
	@cextern clang_EvalResult_getAsLongLong(E::CXEvalResult)::@Clonglong
	
	@doc raw"""
	\\brief Returns a non-zero value if the kind is Int and the evaluation
	result resulted in an unsigned integer.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5564:25)
	""" clang_EvalResult_isUnsignedInt
	export clang_EvalResult_isUnsignedInt
	@cextern clang_EvalResult_isUnsignedInt(E::CXEvalResult)::@Cuint
	
	@doc raw"""
	\\brief Returns the evaluation result as an unsigned integer if
	the kind is Int and clang_EvalResult_isUnsignedInt is non-zero.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5570:35)
	""" clang_EvalResult_getAsUnsigned
	export clang_EvalResult_getAsUnsigned
	@cextern clang_EvalResult_getAsUnsigned(E::CXEvalResult)::@Culonglong
	
	@doc raw"""
	\\brief Returns the evaluation result as double if the
	kind is double.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5576:23)
	""" clang_EvalResult_getAsDouble
	export clang_EvalResult_getAsDouble
	@cextern clang_EvalResult_getAsDouble(E::CXEvalResult)::@Cdouble
	
	@doc raw"""
	\\brief Returns the evaluation result as a constant string if the
	kind is other than Int or float. User must not free this pointer,
	instead call clang_EvalResult_dispose on the CXEvalResult returned
	by clang_Cursor_Evaluate.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5584:28)
	""" clang_EvalResult_getAsStr
	export clang_EvalResult_getAsStr
	@cextern clang_EvalResult_getAsStr(E::CXEvalResult)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	\\brief Disposes the created Eval memory.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5589:21)
	""" clang_EvalResult_dispose
	export clang_EvalResult_dispose
	@cextern clang_EvalResult_dispose(E::CXEvalResult)::@Cvoid
	
	@doc raw"""
	\\brief A remapping of original source files and their translated files.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5602:15)
	""" CXRemapping
	export CXRemapping
	@ctypedef CXRemapping (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief Retrieve a remapping.
	
	\\param path the path that contains metadata about remappings.
	
	\\returns the requested remapping. This remapping must be freed
	via a call to \\c clang_remap_dispose(). Can return NULL if an error occurred.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5612:28)
	""" clang_getRemappings
	export clang_getRemappings
	@cextern clang_getRemappings(path::(@Ptr){(@Cconst)(@Cchar)})::CXRemapping
	
	@doc raw"""
	\\brief Retrieve a remapping.
	
	\\param filePaths pointer to an array of file paths containing remapping info.
	
	\\param numFiles number of file paths.
	
	\\returns the requested remapping. This remapping must be freed
	via a call to \\c clang_remap_dispose(). Can return NULL if an error occurred.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5625:13)
	""" clang_getRemappingsFromFileList
	export clang_getRemappingsFromFileList
	@cextern clang_getRemappingsFromFileList(filePaths::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, numFiles::(@Cuint))::CXRemapping
	
	@doc raw"""
	\\brief Determine the number of remappings.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5631:25)
	""" clang_remap_getNumFiles
	export clang_remap_getNumFiles
	@cextern clang_remap_getNumFiles(var"?1?"::CXRemapping)::@Cuint
	
	@doc raw"""
	\\brief Get the original and the associated filename from the remapping.
	
	\\param original If non-NULL, will be set to the original filename.
	
	\\param transformed If non-NULL, will be set to the filename that the original
	is associated with.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5641:21)
	""" clang_remap_getFilenames
	export clang_remap_getFilenames
	@cextern clang_remap_getFilenames(var"?1?"::CXRemapping, index::(@Cuint), original::(@Ptr){CXString}, transformed::(@Ptr){CXString})::@Cvoid
	
	@doc raw"""
	\\brief Dispose the remapping.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5647:21)
	""" clang_remap_dispose
	export clang_remap_dispose
	@cextern clang_remap_dispose(var"?1?"::CXRemapping)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5660:3)
	""" CXVisit_Continue
	@doc raw"""
	\\defgroup CINDEX_HIGH Higher level API functions
	
	@{
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5658:6)
	""" CXVisitorResult
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5659:3)
	""" CXVisit_Break
	export CXVisit_Break, CXVisit_Continue, CXVisitorResult
	@cenum CXVisitorResult {
		CXVisit_Break = (@Cuint)(0)
		CXVisit_Continue = (@Cuint)(1)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5663:16)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5666:3)
	""" CXCursorAndRangeVisitor
	export CXCursorAndRangeVisitor
	@ctypedef CXCursorAndRangeVisitor @cstruct CXCursorAndRangeVisitor {
		context::(@Ptr){@Cvoid}
		visit::(@Ptr){(@Cfunction){(CXVisitorResult), (@Tuple){((@Ptr){@Cvoid}), (CXCursor), (CXSourceRange)}, (@CDECL)}}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5683:3)
	""" CXResult
	@doc raw"""
	\\brief Function returned successfully.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5672:3)
	""" CXResult_Success
	@doc raw"""
	\\brief One of the parameters was invalid for the function.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5676:3)
	""" CXResult_Invalid
	@doc raw"""
	\\brief The function was terminated by a callback (e.g. it returned
	CXVisit_Break)
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5681:3)
	""" CXResult_VisitBreak
	export CXResult, CXResult_Invalid, CXResult_Success, CXResult_VisitBreak
	@ctypedef CXResult @cenum {
		CXResult_Success = (@Cuint)(0)
		CXResult_Invalid = (@Cuint)(1)
		CXResult_VisitBreak = (@Cuint)(2)
	}
	
	@doc raw"""
	\\brief Find references of a declaration in a specific file.
	
	\\param cursor pointing to a declaration or a reference of one.
	
	\\param file to search for references.
	
	\\param visitor callback that will receive pairs of CXCursor/CXSourceRange for
	each reference found.
	The CXSourceRange will point inside the file; if the reference is inside
	a macro (and not a macro argument) the CXSourceRange will be invalid.
	
	\\returns one of the CXResult enumerators.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5699:25)
	""" clang_findReferencesInFile
	export clang_findReferencesInFile
	@cextern clang_findReferencesInFile(cursor::CXCursor, file::CXFile, visitor::CXCursorAndRangeVisitor)::CXResult
	
	@doc raw"""
	\\brief Find #import/#include directives in a specific file.
	
	\\param TU translation unit containing the file to query.
	
	\\param file to search for #import/#include directives.
	
	\\param visitor callback that will receive pairs of CXCursor/CXSourceRange for
	each directive found.
	
	\\returns one of the CXResult enumerators.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5714:25)
	""" clang_findIncludesInFile
	export clang_findIncludesInFile
	@cextern clang_findIncludesInFile(TU::CXTranslationUnit, file::CXFile, visitor::CXCursorAndRangeVisitor)::CXResult
	
	@doc raw"""
	\\brief The client's data object that is associated with a CXFile.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5738:15)
	""" CXIdxClientFile
	export CXIdxClientFile
	@ctypedef CXIdxClientFile (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief The client's data object that is associated with a semantic entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5743:15)
	""" CXIdxClientEntity
	export CXIdxClientEntity
	@ctypedef CXIdxClientEntity (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief The client's data object that is associated with a semantic container
	of entities.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5749:15)
	""" CXIdxClientContainer
	export CXIdxClientContainer
	@ctypedef CXIdxClientContainer (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief The client's data object that is associated with an AST file (PCH
	or module).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5755:15)
	""" CXIdxClientASTFile
	export CXIdxClientASTFile
	@ctypedef CXIdxClientASTFile (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5763:3)
	""" CXIdxLoc
	export CXIdxLoc
	@ctypedef CXIdxLoc @cstruct {
		ptr_data::((@Ptr){@Cvoid})[2]
		int_data::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5788:3)
	""" CXIdxIncludedFileInfo
	export CXIdxIncludedFileInfo
	@ctypedef CXIdxIncludedFileInfo @cstruct {
		hashLoc::CXIdxLoc
		filename::(@Ptr){(@Cconst)(@Cchar)}
		file::CXFile
		isImport::@Cint
		isAngled::@Cint
		isModuleImport::@Cint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5812:3)
	""" CXIdxImportedASTFileInfo
	export CXIdxImportedASTFileInfo
	@ctypedef CXIdxImportedASTFileInfo @cstruct {
		file::CXFile
		var"module"::CXModule
		loc::CXIdxLoc
		isImplicit::@Cint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5823:3)
	""" CXIdxEntity_ObjCProtocol
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5841:3)
	""" CXIdxEntity_CXXConstructor
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5839:3)
	""" CXIdxEntity_CXXStaticMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5842:3)
	""" CXIdxEntity_CXXDestructor
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5822:3)
	""" CXIdxEntity_ObjCClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5826:3)
	""" CXIdxEntity_ObjCInstanceMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5833:3)
	""" CXIdxEntity_Union
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5818:3)
	""" CXIdxEntity_Variable
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5815:3)
	""" CXIdxEntity_Unexposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5832:3)
	""" CXIdxEntity_Struct
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5824:3)
	""" CXIdxEntity_ObjCCategory
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5844:3)
	""" CXIdxEntity_CXXTypeAlias
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5837:3)
	""" CXIdxEntity_CXXNamespaceAlias
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5831:3)
	""" CXIdxEntity_Enum
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5819:3)
	""" CXIdxEntity_Field
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5838:3)
	""" CXIdxEntity_CXXStaticVariable
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5816:3)
	""" CXIdxEntity_Typedef
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5817:3)
	""" CXIdxEntity_Function
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5840:3)
	""" CXIdxEntity_CXXInstanceMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5843:3)
	""" CXIdxEntity_CXXConversionFunction
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5820:3)
	""" CXIdxEntity_EnumConstant
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5829:3)
	""" CXIdxEntity_ObjCIvar
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5828:3)
	""" CXIdxEntity_ObjCProperty
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5835:3)
	""" CXIdxEntity_CXXClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5845:3)
	""" CXIdxEntity_CXXInterface
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5827:3)
	""" CXIdxEntity_ObjCClassMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5836:3)
	""" CXIdxEntity_CXXNamespace
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5847:3)
	""" CXIdxEntityKind
	export CXIdxEntityKind, CXIdxEntity_CXXClass, CXIdxEntity_CXXConstructor, CXIdxEntity_CXXConversionFunction, CXIdxEntity_CXXDestructor, CXIdxEntity_CXXInstanceMethod, CXIdxEntity_CXXInterface, CXIdxEntity_CXXNamespace, CXIdxEntity_CXXNamespaceAlias, CXIdxEntity_CXXStaticMethod, CXIdxEntity_CXXStaticVariable, CXIdxEntity_CXXTypeAlias, CXIdxEntity_Enum, CXIdxEntity_EnumConstant, CXIdxEntity_Field, CXIdxEntity_Function, CXIdxEntity_ObjCCategory, CXIdxEntity_ObjCClass, CXIdxEntity_ObjCClassMethod, CXIdxEntity_ObjCInstanceMethod, CXIdxEntity_ObjCIvar, CXIdxEntity_ObjCProperty, CXIdxEntity_ObjCProtocol, CXIdxEntity_Struct, CXIdxEntity_Typedef, CXIdxEntity_Unexposed, CXIdxEntity_Union, CXIdxEntity_Variable
	@ctypedef CXIdxEntityKind @cenum {
		CXIdxEntity_Unexposed = (@Cuint)(0)
		CXIdxEntity_Typedef = (@Cuint)(1)
		CXIdxEntity_Function = (@Cuint)(2)
		CXIdxEntity_Variable = (@Cuint)(3)
		CXIdxEntity_Field = (@Cuint)(4)
		CXIdxEntity_EnumConstant = (@Cuint)(5)
		CXIdxEntity_ObjCClass = (@Cuint)(6)
		CXIdxEntity_ObjCProtocol = (@Cuint)(7)
		CXIdxEntity_ObjCCategory = (@Cuint)(8)
		CXIdxEntity_ObjCInstanceMethod = (@Cuint)(9)
		CXIdxEntity_ObjCClassMethod = (@Cuint)(10)
		CXIdxEntity_ObjCProperty = (@Cuint)(11)
		CXIdxEntity_ObjCIvar = (@Cuint)(12)
		CXIdxEntity_Enum = (@Cuint)(13)
		CXIdxEntity_Struct = (@Cuint)(14)
		CXIdxEntity_Union = (@Cuint)(15)
		CXIdxEntity_CXXClass = (@Cuint)(16)
		CXIdxEntity_CXXNamespace = (@Cuint)(17)
		CXIdxEntity_CXXNamespaceAlias = (@Cuint)(18)
		CXIdxEntity_CXXStaticVariable = (@Cuint)(19)
		CXIdxEntity_CXXStaticMethod = (@Cuint)(20)
		CXIdxEntity_CXXInstanceMethod = (@Cuint)(21)
		CXIdxEntity_CXXConstructor = (@Cuint)(22)
		CXIdxEntity_CXXDestructor = (@Cuint)(23)
		CXIdxEntity_CXXConversionFunction = (@Cuint)(24)
		CXIdxEntity_CXXTypeAlias = (@Cuint)(25)
		CXIdxEntity_CXXInterface = (@Cuint)(26)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5854:3)
	""" CXIdxEntityLang_Swift
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5852:3)
	""" CXIdxEntityLang_ObjC
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5851:3)
	""" CXIdxEntityLang_C
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5853:3)
	""" CXIdxEntityLang_CXX
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5850:3)
	""" CXIdxEntityLang_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5855:3)
	""" CXIdxEntityLanguage
	export CXIdxEntityLang_C, CXIdxEntityLang_CXX, CXIdxEntityLang_None, CXIdxEntityLang_ObjC, CXIdxEntityLang_Swift, CXIdxEntityLanguage
	@ctypedef CXIdxEntityLanguage @cenum {
		CXIdxEntityLang_None = (@Cuint)(0)
		CXIdxEntityLang_C = (@Cuint)(1)
		CXIdxEntityLang_ObjC = (@Cuint)(2)
		CXIdxEntityLang_CXX = (@Cuint)(3)
		CXIdxEntityLang_Swift = (@Cuint)(4)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5868:3)
	""" CXIdxEntity_NonTemplate
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5872:3)
	""" CXIdxEntityCXXTemplateKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5870:3)
	""" CXIdxEntity_TemplatePartialSpecialization
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5869:3)
	""" CXIdxEntity_Template
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5871:3)
	""" CXIdxEntity_TemplateSpecialization
	export CXIdxEntityCXXTemplateKind, CXIdxEntity_NonTemplate, CXIdxEntity_Template, CXIdxEntity_TemplatePartialSpecialization, CXIdxEntity_TemplateSpecialization
	@ctypedef CXIdxEntityCXXTemplateKind @cenum {
		CXIdxEntity_NonTemplate = (@Cuint)(0)
		CXIdxEntity_Template = (@Cuint)(1)
		CXIdxEntity_TemplatePartialSpecialization = (@Cuint)(2)
		CXIdxEntity_TemplateSpecialization = (@Cuint)(3)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5878:3)
	""" CXIdxAttr_IBOutletCollection
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5875:3)
	""" CXIdxAttr_Unexposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5879:3)
	""" CXIdxAttrKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5876:3)
	""" CXIdxAttr_IBAction
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5877:3)
	""" CXIdxAttr_IBOutlet
	export CXIdxAttrKind, CXIdxAttr_IBAction, CXIdxAttr_IBOutlet, CXIdxAttr_IBOutletCollection, CXIdxAttr_Unexposed
	@ctypedef CXIdxAttrKind @cenum {
		CXIdxAttr_Unexposed = (@Cuint)(0)
		CXIdxAttr_IBAction = (@Cuint)(1)
		CXIdxAttr_IBOutlet = (@Cuint)(2)
		CXIdxAttr_IBOutletCollection = (@Cuint)(3)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5885:3)
	""" CXIdxAttrInfo
	export CXIdxAttrInfo
	@ctypedef CXIdxAttrInfo @cstruct {
		kind::CXIdxAttrKind
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5896:3)
	""" CXIdxEntityInfo
	export CXIdxEntityInfo
	@ctypedef CXIdxEntityInfo @cstruct {
		kind::CXIdxEntityKind
		templateKind::CXIdxEntityCXXTemplateKind
		lang::CXIdxEntityLanguage
		name::(@Ptr){(@Cconst)(@Cchar)}
		USR::(@Ptr){(@Cconst)(@Cchar)}
		cursor::CXCursor
		attributes::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxAttrInfo)})}
		numAttributes::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5900:3)
	""" CXIdxContainerInfo
	export CXIdxContainerInfo
	@ctypedef CXIdxContainerInfo @cstruct {
		cursor::CXCursor
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5907:3)
	""" CXIdxIBOutletCollectionAttrInfo
	export CXIdxIBOutletCollectionAttrInfo
	@ctypedef CXIdxIBOutletCollectionAttrInfo @cstruct {
		attrInfo::(@Ptr){(@Cconst)(CXIdxAttrInfo)}
		objcClass::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		classCursor::CXCursor
		classLoc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5910:3)
	""" CXIdxDeclFlag_Skipped
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5911:3)
	""" CXIdxDeclInfoFlags
	export CXIdxDeclFlag_Skipped, CXIdxDeclInfoFlags
	@ctypedef CXIdxDeclInfoFlags @cenum {
		CXIdxDeclFlag_Skipped = (@Cuint)(1)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5937:3)
	""" CXIdxDeclInfo
	export CXIdxDeclInfo
	@ctypedef CXIdxDeclInfo @cstruct {
		entityInfo::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		cursor::CXCursor
		loc::CXIdxLoc
		semanticContainer::(@Ptr){(@Cconst)(CXIdxContainerInfo)}
		lexicalContainer::(@Ptr){(@Cconst)(CXIdxContainerInfo)}
		isRedeclaration::@Cint
		isDefinition::@Cint
		isContainer::@Cint
		declAsContainer::(@Ptr){(@Cconst)(CXIdxContainerInfo)}
		isImplicit::@Cint
		attributes::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxAttrInfo)})}
		numAttributes::@Cuint
		flags::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5941:3)
	""" CXIdxObjCContainer_Interface
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5940:3)
	""" CXIdxObjCContainer_ForwardRef
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5942:3)
	""" CXIdxObjCContainer_Implementation
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5943:3)
	""" CXIdxObjCContainerKind
	export CXIdxObjCContainerKind, CXIdxObjCContainer_ForwardRef, CXIdxObjCContainer_Implementation, CXIdxObjCContainer_Interface
	@ctypedef CXIdxObjCContainerKind @cenum {
		CXIdxObjCContainer_ForwardRef = (@Cuint)(0)
		CXIdxObjCContainer_Interface = (@Cuint)(1)
		CXIdxObjCContainer_Implementation = (@Cuint)(2)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5948:3)
	""" CXIdxObjCContainerDeclInfo
	export CXIdxObjCContainerDeclInfo
	@ctypedef CXIdxObjCContainerDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		kind::CXIdxObjCContainerKind
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5954:3)
	""" CXIdxBaseClassInfo
	export CXIdxBaseClassInfo
	@ctypedef CXIdxBaseClassInfo @cstruct {
		base::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5960:3)
	""" CXIdxObjCProtocolRefInfo
	export CXIdxObjCProtocolRefInfo
	@ctypedef CXIdxObjCProtocolRefInfo @cstruct {
		protocol::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5965:3)
	""" CXIdxObjCProtocolRefListInfo
	export CXIdxObjCProtocolRefListInfo
	@ctypedef CXIdxObjCProtocolRefListInfo @cstruct {
		protocols::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxObjCProtocolRefInfo)})}
		numProtocols::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5971:3)
	""" CXIdxObjCInterfaceDeclInfo
	export CXIdxObjCInterfaceDeclInfo
	@ctypedef CXIdxObjCInterfaceDeclInfo @cstruct {
		containerInfo::(@Ptr){(@Cconst)(CXIdxObjCContainerDeclInfo)}
		superInfo::(@Ptr){(@Cconst)(CXIdxBaseClassInfo)}
		protocols::(@Ptr){(@Cconst)(CXIdxObjCProtocolRefListInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5979:3)
	""" CXIdxObjCCategoryDeclInfo
	export CXIdxObjCCategoryDeclInfo
	@ctypedef CXIdxObjCCategoryDeclInfo @cstruct {
		containerInfo::(@Ptr){(@Cconst)(CXIdxObjCContainerDeclInfo)}
		objcClass::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		classCursor::CXCursor
		classLoc::CXIdxLoc
		protocols::(@Ptr){(@Cconst)(CXIdxObjCProtocolRefListInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5985:3)
	""" CXIdxObjCPropertyDeclInfo
	export CXIdxObjCPropertyDeclInfo
	@ctypedef CXIdxObjCPropertyDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		getter::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		setter::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:5991:3)
	""" CXIdxCXXClassDeclInfo
	export CXIdxCXXClassDeclInfo
	@ctypedef CXIdxCXXClassDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		bases::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxBaseClassInfo)})}
		numBases::@Cuint
	}
	
	@doc raw"""
	\\brief An implicit reference, e.g. a reference of an Objective-C method
	via the dot syntax.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6005:3)
	""" CXIdxEntityRef_Implicit
	@doc raw"""
	\\brief The entity is referenced directly in user's code.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6000:3)
	""" CXIdxEntityRef_Direct
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6006:3)
	""" CXIdxEntityRefKind
	export CXIdxEntityRefKind, CXIdxEntityRef_Direct, CXIdxEntityRef_Implicit
	@ctypedef CXIdxEntityRefKind @cenum {
		CXIdxEntityRef_Direct = (@Cuint)(1)
		CXIdxEntityRef_Implicit = (@Cuint)(2)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6038:3)
	""" CXIdxEntityRefInfo
	export CXIdxEntityRefInfo
	@ctypedef CXIdxEntityRefInfo @cstruct {
		kind::CXIdxEntityRefKind
		cursor::CXCursor
		loc::CXIdxLoc
		referencedEntity::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		parentEntity::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		container::(@Ptr){(@Cconst)(CXIdxContainerInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6092:3)
	""" IndexerCallbacks
	export IndexerCallbacks
	@ctypedef IndexerCallbacks @cstruct {
		abortQuery::(@Ptr){(@Cfunction){(@Cint), (@Tuple){(CXClientData), ((@Ptr){@Cvoid})}, (@CDECL)}}
		diagnostic::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(CXClientData), (CXDiagnosticSet), ((@Ptr){@Cvoid})}, (@CDECL)}}
		enteredMainFile::(@Ptr){(@Cfunction){(CXIdxClientFile), (@Tuple){(CXClientData), (CXFile), ((@Ptr){@Cvoid})}, (@CDECL)}}
		ppIncludedFile::(@Ptr){(@Cfunction){(CXIdxClientFile), (@Tuple){(CXClientData), ((@Ptr){(@Cconst)(CXIdxIncludedFileInfo)})}, (@CDECL)}}
		importedASTFile::(@Ptr){(@Cfunction){(CXIdxClientASTFile), (@Tuple){(CXClientData), ((@Ptr){(@Cconst)(CXIdxImportedASTFileInfo)})}, (@CDECL)}}
		startedTranslationUnit::(@Ptr){(@Cfunction){(CXIdxClientContainer), (@Tuple){(CXClientData), ((@Ptr){@Cvoid})}, (@CDECL)}}
		indexDeclaration::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(CXClientData), ((@Ptr){(@Cconst)(CXIdxDeclInfo)})}, (@CDECL)}}
		indexEntityReference::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(CXClientData), ((@Ptr){(@Cconst)(CXIdxEntityRefInfo)})}, (@CDECL)}}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6094:20)
	""" clang_index_isEntityObjCContainerKind
	export clang_index_isEntityObjCContainerKind
	@cextern clang_index_isEntityObjCContainerKind(var"?1?"::CXIdxEntityKind)::@Cint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6096:1)
	""" clang_index_getObjCContainerDeclInfo
	export clang_index_getObjCContainerDeclInfo
	@cextern clang_index_getObjCContainerDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCContainerDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6099:1)
	""" clang_index_getObjCInterfaceDeclInfo
	export clang_index_getObjCInterfaceDeclInfo
	@cextern clang_index_getObjCInterfaceDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCInterfaceDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6103:1)
	""" clang_index_getObjCCategoryDeclInfo
	export clang_index_getObjCCategoryDeclInfo
	@cextern clang_index_getObjCCategoryDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCCategoryDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6106:1)
	""" clang_index_getObjCProtocolRefListInfo
	export clang_index_getObjCProtocolRefListInfo
	@cextern clang_index_getObjCProtocolRefListInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCProtocolRefListInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6109:1)
	""" clang_index_getObjCPropertyDeclInfo
	export clang_index_getObjCPropertyDeclInfo
	@cextern clang_index_getObjCPropertyDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCPropertyDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6112:1)
	""" clang_index_getIBOutletCollectionAttrInfo
	export clang_index_getIBOutletCollectionAttrInfo
	@cextern clang_index_getIBOutletCollectionAttrInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxAttrInfo)})::(@Ptr){(@Cconst)(CXIdxIBOutletCollectionAttrInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6115:1)
	""" clang_index_getCXXClassDeclInfo
	export clang_index_getCXXClassDeclInfo
	@cextern clang_index_getCXXClassDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxCXXClassDeclInfo)}
	
	@doc raw"""
	\\brief For retrieving a custom CXIdxClientContainer attached to a
	container.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6122:1)
	""" clang_index_getClientContainer
	export clang_index_getClientContainer
	@cextern clang_index_getClientContainer(var"?1?"::(@Ptr){(@Cconst)(CXIdxContainerInfo)})::CXIdxClientContainer
	
	@doc raw"""
	\\brief For setting a custom CXIdxClientContainer attached to a
	container.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6129:1)
	""" clang_index_setClientContainer
	export clang_index_setClientContainer
	@cextern clang_index_setClientContainer(var"?1?"::(@Ptr){(@Cconst)(CXIdxContainerInfo)}, var"?2?"::CXIdxClientContainer)::@Cvoid
	
	@doc raw"""
	\\brief For retrieving a custom CXIdxClientEntity attached to an entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6135:1)
	""" clang_index_getClientEntity
	export clang_index_getClientEntity
	@cextern clang_index_getClientEntity(var"?1?"::(@Ptr){(@Cconst)(CXIdxEntityInfo)})::CXIdxClientEntity
	
	@doc raw"""
	\\brief For setting a custom CXIdxClientEntity attached to an entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6141:1)
	""" clang_index_setClientEntity
	export clang_index_setClientEntity
	@cextern clang_index_setClientEntity(var"?1?"::(@Ptr){(@Cconst)(CXIdxEntityInfo)}, var"?2?"::CXIdxClientEntity)::@Cvoid
	
	@doc raw"""
	\\brief An indexing action/session, to be applied to one or multiple
	translation units.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6147:15)
	""" CXIndexAction
	export CXIndexAction
	@ctypedef CXIndexAction (@Ptr){@Cvoid}
	
	@doc raw"""
	\\brief An indexing action/session, to be applied to one or multiple
	translation units.
	
	\\param CIdx The index object with which the index action will be associated.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6155:30)
	""" clang_IndexAction_create
	export clang_IndexAction_create
	@cextern clang_IndexAction_create(CIdx::CXIndex)::CXIndexAction
	
	@doc raw"""
	\\brief Destroy the given index action.
	
	The index action must not be destroyed until all of the translation units
	created within that index action have been destroyed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6163:21)
	""" clang_IndexAction_dispose
	export clang_IndexAction_dispose
	@cextern clang_IndexAction_dispose(var"?1?"::CXIndexAction)::@Cvoid
	
	@doc raw"""
	\\brief Skip a function/method body that was already parsed during an
	indexing session associated with a \\c CXIndexAction object.
	Bodies in system headers are always skipped.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6200:3)
	""" CXIndexOpt_SkipParsedBodiesInSession
	@doc raw"""
	\\brief Implicit function/class template instantiations should be indexed.
	If this is not set, implicit instantiations will be ignored.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6188:3)
	""" CXIndexOpt_IndexImplicitTemplateInstantiations
	@doc raw"""
	\\brief Used to indicate that no special indexing options are needed.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6169:3)
	""" CXIndexOpt_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6202:3)
	""" CXIndexOptFlags
	@doc raw"""
	\\brief Suppress all compiler warnings when parsing for indexing.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6193:3)
	""" CXIndexOpt_SuppressWarnings
	@doc raw"""
	\\brief Used to indicate that IndexerCallbacks#indexEntityReference should
	be invoked for only one reference of an entity per source file that does
	not also include a declaration/definition of the entity.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6176:3)
	""" CXIndexOpt_SuppressRedundantRefs
	@doc raw"""
	\\brief Function-local symbols should be indexed. If this is not set
	function-local symbols will be ignored.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6182:3)
	""" CXIndexOpt_IndexFunctionLocalSymbols
	export CXIndexOptFlags, CXIndexOpt_IndexFunctionLocalSymbols, CXIndexOpt_IndexImplicitTemplateInstantiations, CXIndexOpt_None, CXIndexOpt_SkipParsedBodiesInSession, CXIndexOpt_SuppressRedundantRefs, CXIndexOpt_SuppressWarnings
	@ctypedef CXIndexOptFlags @cenum {
		CXIndexOpt_None = (@Cuint)(0)
		CXIndexOpt_SuppressRedundantRefs = (@Cuint)(1)
		CXIndexOpt_IndexFunctionLocalSymbols = (@Cuint)(2)
		CXIndexOpt_IndexImplicitTemplateInstantiations = (@Cuint)(4)
		CXIndexOpt_SuppressWarnings = (@Cuint)(8)
		CXIndexOpt_SkipParsedBodiesInSession = (@Cuint)(16)
	}
	
	@doc raw"""
	\\brief Index the given source file and the translation unit corresponding
	to that file via callbacks implemented through #IndexerCallbacks.
	
	\\param client_data pointer data supplied by the client, which will
	be passed to the invoked callbacks.
	
	\\param index_callbacks Pointer to indexing callbacks that the client
	implements.
	
	\\param index_callbacks_size Size of #IndexerCallbacks structure that gets
	passed in index_callbacks.
	
	\\param index_options A bitmask of options that affects how indexing is
	performed. This should be a bitwise OR of the CXIndexOpt_XXX flags.
	
	\\param[out] out_TU pointer to store a \\c CXTranslationUnit that can be
	reused after indexing is finished. Set to \\c NULL if you do not require it.
	
	\\returns 0 on success or if there were errors from which the compiler could
	recover.  If there is a failure from which there is no recovery, returns
	a non-zero \\c CXErrorCode.
	
	The rest of the parameters are the same as #clang_parseTranslationUnit.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6229:20)
	""" clang_indexSourceFile
	export clang_indexSourceFile
	@cextern clang_indexSourceFile(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), out_TU::(@Ptr){CXTranslationUnit}, TU_options::(@Cuint))::@Cint
	
	@doc raw"""
	\\brief Same as clang_indexSourceFile but requires a full command line
	for \\c command_line_args including argv[0]. This is useful if the standard
	library paths are relative to the binary.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6247:20)
	""" clang_indexSourceFileFullArgv
	export clang_indexSourceFileFullArgv
	@cextern clang_indexSourceFileFullArgv(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), out_TU::(@Ptr){CXTranslationUnit}, TU_options::(@Cuint))::@Cint
	
	@doc raw"""
	\\brief Index the given translation unit via callbacks implemented through
	#IndexerCallbacks.
	
	The order of callback invocations is not guaranteed to be the same as
	when indexing a source file. The high level order will be:
	
	-Preprocessor callbacks invocations
	-Declaration/reference callbacks invocations
	-Diagnostic callback invocations
	
	The parameters are the same as #clang_indexSourceFile.
	
	\\returns If there is a failure from which there is no recovery, returns
	non-zero, otherwise returns 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6270:20)
	""" clang_indexTranslationUnit
	export clang_indexTranslationUnit
	@cextern clang_indexTranslationUnit(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), var"?6?"::CXTranslationUnit)::@Cint
	
	@doc raw"""
	\\brief Retrieve the CXIdxFile, file, line, column, and offset represented by
	the given CXIdxLoc.
	
	If the location refers into a macro expansion, retrieves the
	location of the macro expansion and if it refers into a macro argument
	retrieves the location of the argument.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6285:21)
	""" clang_indexLoc_getFileLocation
	export clang_indexLoc_getFileLocation
	@cextern clang_indexLoc_getFileLocation(loc::CXIdxLoc, indexFile::(@Ptr){CXIdxClientFile}, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	\\brief Retrieve the CXSourceLocation represented by the given CXIdxLoc.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6296:18)
	""" clang_indexLoc_getCXSourceLocation
	export clang_indexLoc_getCXSourceLocation
	@cextern clang_indexLoc_getCXSourceLocation(loc::CXIdxLoc)::CXSourceLocation
	
	@doc raw"""
	\\brief Visitor invoked for each field found by a traversal.
	
	This visitor function will be invoked for each field found by
	\\c clang_Type_visitFields. Its first argument is the cursor being
	visited, its second argument is the client data provided to
	\\c clang_Type_visitFields.
	
	The visitor should return one of the \\c CXVisitorResult values
	to direct \\c clang_Type_visitFields.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6309:32)
	""" CXFieldVisitor
	export CXFieldVisitor
	@ctypedef CXFieldVisitor (@Ptr){(@Cfunction){(CXVisitorResult), (@Tuple){(CXCursor), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	\\brief Visit the fields of a particular type.
	
	This function visits all the direct fields of the given cursor,
	invoking the given \\p visitor function with the cursors of each
	visited field. The traversal may be ended prematurely, if
	the visitor returns \\c CXFieldVisit_Break.
	
	\\param T the record type whose field may be visited.
	
	\\param visitor the visitor function that will be invoked for each
	field of \\p T.
	
	\\param client_data pointer data supplied by the client, which will
	be passed to the visitor each time it is invoked.
	
	\\returns a non-zero value if the traversal was terminated
	prematurely by the visitor returning \\c CXFieldVisit_Break.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Index.h:6331:25)
	""" clang_Type_visitFields
	export clang_Type_visitFields
	@cextern clang_Type_visitFields(T::CXType, visitor::CXFieldVisitor, client_data::CXClientData)::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:40:3)
	""" CXComment
	export CXComment
	@ctypedef CXComment @cstruct {
		ASTNode::(@Ptr){(@Cconst)(@Cvoid)}
		TranslationUnit::CXTranslationUnit
	}
	
	@doc raw"""
	\\brief Given a cursor that represents a documentable entity (e.g.,
	declaration), return the associated parsed comment as a
	\\c CXComment_FullComment AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:47:26)
	""" clang_Cursor_getParsedComment
	export clang_Cursor_getParsedComment
	@cextern clang_Cursor_getParsedComment(C::CXCursor)::CXComment
	
	@doc raw"""
	\\brief HTML end tag.  Considered inline content.
	
	For example:
	\\verbatim
	</a>
	\\endverbatim
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:92:3)
	""" CXComment_HTMLEndTag
	@doc raw"""
	\\brief Plain text.  Inline content.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:64:3)
	""" CXComment_Text
	@doc raw"""
	\\brief Describes the type of the comment AST node (\\c CXComment).  A comment
	node can be considered block content (e. g., paragraph), inline content
	(plain text) or neither (the root AST node).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:54:6)
	""" CXCommentKind
	@doc raw"""
	\\brief A verbatim line command.  Verbatim line has an opening command,
	a single line of text (up to the newline after the opening command) and
	has no closing command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:153:3)
	""" CXComment_VerbatimLine
	@doc raw"""
	\\brief A paragraph, contains inline comment.  The paragraph itself is
	block content.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:98:3)
	""" CXComment_Paragraph
	@doc raw"""
	\\brief A full comment attached to a declaration, contains block content.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:158:3)
	""" CXComment_FullComment
	@doc raw"""
	\\brief A \\\\tparam command that describes a template parameter (name and
	description).
	
	For example: \\\\tparam T description.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:128:3)
	""" CXComment_TParamCommand
	@doc raw"""
	\\brief A verbatim block command (e. g., preformatted code).  Verbatim
	block has an opening and a closing command and contains multiple lines of
	text (\\c CXComment_VerbatimBlockLine child nodes).
	
	For example:
	\\\\verbatim
	aaa
	\\\\endverbatim
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:140:3)
	""" CXComment_VerbatimBlockCommand
	@doc raw"""
	\\brief HTML start tag with attributes (name-value pairs).  Considered
	inline content.
	
	For example:
	\\verbatim
	<br> <br /> <a href="http://example.org/">
	\\endverbatim
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:82:3)
	""" CXComment_HTMLStartTag
	@doc raw"""
	\\brief A command that has zero or more word-like arguments (number of
	word-like arguments depends on command name) and a paragraph as an
	argument.  Block command is block content.
	
	Paragraph argument is also a child of the block command.
	
	For example: \\\\brief has 0 word-like arguments and a paragraph argument.
	
	AST nodes of special kinds that parser knows about (e. g., \\\\param
	command) have their own node kinds.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:112:3)
	""" CXComment_BlockCommand
	@doc raw"""
	\\brief A command with word-like arguments that is considered inline content.
	
	For example: \\\\c command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:71:3)
	""" CXComment_InlineCommand
	@doc raw"""
	\\brief A line of text that is contained within a
	CXComment_VerbatimBlockCommand node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:146:3)
	""" CXComment_VerbatimBlockLine
	@doc raw"""
	\\brief A \\\\param or \\\\arg command that describes the function parameter
	(name, passing direction, description).
	
	For example: \\\\param [in] ParamName description.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:120:3)
	""" CXComment_ParamCommand
	@doc raw"""
	\\brief Null comment.  No AST node is constructed at the requested location
	because there is no text or a syntax error.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:59:3)
	""" CXComment_Null
	export CXCommentKind, CXComment_BlockCommand, CXComment_FullComment, CXComment_HTMLEndTag, CXComment_HTMLStartTag, CXComment_InlineCommand, CXComment_Null, CXComment_Paragraph, CXComment_ParamCommand, CXComment_TParamCommand, CXComment_Text, CXComment_VerbatimBlockCommand, CXComment_VerbatimBlockLine, CXComment_VerbatimLine
	@cenum CXCommentKind {
		CXComment_Null = (@Cuint)(0)
		CXComment_Text = (@Cuint)(1)
		CXComment_InlineCommand = (@Cuint)(2)
		CXComment_HTMLStartTag = (@Cuint)(3)
		CXComment_HTMLEndTag = (@Cuint)(4)
		CXComment_Paragraph = (@Cuint)(5)
		CXComment_BlockCommand = (@Cuint)(6)
		CXComment_ParamCommand = (@Cuint)(7)
		CXComment_TParamCommand = (@Cuint)(8)
		CXComment_VerbatimBlockCommand = (@Cuint)(9)
		CXComment_VerbatimBlockLine = (@Cuint)(10)
		CXComment_VerbatimLine = (@Cuint)(11)
		CXComment_FullComment = (@Cuint)(12)
	}
	
	@doc raw"""
	\\brief Command argument should be rendered in a monospaced font.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:179:3)
	""" CXCommentInlineCommandRenderKind_Monospaced
	@doc raw"""
	\\brief Command argument should be rendered in a bold font.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:174:3)
	""" CXCommentInlineCommandRenderKind_Bold
	@doc raw"""
	\\brief Command argument should be rendered emphasized (typically italic
	font).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:185:3)
	""" CXCommentInlineCommandRenderKind_Emphasized
	@doc raw"""
	\\brief The most appropriate rendering mode for an inline command, chosen on
	command semantics in Doxygen.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:165:6)
	""" CXCommentInlineCommandRenderKind
	@doc raw"""
	\\brief Command argument should be rendered in a normal font.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:169:3)
	""" CXCommentInlineCommandRenderKind_Normal
	export CXCommentInlineCommandRenderKind, CXCommentInlineCommandRenderKind_Bold, CXCommentInlineCommandRenderKind_Emphasized, CXCommentInlineCommandRenderKind_Monospaced, CXCommentInlineCommandRenderKind_Normal
	@cenum CXCommentInlineCommandRenderKind {
		CXCommentInlineCommandRenderKind_Normal = (@Cuint)(0)
		CXCommentInlineCommandRenderKind_Bold = (@Cuint)(1)
		CXCommentInlineCommandRenderKind_Monospaced = (@Cuint)(2)
		CXCommentInlineCommandRenderKind_Emphasized = (@Cuint)(3)
	}
	
	@doc raw"""
	\\brief The parameter is an input parameter.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:195:3)
	""" CXCommentParamPassDirection_In
	@doc raw"""
	\\brief The parameter is an output parameter.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:200:3)
	""" CXCommentParamPassDirection_Out
	@doc raw"""
	\\brief Describes parameter passing direction for \\\\param or \\\\arg command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:191:6)
	""" CXCommentParamPassDirection
	@doc raw"""
	\\brief The parameter is an input and output parameter.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:205:3)
	""" CXCommentParamPassDirection_InOut
	export CXCommentParamPassDirection, CXCommentParamPassDirection_In, CXCommentParamPassDirection_InOut, CXCommentParamPassDirection_Out
	@cenum CXCommentParamPassDirection {
		CXCommentParamPassDirection_In = (@Cuint)(0)
		CXCommentParamPassDirection_Out = (@Cuint)(1)
		CXCommentParamPassDirection_InOut = (@Cuint)(2)
	}
	
	@doc raw"""
	\\param Comment AST node of any kind.
	
	\\returns the type of the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:213:35)
	""" clang_Comment_getKind
	export clang_Comment_getKind
	@cextern clang_Comment_getKind(Comment::CXComment)::CXCommentKind
	
	@doc raw"""
	\\param Comment AST node of any kind.
	
	\\returns number of children of the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:220:25)
	""" clang_Comment_getNumChildren
	export clang_Comment_getNumChildren
	@cextern clang_Comment_getNumChildren(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment AST node of any kind.
	
	\\param ChildIdx child index (zero-based).
	
	\\returns the specified child of the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:230:11)
	""" clang_Comment_getChild
	export clang_Comment_getChild
	@cextern clang_Comment_getChild(Comment::CXComment, ChildIdx::(@Cuint))::CXComment
	
	@doc raw"""
	\\brief A \\c CXComment_Paragraph node is considered whitespace if it contains
	only \\c CXComment_Text nodes that are empty or whitespace.
	
	Other AST nodes (except \\c CXComment_Paragraph and \\c CXComment_Text) are
	never considered whitespace.
	
	\\returns non-zero if \\c Comment is whitespace.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:241:25)
	""" clang_Comment_isWhitespace
	export clang_Comment_isWhitespace
	@cextern clang_Comment_isWhitespace(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\returns non-zero if \\c Comment is inline content and has a newline
	immediately following it in the comment text.  Newlines between paragraphs
	do not count.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:249:10)
	""" clang_InlineContentComment_hasTrailingNewline
	export clang_InlineContentComment_hasTrailingNewline
	@cextern clang_InlineContentComment_hasTrailingNewline(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_Text AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:256:25)
	""" clang_TextComment_getText
	export clang_TextComment_getText
	@cextern clang_TextComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns name of the inline command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:264:10)
	""" clang_InlineCommandComment_getCommandName
	export clang_InlineCommandComment_getCommandName
	@cextern clang_InlineCommandComment_getCommandName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns the most appropriate rendering mode, chosen on command
	semantics in Doxygen.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:273:1)
	""" clang_InlineCommandComment_getRenderKind
	export clang_InlineCommandComment_getRenderKind
	@cextern clang_InlineCommandComment_getRenderKind(Comment::CXComment)::CXCommentInlineCommandRenderKind
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns number of command arguments.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:281:10)
	""" clang_InlineCommandComment_getNumArgs
	export clang_InlineCommandComment_getNumArgs
	@cextern clang_InlineCommandComment_getNumArgs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\param ArgIdx argument index (zero-based).
	
	\\returns text of the specified argument.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:291:10)
	""" clang_InlineCommandComment_getArgText
	export clang_InlineCommandComment_getArgText
	@cextern clang_InlineCommandComment_getArgText(Comment::CXComment, ArgIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag or \\c CXComment_HTMLEndTag AST
	node.
	
	\\returns HTML tag name.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:300:25)
	""" clang_HTMLTagComment_getTagName
	export clang_HTMLTagComment_getTagName
	@cextern clang_HTMLTagComment_getTagName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\returns non-zero if tag is self-closing (for example, &lt;br /&gt;).
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:308:10)
	""" clang_HTMLStartTagComment_isSelfClosing
	export clang_HTMLStartTagComment_isSelfClosing
	@cextern clang_HTMLStartTagComment_isSelfClosing(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\returns number of attributes (name-value pairs) attached to the start tag.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:315:25)
	""" clang_HTMLStartTag_getNumAttrs
	export clang_HTMLStartTag_getNumAttrs
	@cextern clang_HTMLStartTag_getNumAttrs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\param AttrIdx attribute index (zero-based).
	
	\\returns name of the specified attribute.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:325:10)
	""" clang_HTMLStartTag_getAttrName
	export clang_HTMLStartTag_getAttrName
	@cextern clang_HTMLStartTag_getAttrName(Comment::CXComment, AttrIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\param AttrIdx attribute index (zero-based).
	
	\\returns value of the specified attribute.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:335:10)
	""" clang_HTMLStartTag_getAttrValue
	export clang_HTMLStartTag_getAttrValue
	@cextern clang_HTMLStartTag_getAttrValue(Comment::CXComment, AttrIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\returns name of the block command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:343:10)
	""" clang_BlockCommandComment_getCommandName
	export clang_BlockCommandComment_getCommandName
	@cextern clang_BlockCommandComment_getCommandName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\returns number of word-like arguments.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:351:10)
	""" clang_BlockCommandComment_getNumArgs
	export clang_BlockCommandComment_getNumArgs
	@cextern clang_BlockCommandComment_getNumArgs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\param ArgIdx argument index (zero-based).
	
	\\returns text of the specified word-like argument.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:361:10)
	""" clang_BlockCommandComment_getArgText
	export clang_BlockCommandComment_getArgText
	@cextern clang_BlockCommandComment_getArgText(Comment::CXComment, ArgIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand or
	\\c CXComment_VerbatimBlockCommand AST node.
	
	\\returns paragraph argument of the block command.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:371:11)
	""" clang_BlockCommandComment_getParagraph
	export clang_BlockCommandComment_getParagraph
	@cextern clang_BlockCommandComment_getParagraph(Comment::CXComment)::CXComment
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns parameter name.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:379:10)
	""" clang_ParamCommandComment_getParamName
	export clang_ParamCommandComment_getParamName
	@cextern clang_ParamCommandComment_getParamName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns non-zero if the parameter that this AST node represents was found
	in the function prototype and \\c clang_ParamCommandComment_getParamIndex
	function will return a meaningful value.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:389:10)
	""" clang_ParamCommandComment_isParamIndexValid
	export clang_ParamCommandComment_isParamIndexValid
	@cextern clang_ParamCommandComment_isParamIndexValid(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns zero-based parameter index in function prototype.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:397:10)
	""" clang_ParamCommandComment_getParamIndex
	export clang_ParamCommandComment_getParamIndex
	@cextern clang_ParamCommandComment_getParamIndex(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns non-zero if parameter passing direction was specified explicitly in
	the comment.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:406:10)
	""" clang_ParamCommandComment_isDirectionExplicit
	export clang_ParamCommandComment_isDirectionExplicit
	@cextern clang_ParamCommandComment_isDirectionExplicit(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns parameter passing direction.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:414:34)
	""" clang_ParamCommandComment_getDirection
	export clang_ParamCommandComment_getDirection
	@cextern clang_ParamCommandComment_getDirection(Comment::CXComment)::CXCommentParamPassDirection
	
	@doc raw"""
	\\param Comment a \\c CXComment_TParamCommand AST node.
	
	\\returns template parameter name.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:423:10)
	""" clang_TParamCommandComment_getParamName
	export clang_TParamCommandComment_getParamName
	@cextern clang_TParamCommandComment_getParamName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_TParamCommand AST node.
	
	\\returns non-zero if the parameter that this AST node represents was found
	in the template parameter list and
	\\c clang_TParamCommandComment_getDepth and
	\\c clang_TParamCommandComment_getIndex functions will return a meaningful
	value.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:435:10)
	""" clang_TParamCommandComment_isParamPositionValid
	export clang_TParamCommandComment_isParamPositionValid
	@cextern clang_TParamCommandComment_isParamPositionValid(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_TParamCommand AST node.
	
	\\returns zero-based nesting depth of this parameter in the template parameter list.
	
	For example,
	\\verbatim
	template<typename C, template<typename T> class TT>
	void test(TT<int> aaa);
	\\endverbatim
	for C and TT nesting depth is 0,
	for T nesting depth is 1.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:451:10)
	""" clang_TParamCommandComment_getDepth
	export clang_TParamCommandComment_getDepth
	@cextern clang_TParamCommandComment_getDepth(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_TParamCommand AST node.
	
	\\returns zero-based parameter index in the template parameter list at a
	given nesting depth.
	
	For example,
	\\verbatim
	template<typename C, template<typename T> class TT>
	void test(TT<int> aaa);
	\\endverbatim
	for C and TT nesting depth is 0, so we can ask for index at depth 0:
	at depth 0 C's index is 0, TT's index is 1.
	
	For T nesting depth is 1, so we can ask for index at depth 0 and 1:
	at depth 0 T's index is 1 (same as TT's),
	at depth 1 T's index is 0.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:472:10)
	""" clang_TParamCommandComment_getIndex
	export clang_TParamCommandComment_getIndex
	@cextern clang_TParamCommandComment_getIndex(Comment::CXComment, Depth::(@Cuint))::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_VerbatimBlockLine AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:480:10)
	""" clang_VerbatimBlockLineComment_getText
	export clang_VerbatimBlockLineComment_getText
	@cextern clang_VerbatimBlockLineComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_VerbatimLine AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:487:25)
	""" clang_VerbatimLineComment_getText
	export clang_VerbatimLineComment_getText
	@cextern clang_VerbatimLineComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	\\brief Convert an HTML tag AST node to string.
	
	\\param Comment a \\c CXComment_HTMLStartTag or \\c CXComment_HTMLEndTag AST
	node.
	
	\\returns string containing an HTML tag.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:497:25)
	""" clang_HTMLTagComment_getAsString
	export clang_HTMLTagComment_getAsString
	@cextern clang_HTMLTagComment_getAsString(Comment::CXComment)::CXString
	
	@doc raw"""
	\\brief Convert a given full parsed comment to an HTML fragment.
	
	Specific details of HTML layout are subject to change.  Don't try to parse
	this HTML back into an AST, use other APIs instead.
	
	Currently the following CSS classes are used:
	\\li "para-brief" for \\\\brief paragraph and equivalent commands;
	\\li "para-returns" for \\\\returns paragraph and equivalent commands;
	\\li "word-returns" for the "Returns" word in \\\\returns paragraph.
	
	Function argument documentation is rendered as a \\<dl\\> list with arguments
	sorted in function prototype order.  CSS classes used:
	\\li "param-name-index-NUMBER" for parameter name (\\<dt\\>);
	\\li "param-descr-index-NUMBER" for parameter description (\\<dd\\>);
	\\li "param-name-index-invalid" and "param-descr-index-invalid" are used if
	parameter index is invalid.
	
	Template parameter documentation is rendered as a \\<dl\\> list with
	parameters sorted in template parameter list order.  CSS classes used:
	\\li "tparam-name-index-NUMBER" for parameter name (\\<dt\\>);
	\\li "tparam-descr-index-NUMBER" for parameter description (\\<dd\\>);
	\\li "tparam-name-index-other" and "tparam-descr-index-other" are used for
	names inside template template parameters;
	\\li "tparam-name-index-invalid" and "tparam-descr-index-invalid" are used if
	parameter position is invalid.
	
	\\param Comment a \\c CXComment_FullComment AST node.
	
	\\returns string containing an HTML fragment.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:530:25)
	""" clang_FullComment_getAsHTML
	export clang_FullComment_getAsHTML
	@cextern clang_FullComment_getAsHTML(Comment::CXComment)::CXString
	
	@doc raw"""
	\\brief Convert a given full parsed comment to an XML document.
	
	A Relax NG schema for the XML can be found in comment-xml-schema.rng file
	inside clang source tree.
	
	\\param Comment a \\c CXComment_FullComment AST node.
	
	\\returns string containing an XML document.
	
	[C Reference](~/.julia/artifacts/0a61032597a12ac88c748b0ca780d80f5c51e98d/include/clang-c/Documentation.h:542:25)
	""" clang_FullComment_getAsXML
	export clang_FullComment_getAsXML
	@cextern clang_FullComment_getAsXML(Comment::CXComment)::CXString
end
