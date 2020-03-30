using CBinding: @macros
@macros

@cbindings "{{ LIBCLANG_PATH }}" begin
	@doc raw"""
	A generic error code, no further details are available.
	
	Errors of this kind can get their own specific error codes in future
	libclang versions.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:41:3)
	""" CXError_Failure
	@doc raw"""
	Error codes returned by libclang routines.
	
	Zero (\\c CXError_Success) is the only error code indicating success.  Other
	error codes, including not yet assigned non-zero values, indicate errors.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:29:6)
	""" CXErrorCode
	@doc raw"""
	No error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:33:3)
	""" CXError_Success
	@doc raw"""
	libclang crashed while performing the requested operation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:46:3)
	""" CXError_Crashed
	@doc raw"""
	The function detected that the arguments violate the function
	contract.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:52:3)
	""" CXError_InvalidArguments
	@doc raw"""
	An AST deserialization error has occurred.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXErrorCode.h:57:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXString.h:41:3)
	""" CXString
	export CXString
	@ctypedef CXString @cstruct {
		data::(@Ptr){(@Cconst)(@Cvoid)}
		private_flags::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXString.h:46:3)
	""" CXStringSet
	export CXStringSet
	@ctypedef CXStringSet @cstruct {
		Strings::(@Ptr){CXString}
		Count::@Cuint
	}
	
	@doc raw"""
	Retrieve the character data associated with the given string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXString.h:51:28)
	""" clang_getCString
	export clang_getCString
	@cextern clang_getCString(string::CXString)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	Free the given string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXString.h:56:21)
	""" clang_disposeString
	export clang_disposeString
	@cextern clang_disposeString(string::CXString)::@Cvoid
	
	@doc raw"""
	Free the given string set.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXString.h:61:21)
	""" clang_disposeStringSet
	export clang_disposeStringSet
	@cextern clang_disposeStringSet(set::(@Ptr){CXStringSet})::@Cvoid
	
	@doc raw"""
	Return the timestamp for use with Clang's
	\\c -fbuild-session-timestamp= option.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:34:35)
	""" clang_getBuildSessionTimestamp
	export clang_getBuildSessionTimestamp
	@cextern clang_getBuildSessionTimestamp()::@Culonglong
	
	@doc raw"""
	Object encapsulating information about overlaying virtual
	file/directories over the real file system.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:40:42)
	""" CXVirtualFileOverlay
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:40:16)
	""" CXVirtualFileOverlayImpl
	export CXVirtualFileOverlay, CXVirtualFileOverlayImpl
	@ctypedef CXVirtualFileOverlay (@Ptr){@cstruct CXVirtualFileOverlayImpl}
	
	@doc raw"""
	Create a \\c CXVirtualFileOverlay object.
	Must be disposed with \\c clang_VirtualFileOverlay_dispose().
	
	\\param options is reserved, always pass 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:49:1)
	""" clang_VirtualFileOverlay_create
	export clang_VirtualFileOverlay_create
	@cextern clang_VirtualFileOverlay_create(options::@Cuint)::CXVirtualFileOverlay
	
	@doc raw"""
	Map an absolute virtual file path to an absolute real one.
	The virtual path must be canonicalized (not contain "."/"..").
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:57:1)
	""" clang_VirtualFileOverlay_addFileMapping
	export clang_VirtualFileOverlay_addFileMapping
	@cextern clang_VirtualFileOverlay_addFileMapping(var"?1?"::CXVirtualFileOverlay, virtualPath::(@Ptr){(@Cconst)(@Cchar)}, realPath::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	Set the case sensitivity for the \\c CXVirtualFileOverlay object.
	The \\c CXVirtualFileOverlay object is case-sensitive by default, this
	option can be used to override the default.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:68:1)
	""" clang_VirtualFileOverlay_setCaseSensitivity
	export clang_VirtualFileOverlay_setCaseSensitivity
	@cextern clang_VirtualFileOverlay_setCaseSensitivity(var"?1?"::CXVirtualFileOverlay, caseSensitive::(@Cint))::CXErrorCode
	
	@doc raw"""
	Write out the \\c CXVirtualFileOverlay object to a char buffer.
	
	\\param options is reserved, always pass 0.
	\\param out_buffer_ptr pointer to receive the buffer pointer, which should be
	disposed using \\c clang_free().
	\\param out_buffer_size pointer to receive the buffer size.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:81:1)
	""" clang_VirtualFileOverlay_writeToBuffer
	export clang_VirtualFileOverlay_writeToBuffer
	@cextern clang_VirtualFileOverlay_writeToBuffer(var"?1?"::CXVirtualFileOverlay, options::(@Cuint), out_buffer_ptr::(@Ptr){(@Ptr){@Cchar}}, out_buffer_size::(@Ptr){@Cuint})::CXErrorCode
	
	@doc raw"""
	free memory allocated by libclang, such as the buffer returned by
	\\c CXVirtualFileOverlay() or \\c clang_ModuleMapDescriptor_writeToBuffer().
	
	\\param buffer memory pointer to free.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:91:21)
	""" clang_free
	export clang_free
	@cextern clang_free(buffer::(@Ptr){@Cvoid})::@Cvoid
	
	@doc raw"""
	Dispose a \\c CXVirtualFileOverlay object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:96:21)
	""" clang_VirtualFileOverlay_dispose
	export clang_VirtualFileOverlay_dispose
	@cextern clang_VirtualFileOverlay_dispose(var"?1?"::CXVirtualFileOverlay)::@Cvoid
	
	@doc raw"""
	Object encapsulating information about a module.map file.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:101:43)
	""" CXModuleMapDescriptor
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:101:16)
	""" CXModuleMapDescriptorImpl
	export CXModuleMapDescriptor, CXModuleMapDescriptorImpl
	@ctypedef CXModuleMapDescriptor (@Ptr){@cstruct CXModuleMapDescriptorImpl}
	
	@doc raw"""
	Create a \\c CXModuleMapDescriptor object.
	Must be disposed with \\c clang_ModuleMapDescriptor_dispose().
	
	\\param options is reserved, always pass 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:110:1)
	""" clang_ModuleMapDescriptor_create
	export clang_ModuleMapDescriptor_create
	@cextern clang_ModuleMapDescriptor_create(options::@Cuint)::CXModuleMapDescriptor
	
	@doc raw"""
	Sets the framework module name that the module.map describes.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:117:1)
	""" clang_ModuleMapDescriptor_setFrameworkModuleName
	export clang_ModuleMapDescriptor_setFrameworkModuleName
	@cextern clang_ModuleMapDescriptor_setFrameworkModuleName(var"?1?"::CXModuleMapDescriptor, name::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	Sets the umbrealla header name that the module.map describes.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:125:1)
	""" clang_ModuleMapDescriptor_setUmbrellaHeader
	export clang_ModuleMapDescriptor_setUmbrellaHeader
	@cextern clang_ModuleMapDescriptor_setUmbrellaHeader(var"?1?"::CXModuleMapDescriptor, name::(@Ptr){(@Cconst)(@Cchar)})::CXErrorCode
	
	@doc raw"""
	Write out the \\c CXModuleMapDescriptor object to a char buffer.
	
	\\param options is reserved, always pass 0.
	\\param out_buffer_ptr pointer to receive the buffer pointer, which should be
	disposed using \\c clang_free().
	\\param out_buffer_size pointer to receive the buffer size.
	\\returns 0 for success, non-zero to indicate an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:138:1)
	""" clang_ModuleMapDescriptor_writeToBuffer
	export clang_ModuleMapDescriptor_writeToBuffer
	@cextern clang_ModuleMapDescriptor_writeToBuffer(var"?1?"::CXModuleMapDescriptor, options::(@Cuint), out_buffer_ptr::(@Ptr){(@Ptr){@Cchar}}, out_buffer_size::(@Ptr){@Cuint})::CXErrorCode
	
	@doc raw"""
	Dispose a \\c CXModuleMapDescriptor object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/BuildSystem.h:145:21)
	""" clang_ModuleMapDescriptor_dispose
	export clang_ModuleMapDescriptor_dispose
	@cextern clang_ModuleMapDescriptor_dispose(var"?1?"::CXModuleMapDescriptor)::@Cvoid
	
	@doc raw"""
	A compilation database holds all information used to compile files in a
	project. For each file in the database, it can be queried for the working
	directory or the command line used for the compiler invocation.
	
	Must be freed by \\c clang_CompilationDatabase_dispose
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:38:16)
	""" CXCompilationDatabase
	export CXCompilationDatabase
	@ctypedef CXCompilationDatabase (@Ptr){@Cvoid}
	
	@doc raw"""
	Contains the results of a search in the compilation database
	
	When searching for the compile command for a file, the compilation db can
	return several commands, as the file may have been compiled with
	different options in different places of the project. This choice of compile
	commands is wrapped in this opaque data structure. It must be freed by
	\\c clang_CompileCommands_dispose.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:49:16)
	""" CXCompileCommands
	export CXCompileCommands
	@ctypedef CXCompileCommands (@Ptr){@Cvoid}
	
	@doc raw"""
	Represents the command line invocation to compile a specific file.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:54:16)
	""" CXCompileCommand
	export CXCompileCommand
	@ctypedef CXCompileCommand (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:70:3)
	""" CXCompilationDatabase_Error
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:63:3)
	""" CXCompilationDatabase_NoError
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:68:3)
	""" CXCompilationDatabase_CanNotLoadDatabase
	export CXCompilationDatabase_CanNotLoadDatabase, CXCompilationDatabase_Error, CXCompilationDatabase_NoError
	@ctypedef CXCompilationDatabase_Error @cenum {
		CXCompilationDatabase_NoError = (@Cuint)(0)
		CXCompilationDatabase_CanNotLoadDatabase = (@Cuint)(1)
	}
	
	@doc raw"""
	Creates a compilation database from the database found in directory
	buildDir. For example, CMake can output a compile_commands.json which can
	be used to build the database.
	
	It must be freed by \\c clang_CompilationDatabase_dispose.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:80:1)
	""" clang_CompilationDatabase_fromDirectory
	export clang_CompilationDatabase_fromDirectory
	@cextern clang_CompilationDatabase_fromDirectory(BuildDir::(@Ptr){(@Cconst)(@Cchar)}, ErrorCode::(@Ptr){CXCompilationDatabase_Error})::CXCompilationDatabase
	
	@doc raw"""
	Free the given compilation database
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:87:1)
	""" clang_CompilationDatabase_dispose
	export clang_CompilationDatabase_dispose
	@cextern clang_CompilationDatabase_dispose(var"?1?"::CXCompilationDatabase)::@Cvoid
	
	@doc raw"""
	Find the compile commands used for a file. The compile commands
	must be freed by \\c clang_CompileCommands_dispose.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:94:1)
	""" clang_CompilationDatabase_getCompileCommands
	export clang_CompilationDatabase_getCompileCommands
	@cextern clang_CompilationDatabase_getCompileCommands(var"?1?"::CXCompilationDatabase, CompleteFileName::(@Ptr){(@Cconst)(@Cchar)})::CXCompileCommands
	
	@doc raw"""
	Get all the compile commands in the given compilation database.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:101:1)
	""" clang_CompilationDatabase_getAllCompileCommands
	export clang_CompilationDatabase_getAllCompileCommands
	@cextern clang_CompilationDatabase_getAllCompileCommands(var"?1?"::CXCompilationDatabase)::CXCompileCommands
	
	@doc raw"""
	Free the given CompileCommands
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:106:21)
	""" clang_CompileCommands_dispose
	export clang_CompileCommands_dispose
	@cextern clang_CompileCommands_dispose(var"?1?"::CXCompileCommands)::@Cvoid
	
	@doc raw"""
	Get the number of CompileCommand we have for a file
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:112:1)
	""" clang_CompileCommands_getSize
	export clang_CompileCommands_getSize
	@cextern clang_CompileCommands_getSize(var"?1?"::CXCompileCommands)::@Cuint
	
	@doc raw"""
	Get the I'th CompileCommand for a file
	
	Note : 0 <= i < clang_CompileCommands_getSize(CXCompileCommands)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:120:1)
	""" clang_CompileCommands_getCommand
	export clang_CompileCommands_getCommand
	@cextern clang_CompileCommands_getCommand(var"?1?"::CXCompileCommands, I::(@Cuint))::CXCompileCommand
	
	@doc raw"""
	Get the working directory where the CompileCommand was executed from
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:126:1)
	""" clang_CompileCommand_getDirectory
	export clang_CompileCommand_getDirectory
	@cextern clang_CompileCommand_getDirectory(var"?1?"::CXCompileCommand)::CXString
	
	@doc raw"""
	Get the filename associated with the CompileCommand.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:132:1)
	""" clang_CompileCommand_getFilename
	export clang_CompileCommand_getFilename
	@cextern clang_CompileCommand_getFilename(var"?1?"::CXCompileCommand)::CXString
	
	@doc raw"""
	Get the number of arguments in the compiler invocation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:139:1)
	""" clang_CompileCommand_getNumArgs
	export clang_CompileCommand_getNumArgs
	@cextern clang_CompileCommand_getNumArgs(var"?1?"::CXCompileCommand)::@Cuint
	
	@doc raw"""
	Get the I'th argument value in the compiler invocations
	
	Invariant :
	- argument 0 is the compiler executable
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:148:1)
	""" clang_CompileCommand_getArg
	export clang_CompileCommand_getArg
	@cextern clang_CompileCommand_getArg(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	Get the number of source mappings for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:154:1)
	""" clang_CompileCommand_getNumMappedSources
	export clang_CompileCommand_getNumMappedSources
	@cextern clang_CompileCommand_getNumMappedSources(var"?1?"::CXCompileCommand)::@Cuint
	
	@doc raw"""
	Get the I'th mapped source path for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:160:1)
	""" clang_CompileCommand_getMappedSourcePath
	export clang_CompileCommand_getMappedSourcePath
	@cextern clang_CompileCommand_getMappedSourcePath(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	Get the I'th mapped source content for the compiler invocation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/CXCompilationDatabase.h:166:1)
	""" clang_CompileCommand_getMappedSourceContent
	export clang_CompileCommand_getMappedSourceContent
	@cextern clang_CompileCommand_getMappedSourceContent(var"?1?"::CXCompileCommand, I::(@Cuint))::CXString
	
	@doc raw"""
	An "index" that consists of a set of translation units that would
	typically be linked together into an executable or library.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:81:15)
	""" CXIndex
	export CXIndex
	@ctypedef CXIndex (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:87:16)
	""" CXTargetInfoImpl
	@doc raw"""
	An opaque type representing target information for a given translation
	unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:87:34)
	""" CXTargetInfo
	export CXTargetInfo, CXTargetInfoImpl
	@ctypedef CXTargetInfo (@Ptr){@cstruct CXTargetInfoImpl}
	
	@doc raw"""
	A single translation unit, which resides in an index.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:92:39)
	""" CXTranslationUnit
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:92:16)
	""" CXTranslationUnitImpl
	export CXTranslationUnit, CXTranslationUnitImpl
	@ctypedef CXTranslationUnit (@Ptr){@cstruct CXTranslationUnitImpl}
	
	@doc raw"""
	Opaque pointer representing client data that will be passed through
	to various callbacks and visitors.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:98:15)
	""" CXClientData
	export CXClientData
	@ctypedef CXClientData (@Ptr){@Cvoid}
	
	@doc raw"""
	Provides the contents of a file that has not yet been saved to disk.
	
	Each CXUnsavedFile instance provides the name of a file on the
	system along with the current contents of that file that have not
	yet been saved to disk.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:107:8)
	""" CXUnsavedFile
	export CXUnsavedFile
	@cstruct CXUnsavedFile {
		Filename::(@Ptr){(@Cconst)(@Cchar)}
		Contents::(@Ptr){(@Cconst)(@Cchar)}
		Length::@Culong
	}
	
	@doc raw"""
	The entity is available, but has been deprecated (and its use is
	not recommended).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:140:3)
	""" CXAvailability_Deprecated
	@doc raw"""
	The entity is not available; any use of it will be an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:144:3)
	""" CXAvailability_NotAvailable
	@doc raw"""
	Describes the availability of a particular entity, which indicates
	whether the use of this entity will result in a warning or error due to
	it being deprecated or unavailable.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:131:6)
	""" CXAvailabilityKind
	@doc raw"""
	The entity is available, but not accessible; any use of it will be
	an error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:149:3)
	""" CXAvailability_NotAccessible
	@doc raw"""
	The entity is available.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:135:3)
	""" CXAvailability_Available
	export CXAvailabilityKind, CXAvailability_Available, CXAvailability_Deprecated, CXAvailability_NotAccessible, CXAvailability_NotAvailable
	@cenum CXAvailabilityKind {
		CXAvailability_Available = (@Cuint)(0)
		CXAvailability_Deprecated = (@Cuint)(1)
		CXAvailability_NotAvailable = (@Cuint)(2)
		CXAvailability_NotAccessible = (@Cuint)(3)
	}
	
	@doc raw"""
	Describes a version number of the form major.minor.subminor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:155:16)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:173:3)
	""" CXVersion
	export CXVersion
	@ctypedef CXVersion @cstruct CXVersion {
		Major::@Cint
		Minor::@Cint
		Subminor::@Cint
	}
	
	@doc raw"""
	The cursor has exception specification basic noexcept.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:204:3)
	""" CXCursor_ExceptionSpecificationKind_BasicNoexcept
	@doc raw"""
	The cursor has exception specification throw(...).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:199:3)
	""" CXCursor_ExceptionSpecificationKind_MSAny
	@doc raw"""
	The cursor has exception specification throw(T1, T2)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:194:3)
	""" CXCursor_ExceptionSpecificationKind_Dynamic
	@doc raw"""
	The cursor has exception specification throw()
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:189:3)
	""" CXCursor_ExceptionSpecificationKind_DynamicNone
	@doc raw"""
	The cursor has exception specification computed noexcept.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:209:3)
	""" CXCursor_ExceptionSpecificationKind_ComputedNoexcept
	@doc raw"""
	The cursor has no exception specification.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:184:3)
	""" CXCursor_ExceptionSpecificationKind_None
	@doc raw"""
	The exception specification has not yet been evaluated.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:214:3)
	""" CXCursor_ExceptionSpecificationKind_Unevaluated
	@doc raw"""
	The exception specification has not yet been instantiated.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:219:3)
	""" CXCursor_ExceptionSpecificationKind_Uninstantiated
	@doc raw"""
	The exception specification has not been parsed yet.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:224:3)
	""" CXCursor_ExceptionSpecificationKind_Unparsed
	@doc raw"""
	Describes the exception specification of a cursor.
	
	A negative value indicates that the cursor is not a function declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:180:6)
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
	Provides a shared context for creating translation units.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:267:24)
	""" clang_createIndex
	export clang_createIndex
	@cextern clang_createIndex(excludeDeclarationsFromPCH::(@Cint), displayDiagnostics::(@Cint))::CXIndex
	
	@doc raw"""
	Destroy the given index.
	
	The index must not be destroyed until all of the translation units created
	within that index have been destroyed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:276:21)
	""" clang_disposeIndex
	export clang_disposeIndex
	@cextern clang_disposeIndex(index::CXIndex)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:310:3)
	""" CXGlobalOptFlags
	@doc raw"""
	Used to indicate that threads that libclang creates for editing
	purposes should use background priority.
	
	Affects #clang_reparseTranslationUnit, #clang_codeCompleteAt,
	#clang_annotateTokens
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:300:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForEditing
	@doc raw"""
	Used to indicate that threads that libclang creates for indexing
	purposes should use background priority.
	
	Affects #clang_indexSourceFile, #clang_indexTranslationUnit,
	#clang_parseTranslationUnit, #clang_saveTranslationUnit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:291:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForIndexing
	@doc raw"""
	Used to indicate that all threads that libclang creates should use
	background priority.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:306:3)
	""" CXGlobalOpt_ThreadBackgroundPriorityForAll
	@doc raw"""
	Used to indicate that no special CXIndex options are needed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:282:3)
	""" CXGlobalOpt_None
	export CXGlobalOptFlags, CXGlobalOpt_None, CXGlobalOpt_ThreadBackgroundPriorityForAll, CXGlobalOpt_ThreadBackgroundPriorityForEditing, CXGlobalOpt_ThreadBackgroundPriorityForIndexing
	@ctypedef CXGlobalOptFlags @cenum {
		CXGlobalOpt_None = (@Cuint)(0)
		CXGlobalOpt_ThreadBackgroundPriorityForIndexing = (@Cuint)(1)
		CXGlobalOpt_ThreadBackgroundPriorityForEditing = (@Cuint)(2)
		CXGlobalOpt_ThreadBackgroundPriorityForAll = (@Cuint)(3)
	}
	
	@doc raw"""
	Sets general options associated with a CXIndex.
	
	For example:
	\\code
	CXIndex idx = ...;
	clang_CXIndex_setGlobalOptions(idx,
	clang_CXIndex_getGlobalOptions(idx) |
	CXGlobalOpt_ThreadBackgroundPriorityForIndexing);
	\\endcode
	
	\\param options A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:325:21)
	""" clang_CXIndex_setGlobalOptions
	export clang_CXIndex_setGlobalOptions
	@cextern clang_CXIndex_setGlobalOptions(var"?1?"::CXIndex, options::(@Cuint))::@Cvoid
	
	@doc raw"""
	Gets the general options associated with a CXIndex.
	
	\\returns A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags that
	are associated with the given CXIndex object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:333:25)
	""" clang_CXIndex_getGlobalOptions
	export clang_CXIndex_getGlobalOptions
	@cextern clang_CXIndex_getGlobalOptions(var"?1?"::CXIndex)::@Cuint
	
	@doc raw"""
	Sets the invocation emission path option in a CXIndex.
	
	The invocation emission path specifies a path which will contain log
	files for certain libclang invocations. A null value (default) implies that
	libclang invocations are not logged..
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:343:1)
	""" clang_CXIndex_setInvocationEmissionPathOption
	export clang_CXIndex_setInvocationEmissionPathOption
	@cextern clang_CXIndex_setInvocationEmissionPathOption(var"?1?"::CXIndex, Path::(@Ptr){(@Cconst)(@Cchar)})::@Cvoid
	
	@doc raw"""
	A particular source file that is part of a translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:354:15)
	""" CXFile
	export CXFile
	@ctypedef CXFile (@Ptr){@Cvoid}
	
	@doc raw"""
	Retrieve the complete file and path name of the given file.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:359:25)
	""" clang_getFileName
	export clang_getFileName
	@cextern clang_getFileName(SFile::CXFile)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:372:3)
	""" CXFileUniqueID
	export CXFileUniqueID
	@ctypedef CXFileUniqueID @cstruct {
		data::(@Culonglong)[3]
	}
	
	@doc raw"""
	Retrieve the unique ID for the given \\c file.
	
	\\param file the file to get the ID for.
	\\param outID stores the returned CXFileUniqueID.
	\\returns If there was a failure getting the unique ID, returns non-zero,
	otherwise returns 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:382:20)
	""" clang_getFileUniqueID
	export clang_getFileUniqueID
	@cextern clang_getFileUniqueID(file::CXFile, outID::(@Ptr){CXFileUniqueID})::@Cint
	
	@doc raw"""
	Determine whether the given header is guarded against
	multiple inclusions, either with the conventional
	\\#ifndef/\\#define/\\#endif macro guards or with \\#pragma once.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:390:1)
	""" clang_isFileMultipleIncludeGuarded
	export clang_isFileMultipleIncludeGuarded
	@cextern clang_isFileMultipleIncludeGuarded(tu::CXTranslationUnit, file::CXFile)::@Cuint
	
	@doc raw"""
	Retrieve a file handle within the given translation unit.
	
	\\param tu the translation unit
	
	\\param file_name the name of the file.
	
	\\returns the file handle for the named file in the translation unit \\p tu,
	or a NULL file handle if the file was not a part of this translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:402:23)
	""" clang_getFile
	export clang_getFile
	@cextern clang_getFile(tu::CXTranslationUnit, file_name::(@Ptr){(@Cconst)(@Cchar)})::CXFile
	
	@doc raw"""
	Retrieve the buffer associated with the given file.
	
	\\param tu the translation unit
	
	\\param file the file for which to retrieve the buffer.
	
	\\param size [out] if non-NULL, will be set to the size of the buffer.
	
	\\returns a pointer to the buffer in memory that holds the contents of
	\\p file, or a NULL pointer when the file is not loaded.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:417:28)
	""" clang_getFileContents
	export clang_getFileContents
	@cextern clang_getFileContents(tu::CXTranslationUnit, file::CXFile, size::(@Ptr){size_t})::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	Returns non-zero if the \\c file1 and \\c file2 point to the same file,
	or they are both NULL.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:424:20)
	""" clang_File_isEqual
	export clang_File_isEqual
	@cextern clang_File_isEqual(file1::CXFile, file2::CXFile)::@Cint
	
	@doc raw"""
	Returns the real path name of \\c file.
	
	An empty string may be returned. Use \\c clang_getFileName() in that case.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:431:25)
	""" clang_File_tryGetRealPathName
	export clang_File_tryGetRealPathName
	@cextern clang_File_tryGetRealPathName(file::CXFile)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:460:3)
	""" CXSourceLocation
	export CXSourceLocation
	@ctypedef CXSourceLocation @cstruct {
		ptr_data::((@Ptr){(@Cconst)(@Cvoid)})[2]
		int_data::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:472:3)
	""" CXSourceRange
	export CXSourceRange
	@ctypedef CXSourceRange @cstruct {
		ptr_data::((@Ptr){(@Cconst)(@Cvoid)})[2]
		begin_int_data::@Cuint
		end_int_data::@Cuint
	}
	
	@doc raw"""
	Retrieve a NULL (invalid) source location.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:477:33)
	""" clang_getNullLocation
	export clang_getNullLocation
	@cextern clang_getNullLocation()::CXSourceLocation
	
	@doc raw"""
	Determine whether two source locations, which must refer into
	the same translation unit, refer to exactly the same point in the source
	code.
	
	\\returns non-zero if the source locations refer to the same location, zero
	if they refer to different locations.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:487:25)
	""" clang_equalLocations
	export clang_equalLocations
	@cextern clang_equalLocations(loc1::CXSourceLocation, loc2::CXSourceLocation)::@Cuint
	
	@doc raw"""
	Retrieves the source location associated with a given file/line/column
	in a particular translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:494:33)
	""" clang_getLocation
	export clang_getLocation
	@cextern clang_getLocation(tu::CXTranslationUnit, file::CXFile, line::(@Cuint), column::(@Cuint))::CXSourceLocation
	
	@doc raw"""
	Retrieves the source location associated with a given character offset
	in a particular translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:502:33)
	""" clang_getLocationForOffset
	export clang_getLocationForOffset
	@cextern clang_getLocationForOffset(tu::CXTranslationUnit, file::CXFile, offset::(@Cuint))::CXSourceLocation
	
	@doc raw"""
	Returns non-zero if the given source location is in a system header.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:509:20)
	""" clang_Location_isInSystemHeader
	export clang_Location_isInSystemHeader
	@cextern clang_Location_isInSystemHeader(location::CXSourceLocation)::@Cint
	
	@doc raw"""
	Returns non-zero if the given source location is in the main file of
	the corresponding translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:515:20)
	""" clang_Location_isFromMainFile
	export clang_Location_isFromMainFile
	@cextern clang_Location_isFromMainFile(location::CXSourceLocation)::@Cint
	
	@doc raw"""
	Retrieve a NULL (invalid) source range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:520:30)
	""" clang_getNullRange
	export clang_getNullRange
	@cextern clang_getNullRange()::CXSourceRange
	
	@doc raw"""
	Retrieve a source range given the beginning and ending source
	locations.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:526:30)
	""" clang_getRange
	export clang_getRange
	@cextern clang_getRange(var"begin"::CXSourceLocation, var"end"::CXSourceLocation)::CXSourceRange
	
	@doc raw"""
	Determine whether two ranges are equivalent.
	
	\\returns non-zero if the ranges are the same, zero if they differ.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:534:25)
	""" clang_equalRanges
	export clang_equalRanges
	@cextern clang_equalRanges(range1::CXSourceRange, range2::CXSourceRange)::@Cuint
	
	@doc raw"""
	Returns non-zero if \\p range is null.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:540:20)
	""" clang_Range_isNull
	export clang_Range_isNull
	@cextern clang_Range_isNull(range::CXSourceRange)::@Cint
	
	@doc raw"""
	Retrieve the file, line, column, and offset represented by
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:564:21)
	""" clang_getExpansionLocation
	export clang_getExpansionLocation
	@cextern clang_getExpansionLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Retrieve the file, line and column represented by the given source
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:610:21)
	""" clang_getPresumedLocation
	export clang_getPresumedLocation
	@cextern clang_getPresumedLocation(location::CXSourceLocation, filename::(@Ptr){CXString}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Legacy API to retrieve the file, line, column, and offset represented
	by the given source location.
	
	This interface has been replaced by the newer interface
	#clang_getExpansionLocation(). See that interface's documentation for
	details.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:623:21)
	""" clang_getInstantiationLocation
	export clang_getInstantiationLocation
	@cextern clang_getInstantiationLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Retrieve the file, line, column, and offset represented by
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:651:21)
	""" clang_getSpellingLocation
	export clang_getSpellingLocation
	@cextern clang_getSpellingLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Retrieve the file, line, column, and offset represented by
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:680:21)
	""" clang_getFileLocation
	export clang_getFileLocation
	@cextern clang_getFileLocation(location::CXSourceLocation, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Retrieve a source location representing the first character within a
	source range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:690:33)
	""" clang_getRangeStart
	export clang_getRangeStart
	@cextern clang_getRangeStart(range::CXSourceRange)::CXSourceLocation
	
	@doc raw"""
	Retrieve a source location representing the last character within a
	source range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:696:33)
	""" clang_getRangeEnd
	export clang_getRangeEnd
	@cextern clang_getRangeEnd(range::CXSourceRange)::CXSourceLocation
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:708:3)
	""" CXSourceRangeList
	export CXSourceRangeList
	@ctypedef CXSourceRangeList @cstruct {
		count::@Cuint
		ranges::(@Ptr){CXSourceRange}
	}
	
	@doc raw"""
	Retrieve all ranges that were skipped by the preprocessor.
	
	The preprocessor will skip lines when they are surrounded by an
	if/ifdef/ifndef directive whose condition does not evaluate to true.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:716:35)
	""" clang_getSkippedRanges
	export clang_getSkippedRanges
	@cextern clang_getSkippedRanges(tu::CXTranslationUnit, file::CXFile)::(@Ptr){CXSourceRangeList}
	
	@doc raw"""
	Retrieve all ranges from all files that were skipped by the
	preprocessor.
	
	The preprocessor will skip lines when they are surrounded by an
	if/ifdef/ifndef directive whose condition does not evaluate to true.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:726:35)
	""" clang_getAllSkippedRanges
	export clang_getAllSkippedRanges
	@cextern clang_getAllSkippedRanges(tu::CXTranslationUnit)::(@Ptr){CXSourceRangeList}
	
	@doc raw"""
	Destroy the given \\c CXSourceRangeList.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:731:21)
	""" clang_disposeSourceRangeList
	export clang_disposeSourceRangeList
	@cextern clang_disposeSourceRangeList(ranges::(@Ptr){CXSourceRangeList})::@Cvoid
	
	@doc raw"""
	Describes the severity of a particular diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:746:6)
	""" CXDiagnosticSeverity
	@doc raw"""
	This diagnostic is a note that should be attached to the
	previous (non-note) diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:757:3)
	""" CXDiagnostic_Note
	@doc raw"""
	This diagnostic indicates that the code is ill-formed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:768:3)
	""" CXDiagnostic_Error
	@doc raw"""
	A diagnostic that has been suppressed, e.g., by a command-line
	option.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:751:3)
	""" CXDiagnostic_Ignored
	@doc raw"""
	This diagnostic indicates suspicious code that may not be
	wrong.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:763:3)
	""" CXDiagnostic_Warning
	@doc raw"""
	This diagnostic indicates that the code is ill-formed such
	that future parser recovery is unlikely to produce useful
	results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:775:3)
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
	A single diagnostic, containing the diagnostic's severity,
	location, text, source ranges, and fix-it hints.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:782:15)
	""" CXDiagnostic
	export CXDiagnostic
	@ctypedef CXDiagnostic (@Ptr){@Cvoid}
	
	@doc raw"""
	A group of CXDiagnostics.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:787:15)
	""" CXDiagnosticSet
	export CXDiagnosticSet
	@ctypedef CXDiagnosticSet (@Ptr){@Cvoid}
	
	@doc raw"""
	Determine the number of diagnostics in a CXDiagnosticSet.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:792:25)
	""" clang_getNumDiagnosticsInSet
	export clang_getNumDiagnosticsInSet
	@cextern clang_getNumDiagnosticsInSet(Diags::CXDiagnosticSet)::@Cuint
	
	@doc raw"""
	Retrieve a diagnostic associated with the given CXDiagnosticSet.
	
	\\param Diags the CXDiagnosticSet to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:803:29)
	""" clang_getDiagnosticInSet
	export clang_getDiagnosticInSet
	@cextern clang_getDiagnosticInSet(Diags::CXDiagnosticSet, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	Indicates that no error occurred.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:814:3)
	""" CXLoadDiag_None
	@doc raw"""
	Describes the kind of error that occurred (if any) in a call to
	\\c clang_loadDiagnostics.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:810:6)
	""" CXLoadDiag_Error
	@doc raw"""
	Indicates that the serialized diagnostics file is invalid or
	corrupt.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:832:3)
	""" CXLoadDiag_InvalidFile
	@doc raw"""
	Indicates that an unknown error occurred while attempting to
	deserialize diagnostics.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:820:3)
	""" CXLoadDiag_Unknown
	@doc raw"""
	Indicates that the file containing the serialized diagnostics
	could not be opened.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:826:3)
	""" CXLoadDiag_CannotLoad
	export CXLoadDiag_CannotLoad, CXLoadDiag_Error, CXLoadDiag_InvalidFile, CXLoadDiag_None, CXLoadDiag_Unknown
	@cenum CXLoadDiag_Error {
		CXLoadDiag_None = (@Cuint)(0)
		CXLoadDiag_Unknown = (@Cuint)(1)
		CXLoadDiag_CannotLoad = (@Cuint)(2)
		CXLoadDiag_InvalidFile = (@Cuint)(3)
	}
	
	@doc raw"""
	Deserialize a set of diagnostics from a Clang diagnostics bitcode
	file.
	
	\\param file The name of the file to deserialize.
	\\param error A pointer to a enum value recording if there was a problem
	deserializing the diagnostics.
	\\param errorString A pointer to a CXString for recording the error string
	if the file was not successfully loaded.
	
	\\returns A loaded CXDiagnosticSet if successful, and NULL otherwise.  These
	diagnostics should be released using clang_disposeDiagnosticSet().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:848:32)
	""" clang_loadDiagnostics
	export clang_loadDiagnostics
	@cextern clang_loadDiagnostics(file::(@Ptr){(@Cconst)(@Cchar)}, error::(@Ptr){CXLoadDiag_Error}, errorString::(@Ptr){CXString})::CXDiagnosticSet
	
	@doc raw"""
	Release a CXDiagnosticSet and all of its contained diagnostics.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:855:21)
	""" clang_disposeDiagnosticSet
	export clang_disposeDiagnosticSet
	@cextern clang_disposeDiagnosticSet(Diags::CXDiagnosticSet)::@Cvoid
	
	@doc raw"""
	Retrieve the child diagnostics of a CXDiagnostic.
	
	This CXDiagnosticSet does not need to be released by
	clang_disposeDiagnosticSet.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:863:32)
	""" clang_getChildDiagnostics
	export clang_getChildDiagnostics
	@cextern clang_getChildDiagnostics(D::CXDiagnostic)::CXDiagnosticSet
	
	@doc raw"""
	Determine the number of diagnostics produced for the given
	translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:869:25)
	""" clang_getNumDiagnostics
	export clang_getNumDiagnostics
	@cextern clang_getNumDiagnostics(Unit::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	Retrieve a diagnostic associated with the given translation unit.
	
	\\param Unit the translation unit to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:880:29)
	""" clang_getDiagnostic
	export clang_getDiagnostic
	@cextern clang_getDiagnostic(Unit::CXTranslationUnit, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	Retrieve the complete set of diagnostics associated with a
	translation unit.
	
	\\param Unit the translation unit to query.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:890:3)
	""" clang_getDiagnosticSetFromTU
	export clang_getDiagnosticSetFromTU
	@cextern clang_getDiagnosticSetFromTU(Unit::CXTranslationUnit)::CXDiagnosticSet
	
	@doc raw"""
	Destroy a diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:895:21)
	""" clang_disposeDiagnostic
	export clang_disposeDiagnostic
	@cextern clang_disposeDiagnostic(Diagnostic::CXDiagnostic)::@Cvoid
	
	@doc raw"""
	Options to control the display of diagnostics.
	
	The values in this enum are meant to be combined to customize the
	behavior of \\c clang_formatDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:903:6)
	""" CXDiagnosticDisplayOptions
	@doc raw"""
	Display the source-location information where the
	diagnostic was located.
	
	When set, diagnostics will be prefixed by the file, line, and
	(optionally) column to which the diagnostic refers. For example,
	
	\\code
	test.c:28: warning: extra tokens at end of #endif directive
	\\endcode
	
	This option corresponds to the clang flag \\c -fshow-source-location.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:917:3)
	""" CXDiagnostic_DisplaySourceLocation
	@doc raw"""
	If displaying the source-location information of the
	diagnostic, also include the column number.
	
	This option corresponds to the clang flag \\c -fshow-column.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:925:3)
	""" CXDiagnostic_DisplayColumn
	@doc raw"""
	Display the option name associated with this diagnostic, if any.
	
	The option name displayed (e.g., -Wconversion) will be placed in brackets
	after the diagnostic text. This option corresponds to the clang flag
	\\c -fdiagnostics-show-option.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:944:3)
	""" CXDiagnostic_DisplayOption
	@doc raw"""
	Display the category number associated with this diagnostic, if any.
	
	The category number is displayed within brackets after the diagnostic text.
	This option corresponds to the clang flag
	\\c -fdiagnostics-show-category=id.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:953:3)
	""" CXDiagnostic_DisplayCategoryId
	@doc raw"""
	If displaying the source-location information of the
	diagnostic, also include information about source ranges in a
	machine-parsable format.
	
	This option corresponds to the clang flag
	\\c -fdiagnostics-print-source-range-info.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:935:3)
	""" CXDiagnostic_DisplaySourceRanges
	@doc raw"""
	Display the category name associated with this diagnostic, if any.
	
	The category name is displayed within brackets after the diagnostic text.
	This option corresponds to the clang flag
	\\c -fdiagnostics-show-category=name.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:962:3)
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
	Format the given diagnostic in a manner that is suitable for display.
	
	This routine will format the given diagnostic to a string, rendering
	the diagnostic according to the various options given. The
	\\c clang_defaultDiagnosticDisplayOptions() function returns the set of
	options that most closely mimics the behavior of the clang compiler.
	
	\\param Diagnostic The diagnostic to print.
	
	\\param Options A set of options that control the diagnostic display,
	created by combining \\c CXDiagnosticDisplayOptions values.
	
	\\returns A new string containing for formatted diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:980:25)
	""" clang_formatDiagnostic
	export clang_formatDiagnostic
	@cextern clang_formatDiagnostic(Diagnostic::CXDiagnostic, Options::(@Cuint))::CXString
	
	@doc raw"""
	Retrieve the set of display options most similar to the
	default behavior of the clang compiler.
	
	\\returns A set of display options suitable for use with \\c
	clang_formatDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:990:25)
	""" clang_defaultDiagnosticDisplayOptions
	export clang_defaultDiagnosticDisplayOptions
	@cextern clang_defaultDiagnosticDisplayOptions()::@Cuint
	
	@doc raw"""
	Determine the severity of the given diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:996:1)
	""" clang_getDiagnosticSeverity
	export clang_getDiagnosticSeverity
	@cextern clang_getDiagnosticSeverity(var"?1?"::CXDiagnostic)::CXDiagnosticSeverity
	
	@doc raw"""
	Retrieve the source location of the given diagnostic.
	
	This location is where Clang would print the caret ('^') when
	displaying the diagnostic on the command line.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1004:33)
	""" clang_getDiagnosticLocation
	export clang_getDiagnosticLocation
	@cextern clang_getDiagnosticLocation(var"?1?"::CXDiagnostic)::CXSourceLocation
	
	@doc raw"""
	Retrieve the text of the given diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1009:25)
	""" clang_getDiagnosticSpelling
	export clang_getDiagnosticSpelling
	@cextern clang_getDiagnosticSpelling(var"?1?"::CXDiagnostic)::CXString
	
	@doc raw"""
	Retrieve the name of the command-line option that enabled this
	diagnostic.
	
	\\param Diag The diagnostic to be queried.
	
	\\param Disable If non-NULL, will be set to the option that disables this
	diagnostic (if any).
	
	\\returns A string that contains the command-line option used to enable this
	warning, such as "-Wconversion" or "-pedantic".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1023:25)
	""" clang_getDiagnosticOption
	export clang_getDiagnosticOption
	@cextern clang_getDiagnosticOption(Diag::CXDiagnostic, Disable::(@Ptr){CXString})::CXString
	
	@doc raw"""
	Retrieve the category number for this diagnostic.
	
	Diagnostics can be categorized into groups along with other, related
	diagnostics (e.g., diagnostics under the same warning flag). This routine
	retrieves the category number for the given diagnostic.
	
	\\returns The number of the category that contains this diagnostic, or zero
	if this diagnostic is uncategorized.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1036:25)
	""" clang_getDiagnosticCategory
	export clang_getDiagnosticCategory
	@cextern clang_getDiagnosticCategory(var"?1?"::CXDiagnostic)::@Cuint
	
	@doc raw"""
	Retrieve the name of a particular diagnostic category.  This
	is now deprecated.  Use clang_getDiagnosticCategoryText()
	instead.
	
	\\param Category A diagnostic category number, as returned by
	\\c clang_getDiagnosticCategory().
	
	\\returns The name of the given diagnostic category.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1049:10)
	""" clang_getDiagnosticCategoryName
	export clang_getDiagnosticCategoryName
	@cextern clang_getDiagnosticCategoryName(Category::@Cuint)::CXString
	
	@doc raw"""
	Retrieve the diagnostic category text for a given diagnostic.
	
	\\returns The text of the given diagnostic category.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1056:25)
	""" clang_getDiagnosticCategoryText
	export clang_getDiagnosticCategoryText
	@cextern clang_getDiagnosticCategoryText(var"?1?"::CXDiagnostic)::CXString
	
	@doc raw"""
	Determine the number of source ranges associated with the given
	diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1062:25)
	""" clang_getDiagnosticNumRanges
	export clang_getDiagnosticNumRanges
	@cextern clang_getDiagnosticNumRanges(var"?1?"::CXDiagnostic)::@Cuint
	
	@doc raw"""
	Retrieve a source range associated with the diagnostic.
	
	A diagnostic's source ranges highlight important elements in the source
	code. On the command line, Clang displays source ranges by
	underlining them with '~' characters.
	
	\\param Diagnostic the diagnostic whose range is being extracted.
	
	\\param Range the zero-based index specifying which range to
	
	\\returns the requested source range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1077:30)
	""" clang_getDiagnosticRange
	export clang_getDiagnosticRange
	@cextern clang_getDiagnosticRange(Diagnostic::CXDiagnostic, Range::(@Cuint))::CXSourceRange
	
	@doc raw"""
	Determine the number of fix-it hints associated with the
	given diagnostic.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1084:25)
	""" clang_getDiagnosticNumFixIts
	export clang_getDiagnosticNumFixIts
	@cextern clang_getDiagnosticNumFixIts(Diagnostic::CXDiagnostic)::@Cuint
	
	@doc raw"""
	Retrieve the replacement information for a given fix-it.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1111:25)
	""" clang_getDiagnosticFixIt
	export clang_getDiagnosticFixIt
	@cextern clang_getDiagnosticFixIt(Diagnostic::CXDiagnostic, FixIt::(@Cuint), ReplacementRange::(@Ptr){CXSourceRange})::CXString
	
	@doc raw"""
	Get the original translation unit source file name.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1133:1)
	""" clang_getTranslationUnitSpelling
	export clang_getTranslationUnitSpelling
	@cextern clang_getTranslationUnitSpelling(CTUnit::CXTranslationUnit)::CXString
	
	@doc raw"""
	Return the CXTranslationUnit for a given source file and the provided
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1175:34)
	""" clang_createTranslationUnitFromSourceFile
	export clang_createTranslationUnitFromSourceFile
	@cextern clang_createTranslationUnitFromSourceFile(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, num_clang_command_line_args::(@Cint), clang_command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_unsaved_files::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile})::CXTranslationUnit
	
	@doc raw"""
	Same as \\c clang_createTranslationUnit2, but returns
	the \\c CXTranslationUnit instead of an error code.  In case of an error this
	routine returns a \\c NULL \\c CXTranslationUnit, without further detailed
	error codes.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1189:34)
	""" clang_createTranslationUnit
	export clang_createTranslationUnit
	@cextern clang_createTranslationUnit(CIdx::CXIndex, ast_filename::(@Ptr){(@Cconst)(@Cchar)})::CXTranslationUnit
	
	@doc raw"""
	Create a translation unit from an AST file (\\c -emit-ast).
	
	\\param[out] out_TU A non-NULL pointer to store the created
	\\c CXTranslationUnit.
	
	\\returns Zero on success, otherwise returns an error code.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1201:33)
	""" clang_createTranslationUnit2
	export clang_createTranslationUnit2
	@cextern clang_createTranslationUnit2(CIdx::CXIndex, ast_filename::(@Ptr){(@Cconst)(@Cchar)}, out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	Used to indicate that no special translation-unit options are
	needed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1218:3)
	""" CXTranslationUnit_None
	@doc raw"""
	DEPRECATED: Enabled chained precompiled preambles in C++.
	
	Note: this is a *temporary* option that is available only while
	we are testing C++ precompiled preamble support. It is deprecated.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1286:3)
	""" CXTranslationUnit_CXXChainedPCH
	@doc raw"""
	Used to indicate that attributed types should be included in CXType.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1339:3)
	""" CXTranslationUnit_IncludeAttributedTypes
	@doc raw"""
	Used to indicate that the parser should construct a "detailed"
	preprocessing record, including all macro definitions and instantiations.
	
	Constructing a detailed preprocessing record requires more memory
	and time to parse, since the information contained in the record
	is usually not retained. However, it can be useful for
	applications that require more detailed information about the
	behavior of the preprocessor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1230:3)
	""" CXTranslationUnit_DetailedPreprocessingRecord
	@doc raw"""
	Flags that control the creation of translation units.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	constructing the translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1213:6)
	""" CXTranslationUnit_Flags
	@doc raw"""
	Sets the preprocessor in a mode for parsing a single file only.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1326:3)
	""" CXTranslationUnit_SingleFileParse
	@doc raw"""
	Used to indicate that brief documentation comments should be
	included into the set of code completions returned from this translation
	unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1302:3)
	""" CXTranslationUnit_IncludeBriefCommentsInCodeCompletion
	@doc raw"""
	Used to indicate that the translation unit should cache some
	code-completion results with each reparse of the source file.
	
	Caching of code-completion results is a performance optimization that
	introduces some overhead to reparsing but improves the performance of
	code-completion operations.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1269:3)
	""" CXTranslationUnit_CacheCompletionResults
	@doc raw"""
	Used to indicate that the translation unit will be serialized with
	\\c clang_saveTranslationUnit.
	
	This option is typically used when parsing a header with the intent of
	producing a precompiled header.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1278:3)
	""" CXTranslationUnit_ForSerialization
	@doc raw"""
	Used to indicate that the translation unit should be built with an
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1259:3)
	""" CXTranslationUnit_PrecompiledPreamble
	@doc raw"""
	Used to indicate that implicit attributes should be visited.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1344:3)
	""" CXTranslationUnit_VisitImplicitAttributes
	@doc raw"""
	Used to indicate that function/method bodies should be skipped while
	parsing.
	
	This option can be used to search for declarations/definitions while
	ignoring the usages.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1295:3)
	""" CXTranslationUnit_SkipFunctionBodies
	@doc raw"""
	Used to indicate that the translation unit is incomplete.
	
	When a translation unit is considered "incomplete", semantic
	analysis that is typically performed at the end of the
	translation unit will be suppressed. For example, this suppresses
	the completion of tentative declarations in C and of
	instantiation of implicitly-instantiation function templates in
	C++. This option is typically used when parsing a header with the
	intent of producing a precompiled header.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1243:3)
	""" CXTranslationUnit_Incomplete
	@doc raw"""
	Do not stop processing when fatal errors are encountered.
	
	When fatal errors are encountered while parsing a translation unit,
	semantic analysis is typically stopped early when compiling code. A common
	source for fatal errors are unresolvable include files. For the
	purposes of an IDE, this is undesirable behavior and as much information
	as possible should be reported. Use this flag to enable this behavior.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1321:3)
	""" CXTranslationUnit_KeepGoing
	@doc raw"""
	Used to indicate that the precompiled preamble should be created on
	the first parse. Otherwise it will be created on the first reparse. This
	trades runtime on the first parse (serializing the preamble takes time) for
	reduced runtime on the second parse (can now reuse the preamble).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1310:3)
	""" CXTranslationUnit_CreatePreambleOnFirstParse
	@doc raw"""
	Used in combination with CXTranslationUnit_SkipFunctionBodies to
	constrain the skipping of function bodies to the preamble.
	
	The function bodies of the main file are not skipped.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1334:3)
	""" CXTranslationUnit_LimitSkipFunctionBodiesToPreamble
	export CXTranslationUnit_CXXChainedPCH, CXTranslationUnit_CacheCompletionResults, CXTranslationUnit_CreatePreambleOnFirstParse, CXTranslationUnit_DetailedPreprocessingRecord, CXTranslationUnit_Flags, CXTranslationUnit_ForSerialization, CXTranslationUnit_IncludeAttributedTypes, CXTranslationUnit_IncludeBriefCommentsInCodeCompletion, CXTranslationUnit_Incomplete, CXTranslationUnit_KeepGoing, CXTranslationUnit_LimitSkipFunctionBodiesToPreamble, CXTranslationUnit_None, CXTranslationUnit_PrecompiledPreamble, CXTranslationUnit_SingleFileParse, CXTranslationUnit_SkipFunctionBodies, CXTranslationUnit_VisitImplicitAttributes
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
		CXTranslationUnit_LimitSkipFunctionBodiesToPreamble = (@Cuint)(2048)
		CXTranslationUnit_IncludeAttributedTypes = (@Cuint)(4096)
		CXTranslationUnit_VisitImplicitAttributes = (@Cuint)(8192)
	}
	
	@doc raw"""
	Returns the set of flags that is suitable for parsing a translation
	unit that is being edited.
	
	The set of flags returned provide options for \\c clang_parseTranslationUnit()
	to indicate that the translation unit is likely to be reparsed many times,
	either explicitly (via \\c clang_reparseTranslationUnit()) or implicitly
	(e.g., by code completion (\\c clang_codeCompletionAt())). The returned flag
	set contains an unspecified set of optimizations (e.g., the precompiled
	preamble) geared toward improving the performance of these routines. The
	set of optimizations enabled may change from one version to the next.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1359:25)
	""" clang_defaultEditingTranslationUnitOptions
	export clang_defaultEditingTranslationUnitOptions
	@cextern clang_defaultEditingTranslationUnitOptions()::@Cuint
	
	@doc raw"""
	Same as \\c clang_parseTranslationUnit2, but returns
	the \\c CXTranslationUnit instead of an error code.  In case of an error this
	routine returns a \\c NULL \\c CXTranslationUnit, without further detailed
	error codes.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1368:1)
	""" clang_parseTranslationUnit
	export clang_parseTranslationUnit
	@cextern clang_parseTranslationUnit(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint))::CXTranslationUnit
	
	@doc raw"""
	Parse the given source file and the translation unit corresponding
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1421:1)
	""" clang_parseTranslationUnit2
	export clang_parseTranslationUnit2
	@cextern clang_parseTranslationUnit2(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint), out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	Same as clang_parseTranslationUnit2 but requires a full command line
	for \\c command_line_args including argv[0]. This is useful if the standard
	library paths are relative to the binary.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1435:33)
	""" clang_parseTranslationUnit2FullArgv
	export clang_parseTranslationUnit2FullArgv
	@cextern clang_parseTranslationUnit2FullArgv(CIdx::CXIndex, source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint), out_TU::(@Ptr){CXTranslationUnit})::CXErrorCode
	
	@doc raw"""
	Flags that control how translation units are saved.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	saving the translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1448:6)
	""" CXSaveTranslationUnit_Flags
	@doc raw"""
	Used to indicate that no special saving options are needed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1452:3)
	""" CXSaveTranslationUnit_None
	export CXSaveTranslationUnit_Flags, CXSaveTranslationUnit_None
	@cenum CXSaveTranslationUnit_Flags {
		CXSaveTranslationUnit_None = (@Cuint)(0)
	}
	
	@doc raw"""
	Returns the set of flags that is suitable for saving a translation
	unit.
	
	The set of flags returned provide options for
	\\c clang_saveTranslationUnit() by default. The returned flag
	set contains an unspecified set of options that save translation units with
	the most commonly-requested data.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1464:25)
	""" clang_defaultSaveOptions
	export clang_defaultSaveOptions
	@cextern clang_defaultSaveOptions(TU::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	Indicates that no error occurred while saving a translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1474:3)
	""" CXSaveError_None
	@doc raw"""
	Indicates that errors during translation prevented this attempt
	to save the translation unit.
	
	Errors that prevent the translation unit from being saved can be
	extracted using \\c clang_getNumDiagnostics() and \\c clang_getDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1492:3)
	""" CXSaveError_TranslationErrors
	@doc raw"""
	Indicates that the translation unit to be saved was somehow
	invalid (e.g., NULL).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1498:3)
	""" CXSaveError_InvalidTU
	@doc raw"""
	Indicates that an unknown error occurred while attempting to save
	the file.
	
	This error typically indicates that file I/O failed when attempting to
	write the file.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1483:3)
	""" CXSaveError_Unknown
	@doc raw"""
	Describes the kind of error that occurred (if any) in a call to
	\\c clang_saveTranslationUnit().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1470:6)
	""" CXSaveError
	export CXSaveError, CXSaveError_InvalidTU, CXSaveError_None, CXSaveError_TranslationErrors, CXSaveError_Unknown
	@cenum CXSaveError {
		CXSaveError_None = (@Cuint)(0)
		CXSaveError_Unknown = (@Cuint)(1)
		CXSaveError_TranslationErrors = (@Cuint)(2)
		CXSaveError_InvalidTU = (@Cuint)(3)
	}
	
	@doc raw"""
	Saves a translation unit into a serialized representation of
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1524:20)
	""" clang_saveTranslationUnit
	export clang_saveTranslationUnit
	@cextern clang_saveTranslationUnit(TU::CXTranslationUnit, FileName::(@Ptr){(@Cconst)(@Cchar)}, options::(@Cuint))::@Cint
	
	@doc raw"""
	Suspend a translation unit in order to free memory associated with it.
	
	A suspended translation unit uses significantly less memory but on the other
	side does not support any other calls than \\c clang_reparseTranslationUnit
	to resume it or \\c clang_disposeTranslationUnit to dispose it completely.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1535:25)
	""" clang_suspendTranslationUnit
	export clang_suspendTranslationUnit
	@cextern clang_suspendTranslationUnit(var"?1?"::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	Destroy the specified CXTranslationUnit object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1540:21)
	""" clang_disposeTranslationUnit
	export clang_disposeTranslationUnit
	@cextern clang_disposeTranslationUnit(var"?1?"::CXTranslationUnit)::@Cvoid
	
	@doc raw"""
	Used to indicate that no special reparsing options are needed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1553:3)
	""" CXReparse_None
	@doc raw"""
	Flags that control the reparsing of translation units.
	
	The enumerators in this enumeration type are meant to be bitwise
	ORed together to specify which options should be used when
	reparsing the translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1549:6)
	""" CXReparse_Flags
	export CXReparse_Flags, CXReparse_None
	@cenum CXReparse_Flags {
		CXReparse_None = (@Cuint)(0)
	}
	
	@doc raw"""
	Returns the set of flags that is suitable for reparsing a translation
	unit.
	
	The set of flags returned provide options for
	\\c clang_reparseTranslationUnit() by default. The returned flag
	set contains an unspecified set of optimizations geared toward common uses
	of reparsing. The set of optimizations enabled may change from one version
	to the next.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1566:25)
	""" clang_defaultReparseOptions
	export clang_defaultReparseOptions
	@cextern clang_defaultReparseOptions(TU::CXTranslationUnit)::@Cuint
	
	@doc raw"""
	Reparse the source files that produced this translation unit.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1607:20)
	""" clang_reparseTranslationUnit
	export clang_reparseTranslationUnit
	@cextern clang_reparseTranslationUnit(TU::CXTranslationUnit, num_unsaved_files::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile}, options::(@Cuint))::@Cint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1619:3)
	""" CXTUResourceUsage_GlobalCompletionResults
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1623:3)
	""" CXTUResourceUsage_SourceManager_Membuffer_MMap
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1630:3)
	""" CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1616:3)
	""" CXTUResourceUsage_AST
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1628:3)
	""" CXTUResourceUsage_SourceManager_DataStructures
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1635:3)
	""" CXTUResourceUsage_Last
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1627:3)
	""" CXTUResourceUsage_PreprocessingRecord
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1622:3)
	""" CXTUResourceUsage_SourceManager_Membuffer_Malloc
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1620:3)
	""" CXTUResourceUsage_SourceManagerContentCache
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1617:3)
	""" CXTUResourceUsage_Identifiers
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1621:3)
	""" CXTUResourceUsage_AST_SideTables
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1625:3)
	""" CXTUResourceUsage_ExternalASTSource_Membuffer_MMap
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1618:3)
	""" CXTUResourceUsage_Selectors
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1626:3)
	""" CXTUResourceUsage_Preprocessor
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1629:3)
	""" CXTUResourceUsage_Preprocessor_HeaderSearch
	@doc raw"""
	Categorizes how memory is being used by a translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1615:6)
	""" CXTUResourceUsageKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1631:3)
	""" CXTUResourceUsage_MEMORY_IN_BYTES_END
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1634:3)
	""" CXTUResourceUsage_First
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1624:3)
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
	Returns the human-readable null-terminated C string that represents
	the name of the memory category.  This string should never be freed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1643:13)
	""" clang_getTUResourceUsageName
	export clang_getTUResourceUsageName
	@cextern clang_getTUResourceUsageName(kind::CXTUResourceUsageKind)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1645:16)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1651:3)
	""" CXTUResourceUsageEntry
	export CXTUResourceUsageEntry
	@ctypedef CXTUResourceUsageEntry @cstruct CXTUResourceUsageEntry {
		kind::CXTUResourceUsageKind
		amount::@Culong
	}
	
	@doc raw"""
	The memory usage of a CXTranslationUnit, broken into categories.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1656:16)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1667:3)
	""" CXTUResourceUsage
	export CXTUResourceUsage
	@ctypedef CXTUResourceUsage @cstruct CXTUResourceUsage {
		data::(@Ptr){@Cvoid}
		numEntries::@Cuint
		entries::(@Ptr){CXTUResourceUsageEntry}
	}
	
	@doc raw"""
	Return the memory usage of a translation unit.  This object
	should be released with clang_disposeCXTUResourceUsage().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1673:34)
	""" clang_getCXTUResourceUsage
	export clang_getCXTUResourceUsage
	@cextern clang_getCXTUResourceUsage(TU::CXTranslationUnit)::CXTUResourceUsage
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1675:21)
	""" clang_disposeCXTUResourceUsage
	export clang_disposeCXTUResourceUsage
	@cextern clang_disposeCXTUResourceUsage(usage::CXTUResourceUsage)::@Cvoid
	
	@doc raw"""
	Get target information for this translation unit.
	
	The CXTargetInfo object cannot outlive the CXTranslationUnit object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1683:1)
	""" clang_getTranslationUnitTargetInfo
	export clang_getTranslationUnitTargetInfo
	@cextern clang_getTranslationUnitTargetInfo(CTUnit::CXTranslationUnit)::CXTargetInfo
	
	@doc raw"""
	Destroy the CXTargetInfo object.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1689:1)
	""" clang_TargetInfo_dispose
	export clang_TargetInfo_dispose
	@cextern clang_TargetInfo_dispose(Info::CXTargetInfo)::@Cvoid
	
	@doc raw"""
	Get the normalized target triple as a string.
	
	Returns the empty string in case of any error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1697:1)
	""" clang_TargetInfo_getTriple
	export clang_TargetInfo_getTriple
	@cextern clang_TargetInfo_getTriple(Info::CXTargetInfo)::CXString
	
	@doc raw"""
	Get the pointer width of the target in bits.
	
	Returns -1 in case of error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1705:1)
	""" clang_TargetInfo_getPointerWidth
	export clang_TargetInfo_getPointerWidth
	@cextern clang_TargetInfo_getPointerWidth(Info::CXTargetInfo)::@Cint
	
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2559:3)
	""" CXCursor_PackedAttr
	@doc raw"""
	OpenMP target teams distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2528:3)
	""" CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2553:3)
	""" CXCursor_IBOutletAttr
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1812:3)
	""" CXCursor_ObjCProtocolRef
	@doc raw"""
	OpenMP atomic directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2412:3)
	""" CXCursor_OMPAtomicDirective
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1807:3)
	""" CXCursor_LastDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2598:3)
	""" CXCursor_LastPreprocessing
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2572:3)
	""" CXCursor_NSReturnsNotRetained
	@doc raw"""
	OpenMP taskgroup directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2432:3)
	""" CXCursor_OMPTaskgroupDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2578:3)
	""" CXCursor_ObjCIndependentClass
	@doc raw"""
	A module import declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2605:3)
	""" CXCursor_TypeAliasTemplateDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2588:3)
	""" CXCursor_FlagEnum
	@doc raw"""
	A C++ template template parameter. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1784:3)
	""" CXCursor_TemplateTemplateParameter
	@doc raw"""
	Describes the kind of entity that a cursor refers to.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1714:6)
	""" CXCursorKind
	@doc raw"""
	A typedef. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1766:3)
	""" CXCursor_TypedefDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2587:3)
	""" CXCursor_ObjCBoxable
	@doc raw"""
	C++'s const_cast<> expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2051:3)
	""" CXCursor_CXXConstCastExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2583:3)
	""" CXCursor_ObjCSubclassingRestricted
	@doc raw"""
	OpenMP parallel directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2344:3)
	""" CXCursor_OMPParallelDirective
	@doc raw"""
	OpenMP flush directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2400:3)
	""" CXCursor_OMPFlushDirective
	@doc raw"""
	A floating point number literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1958:3)
	""" CXCursor_FloatingLiteral
	@doc raw"""
	A parenthesized expression, e.g. "(1)".
	
	This AST node is only formed if full location information is requested.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1976:3)
	""" CXCursor_ParenExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2596:3)
	""" CXCursor_InclusionDirective
	@doc raw"""
	A reference to a namespace or namespace alias.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1839:3)
	""" CXCursor_NamespaceRef
	@doc raw"""
	OpenMP teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2504:3)
	""" CXCursor_OMPTeamsDistributeSimdDirective
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1813:3)
	""" CXCursor_ObjCClassRef
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1914:3)
	""" CXCursor_LastInvalid
	@doc raw"""
	OpenMP for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2352:3)
	""" CXCursor_OMPForDirective
	@doc raw"""
	A builtin binary operation expression such as "x + y" or
	"x <= y".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1990:3)
	""" CXCursor_BinaryOperator
	@doc raw"""
	OpenMP taskyield directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2388:3)
	""" CXCursor_OMPTaskyieldDirective
	@doc raw"""
	A character literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1970:3)
	""" CXCursor_CharacterLiteral
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1904:3)
	""" CXCursor_VariableRef
	@doc raw"""
	OpenMP barrier directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2392:3)
	""" CXCursor_OMPBarrierDirective
	@doc raw"""
	An expression that refers to some value declaration, such
	as a function, variable, or enumerator.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1934:3)
	""" CXCursor_DeclRefExpr
	@doc raw"""
	C++'s try statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2309:3)
	""" CXCursor_CXXTryStmt
	@doc raw"""
	A new expression for memory allocation and constructor calls, e.g:
	"new CXXNewExpr(foo)".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2089:3)
	""" CXCursor_CXXNewExpr
	@doc raw"""
	An integer literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1954:3)
	""" CXCursor_IntegerLiteral
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1911:3)
	""" CXCursor_NoDeclFound
	@doc raw"""
	An Objective-C \\@selector expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2110:3)
	""" CXCursor_ObjCSelectorExpr
	@doc raw"""
	This is the GNU Statement Expression extension: ({int X=4; X;})
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2021:3)
	""" CXCursor_StmtExpr
	@doc raw"""
	An Objective-C \\@protocol expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2114:3)
	""" CXCursor_ObjCProtocolExpr
	@doc raw"""
	Fixed point literal
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2190:3)
	""" CXCursor_FirstStmt
	@doc raw"""
	C++'s dynamic_cast<> expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2043:3)
	""" CXCursor_CXXDynamicCastExpr
	@doc raw"""
	[C++ 15] C++ Throw Expression.
	
	This handles 'throw' and 'throw' assignment-expression. When
	assignment-expression isn't present, Op will be null.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2084:3)
	""" CXCursor_CXXThrowExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2589:3)
	""" CXCursor_LastAttr
	@doc raw"""
	An Objective-C instance method. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1758:3)
	""" CXCursor_ObjCInstanceMethodDecl
	@doc raw"""
	A default statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2228:3)
	""" CXCursor_DefaultStmt
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2586:3)
	""" CXCursor_ObjCRuntimeVisible
	@doc raw"""
	A C++ conversion function. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1778:3)
	""" CXCursor_ConversionFunction
	@doc raw"""
	A variable. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1744:3)
	""" CXCursor_VarDecl
	@doc raw"""
	[C++ 2.13.5] C++ Boolean Literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2069:3)
	""" CXCursor_CXXBoolLiteralExpr
	@doc raw"""
	A continue statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2260:3)
	""" CXCursor_ContinueStmt
	@doc raw"""
	OpenMP parallel sections directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2372:3)
	""" CXCursor_OMPParallelSectionsDirective
	@doc raw"""
	Objective-C's \\@synchronized statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2293:3)
	""" CXCursor_ObjCAtSynchronizedStmt
	@doc raw"""
	An Objective-C \\@interface. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1748:3)
	""" CXCursor_ObjCInterfaceDecl
	@doc raw"""
	A C++ using declaration. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1796:3)
	""" CXCursor_UsingDeclaration
	@doc raw"""
	A C++ class template. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1788:3)
	""" CXCursor_ClassTemplate
	@doc raw"""
	Objective-C's \\@catch statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2281:3)
	""" CXCursor_ObjCAtCatchStmt
	@doc raw"""
	Represents an explicit C++ type conversion that uses "functional"
	notion (C++ [expr.type.conv]).
	
	Example:
	\\code
	x = int(0.5);
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2061:3)
	""" CXCursor_CXXFunctionalCastExpr
	@doc raw"""
	C++'s catch statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2305:3)
	""" CXCursor_CXXCatchStmt
	@doc raw"""
	OpenMP target parallel directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2468:3)
	""" CXCursor_OMPTargetParallelDirective
	@doc raw"""
	An enumerator constant. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1740:3)
	""" CXCursor_EnumConstantDecl
	@doc raw"""
	A C++ function template. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1786:3)
	""" CXCursor_FunctionTemplate
	@doc raw"""
	Windows Structured Exception Handling's except statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2321:3)
	""" CXCursor_SEHExceptStmt
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2562:3)
	""" CXCursor_NoDuplicateAttr
	@doc raw"""
	An Objective-C string literal i.e. @"foo".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2102:3)
	""" CXCursor_ObjCStringLiteral
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2552:3)
	""" CXCursor_IBActionAttr
	@doc raw"""
	A labelled statement in a function.
	
	This cursor kind is used to describe the "start_over:" label statement in
	the following example:
	
	\\code
	start_over:
	++counter;
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2213:3)
	""" CXCursor_LabelStmt
	@doc raw"""
	A for statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2248:3)
	""" CXCursor_ForStmt
	@doc raw"""
	Represents the "this" expression in C++
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2077:3)
	""" CXCursor_CXXThisExpr
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2164:3)
	""" CXCursor_LambdaExpr
	@doc raw"""
	A string literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1966:3)
	""" CXCursor_StringLiteral
	@doc raw"""
	OpenMP target parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2492:3)
	""" CXCursor_OMPTargetParallelForSimdDirective
	@doc raw"""
	A goto statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2252:3)
	""" CXCursor_GotoStmt
	@doc raw"""
	A return statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2268:3)
	""" CXCursor_ReturnStmt
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2595:3)
	""" CXCursor_MacroInstantiation
	@doc raw"""
	Represents an @available(...) check.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2180:3)
	""" CXCursor_ObjCAvailabilityCheckExpr
	@doc raw"""
	OpenMP target teams directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2516:3)
	""" CXCursor_OMPTargetTeamsDirective
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1810:3)
	""" CXCursor_FirstRef
	@doc raw"""
	An expression that represents a block literal. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1950:3)
	""" CXCursor_BlockExpr
	@doc raw"""
	An explicit cast in C (C99 6.5.4) or a C-style cast in C++
	(C++ [expr.cast]), which uses the syntax (Type)expr.
	
	For example: (int)f.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2005:3)
	""" CXCursor_CStyleCastExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2579:3)
	""" CXCursor_ObjCPreciseLifetime
	@doc raw"""
	A module import declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2604:3)
	""" CXCursor_ModuleImportDecl
	@doc raw"""
	A code completion overload candidate.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2620:3)
	""" CXCursor_OverloadCandidate
	@doc raw"""
	A C++ using directive. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1794:3)
	""" CXCursor_UsingDirective
	@doc raw"""
	A reference to a type declaration.
	
	A type reference occurs anywhere where a type is named but not
	declared. For example, given:
	
	\\code
	typedef unsigned size_type;
	size_type size;
	\\endcode
	
	The typedef is a declaration of size_type (CXCursor_TypedefDecl),
	while the type of the variable "size" is referenced. The cursor
	referenced by the type of size is the typedef for size_type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1829:3)
	""" CXCursor_TypeRef
	@doc raw"""
	Adaptor class for mixing declarations with statements and
	expressions.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2340:3)
	""" CXCursor_DeclStmt
	@doc raw"""
	Represents the "self" expression in an Objective-C method.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2172:3)
	""" CXCursor_ObjCSelfExpr
	@doc raw"""
	An Objective-C \\@implementation for a category. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1764:3)
	""" CXCursor_ObjCCategoryImplDecl
	@doc raw"""
	OpenMP target exit data directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2464:3)
	""" CXCursor_OMPTargetExitDataDirective
	@doc raw"""
	A GCC inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2273:3)
	""" CXCursor_AsmStmt
	@doc raw"""
	An expression that sends a message to an Objective-C
	   object or class. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1947:3)
	""" CXCursor_ObjCMessageExpr
	@doc raw"""
	An indirect goto statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2256:3)
	""" CXCursor_IndirectGotoStmt
	@doc raw"""
	OpenMP single directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2364:3)
	""" CXCursor_OMPSingleDirective
	@doc raw"""
	OpenMP parallel for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2368:3)
	""" CXCursor_OMPParallelForDirective
	@doc raw"""
	Objective-C's \\@finally statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2285:3)
	""" CXCursor_ObjCAtFinallyStmt
	@doc raw"""
	OpenMP ordered directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2408:3)
	""" CXCursor_OMPOrderedDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2561:3)
	""" CXCursor_ConstAttr
	@doc raw"""
	C++'s for (* : *) statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2313:3)
	""" CXCursor_CXXForRangeStmt
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2570:3)
	""" CXCursor_DLLImport
	@doc raw"""
	A linkage specification, e.g. 'extern "C"'. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1772:3)
	""" CXCursor_LinkageSpec
	@doc raw"""
	OpenMP distribute simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2488:3)
	""" CXCursor_OMPDistributeSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2565:3)
	""" CXCursor_CUDAGlobalAttr
	@doc raw"""
	A C++ typeid expression (C++ [expr.typeid]).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2065:3)
	""" CXCursor_CXXTypeidExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2567:3)
	""" CXCursor_CUDASharedAttr
	@doc raw"""
	A unary expression. (noexcept, sizeof, or other traits)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2098:3)
	""" CXCursor_UnaryExpr
	@doc raw"""
	Cursor that represents the translation unit itself.
	
	The translation unit cursor exists primarily to act as the root
	cursor for traversing the contents of a translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2545:3)
	""" CXCursor_FirstAttr
	@doc raw"""
	Represents a C11 generic selection.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2025:3)
	""" CXCursor_GenericSelectionExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2584:3)
	""" CXCursor_ObjCExplicitProtocolImpl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2555:3)
	""" CXCursor_CXXFinalAttr
	@doc raw"""
	An Objective-C \\@synthesize definition. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1800:3)
	""" CXCursor_ObjCSynthesizeDecl
	@doc raw"""
	OpenMP distribute directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2456:3)
	""" CXCursor_OMPDistributeDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2585:3)
	""" CXCursor_ObjCDesignatedInitializer
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2568:3)
	""" CXCursor_VisibilityAttr
	@doc raw"""
	An enumeration. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1733:3)
	""" CXCursor_EnumDecl
	@doc raw"""
	The GNU address of label extension, representing &&label.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2017:3)
	""" CXCursor_AddrLabelExpr
	@doc raw"""
	An expression that refers to a member of a struct, union,
	class, Objective-C class, etc.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1940:3)
	""" CXCursor_MemberRefExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2557:3)
	""" CXCursor_AnnotateAttr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2569:3)
	""" CXCursor_DLLExport
	@doc raw"""
	A declaration whose specific kind is not exposed via this
	interface.
	
	Unexposed declarations have the same operations as any other kind
	of declaration; one can extract their location information,
	spelling, find their definitions, etc. However, the specific kind
	of the declaration is not reported.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1725:3)
	""" CXCursor_UnexposedDecl
	@doc raw"""
	[C99 6.5.2.1] Array Subscripting.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1985:3)
	""" CXCursor_ArraySubscriptExpr
	@doc raw"""
	Objective-C's collection statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2301:3)
	""" CXCursor_ObjCForCollectionStmt
	@doc raw"""
	OpenMP target simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2496:3)
	""" CXCursor_OMPTargetSimdDirective
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1804:3)
	""" CXCursor_CXXAccessSpecifier
	@doc raw"""
	A statement whose specific kind is not exposed via this
	interface.
	
	Unexposed statements have the same operations as any other kind of
	statement; one can extract their location information, spelling,
	children, etc. However, the specific kind of the statement is not
	reported.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2200:3)
	""" CXCursor_UnexposedStmt
	@doc raw"""
	An Objective-C class method. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1760:3)
	""" CXCursor_ObjCClassMethodDecl
	@doc raw"""
	Compound assignment such as "+=".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1994:3)
	""" CXCursor_CompoundAssignOperator
	@doc raw"""
	This represents the unary-expression's (except sizeof and
	alignof).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1981:3)
	""" CXCursor_UnaryOperator
	@doc raw"""
	OpenMP target data directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2444:3)
	""" CXCursor_OMPTargetDataDirective
	@doc raw"""
	OpenMP teams distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2512:3)
	""" CXCursor_OMPTeamsDistributeParallelForDirective
	@doc raw"""
	Describes an C or C++ initializer list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2013:3)
	""" CXCursor_InitListExpr
	@doc raw"""
	An Objective-C "bridged" cast expression, which casts between
	Objective-C pointers and C pointers, transferring ownership in the process.
	
	\\code
	NSString *str = (__bridge_transfer NSString *)CFCreateString();
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2123:3)
	""" CXCursor_ObjCBridgedCastExpr
	@doc raw"""
	An Objective-C instance variable. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1756:3)
	""" CXCursor_ObjCIvarDecl
	@doc raw"""
	Windows Structured Exception Handling's try statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2317:3)
	""" CXCursor_SEHTryStmt
	@doc raw"""
	An Objective-C \\@implementation. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1762:3)
	""" CXCursor_ObjCImplementationDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2582:3)
	""" CXCursor_ObjCRootClass
	@doc raw"""
	A break statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2264:3)
	""" CXCursor_BreakStmt
	@doc raw"""
	OpenMP SIMD directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2348:3)
	""" CXCursor_OMPSimdDirective
	@doc raw"""
	OpenMP taskloop simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2452:3)
	""" CXCursor_OMPTaskLoopSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2556:3)
	""" CXCursor_CXXOverrideAttr
	@doc raw"""
	An expression that calls a function. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1943:3)
	""" CXCursor_CallExpr
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1806:3)
	""" CXCursor_FirstDecl
	@doc raw"""
	A C++ template type parameter. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1780:3)
	""" CXCursor_TemplateTypeParameter
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1917:3)
	""" CXCursor_FirstExpr
	@doc raw"""
	OpenMP sections directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2356:3)
	""" CXCursor_OMPSectionsDirective
	@doc raw"""
	A C++ namespace alias declaration. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1792:3)
	""" CXCursor_NamespaceAlias
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1906:3)
	""" CXCursor_LastRef
	@doc raw"""
	OpenMP for SIMD directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2416:3)
	""" CXCursor_OMPForSimdDirective
	@doc raw"""
	A C++ destructor. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1776:3)
	""" CXCursor_Destructor
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1913:3)
	""" CXCursor_InvalidCode
	@doc raw"""
	OpenMP critical directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2384:3)
	""" CXCursor_OMPCriticalDirective
	@doc raw"""
	OpenMP target teams distribute directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2520:3)
	""" CXCursor_OMPTargetTeamsDistributeDirective
	@doc raw"""
	Cursor that represents the translation unit itself.
	
	The translation unit cursor exists primarily to act as the root
	cursor for traversing the contents of a translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2542:3)
	""" CXCursor_TranslationUnit
	@doc raw"""
	C++'s reinterpret_cast<> expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2047:3)
	""" CXCursor_CXXReinterpretCastExpr
	@doc raw"""
	A function or method parameter. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1746:3)
	""" CXCursor_ParmDecl
	@doc raw"""
	Windows Structured Exception Handling's leave statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2404:3)
	""" CXCursor_SEHLeaveStmt
	@doc raw"""
	OpenMP cancellation point directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2436:3)
	""" CXCursor_OMPCancellationPointDirective
	@doc raw"""
	A case statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2224:3)
	""" CXCursor_CaseStmt
	@doc raw"""
	OpenMP teams directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2428:3)
	""" CXCursor_OMPTeamsDirective
	@doc raw"""
	Implements the GNU __null extension, which is a name for a null
	pointer constant that has integral type (e.g., int or long) and is the same
	size and alignment as a pointer.
	
	The __null extension is typically only used by system headers, which define
	NULL as __null in C++ rather than using 0 (which is an integer that may not
	match the size of a pointer).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2035:3)
	""" CXCursor_GNUNullExpr
	@doc raw"""
	OpenMP teams distribute directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2500:3)
	""" CXCursor_OMPTeamsDistributeDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2558:3)
	""" CXCursor_AsmLabelAttr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2592:3)
	""" CXCursor_PreprocessingDirective
	@doc raw"""
	An imaginary number literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1962:3)
	""" CXCursor_ImaginaryLiteral
	@doc raw"""
	OpenMP target update directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2476:3)
	""" CXCursor_OMPTargetUpdateDirective
	@doc raw"""
	A field (in C) or non-static data member (in C++) in a
	struct, union, or C++ class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1738:3)
	""" CXCursor_FieldDecl
	@doc raw"""
	A function. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1742:3)
	""" CXCursor_FunctionDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2575:3)
	""" CXCursor_NSConsumed
	@doc raw"""
	OpenMP taskwait directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2396:3)
	""" CXCursor_OMPTaskwaitDirective
	@doc raw"""
	A delete expression for memory deallocation and destructor calls,
	e.g. "delete[] pArray".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2094:3)
	""" CXCursor_CXXDeleteExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2580:3)
	""" CXCursor_ObjCReturnsInnerPointer
	@doc raw"""
	A C++ constructor. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1774:3)
	""" CXCursor_Constructor
	@doc raw"""
	[C++0x 2.14.7] C++ Pointer Literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2073:3)
	""" CXCursor_CXXNullPtrLiteralExpr
	@doc raw"""
	Fixed point literal
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2187:3)
	""" CXCursor_LastExpr
	@doc raw"""
	A switch statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2236:3)
	""" CXCursor_SwitchStmt
	@doc raw"""
	An if statement
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2232:3)
	""" CXCursor_IfStmt
	@doc raw"""
	OpenMP target teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2532:3)
	""" CXCursor_OMPTargetTeamsDistributeSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2554:3)
	""" CXCursor_IBOutletCollectionAttr
	@doc raw"""
	An access specifier. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1811:3)
	""" CXCursor_ObjCSuperClassRef
	@doc raw"""
	A do statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2244:3)
	""" CXCursor_DoStmt
	@doc raw"""
	OpenMP parallel for SIMD directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2420:3)
	""" CXCursor_OMPParallelForSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2550:3)
	""" CXCursor_UnexposedAttr
	@doc raw"""
	Represents an expression that computes the length of a parameter
	pack.
	
	\\code
	template<typename ...Types>
	struct count {
	static const unsigned value = sizeof...(Types);
	};
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2150:3)
	""" CXCursor_SizeOfPackExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2581:3)
	""" CXCursor_ObjCRequiresSuper
	@doc raw"""
	OpenMP target teams distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2524:3)
	""" CXCursor_OMPTargetTeamsDistributeParallelForDirective
	@doc raw"""
	OpenMP 4.0 [2.4, Array Section].
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2176:3)
	""" CXCursor_OMPArraySectionExpr
	@doc raw"""
	A GCC inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2272:3)
	""" CXCursor_GCCAsmStmt
	@doc raw"""
	A MS inline assembly statement extension.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2329:3)
	""" CXCursor_MSAsmStmt
	@doc raw"""
	An Objective-C \\@property declaration. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1754:3)
	""" CXCursor_ObjCPropertyDecl
	@doc raw"""
	A reference to a member of a struct, union, or class that occurs in
	some non-expression context, e.g., a designated initializer.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1844:3)
	""" CXCursor_MemberRef
	@doc raw"""
	A C++ class template partial specialization. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1790:3)
	""" CXCursor_ClassTemplatePartialSpecialization
	@doc raw"""
	OpenMP target enter data directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2460:3)
	""" CXCursor_OMPTargetEnterDataDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2566:3)
	""" CXCursor_CUDAHostAttr
	@doc raw"""
	OpenMP target teams distribute simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2534:3)
	""" CXCursor_LastStmt
	@doc raw"""
	A C++ namespace. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1770:3)
	""" CXCursor_Namespace
	@doc raw"""
	[C99 6.5.2.5]
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2009:3)
	""" CXCursor_CompoundLiteralExpr
	@doc raw"""
	An Objective-C \\@interface for a category. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1750:3)
	""" CXCursor_ObjCCategoryDecl
	@doc raw"""
	OpenMP teams distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2508:3)
	""" CXCursor_OMPTeamsDistributeParallelForSimdDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2594:3)
	""" CXCursor_MacroExpansion
	@doc raw"""
	The null statement ";": C99 6.8.3p3.
	
	This cursor kind is used to describe the null statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2335:3)
	""" CXCursor_NullStmt
	@doc raw"""
	A reference to a type declaration.
	
	A type reference occurs anywhere where a type is named but not
	declared. For example, given:
	
	\\code
	typedef unsigned size_type;
	size_type size;
	\\endcode
	
	The typedef is a declaration of size_type (CXCursor_TypedefDecl),
	while the type of the variable "size" is referenced. The cursor
	referenced by the type of size is the typedef for size_type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1830:3)
	""" CXCursor_CXXBaseSpecifier
	@doc raw"""
	Objective-C's autorelease pool statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2297:3)
	""" CXCursor_ObjCAutoreleasePoolStmt
	@doc raw"""
	a friend declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2614:3)
	""" CXCursor_FirstExtraDecl
	@doc raw"""
	A reference to a class template, function template, template
	template parameter, or class template partial specialization.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1835:3)
	""" CXCursor_TemplateRef
	@doc raw"""
	Objective-C's \\@throw statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2289:3)
	""" CXCursor_ObjCAtThrowStmt
	@doc raw"""
	OpenMP target directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2424:3)
	""" CXCursor_OMPTargetDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2593:3)
	""" CXCursor_MacroDefinition
	@doc raw"""
	a friend declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2613:3)
	""" CXCursor_FriendDecl
	@doc raw"""
	Fixed point literal
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2185:3)
	""" CXCursor_FixedPointLiteral
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2577:3)
	""" CXCursor_ObjCNSObject
	@doc raw"""
	An Objective-C \\@dynamic definition. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1802:3)
	""" CXCursor_ObjCDynamicDecl
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2563:3)
	""" CXCursor_CUDAConstantAttr
	@doc raw"""
	Represents a C++0x pack expansion that produces a sequence of
	expressions.
	
	A pack expansion expression contains a pattern (which itself is an
	expression) followed by an ellipsis. For example:
	
	\\code
	template<typename F, typename ...Types>
	void forward(F f, Types &&...args) {
	f(static_cast<Types&&>(args)...);
	}
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2138:3)
	""" CXCursor_PackExpansionExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2576:3)
	""" CXCursor_ObjCException
	@doc raw"""
	An expression whose specific kind is not exposed via this
	interface.
	
	Unexposed expressions have the same operations as any other kind
	of expression; one can extract their location information,
	spelling, children, etc. However, the specific kind of the
	expression is not reported.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1928:3)
	""" CXCursor_UnexposedExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2560:3)
	""" CXCursor_PureAttr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2573:3)
	""" CXCursor_NSReturnsAutoreleased
	@doc raw"""
	Windows Structured Exception Handling's finally statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2325:3)
	""" CXCursor_SEHFinallyStmt
	@doc raw"""
	A reference to a labeled statement.
	
	This cursor kind is used to describe the jump to "start_over" in the
	goto statement in the following example:
	
	\\code
	start_over:
	++counter;
	
	goto start_over;
	\\endcode
	
	A label reference cursor refers to a label statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1860:3)
	""" CXCursor_LabelRef
	@doc raw"""
	An Objective-C \\@encode expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2106:3)
	""" CXCursor_ObjCEncodeExpr
	@doc raw"""
	OpenMP taskloop directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2448:3)
	""" CXCursor_OMPTaskLoopDirective
	@doc raw"""
	A C++ class method. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1768:3)
	""" CXCursor_CXXMethod
	@doc raw"""
	OpenMP master directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2380:3)
	""" CXCursor_OMPMasterDirective
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2574:3)
	""" CXCursor_NSConsumesSelf
	@doc raw"""
	A C++ class. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1731:3)
	""" CXCursor_ClassDecl
	@doc raw"""
	OpenMP distribute parallel for simd directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2484:3)
	""" CXCursor_OMPDistributeParallelForSimdDirective
	@doc raw"""
	The ?: ternary operator.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1998:3)
	""" CXCursor_ConditionalOperator
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2564:3)
	""" CXCursor_CUDADeviceAttr
	@doc raw"""
	OpenMP cancel directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2440:3)
	""" CXCursor_OMPCancelDirective
	@doc raw"""
	OpenMP distribute parallel for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2480:3)
	""" CXCursor_OMPDistributeParallelForDirective
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1910:3)
	""" CXCursor_InvalidFile
	@doc raw"""
	A C or C++ struct. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1727:3)
	""" CXCursor_StructDecl
	@doc raw"""
	A reference to a set of overloaded functions or function templates
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1898:3)
	""" CXCursor_OverloadedDeclRef
	@doc raw"""
	An Objective-C \\@protocol declaration. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1752:3)
	""" CXCursor_ObjCProtocolDecl
	@doc raw"""
	OpenMP target parallel for directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2472:3)
	""" CXCursor_OMPTargetParallelForDirective
	@doc raw"""
	OpenMP section directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2360:3)
	""" CXCursor_OMPSectionDirective
	@doc raw"""
	A static_assert or _Static_assert node
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2609:3)
	""" CXCursor_StaticAssert
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1909:3)
	""" CXCursor_FirstInvalid
	@doc raw"""
	C++'s static_cast<> expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2039:3)
	""" CXCursor_CXXStaticCastExpr
	@doc raw"""
	Objective-c Boolean Literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2168:3)
	""" CXCursor_ObjCBoolLiteralExpr
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2571:3)
	""" CXCursor_NSReturnsRetained
	@doc raw"""
	An attribute whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2597:3)
	""" CXCursor_FirstPreprocessing
	@doc raw"""
	A while statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2240:3)
	""" CXCursor_WhileStmt
	@doc raw"""
	a friend declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2615:3)
	""" CXCursor_LastExtraDecl
	@doc raw"""
	A C++ non-type template parameter. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1782:3)
	""" CXCursor_NonTypeTemplateParameter
	@doc raw"""
	Objective-C's overall \\@try-\\@catch-\\@finally statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2277:3)
	""" CXCursor_ObjCAtTryStmt
	@doc raw"""
	A C or C++ union. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1729:3)
	""" CXCursor_UnionDecl
	@doc raw"""
	A C++ alias declaration */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1798:3)
	""" CXCursor_TypeAliasDecl
	@doc raw"""
	A group of statements like { stmt stmt }.
	
	This cursor kind is used to describe compound statements, e.g. function
	bodies.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2220:3)
	""" CXCursor_CompoundStmt
	@doc raw"""
	OpenMP task directive.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2376:3)
	""" CXCursor_OMPTaskDirective
	@doc raw"""
	A reference to a variable that occurs in some non-expression
	context, e.g., a C++ lambda capture list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:1912:3)
	""" CXCursor_NotImplemented
	export CXCursorKind, CXCursor_AddrLabelExpr, CXCursor_AnnotateAttr, CXCursor_ArraySubscriptExpr, CXCursor_AsmLabelAttr, CXCursor_AsmStmt, CXCursor_BinaryOperator, CXCursor_BlockExpr, CXCursor_BreakStmt, CXCursor_CStyleCastExpr, CXCursor_CUDAConstantAttr, CXCursor_CUDADeviceAttr, CXCursor_CUDAGlobalAttr, CXCursor_CUDAHostAttr, CXCursor_CUDASharedAttr, CXCursor_CXXAccessSpecifier, CXCursor_CXXBaseSpecifier, CXCursor_CXXBoolLiteralExpr, CXCursor_CXXCatchStmt, CXCursor_CXXConstCastExpr, CXCursor_CXXDeleteExpr, CXCursor_CXXDynamicCastExpr, CXCursor_CXXFinalAttr, CXCursor_CXXForRangeStmt, CXCursor_CXXFunctionalCastExpr, CXCursor_CXXMethod, CXCursor_CXXNewExpr, CXCursor_CXXNullPtrLiteralExpr, CXCursor_CXXOverrideAttr, CXCursor_CXXReinterpretCastExpr, CXCursor_CXXStaticCastExpr, CXCursor_CXXThisExpr, CXCursor_CXXThrowExpr, CXCursor_CXXTryStmt, CXCursor_CXXTypeidExpr, CXCursor_CallExpr, CXCursor_CaseStmt, CXCursor_CharacterLiteral, CXCursor_ClassDecl, CXCursor_ClassTemplate, CXCursor_ClassTemplatePartialSpecialization, CXCursor_CompoundAssignOperator, CXCursor_CompoundLiteralExpr, CXCursor_CompoundStmt, CXCursor_ConditionalOperator, CXCursor_ConstAttr, CXCursor_Constructor, CXCursor_ContinueStmt, CXCursor_ConversionFunction, CXCursor_DLLExport, CXCursor_DLLImport, CXCursor_DeclRefExpr, CXCursor_DeclStmt, CXCursor_DefaultStmt, CXCursor_Destructor, CXCursor_DoStmt, CXCursor_EnumConstantDecl, CXCursor_EnumDecl, CXCursor_FieldDecl, CXCursor_FirstAttr, CXCursor_FirstDecl, CXCursor_FirstExpr, CXCursor_FirstExtraDecl, CXCursor_FirstInvalid, CXCursor_FirstPreprocessing, CXCursor_FirstRef, CXCursor_FirstStmt, CXCursor_FixedPointLiteral, CXCursor_FlagEnum, CXCursor_FloatingLiteral, CXCursor_ForStmt, CXCursor_FriendDecl, CXCursor_FunctionDecl, CXCursor_FunctionTemplate, CXCursor_GCCAsmStmt, CXCursor_GNUNullExpr, CXCursor_GenericSelectionExpr, CXCursor_GotoStmt, CXCursor_IBActionAttr, CXCursor_IBOutletAttr, CXCursor_IBOutletCollectionAttr, CXCursor_IfStmt, CXCursor_ImaginaryLiteral, CXCursor_InclusionDirective, CXCursor_IndirectGotoStmt, CXCursor_InitListExpr, CXCursor_IntegerLiteral, CXCursor_InvalidCode, CXCursor_InvalidFile, CXCursor_LabelRef, CXCursor_LabelStmt, CXCursor_LambdaExpr, CXCursor_LastAttr, CXCursor_LastDecl, CXCursor_LastExpr, CXCursor_LastExtraDecl, CXCursor_LastInvalid, CXCursor_LastPreprocessing, CXCursor_LastRef, CXCursor_LastStmt, CXCursor_LinkageSpec, CXCursor_MSAsmStmt, CXCursor_MacroDefinition, CXCursor_MacroExpansion, CXCursor_MacroInstantiation, CXCursor_MemberRef, CXCursor_MemberRefExpr, CXCursor_ModuleImportDecl, CXCursor_NSConsumed, CXCursor_NSConsumesSelf, CXCursor_NSReturnsAutoreleased, CXCursor_NSReturnsNotRetained, CXCursor_NSReturnsRetained, CXCursor_Namespace, CXCursor_NamespaceAlias, CXCursor_NamespaceRef, CXCursor_NoDeclFound, CXCursor_NoDuplicateAttr, CXCursor_NonTypeTemplateParameter, CXCursor_NotImplemented, CXCursor_NullStmt, CXCursor_OMPArraySectionExpr, CXCursor_OMPAtomicDirective, CXCursor_OMPBarrierDirective, CXCursor_OMPCancelDirective, CXCursor_OMPCancellationPointDirective, CXCursor_OMPCriticalDirective, CXCursor_OMPDistributeDirective, CXCursor_OMPDistributeParallelForDirective, CXCursor_OMPDistributeParallelForSimdDirective, CXCursor_OMPDistributeSimdDirective, CXCursor_OMPFlushDirective, CXCursor_OMPForDirective, CXCursor_OMPForSimdDirective, CXCursor_OMPMasterDirective, CXCursor_OMPOrderedDirective, CXCursor_OMPParallelDirective, CXCursor_OMPParallelForDirective, CXCursor_OMPParallelForSimdDirective, CXCursor_OMPParallelSectionsDirective, CXCursor_OMPSectionDirective, CXCursor_OMPSectionsDirective, CXCursor_OMPSimdDirective, CXCursor_OMPSingleDirective, CXCursor_OMPTargetDataDirective, CXCursor_OMPTargetDirective, CXCursor_OMPTargetEnterDataDirective, CXCursor_OMPTargetExitDataDirective, CXCursor_OMPTargetParallelDirective, CXCursor_OMPTargetParallelForDirective, CXCursor_OMPTargetParallelForSimdDirective, CXCursor_OMPTargetSimdDirective, CXCursor_OMPTargetTeamsDirective, CXCursor_OMPTargetTeamsDistributeDirective, CXCursor_OMPTargetTeamsDistributeParallelForDirective, CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective, CXCursor_OMPTargetTeamsDistributeSimdDirective, CXCursor_OMPTargetUpdateDirective, CXCursor_OMPTaskDirective, CXCursor_OMPTaskLoopDirective, CXCursor_OMPTaskLoopSimdDirective, CXCursor_OMPTaskgroupDirective, CXCursor_OMPTaskwaitDirective, CXCursor_OMPTaskyieldDirective, CXCursor_OMPTeamsDirective, CXCursor_OMPTeamsDistributeDirective, CXCursor_OMPTeamsDistributeParallelForDirective, CXCursor_OMPTeamsDistributeParallelForSimdDirective, CXCursor_OMPTeamsDistributeSimdDirective, CXCursor_ObjCAtCatchStmt, CXCursor_ObjCAtFinallyStmt, CXCursor_ObjCAtSynchronizedStmt, CXCursor_ObjCAtThrowStmt, CXCursor_ObjCAtTryStmt, CXCursor_ObjCAutoreleasePoolStmt, CXCursor_ObjCAvailabilityCheckExpr, CXCursor_ObjCBoolLiteralExpr, CXCursor_ObjCBoxable, CXCursor_ObjCBridgedCastExpr, CXCursor_ObjCCategoryDecl, CXCursor_ObjCCategoryImplDecl, CXCursor_ObjCClassMethodDecl, CXCursor_ObjCClassRef, CXCursor_ObjCDesignatedInitializer, CXCursor_ObjCDynamicDecl, CXCursor_ObjCEncodeExpr, CXCursor_ObjCException, CXCursor_ObjCExplicitProtocolImpl, CXCursor_ObjCForCollectionStmt, CXCursor_ObjCImplementationDecl, CXCursor_ObjCIndependentClass, CXCursor_ObjCInstanceMethodDecl, CXCursor_ObjCInterfaceDecl, CXCursor_ObjCIvarDecl, CXCursor_ObjCMessageExpr, CXCursor_ObjCNSObject, CXCursor_ObjCPreciseLifetime, CXCursor_ObjCPropertyDecl, CXCursor_ObjCProtocolDecl, CXCursor_ObjCProtocolExpr, CXCursor_ObjCProtocolRef, CXCursor_ObjCRequiresSuper, CXCursor_ObjCReturnsInnerPointer, CXCursor_ObjCRootClass, CXCursor_ObjCRuntimeVisible, CXCursor_ObjCSelectorExpr, CXCursor_ObjCSelfExpr, CXCursor_ObjCStringLiteral, CXCursor_ObjCSubclassingRestricted, CXCursor_ObjCSuperClassRef, CXCursor_ObjCSynthesizeDecl, CXCursor_OverloadCandidate, CXCursor_OverloadedDeclRef, CXCursor_PackExpansionExpr, CXCursor_PackedAttr, CXCursor_ParenExpr, CXCursor_ParmDecl, CXCursor_PreprocessingDirective, CXCursor_PureAttr, CXCursor_ReturnStmt, CXCursor_SEHExceptStmt, CXCursor_SEHFinallyStmt, CXCursor_SEHLeaveStmt, CXCursor_SEHTryStmt, CXCursor_SizeOfPackExpr, CXCursor_StaticAssert, CXCursor_StmtExpr, CXCursor_StringLiteral, CXCursor_StructDecl, CXCursor_SwitchStmt, CXCursor_TemplateRef, CXCursor_TemplateTemplateParameter, CXCursor_TemplateTypeParameter, CXCursor_TranslationUnit, CXCursor_TypeAliasDecl, CXCursor_TypeAliasTemplateDecl, CXCursor_TypeRef, CXCursor_TypedefDecl, CXCursor_UnaryExpr, CXCursor_UnaryOperator, CXCursor_UnexposedAttr, CXCursor_UnexposedDecl, CXCursor_UnexposedExpr, CXCursor_UnexposedStmt, CXCursor_UnionDecl, CXCursor_UsingDeclaration, CXCursor_UsingDirective, CXCursor_VarDecl, CXCursor_VariableRef, CXCursor_VisibilityAttr, CXCursor_WhileStmt
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
		CXCursor_FixedPointLiteral = (@Cuint)(149)
		CXCursor_LastExpr = (@Cuint)(149)
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
		CXCursor_NSReturnsRetained = (@Cuint)(420)
		CXCursor_NSReturnsNotRetained = (@Cuint)(421)
		CXCursor_NSReturnsAutoreleased = (@Cuint)(422)
		CXCursor_NSConsumesSelf = (@Cuint)(423)
		CXCursor_NSConsumed = (@Cuint)(424)
		CXCursor_ObjCException = (@Cuint)(425)
		CXCursor_ObjCNSObject = (@Cuint)(426)
		CXCursor_ObjCIndependentClass = (@Cuint)(427)
		CXCursor_ObjCPreciseLifetime = (@Cuint)(428)
		CXCursor_ObjCReturnsInnerPointer = (@Cuint)(429)
		CXCursor_ObjCRequiresSuper = (@Cuint)(430)
		CXCursor_ObjCRootClass = (@Cuint)(431)
		CXCursor_ObjCSubclassingRestricted = (@Cuint)(432)
		CXCursor_ObjCExplicitProtocolImpl = (@Cuint)(433)
		CXCursor_ObjCDesignatedInitializer = (@Cuint)(434)
		CXCursor_ObjCRuntimeVisible = (@Cuint)(435)
		CXCursor_ObjCBoxable = (@Cuint)(436)
		CXCursor_FlagEnum = (@Cuint)(437)
		CXCursor_LastAttr = (@Cuint)(437)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2645:3)
	""" CXCursor
	export CXCursor
	@ctypedef CXCursor @cstruct {
		kind::CXCursorKind
		xdata::@Cint
		data::((@Ptr){(@Cconst)(@Cvoid)})[3]
	}
	
	@doc raw"""
	Retrieve the NULL cursor, which represents no entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2656:25)
	""" clang_getNullCursor
	export clang_getNullCursor
	@cextern clang_getNullCursor()::CXCursor
	
	@doc raw"""
	Retrieve the cursor that represents the given translation unit.
	
	The translation unit cursor can be used to start traversing the
	various declarations within the given translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2664:25)
	""" clang_getTranslationUnitCursor
	export clang_getTranslationUnitCursor
	@cextern clang_getTranslationUnitCursor(var"?1?"::CXTranslationUnit)::CXCursor
	
	@doc raw"""
	Determine whether two cursors are equivalent.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2669:25)
	""" clang_equalCursors
	export clang_equalCursors
	@cextern clang_equalCursors(var"?1?"::CXCursor, var"?2?"::CXCursor)::@Cuint
	
	@doc raw"""
	Returns non-zero if \\p cursor is null.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2674:20)
	""" clang_Cursor_isNull
	export clang_Cursor_isNull
	@cextern clang_Cursor_isNull(cursor::CXCursor)::@Cint
	
	@doc raw"""
	Compute a hash value for the given cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2679:25)
	""" clang_hashCursor
	export clang_hashCursor
	@cextern clang_hashCursor(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	Retrieve the kind of the given cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2684:34)
	""" clang_getCursorKind
	export clang_getCursorKind
	@cextern clang_getCursorKind(var"?1?"::CXCursor)::CXCursorKind
	
	@doc raw"""
	Determine whether the given cursor kind represents a declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2689:25)
	""" clang_isDeclaration
	export clang_isDeclaration
	@cextern clang_isDeclaration(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given declaration is invalid.
	
	A declaration is invalid if it could not be parsed successfully.
	
	\\returns non-zero if the cursor represents a declaration and it is
	invalid, otherwise NULL.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2699:25)
	""" clang_isInvalidDeclaration
	export clang_isInvalidDeclaration
	@cextern clang_isInvalidDeclaration(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents a simple
	reference.
	
	Note that other kinds of cursors (such as expressions) can also refer to
	other cursors. Use clang_getCursorReferenced() to determine whether a
	particular cursor refers to another entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2709:25)
	""" clang_isReference
	export clang_isReference
	@cextern clang_isReference(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents an expression.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2714:25)
	""" clang_isExpression
	export clang_isExpression
	@cextern clang_isExpression(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents a statement.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2719:25)
	""" clang_isStatement
	export clang_isStatement
	@cextern clang_isStatement(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents an attribute.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2724:25)
	""" clang_isAttribute
	export clang_isAttribute
	@cextern clang_isAttribute(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor has any attributes.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2729:25)
	""" clang_Cursor_hasAttrs
	export clang_Cursor_hasAttrs
	@cextern clang_Cursor_hasAttrs(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents an invalid
	cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2735:25)
	""" clang_isInvalid
	export clang_isInvalid
	@cextern clang_isInvalid(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor kind represents a translation
	unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2741:25)
	""" clang_isTranslationUnit
	export clang_isTranslationUnit
	@cextern clang_isTranslationUnit(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor represents a preprocessing
	element, such as a preprocessor directive or macro instantiation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2747:25)
	""" clang_isPreprocessing
	export clang_isPreprocessing
	@cextern clang_isPreprocessing(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	Determine whether the given cursor represents a currently
	unexposed piece of the AST (e.g., CXCursor_UnexposedStmt).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2753:25)
	""" clang_isUnexposed
	export clang_isUnexposed
	@cextern clang_isUnexposed(var"?1?"::CXCursorKind)::@Cuint
	
	@doc raw"""
	This is the linkage for static variables and static functions. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2768:3)
	""" CXLinkage_Internal
	@doc raw"""
	This is the linkage for entities with external linkage that live
	in C++ anonymous namespaces.*/
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2771:3)
	""" CXLinkage_UniqueExternal
	@doc raw"""
	This is the linkage for entities with true, external linkage. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2773:3)
	""" CXLinkage_External
	@doc raw"""
	This value indicates that no linkage information is available
	for a provided CXCursor. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2761:3)
	""" CXLinkage_Invalid
	@doc raw"""
	This is the linkage for variables, parameters, and so on that
	have automatic storage.  This covers normal (non-extern) local variables.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2766:3)
	""" CXLinkage_NoLinkage
	@doc raw"""
	Describe the linkage of the entity referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2758:6)
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
	Determine the linkage of the entity referred to by a given cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2779:35)
	""" clang_getCursorLinkage
	export clang_getCursorLinkage
	@cextern clang_getCursorLinkage(cursor::CXCursor)::CXLinkageKind
	
	@doc raw"""
	Symbol seen by the linker but resolves to a symbol inside this object. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2789:3)
	""" CXVisibility_Protected
	@doc raw"""
	This value indicates that no visibility information is available
	for a provided CXCursor. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2784:3)
	""" CXVisibility_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2781:6)
	""" CXVisibilityKind
	@doc raw"""
	Symbol not seen by the linker. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2787:3)
	""" CXVisibility_Hidden
	@doc raw"""
	Symbol seen by the linker and acts like a normal symbol. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2791:3)
	""" CXVisibility_Default
	export CXVisibilityKind, CXVisibility_Default, CXVisibility_Hidden, CXVisibility_Invalid, CXVisibility_Protected
	@cenum CXVisibilityKind {
		CXVisibility_Invalid = (@Cuint)(0)
		CXVisibility_Hidden = (@Cuint)(1)
		CXVisibility_Protected = (@Cuint)(2)
		CXVisibility_Default = (@Cuint)(3)
	}
	
	@doc raw"""
	Describe the visibility of the entity referred to by a cursor.
	
	This returns the default visibility if not explicitly specified by
	a visibility attribute. The default visibility may be changed by
	commandline arguments.
	
	\\param cursor The cursor to query.
	
	\\returns The visibility of the cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2805:38)
	""" clang_getCursorVisibility
	export clang_getCursorVisibility
	@cextern clang_getCursorVisibility(cursor::CXCursor)::CXVisibilityKind
	
	@doc raw"""
	Determine the availability of the entity that this cursor refers to,
	taking the current target platform into account.
	
	\\param cursor The cursor to query.
	
	\\returns The availability of the cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2816:1)
	""" clang_getCursorAvailability
	export clang_getCursorAvailability
	@cextern clang_getCursorAvailability(cursor::CXCursor)::CXAvailabilityKind
	
	@doc raw"""
	Describes the availability of a given entity on a particular platform, e.g.,
	a particular class might only be available on Mac OS 10.7 or newer.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2822:16)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2853:3)
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
	Determine the availability of the entity that this cursor refers to
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2892:1)
	""" clang_getCursorPlatformAvailability
	export clang_getCursorPlatformAvailability
	@cextern clang_getCursorPlatformAvailability(cursor::CXCursor, always_deprecated::(@Ptr){@Cint}, deprecated_message::(@Ptr){CXString}, always_unavailable::(@Ptr){@Cint}, unavailable_message::(@Ptr){CXString}, availability::(@Ptr){CXPlatformAvailability}, availability_size::(@Cint))::@Cint
	
	@doc raw"""
	Free the memory associated with a \\c CXPlatformAvailability structure.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2904:1)
	""" clang_disposeCXPlatformAvailability
	export clang_disposeCXPlatformAvailability
	@cextern clang_disposeCXPlatformAvailability(availability::(@Ptr){CXPlatformAvailability})::@Cvoid
	
	@doc raw"""
	Describe the "language" of the entity referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2909:6)
	""" CXLanguageKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2913:3)
	""" CXLanguage_CPlusPlus
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2912:3)
	""" CXLanguage_ObjC
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2910:3)
	""" CXLanguage_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2911:3)
	""" CXLanguage_C
	export CXLanguageKind, CXLanguage_C, CXLanguage_CPlusPlus, CXLanguage_Invalid, CXLanguage_ObjC
	@cenum CXLanguageKind {
		CXLanguage_Invalid = (@Cuint)(0)
		CXLanguage_C = (@Cuint)(1)
		CXLanguage_ObjC = (@Cuint)(2)
		CXLanguage_CPlusPlus = (@Cuint)(3)
	}
	
	@doc raw"""
	Determine the "language" of the entity referred to by a given cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2919:36)
	""" clang_getCursorLanguage
	export clang_getCursorLanguage
	@cextern clang_getCursorLanguage(cursor::CXCursor)::CXLanguageKind
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2927:3)
	""" CXTLS_Dynamic
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2928:3)
	""" CXTLS_Static
	@doc raw"""
	Describe the "thread-local storage (TLS) kind" of the declaration
	referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2925:6)
	""" CXTLSKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2926:3)
	""" CXTLS_None
	export CXTLSKind, CXTLS_Dynamic, CXTLS_None, CXTLS_Static
	@cenum CXTLSKind {
		CXTLS_None = (@Cuint)(0)
		CXTLS_Dynamic = (@Cuint)(1)
		CXTLS_Static = (@Cuint)(2)
	}
	
	@doc raw"""
	Determine the "thread-local storage (TLS) kind" of the declaration
	referred to by a cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2935:31)
	""" clang_getCursorTLSKind
	export clang_getCursorTLSKind
	@cextern clang_getCursorTLSKind(cursor::CXCursor)::CXTLSKind
	
	@doc raw"""
	Returns the translation unit that a cursor originated from.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2940:34)
	""" clang_Cursor_getTranslationUnit
	export clang_Cursor_getTranslationUnit
	@cextern clang_Cursor_getTranslationUnit(var"?1?"::CXCursor)::CXTranslationUnit
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2945:16)
	""" CXCursorSetImpl
	@doc raw"""
	A fast container representing a set of CXCursors.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2945:33)
	""" CXCursorSet
	export CXCursorSet, CXCursorSetImpl
	@ctypedef CXCursorSet (@Ptr){@cstruct CXCursorSetImpl}
	
	@doc raw"""
	Creates an empty CXCursorSet.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2950:28)
	""" clang_createCXCursorSet
	export clang_createCXCursorSet
	@cextern clang_createCXCursorSet()::CXCursorSet
	
	@doc raw"""
	Disposes a CXCursorSet and releases its associated memory.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2955:21)
	""" clang_disposeCXCursorSet
	export clang_disposeCXCursorSet
	@cextern clang_disposeCXCursorSet(cset::CXCursorSet)::@Cvoid
	
	@doc raw"""
	Queries a CXCursorSet to see if it contains a specific CXCursor.
	
	\\returns non-zero if the set contains the specified cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2962:25)
	""" clang_CXCursorSet_contains
	export clang_CXCursorSet_contains
	@cextern clang_CXCursorSet_contains(cset::CXCursorSet, cursor::CXCursor)::@Cuint
	
	@doc raw"""
	Inserts a CXCursor into a CXCursorSet.
	
	\\returns zero if the CXCursor was already in the set, and non-zero otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:2970:25)
	""" clang_CXCursorSet_insert
	export clang_CXCursorSet_insert
	@cextern clang_CXCursorSet_insert(cset::CXCursorSet, cursor::CXCursor)::@Cuint
	
	@doc raw"""
	Determine the semantic parent of the given cursor.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3006:25)
	""" clang_getCursorSemanticParent
	export clang_getCursorSemanticParent
	@cextern clang_getCursorSemanticParent(cursor::CXCursor)::CXCursor
	
	@doc raw"""
	Determine the lexical parent of the given cursor.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3042:25)
	""" clang_getCursorLexicalParent
	export clang_getCursorLexicalParent
	@cextern clang_getCursorLexicalParent(cursor::CXCursor)::CXCursor
	
	@doc raw"""
	Determine the set of methods that are overridden by the given
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3087:21)
	""" clang_getOverriddenCursors
	export clang_getOverriddenCursors
	@cextern clang_getOverriddenCursors(cursor::CXCursor, overridden::(@Ptr){(@Ptr){CXCursor}}, num_overridden::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Free the set of overridden cursors returned by \\c
	clang_getOverriddenCursors().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3095:21)
	""" clang_disposeOverriddenCursors
	export clang_disposeOverriddenCursors
	@cextern clang_disposeOverriddenCursors(overridden::(@Ptr){CXCursor})::@Cvoid
	
	@doc raw"""
	Retrieve the file that is included by the given inclusion directive
	cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3101:23)
	""" clang_getIncludedFile
	export clang_getIncludedFile
	@cextern clang_getIncludedFile(cursor::CXCursor)::CXFile
	
	@doc raw"""
	Map a source location to the cursor that describes the entity at that
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3133:25)
	""" clang_getCursor
	export clang_getCursor
	@cextern clang_getCursor(var"?1?"::CXTranslationUnit, var"?2?"::CXSourceLocation)::CXCursor
	
	@doc raw"""
	Retrieve the physical location of the source constructor referenced
	by the given cursor.
	
	The location of a declaration is typically the location of the name of that
	declaration, where the name of that declaration would occur if it is
	unnamed, or some keyword that introduces that particular declaration.
	The location of a reference is where that reference occurs within the
	source code.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3145:33)
	""" clang_getCursorLocation
	export clang_getCursorLocation
	@cextern clang_getCursorLocation(var"?1?"::CXCursor)::CXSourceLocation
	
	@doc raw"""
	Retrieve the physical extent of the source construct referenced by
	the given cursor.
	
	The extent of a cursor starts with the file/line/column pointing at the
	first character within the source construct that the cursor refers to and
	ends with the last character within that source construct. For a
	declaration, the extent covers the declaration itself. For a reference,
	the extent covers the location of the reference (e.g., where the referenced
	entity was actually used).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3158:30)
	""" clang_getCursorExtent
	export clang_getCursorExtent
	@cextern clang_getCursorExtent(var"?1?"::CXCursor)::CXSourceRange
	
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3244:3)
	""" CXType_Auto
	@doc raw"""
	Describes the kind of type
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3173:6)
	""" CXTypeKind
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3221:3)
	""" CXType_UAccum
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3229:3)
	""" CXType_LValueReference
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3305:3)
	""" CXType_OCLIntelSubgroupAVCSicPayload
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3224:3)
	""" CXType_LastBuiltin
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3257:3)
	""" CXType_OCLImage1dRO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3232:3)
	""" CXType_Enum
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3210:3)
	""" CXType_Dependent
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3285:3)
	""" CXType_OCLImage2dArrayRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3213:3)
	""" CXType_ObjCSel
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3228:3)
	""" CXType_BlockPointer
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3298:3)
	""" CXType_ObjCObject
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3264:3)
	""" CXType_OCLImage2dMSAARO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3194:3)
	""" CXType_ULong
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3206:3)
	""" CXType_Double
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3307:3)
	""" CXType_OCLIntelSubgroupAVCImeResult
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3303:3)
	""" CXType_OCLIntelSubgroupAVCImePayload
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3205:3)
	""" CXType_Float
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3314:3)
	""" CXType_OCLIntelSubgroupAVCImeDualRefStreamin
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3276:3)
	""" CXType_OCLImage2dMSAAWO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3192:3)
	""" CXType_UShort
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3291:3)
	""" CXType_OCLImage2dArrayMSAADepthRW
	@doc raw"""
	Represents an invalid type (e.g., where no type is available).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3177:3)
	""" CXType_Invalid
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3294:3)
	""" CXType_OCLEvent
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3272:3)
	""" CXType_OCLImage2dWO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3198:3)
	""" CXType_SChar
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3231:3)
	""" CXType_Record
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3269:3)
	""" CXType_OCLImage1dWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3302:3)
	""" CXType_OCLIntelSubgroupAVCMcePayload
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3202:3)
	""" CXType_Long
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3275:3)
	""" CXType_OCLImage2dArrayDepthWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3274:3)
	""" CXType_OCLImage2dDepthWO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3187:3)
	""" CXType_Bool
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3218:3)
	""" CXType_Accum
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3270:3)
	""" CXType_OCLImage1dArrayWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3283:3)
	""" CXType_OCLImage1dBufferRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3240:3)
	""" CXType_IncompleteArray
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3190:3)
	""" CXType_Char16
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3265:3)
	""" CXType_OCLImage2dArrayMSAARO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3278:3)
	""" CXType_OCLImage2dMSAADepthWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3260:3)
	""" CXType_OCLImage2dRO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3234:3)
	""" CXType_ObjCInterface
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3219:3)
	""" CXType_LongAccum
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3292:3)
	""" CXType_OCLImage3dRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3241:3)
	""" CXType_VariableArray
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3311:3)
	""" CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3230:3)
	""" CXType_RValueReference
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3233:3)
	""" CXType_Typedef
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3280:3)
	""" CXType_OCLImage3dWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3271:3)
	""" CXType_OCLImage1dBufferWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3306:3)
	""" CXType_OCLIntelSubgroupAVCMceResult
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3183:3)
	""" CXType_Unexposed
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3193:3)
	""" CXType_UInt
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3222:3)
	""" CXType_ULongAccum
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3308:3)
	""" CXType_OCLIntelSubgroupAVCRefResult
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3189:3)
	""" CXType_UChar
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3197:3)
	""" CXType_Char_S
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3188:3)
	""" CXType_Char_U
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3215:3)
	""" CXType_Half
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3207:3)
	""" CXType_LongDouble
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3258:3)
	""" CXType_OCLImage1dArrayRO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3281:3)
	""" CXType_OCLImage1dRW
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3289:3)
	""" CXType_OCLImage2dArrayMSAARW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3204:3)
	""" CXType_Int128
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3196:3)
	""" CXType_UInt128
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3214:3)
	""" CXType_Float128
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3259:3)
	""" CXType_OCLImage1dBufferRO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3191:3)
	""" CXType_Char32
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3284:3)
	""" CXType_OCLImage2dRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3235:3)
	""" CXType_ObjCObjectPointer
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3266:3)
	""" CXType_OCLImage2dMSAADepthRO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3290:3)
	""" CXType_OCLImage2dMSAADepthRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3227:3)
	""" CXType_Pointer
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3261:3)
	""" CXType_OCLImage2dArrayRO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3282:3)
	""" CXType_OCLImage1dArrayRW
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3286:3)
	""" CXType_OCLImage2dDepthRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3236:3)
	""" CXType_FunctionNoProto
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3195:3)
	""" CXType_ULongLong
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3254:3)
	""" CXType_Pipe
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3200:3)
	""" CXType_Short
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3312:3)
	""" CXType_OCLIntelSubgroupAVCImeSingleRefStreamin
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3186:3)
	""" CXType_Void
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3251:3)
	""" CXType_Elaborated
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3211:3)
	""" CXType_ObjCId
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3226:3)
	""" CXType_Complex
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3217:3)
	""" CXType_ShortAccum
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3242:3)
	""" CXType_DependentSizedArray
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3277:3)
	""" CXType_OCLImage2dArrayMSAAWO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3238:3)
	""" CXType_ConstantArray
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3209:3)
	""" CXType_Overload
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3279:3)
	""" CXType_OCLImage2dArrayMSAADepthWO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3295:3)
	""" CXType_OCLQueue
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3267:3)
	""" CXType_OCLImage2dArrayMSAADepthRO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3288:3)
	""" CXType_OCLImage2dMSAARW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3237:3)
	""" CXType_FunctionProto
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3296:3)
	""" CXType_OCLReserveID
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3268:3)
	""" CXType_OCLImage3dRO
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3293:3)
	""" CXType_OCLSampler
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3220:3)
	""" CXType_UShortAccum
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3216:3)
	""" CXType_Float16
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3287:3)
	""" CXType_OCLImage2dArrayDepthRW
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3203:3)
	""" CXType_LongLong
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3263:3)
	""" CXType_OCLImage2dArrayDepthRO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3243:3)
	""" CXType_MemberPointer
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3223:3)
	""" CXType_FirstBuiltin
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3273:3)
	""" CXType_OCLImage2dArrayWO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3208:3)
	""" CXType_NullPtr
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3201:3)
	""" CXType_Int
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3212:3)
	""" CXType_ObjCClass
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3262:3)
	""" CXType_OCLImage2dDepthRO
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3199:3)
	""" CXType_WChar
	@doc raw"""
	A type whose specific kind is not exposed via this
	interface.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3239:3)
	""" CXType_Vector
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3299:3)
	""" CXType_ObjCTypeParam
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3309:3)
	""" CXType_OCLIntelSubgroupAVCSicResult
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3310:3)
	""" CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3304:3)
	""" CXType_OCLIntelSubgroupAVCRefPayload
	@doc raw"""
	Represents a type that was referred to using an elaborated type keyword.
	
	E.g., struct S, or via a qualified name, e.g., N::M::type, or both.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3300:3)
	""" CXType_Attributed
	export CXTypeKind, CXType_Accum, CXType_Attributed, CXType_Auto, CXType_BlockPointer, CXType_Bool, CXType_Char16, CXType_Char32, CXType_Char_S, CXType_Char_U, CXType_Complex, CXType_ConstantArray, CXType_Dependent, CXType_DependentSizedArray, CXType_Double, CXType_Elaborated, CXType_Enum, CXType_FirstBuiltin, CXType_Float, CXType_Float128, CXType_Float16, CXType_FunctionNoProto, CXType_FunctionProto, CXType_Half, CXType_IncompleteArray, CXType_Int, CXType_Int128, CXType_Invalid, CXType_LValueReference, CXType_LastBuiltin, CXType_Long, CXType_LongAccum, CXType_LongDouble, CXType_LongLong, CXType_MemberPointer, CXType_NullPtr, CXType_OCLEvent, CXType_OCLImage1dArrayRO, CXType_OCLImage1dArrayRW, CXType_OCLImage1dArrayWO, CXType_OCLImage1dBufferRO, CXType_OCLImage1dBufferRW, CXType_OCLImage1dBufferWO, CXType_OCLImage1dRO, CXType_OCLImage1dRW, CXType_OCLImage1dWO, CXType_OCLImage2dArrayDepthRO, CXType_OCLImage2dArrayDepthRW, CXType_OCLImage2dArrayDepthWO, CXType_OCLImage2dArrayMSAADepthRO, CXType_OCLImage2dArrayMSAADepthRW, CXType_OCLImage2dArrayMSAADepthWO, CXType_OCLImage2dArrayMSAARO, CXType_OCLImage2dArrayMSAARW, CXType_OCLImage2dArrayMSAAWO, CXType_OCLImage2dArrayRO, CXType_OCLImage2dArrayRW, CXType_OCLImage2dArrayWO, CXType_OCLImage2dDepthRO, CXType_OCLImage2dDepthRW, CXType_OCLImage2dDepthWO, CXType_OCLImage2dMSAADepthRO, CXType_OCLImage2dMSAADepthRW, CXType_OCLImage2dMSAADepthWO, CXType_OCLImage2dMSAARO, CXType_OCLImage2dMSAARW, CXType_OCLImage2dMSAAWO, CXType_OCLImage2dRO, CXType_OCLImage2dRW, CXType_OCLImage2dWO, CXType_OCLImage3dRO, CXType_OCLImage3dRW, CXType_OCLImage3dWO, CXType_OCLIntelSubgroupAVCImeDualRefStreamin, CXType_OCLIntelSubgroupAVCImePayload, CXType_OCLIntelSubgroupAVCImeResult, CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout, CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout, CXType_OCLIntelSubgroupAVCImeSingleRefStreamin, CXType_OCLIntelSubgroupAVCMcePayload, CXType_OCLIntelSubgroupAVCMceResult, CXType_OCLIntelSubgroupAVCRefPayload, CXType_OCLIntelSubgroupAVCRefResult, CXType_OCLIntelSubgroupAVCSicPayload, CXType_OCLIntelSubgroupAVCSicResult, CXType_OCLQueue, CXType_OCLReserveID, CXType_OCLSampler, CXType_ObjCClass, CXType_ObjCId, CXType_ObjCInterface, CXType_ObjCObject, CXType_ObjCObjectPointer, CXType_ObjCSel, CXType_ObjCTypeParam, CXType_Overload, CXType_Pipe, CXType_Pointer, CXType_RValueReference, CXType_Record, CXType_SChar, CXType_Short, CXType_ShortAccum, CXType_Typedef, CXType_UAccum, CXType_UChar, CXType_UInt, CXType_UInt128, CXType_ULong, CXType_ULongAccum, CXType_ULongLong, CXType_UShort, CXType_UShortAccum, CXType_Unexposed, CXType_VariableArray, CXType_Vector, CXType_Void, CXType_WChar
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
		CXType_ShortAccum = (@Cuint)(33)
		CXType_Accum = (@Cuint)(34)
		CXType_LongAccum = (@Cuint)(35)
		CXType_UShortAccum = (@Cuint)(36)
		CXType_UAccum = (@Cuint)(37)
		CXType_ULongAccum = (@Cuint)(38)
		CXType_FirstBuiltin = (@Cuint)(2)
		CXType_LastBuiltin = (@Cuint)(38)
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
		CXType_ObjCObject = (@Cuint)(161)
		CXType_ObjCTypeParam = (@Cuint)(162)
		CXType_Attributed = (@Cuint)(163)
		CXType_OCLIntelSubgroupAVCMcePayload = (@Cuint)(164)
		CXType_OCLIntelSubgroupAVCImePayload = (@Cuint)(165)
		CXType_OCLIntelSubgroupAVCRefPayload = (@Cuint)(166)
		CXType_OCLIntelSubgroupAVCSicPayload = (@Cuint)(167)
		CXType_OCLIntelSubgroupAVCMceResult = (@Cuint)(168)
		CXType_OCLIntelSubgroupAVCImeResult = (@Cuint)(169)
		CXType_OCLIntelSubgroupAVCRefResult = (@Cuint)(170)
		CXType_OCLIntelSubgroupAVCSicResult = (@Cuint)(171)
		CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout = (@Cuint)(172)
		CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout = (@Cuint)(173)
		CXType_OCLIntelSubgroupAVCImeSingleRefStreamin = (@Cuint)(174)
		CXType_OCLIntelSubgroupAVCImeDualRefStreamin = (@Cuint)(175)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3331:3)
	""" CXCallingConv_Win64
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3324:3)
	""" CXCallingConv_X86FastCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3336:3)
	""" CXCallingConv_Swift
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3321:3)
	""" CXCallingConv_Default
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3327:3)
	""" CXCallingConv_AAPCS
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3335:3)
	""" CXCallingConv_X86VectorCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3334:3)
	""" CXCallingConv_X86_64SysV
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3338:3)
	""" CXCallingConv_PreserveAll
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3329:3)
	""" CXCallingConv_X86RegCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3330:3)
	""" CXCallingConv_IntelOclBicc
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3341:3)
	""" CXCallingConv_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3325:3)
	""" CXCallingConv_X86ThisCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3322:3)
	""" CXCallingConv_C
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3326:3)
	""" CXCallingConv_X86Pascal
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3328:3)
	""" CXCallingConv_AAPCS_VFP
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3333:3)
	""" CXCallingConv_X86_64Win64
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3339:3)
	""" CXCallingConv_AArch64VectorCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3323:3)
	""" CXCallingConv_X86StdCall
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3337:3)
	""" CXCallingConv_PreserveMost
	@doc raw"""
	Describes the calling convention of a function type
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3320:6)
	""" CXCallingConv
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3342:3)
	""" CXCallingConv_Unexposed
	export CXCallingConv, CXCallingConv_AAPCS, CXCallingConv_AAPCS_VFP, CXCallingConv_AArch64VectorCall, CXCallingConv_C, CXCallingConv_Default, CXCallingConv_IntelOclBicc, CXCallingConv_Invalid, CXCallingConv_PreserveAll, CXCallingConv_PreserveMost, CXCallingConv_Swift, CXCallingConv_Unexposed, CXCallingConv_Win64, CXCallingConv_X86FastCall, CXCallingConv_X86Pascal, CXCallingConv_X86RegCall, CXCallingConv_X86StdCall, CXCallingConv_X86ThisCall, CXCallingConv_X86VectorCall, CXCallingConv_X86_64SysV, CXCallingConv_X86_64Win64
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
		CXCallingConv_AArch64VectorCall = (@Cuint)(16)
		CXCallingConv_Invalid = (@Cuint)(100)
		CXCallingConv_Unexposed = (@Cuint)(200)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3352:3)
	""" CXType
	export CXType
	@ctypedef CXType @cstruct {
		kind::CXTypeKind
		data::((@Ptr){@Cvoid})[2]
	}
	
	@doc raw"""
	Retrieve the type of a CXCursor (if any).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3357:23)
	""" clang_getCursorType
	export clang_getCursorType
	@cextern clang_getCursorType(C::CXCursor)::CXType
	
	@doc raw"""
	Pretty-print the underlying type using the rules of the
	language of the translation unit from which it came.
	
	If the type is invalid, an empty string is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3365:25)
	""" clang_getTypeSpelling
	export clang_getTypeSpelling
	@cextern clang_getTypeSpelling(CT::CXType)::CXString
	
	@doc raw"""
	Retrieve the underlying type of a typedef declaration.
	
	If the cursor does not reference a typedef declaration, an invalid type is
	returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3373:23)
	""" clang_getTypedefDeclUnderlyingType
	export clang_getTypedefDeclUnderlyingType
	@cextern clang_getTypedefDeclUnderlyingType(C::CXCursor)::CXType
	
	@doc raw"""
	Retrieve the integer type of an enum declaration.
	
	If the cursor does not reference an enum declaration, an invalid type is
	returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3381:23)
	""" clang_getEnumDeclIntegerType
	export clang_getEnumDeclIntegerType
	@cextern clang_getEnumDeclIntegerType(C::CXCursor)::CXType
	
	@doc raw"""
	Retrieve the integer value of an enum constant declaration as a signed
	long long.
	
	If the cursor does not reference an enum constant declaration, LLONG_MIN is returned.
	Since this is also potentially a valid constant value, the kind of the cursor
	must be verified before calling this function.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3391:26)
	""" clang_getEnumConstantDeclValue
	export clang_getEnumConstantDeclValue
	@cextern clang_getEnumConstantDeclValue(C::CXCursor)::@Clonglong
	
	@doc raw"""
	Retrieve the integer value of an enum constant declaration as an unsigned
	long long.
	
	If the cursor does not reference an enum constant declaration, ULLONG_MAX is returned.
	Since this is also potentially a valid constant value, the kind of the cursor
	must be verified before calling this function.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3401:35)
	""" clang_getEnumConstantDeclUnsignedValue
	export clang_getEnumConstantDeclUnsignedValue
	@cextern clang_getEnumConstantDeclUnsignedValue(C::CXCursor)::@Culonglong
	
	@doc raw"""
	Retrieve the bit width of a bit field declaration as an integer.
	
	If a cursor that is not a bit field declaration is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3408:20)
	""" clang_getFieldDeclBitWidth
	export clang_getFieldDeclBitWidth
	@cextern clang_getFieldDeclBitWidth(C::CXCursor)::@Cint
	
	@doc raw"""
	Retrieve the number of non-variadic arguments associated with a given
	cursor.
	
	The number of arguments can be determined for calls as well as for
	declarations of functions or methods. For other cursors -1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3417:20)
	""" clang_Cursor_getNumArguments
	export clang_Cursor_getNumArguments
	@cextern clang_Cursor_getNumArguments(C::CXCursor)::@Cint
	
	@doc raw"""
	Retrieve the argument cursor of a function or method.
	
	The argument cursor can be determined for calls as well as for declarations
	of functions or methods. For other cursors and for invalid indices, an
	invalid cursor is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3426:25)
	""" clang_Cursor_getArgument
	export clang_Cursor_getArgument
	@cextern clang_Cursor_getArgument(C::CXCursor, i::(@Cuint))::CXCursor
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3436:3)
	""" CXTemplateArgumentKind_Type
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3437:3)
	""" CXTemplateArgumentKind_Declaration
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3443:3)
	""" CXTemplateArgumentKind_Pack
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3442:3)
	""" CXTemplateArgumentKind_Expression
	@doc raw"""
	Describes the kind of a template argument.
	
	See the definition of llvm::clang::TemplateArgument::ArgKind for full
	element descriptions.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3434:6)
	""" CXTemplateArgumentKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3440:3)
	""" CXTemplateArgumentKind_Template
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3435:3)
	""" CXTemplateArgumentKind_Null
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3441:3)
	""" CXTemplateArgumentKind_TemplateExpansion
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3445:3)
	""" CXTemplateArgumentKind_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3438:3)
	""" CXTemplateArgumentKind_NullPtr
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3439:3)
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
	Returns the number of template args of a function decl representing a
	template specialization.
	
	If the argument cursor cannot be converted into a template function
	declaration, -1 is returned.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	The value 3 would be returned from this call.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3464:20)
	""" clang_Cursor_getNumTemplateArguments
	export clang_Cursor_getNumTemplateArguments
	@cextern clang_Cursor_getNumTemplateArguments(C::CXCursor)::@Cint
	
	@doc raw"""
	Retrieve the kind of the I'th template argument of the CXCursor C.
	
	If the argument CXCursor does not represent a FunctionDecl, an invalid
	template argument kind is returned.
	
	For example, for the following declaration and specialization:
	template <typename T, int kInt, bool kBool>
	void foo() { ... }
	
	template <>
	void foo<float, -7, true>();
	
	For I = 0, 1, and 2, Type, Integral, and Integral will be returned,
	respectively.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3482:44)
	""" clang_Cursor_getTemplateArgumentKind
	export clang_Cursor_getTemplateArgumentKind
	@cextern clang_Cursor_getTemplateArgumentKind(C::CXCursor, I::(@Cuint))::CXTemplateArgumentKind
	
	@doc raw"""
	Retrieve a CXType representing the type of a TemplateArgument of a
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3503:23)
	""" clang_Cursor_getTemplateArgumentType
	export clang_Cursor_getTemplateArgumentType
	@cextern clang_Cursor_getTemplateArgumentType(C::CXCursor, I::(@Cuint))::CXType
	
	@doc raw"""
	Retrieve the value of an Integral TemplateArgument (of a function
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3523:26)
	""" clang_Cursor_getTemplateArgumentValue
	export clang_Cursor_getTemplateArgumentValue
	@cextern clang_Cursor_getTemplateArgumentValue(C::CXCursor, I::(@Cuint))::@Clonglong
	
	@doc raw"""
	Retrieve the value of an Integral TemplateArgument (of a function
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3543:35)
	""" clang_Cursor_getTemplateArgumentUnsignedValue
	export clang_Cursor_getTemplateArgumentUnsignedValue
	@cextern clang_Cursor_getTemplateArgumentUnsignedValue(C::CXCursor, I::(@Cuint))::@Culonglong
	
	@doc raw"""
	Determine whether two CXTypes represent the same type.
	
	\\returns non-zero if the CXTypes represent the same type and
	zero otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3552:25)
	""" clang_equalTypes
	export clang_equalTypes
	@cextern clang_equalTypes(A::CXType, B::CXType)::@Cuint
	
	@doc raw"""
	Return the canonical type for a CXType.
	
	Clang's type system explicitly models typedefs and all the ways
	a specific type can be represented.  The canonical type is the underlying
	type with all the "sugar" removed.  For example, if 'T' is a typedef
	for 'int', the canonical type for 'T' would be 'int'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3562:23)
	""" clang_getCanonicalType
	export clang_getCanonicalType
	@cextern clang_getCanonicalType(T::CXType)::CXType
	
	@doc raw"""
	Determine whether a CXType has the "const" qualifier set,
	without looking through typedefs that may have added "const" at a
	different level.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3569:25)
	""" clang_isConstQualifiedType
	export clang_isConstQualifiedType
	@cextern clang_isConstQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	Determine whether a  CXCursor that is a macro, is
	function like.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3575:25)
	""" clang_Cursor_isMacroFunctionLike
	export clang_Cursor_isMacroFunctionLike
	@cextern clang_Cursor_isMacroFunctionLike(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine whether a  CXCursor that is a macro, is a
	builtin one.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3581:25)
	""" clang_Cursor_isMacroBuiltin
	export clang_Cursor_isMacroBuiltin
	@cextern clang_Cursor_isMacroBuiltin(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine whether a  CXCursor that is a function declaration, is an
	inline declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3587:25)
	""" clang_Cursor_isFunctionInlined
	export clang_Cursor_isFunctionInlined
	@cextern clang_Cursor_isFunctionInlined(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine whether a CXType has the "volatile" qualifier set,
	without looking through typedefs that may have added "volatile" at
	a different level.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3594:25)
	""" clang_isVolatileQualifiedType
	export clang_isVolatileQualifiedType
	@cextern clang_isVolatileQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	Determine whether a CXType has the "restrict" qualifier set,
	without looking through typedefs that may have added "restrict" at a
	different level.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3601:25)
	""" clang_isRestrictQualifiedType
	export clang_isRestrictQualifiedType
	@cextern clang_isRestrictQualifiedType(T::CXType)::@Cuint
	
	@doc raw"""
	Returns the address space of the given type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3606:25)
	""" clang_getAddressSpace
	export clang_getAddressSpace
	@cextern clang_getAddressSpace(T::CXType)::@Cuint
	
	@doc raw"""
	Returns the typedef name of the given type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3611:25)
	""" clang_getTypedefName
	export clang_getTypedefName
	@cextern clang_getTypedefName(CT::CXType)::CXString
	
	@doc raw"""
	For pointer types, returns the type of the pointee.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3616:23)
	""" clang_getPointeeType
	export clang_getPointeeType
	@cextern clang_getPointeeType(T::CXType)::CXType
	
	@doc raw"""
	Return the cursor for the declaration of the given type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3621:25)
	""" clang_getTypeDeclaration
	export clang_getTypeDeclaration
	@cextern clang_getTypeDeclaration(T::CXType)::CXCursor
	
	@doc raw"""
	Returns the Objective-C type encoding for the specified declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3626:25)
	""" clang_getDeclObjCTypeEncoding
	export clang_getDeclObjCTypeEncoding
	@cextern clang_getDeclObjCTypeEncoding(C::CXCursor)::CXString
	
	@doc raw"""
	Returns the Objective-C type encoding for the specified CXType.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3631:25)
	""" clang_Type_getObjCEncoding
	export clang_Type_getObjCEncoding
	@cextern clang_Type_getObjCEncoding(var"type"::CXType)::CXString
	
	@doc raw"""
	Retrieve the spelling of a given CXTypeKind.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3636:25)
	""" clang_getTypeKindSpelling
	export clang_getTypeKindSpelling
	@cextern clang_getTypeKindSpelling(K::CXTypeKind)::CXString
	
	@doc raw"""
	Retrieve the calling convention associated with a function type.
	
	If a non-function type is passed in, CXCallingConv_Invalid is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3643:35)
	""" clang_getFunctionTypeCallingConv
	export clang_getFunctionTypeCallingConv
	@cextern clang_getFunctionTypeCallingConv(T::CXType)::CXCallingConv
	
	@doc raw"""
	Retrieve the return type associated with a function type.
	
	If a non-function type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3650:23)
	""" clang_getResultType
	export clang_getResultType
	@cextern clang_getResultType(T::CXType)::CXType
	
	@doc raw"""
	Retrieve the exception specification type associated with a function type.
	This is a value of type CXCursor_ExceptionSpecificationKind.
	
	If a non-function type is passed in, an error code of -1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3658:20)
	""" clang_getExceptionSpecificationType
	export clang_getExceptionSpecificationType
	@cextern clang_getExceptionSpecificationType(T::CXType)::@Cint
	
	@doc raw"""
	Retrieve the number of non-variadic parameters associated with a
	function type.
	
	If a non-function type is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3666:20)
	""" clang_getNumArgTypes
	export clang_getNumArgTypes
	@cextern clang_getNumArgTypes(T::CXType)::@Cint
	
	@doc raw"""
	Retrieve the type of a parameter of a function type.
	
	If a non-function type is passed in or the function does not have enough
	parameters, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3674:23)
	""" clang_getArgType
	export clang_getArgType
	@cextern clang_getArgType(T::CXType, i::(@Cuint))::CXType
	
	@doc raw"""
	Retrieves the base type of the ObjCObjectType.
	
	If the type is not an ObjC object, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3681:23)
	""" clang_Type_getObjCObjectBaseType
	export clang_Type_getObjCObjectBaseType
	@cextern clang_Type_getObjCObjectBaseType(T::CXType)::CXType
	
	@doc raw"""
	Retrieve the number of protocol references associated with an ObjC object/id.
	
	If the type is not an ObjC object, 0 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3688:25)
	""" clang_Type_getNumObjCProtocolRefs
	export clang_Type_getNumObjCProtocolRefs
	@cextern clang_Type_getNumObjCProtocolRefs(T::CXType)::@Cuint
	
	@doc raw"""
	Retrieve the decl for a protocol reference for an ObjC object/id.
	
	If the type is not an ObjC object or there are not enough protocol
	references, an invalid cursor is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3696:25)
	""" clang_Type_getObjCProtocolDecl
	export clang_Type_getObjCProtocolDecl
	@cextern clang_Type_getObjCProtocolDecl(T::CXType, i::(@Cuint))::CXCursor
	
	@doc raw"""
	Retreive the number of type arguments associated with an ObjC object.
	
	If the type is not an ObjC object, 0 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3703:25)
	""" clang_Type_getNumObjCTypeArgs
	export clang_Type_getNumObjCTypeArgs
	@cextern clang_Type_getNumObjCTypeArgs(T::CXType)::@Cuint
	
	@doc raw"""
	Retrieve a type argument associated with an ObjC object.
	
	If the type is not an ObjC or the index is not valid,
	an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3711:23)
	""" clang_Type_getObjCTypeArg
	export clang_Type_getObjCTypeArg
	@cextern clang_Type_getObjCTypeArg(T::CXType, i::(@Cuint))::CXType
	
	@doc raw"""
	Return 1 if the CXType is a variadic function type, and 0 otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3716:25)
	""" clang_isFunctionTypeVariadic
	export clang_isFunctionTypeVariadic
	@cextern clang_isFunctionTypeVariadic(T::CXType)::@Cuint
	
	@doc raw"""
	Retrieve the return type associated with a given cursor.
	
	This only returns a valid type if the cursor refers to a function or method.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3723:23)
	""" clang_getCursorResultType
	export clang_getCursorResultType
	@cextern clang_getCursorResultType(C::CXCursor)::CXType
	
	@doc raw"""
	Retrieve the exception specification type associated with a given cursor.
	This is a value of type CXCursor_ExceptionSpecificationKind.
	
	This only returns a valid result if the cursor refers to a function or method.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3731:20)
	""" clang_getCursorExceptionSpecificationType
	export clang_getCursorExceptionSpecificationType
	@cextern clang_getCursorExceptionSpecificationType(C::CXCursor)::@Cint
	
	@doc raw"""
	Return 1 if the CXType is a POD (plain old data) type, and 0
	otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3737:25)
	""" clang_isPODType
	export clang_isPODType
	@cextern clang_isPODType(T::CXType)::@Cuint
	
	@doc raw"""
	Return the element type of an array, complex, or vector type.
	
	If a type is passed in that is not an array, complex, or vector type,
	an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3745:23)
	""" clang_getElementType
	export clang_getElementType
	@cextern clang_getElementType(T::CXType)::CXType
	
	@doc raw"""
	Return the number of elements of an array or vector type.
	
	If a type is passed in that is not an array or vector type,
	-1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3753:26)
	""" clang_getNumElements
	export clang_getNumElements
	@cextern clang_getNumElements(T::CXType)::@Clonglong
	
	@doc raw"""
	Return the element type of an array type.
	
	If a non-array type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3760:23)
	""" clang_getArrayElementType
	export clang_getArrayElementType
	@cextern clang_getArrayElementType(T::CXType)::CXType
	
	@doc raw"""
	Return the array size of a constant array.
	
	If a non-array type is passed in, -1 is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3767:26)
	""" clang_getArraySize
	export clang_getArraySize
	@cextern clang_getArraySize(T::CXType)::@Clonglong
	
	@doc raw"""
	Retrieve the type named by the qualified-id.
	
	If a non-elaborated type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3774:23)
	""" clang_Type_getNamedType
	export clang_Type_getNamedType
	@cextern clang_Type_getNamedType(T::CXType)::CXType
	
	@doc raw"""
	Determine if a typedef is 'transparent' tag.
	
	A typedef is considered 'transparent' if it shares a name and spelling
	location with its underlying tag type, as is the case with the NS_ENUM macro.
	
	\\returns non-zero if transparent and zero otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3784:25)
	""" clang_Type_isTransparentTagTypedef
	export clang_Type_isTransparentTagTypedef
	@cextern clang_Type_isTransparentTagTypedef(T::CXType)::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3786:6)
	""" CXTypeNullabilityKind
	@doc raw"""
	Values of this type can never be null.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3790:3)
	""" CXTypeNullability_NonNull
	@doc raw"""
	Nullability is not applicable to this type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3805:3)
	""" CXTypeNullability_Invalid
	@doc raw"""
	Whether values of this type can be null is (explicitly)
	unspecified. This captures a (fairly rare) case where we
	can't conclude anything about the nullability of the type even
	though it has been considered.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3801:3)
	""" CXTypeNullability_Unspecified
	@doc raw"""
	Values of this type can be null.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3794:3)
	""" CXTypeNullability_Nullable
	export CXTypeNullabilityKind, CXTypeNullability_Invalid, CXTypeNullability_NonNull, CXTypeNullability_Nullable, CXTypeNullability_Unspecified
	@cenum CXTypeNullabilityKind {
		CXTypeNullability_NonNull = (@Cuint)(0)
		CXTypeNullability_Nullable = (@Cuint)(1)
		CXTypeNullability_Unspecified = (@Cuint)(2)
		CXTypeNullability_Invalid = (@Cuint)(3)
	}
	
	@doc raw"""
	Retrieve the nullability kind of a pointer type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3811:43)
	""" clang_Type_getNullability
	export clang_Type_getNullability
	@cextern clang_Type_getNullability(T::CXType)::CXTypeNullabilityKind
	
	@doc raw"""
	The type is a dependent Type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3833:3)
	""" CXTypeLayoutError_Dependent
	@doc raw"""
	List the possible error codes for \\c clang_Type_getSizeOf,
	\\c clang_Type_getAlignOf, \\c clang_Type_getOffsetOf and
	\\c clang_Cursor_getOffsetOf.
	
	A value of this enumeration type can be returned if the target type is not
	a valid argument to sizeof, alignof or offsetof.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3821:6)
	""" CXTypeLayoutError
	@doc raw"""
	The Field name is not valid for this record.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3841:3)
	""" CXTypeLayoutError_InvalidFieldName
	@doc raw"""
	The type is not a constant size type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3837:3)
	""" CXTypeLayoutError_NotConstantSize
	@doc raw"""
	Type is of kind CXType_Invalid.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3825:3)
	""" CXTypeLayoutError_Invalid
	@doc raw"""
	The type is an incomplete Type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3829:3)
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
	Return the alignment of a type in bytes as per C++[expr.alignof]
	standard.
	
	If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
	If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
	is returned.
	If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
	returned.
	If the type declaration is not a constant size type,
	CXTypeLayoutError_NotConstantSize is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3856:26)
	""" clang_Type_getAlignOf
	export clang_Type_getAlignOf
	@cextern clang_Type_getAlignOf(T::CXType)::@Clonglong
	
	@doc raw"""
	Return the class type of an member pointer type.
	
	If a non-member-pointer type is passed in, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3863:23)
	""" clang_Type_getClassType
	export clang_Type_getClassType
	@cextern clang_Type_getClassType(T::CXType)::CXType
	
	@doc raw"""
	Return the size of a type in bytes as per C++[expr.sizeof] standard.
	
	If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
	If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
	is returned.
	If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
	returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3874:26)
	""" clang_Type_getSizeOf
	export clang_Type_getSizeOf
	@cextern clang_Type_getSizeOf(T::CXType)::@Clonglong
	
	@doc raw"""
	Return the offset of a field named S in a record of type T in bits
	as it would be returned by __offsetof__ as per C++11[18.2p4]
	
	If the cursor is not a record field declaration, CXTypeLayoutError_Invalid
	is returned.
	If the field's type declaration is an incomplete type,
	CXTypeLayoutError_Incomplete is returned.
	If the field's type declaration is a dependent type,
	CXTypeLayoutError_Dependent is returned.
	If the field's name S is not found,
	CXTypeLayoutError_InvalidFieldName is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3889:26)
	""" clang_Type_getOffsetOf
	export clang_Type_getOffsetOf
	@cextern clang_Type_getOffsetOf(T::CXType, S::(@Ptr){(@Cconst)(@Cchar)})::@Clonglong
	
	@doc raw"""
	Return the type that was modified by this attributed type.
	
	If the type is not an attributed type, an invalid type is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3896:23)
	""" clang_Type_getModifiedType
	export clang_Type_getModifiedType
	@cextern clang_Type_getModifiedType(T::CXType)::CXType
	
	@doc raw"""
	Return the offset of the field represented by the Cursor.
	
	If the cursor is not a field declaration, -1 is returned.
	If the cursor semantic parent is not a record field declaration,
	CXTypeLayoutError_Invalid is returned.
	If the field's type declaration is an incomplete type,
	CXTypeLayoutError_Incomplete is returned.
	If the field's type declaration is a dependent type,
	CXTypeLayoutError_Dependent is returned.
	If the field's name S is not found,
	CXTypeLayoutError_InvalidFieldName is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3911:26)
	""" clang_Cursor_getOffsetOfField
	export clang_Cursor_getOffsetOfField
	@cextern clang_Cursor_getOffsetOfField(C::CXCursor)::@Clonglong
	
	@doc raw"""
	Determine whether the given cursor represents an anonymous record
	declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3917:25)
	""" clang_Cursor_isAnonymous
	export clang_Cursor_isAnonymous
	@cextern clang_Cursor_isAnonymous(C::CXCursor)::@Cuint
	
	@doc raw"""
	An rvalue ref-qualifier was provided (\\c &&). */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3925:3)
	""" CXRefQualifier_RValue
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3919:6)
	""" CXRefQualifierKind
	@doc raw"""
	An lvalue ref-qualifier was provided (\\c &). */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3923:3)
	""" CXRefQualifier_LValue
	@doc raw"""
	No ref-qualifier was provided. */
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3921:3)
	""" CXRefQualifier_None
	export CXRefQualifierKind, CXRefQualifier_LValue, CXRefQualifier_None, CXRefQualifier_RValue
	@cenum CXRefQualifierKind {
		CXRefQualifier_None = (@Cuint)(0)
		CXRefQualifier_LValue = (@Cuint)(1)
		CXRefQualifier_RValue = (@Cuint)(2)
	}
	
	@doc raw"""
	Returns the number of template arguments for given template
	specialization, or -1 if type \\c T is not a template specialization.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3932:20)
	""" clang_Type_getNumTemplateArguments
	export clang_Type_getNumTemplateArguments
	@cextern clang_Type_getNumTemplateArguments(T::CXType)::@Cint
	
	@doc raw"""
	Returns the type template argument of a template class specialization
	at given index.
	
	This function only returns template type arguments and does not handle
	template template arguments or variadic packs.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3941:23)
	""" clang_Type_getTemplateArgumentAsType
	export clang_Type_getTemplateArgumentAsType
	@cextern clang_Type_getTemplateArgumentAsType(T::CXType, i::(@Cuint))::CXType
	
	@doc raw"""
	Retrieve the ref-qualifier kind of a function or method.
	
	The ref-qualifier is returned for C++ functions or methods. For other types
	or non-C++ declarations, CXRefQualifier_None is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3949:40)
	""" clang_Type_getCXXRefQualifier
	export clang_Type_getCXXRefQualifier
	@cextern clang_Type_getCXXRefQualifier(T::CXType)::CXRefQualifierKind
	
	@doc raw"""
	Returns non-zero if the cursor specifies a Record member that is a
	bitfield.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3955:25)
	""" clang_Cursor_isBitField
	export clang_Cursor_isBitField
	@cextern clang_Cursor_isBitField(C::CXCursor)::@Cuint
	
	@doc raw"""
	Returns 1 if the base class specified by the cursor with kind
	CX_CXXBaseSpecifier is virtual.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3961:25)
	""" clang_isVirtualBase
	export clang_isVirtualBase
	@cextern clang_isVirtualBase(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3969:3)
	""" CX_CXXPublic
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3971:3)
	""" CX_CXXPrivate
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3968:3)
	""" CX_CXXInvalidAccessSpecifier
	@doc raw"""
	Represents the C++ access control level to a base class for a
	cursor with kind CX_CXXBaseSpecifier.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3967:6)
	""" CX_CXXAccessSpecifier
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3970:3)
	""" CX_CXXProtected
	export CX_CXXAccessSpecifier, CX_CXXInvalidAccessSpecifier, CX_CXXPrivate, CX_CXXProtected, CX_CXXPublic
	@cenum CX_CXXAccessSpecifier {
		CX_CXXInvalidAccessSpecifier = (@Cuint)(0)
		CX_CXXPublic = (@Cuint)(1)
		CX_CXXProtected = (@Cuint)(2)
		CX_CXXPrivate = (@Cuint)(3)
	}
	
	@doc raw"""
	Returns the access control level for the referenced object.
	
	If the cursor refers to a C++ declaration, its access control level within its
	parent scope is returned. Otherwise, if the cursor refers to a base specifier or
	access specifier, the specifier itself is returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3981:43)
	""" clang_getCXXAccessSpecifier
	export clang_getCXXAccessSpecifier
	@cextern clang_getCXXAccessSpecifier(var"?1?"::CXCursor)::CX_CXXAccessSpecifier
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3993:3)
	""" CX_SC_OpenCLWorkGroupLocal
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3990:3)
	""" CX_SC_Extern
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3992:3)
	""" CX_SC_PrivateExtern
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3989:3)
	""" CX_SC_None
	@doc raw"""
	Represents the storage classes as declared in the source. CX_SC_Invalid
	was added for the case that the passed cursor in not a declaration.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3987:6)
	""" CX_StorageClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3995:3)
	""" CX_SC_Register
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3994:3)
	""" CX_SC_Auto
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3988:3)
	""" CX_SC_Invalid
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:3991:3)
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
	Returns the storage class for a function or variable declaration.
	
	If the passed in Cursor is not a function or variable declaration,
	CX_SC_Invalid is returned else the storage class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4004:37)
	""" clang_Cursor_getStorageClass
	export clang_Cursor_getStorageClass
	@cextern clang_Cursor_getStorageClass(var"?1?"::CXCursor)::CX_StorageClass
	
	@doc raw"""
	Determine the number of overloaded declarations referenced by a
	\\c CXCursor_OverloadedDeclRef cursor.
	
	\\param cursor The cursor whose overloaded declarations are being queried.
	
	\\returns The number of overloaded declarations referenced by \\c cursor. If it
	is not a \\c CXCursor_OverloadedDeclRef cursor, returns 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4015:25)
	""" clang_getNumOverloadedDecls
	export clang_getNumOverloadedDecls
	@cextern clang_getNumOverloadedDecls(cursor::CXCursor)::@Cuint
	
	@doc raw"""
	Retrieve a cursor for one of the overloaded declarations referenced
	by a \\c CXCursor_OverloadedDeclRef cursor.
	
	\\param cursor The cursor whose overloaded declarations are being queried.
	
	\\param index The zero-based index into the set of overloaded declarations in
	the cursor.
	
	\\returns A cursor representing the declaration referenced by the given
	\\c cursor at the specified \\c index. If the cursor does not have an
	associated set of overloaded declarations, or if the index is out of bounds,
	returns \\c clang_getNullCursor();
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4031:25)
	""" clang_getOverloadedDecl
	export clang_getOverloadedDecl
	@cextern clang_getOverloadedDecl(cursor::CXCursor, index::(@Cuint))::CXCursor
	
	@doc raw"""
	For cursors representing an iboutletcollection attribute,
	this function returns the collection element type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4049:23)
	""" clang_getIBOutletCollectionType
	export clang_getIBOutletCollectionType
	@cextern clang_getIBOutletCollectionType(var"?1?"::CXCursor)::CXType
	
	@doc raw"""
	Recursively traverse the children of this cursor, using
	the same visitor and client data.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4085:3)
	""" CXChildVisit_Recurse
	@doc raw"""
	Terminates the cursor traversal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4075:3)
	""" CXChildVisit_Break
	@doc raw"""
	Continues the cursor traversal with the next sibling of
	the cursor just visited, without visiting its children.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4080:3)
	""" CXChildVisit_Continue
	@doc raw"""
	Describes how the traversal of the children of a particular
	cursor should proceed after visiting a particular child cursor.
	
	A value of this enumeration type should be returned by each
	\\c CXCursorVisitor to indicate how clang_visitChildren() proceed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4071:6)
	""" CXChildVisitResult
	export CXChildVisitResult, CXChildVisit_Break, CXChildVisit_Continue, CXChildVisit_Recurse
	@cenum CXChildVisitResult {
		CXChildVisit_Break = (@Cuint)(0)
		CXChildVisit_Continue = (@Cuint)(1)
		CXChildVisit_Recurse = (@Cuint)(2)
	}
	
	@doc raw"""
	Visitor invoked for each cursor found by a traversal.
	
	This visitor function will be invoked for each cursor found by
	clang_visitCursorChildren(). Its first argument is the cursor being
	visited, its second argument is the parent visitor for that cursor,
	and its third argument is the client data provided to
	clang_visitCursorChildren().
	
	The visitor should return one of the \\c CXChildVisitResult values
	to direct clang_visitCursorChildren().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4100:35)
	""" CXCursorVisitor
	export CXCursorVisitor
	@ctypedef CXCursorVisitor (@Ptr){(@Cfunction){(CXChildVisitResult), (@Tuple){(CXCursor), (CXCursor), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	Visit the children of a particular cursor.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4126:25)
	""" clang_visitChildren
	export clang_visitChildren
	@cextern clang_visitChildren(parent::CXCursor, visitor::CXCursorVisitor, client_data::CXClientData)::@Cuint
	
	@doc raw"""
	Retrieve a Unified Symbol Resolution (USR) for the entity referenced
	by the given cursor.
	
	A Unified Symbol Resolution (USR) is a string that identifies a particular
	entity (function, class, variable, etc.) within a program. USRs can be
	compared across translation units to determine, e.g., when references in
	one translation refer to an entity defined in another translation unit.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4177:25)
	""" clang_getCursorUSR
	export clang_getCursorUSR
	@cextern clang_getCursorUSR(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4182:25)
	""" clang_constructUSR_ObjCClass
	export clang_constructUSR_ObjCClass
	@cextern clang_constructUSR_ObjCClass(class_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C category.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4188:3)
	""" clang_constructUSR_ObjCCategory
	export clang_constructUSR_ObjCCategory
	@cextern clang_constructUSR_ObjCCategory(class_name::(@Ptr){(@Cconst)(@Cchar)}, category_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C protocol.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4195:3)
	""" clang_constructUSR_ObjCProtocol
	export clang_constructUSR_ObjCProtocol
	@cextern clang_constructUSR_ObjCProtocol(protocol_name::(@Ptr){(@Cconst)(@Cchar)})::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C instance variable and
	the USR for its containing class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4201:25)
	""" clang_constructUSR_ObjCIvar
	export clang_constructUSR_ObjCIvar
	@cextern clang_constructUSR_ObjCIvar(name::(@Ptr){(@Cconst)(@Cchar)}, classUSR::CXString)::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C method and
	the USR for its containing class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4208:25)
	""" clang_constructUSR_ObjCMethod
	export clang_constructUSR_ObjCMethod
	@cextern clang_constructUSR_ObjCMethod(name::(@Ptr){(@Cconst)(@Cchar)}, isInstanceMethod::(@Cuint), classUSR::CXString)::CXString
	
	@doc raw"""
	Construct a USR for a specified Objective-C property and the USR
	for its containing class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4216:25)
	""" clang_constructUSR_ObjCProperty
	export clang_constructUSR_ObjCProperty
	@cextern clang_constructUSR_ObjCProperty(property::(@Ptr){(@Cconst)(@Cchar)}, classUSR::CXString)::CXString
	
	@doc raw"""
	Retrieve a name for the entity referenced by this cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4222:25)
	""" clang_getCursorSpelling
	export clang_getCursorSpelling
	@cextern clang_getCursorSpelling(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	Retrieve a range for a piece that forms the cursors spelling name.
	Most of the times there is only one range for the complete spelling but for
	Objective-C methods and Objective-C message expressions, there are multiple
	pieces for each selector identifier.
	
	\\param pieceIndex the index of the spelling name piece. If this is greater
	than the actual number of pieces, it will return a NULL (invalid) range.
	
	\\param options Reserved.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4235:30)
	""" clang_Cursor_getSpellingNameRange
	export clang_Cursor_getSpellingNameRange
	@cextern clang_Cursor_getSpellingNameRange(var"?1?"::CXCursor, pieceIndex::(@Cuint), options::(@Cuint))::CXSourceRange
	
	@doc raw"""
	Opaque pointer representing a policy that controls pretty printing
	for \\c clang_getCursorPrettyPrinted.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4243:15)
	""" CXPrintingPolicy
	export CXPrintingPolicy
	@ctypedef CXPrintingPolicy (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4258:3)
	""" CXPrintingPolicy_ConstantArraySizeAsWritten
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4260:3)
	""" CXPrintingPolicy_SuppressStrongLifetime
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4261:3)
	""" CXPrintingPolicy_SuppressLifetimeQualifiers
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4252:3)
	""" CXPrintingPolicy_SuppressSpecifiers
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4265:3)
	""" CXPrintingPolicy_Alignof
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4251:3)
	""" CXPrintingPolicy_Indentation
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4269:3)
	""" CXPrintingPolicy_PolishForDeclaration
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4256:3)
	""" CXPrintingPolicy_SuppressUnwrittenScope
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4264:3)
	""" CXPrintingPolicy_Restrict
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4276:3)
	""" CXPrintingPolicy_FullyQualifiedName
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4253:3)
	""" CXPrintingPolicy_SuppressTagKeyword
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4274:3)
	""" CXPrintingPolicy_ConstantsAsWritten
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4275:3)
	""" CXPrintingPolicy_SuppressImplicitBase
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4278:3)
	""" CXPrintingPolicy_LastProperty
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4257:3)
	""" CXPrintingPolicy_SuppressInitializers
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4270:3)
	""" CXPrintingPolicy_Half
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4272:3)
	""" CXPrintingPolicy_IncludeNewlines
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4271:3)
	""" CXPrintingPolicy_MSWChar
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4263:3)
	""" CXPrintingPolicy_Bool
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4273:3)
	""" CXPrintingPolicy_MSVCFormatting
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4254:3)
	""" CXPrintingPolicy_IncludeTagDefinition
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4255:3)
	""" CXPrintingPolicy_SuppressScope
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4262:3)
	""" CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4266:3)
	""" CXPrintingPolicy_UnderscoreAlignof
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4267:3)
	""" CXPrintingPolicy_UseVoidForZeroParams
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4268:3)
	""" CXPrintingPolicy_TerseOutput
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4259:3)
	""" CXPrintingPolicy_AnonymousTagLocations
	@doc raw"""
	Properties for the printing policy.
	
	See \\c clang::PrintingPolicy for more information.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4250:6)
	""" CXPrintingPolicyProperty
	export CXPrintingPolicyProperty, CXPrintingPolicy_Alignof, CXPrintingPolicy_AnonymousTagLocations, CXPrintingPolicy_Bool, CXPrintingPolicy_ConstantArraySizeAsWritten, CXPrintingPolicy_ConstantsAsWritten, CXPrintingPolicy_FullyQualifiedName, CXPrintingPolicy_Half, CXPrintingPolicy_IncludeNewlines, CXPrintingPolicy_IncludeTagDefinition, CXPrintingPolicy_Indentation, CXPrintingPolicy_LastProperty, CXPrintingPolicy_MSVCFormatting, CXPrintingPolicy_MSWChar, CXPrintingPolicy_PolishForDeclaration, CXPrintingPolicy_Restrict, CXPrintingPolicy_SuppressImplicitBase, CXPrintingPolicy_SuppressInitializers, CXPrintingPolicy_SuppressLifetimeQualifiers, CXPrintingPolicy_SuppressScope, CXPrintingPolicy_SuppressSpecifiers, CXPrintingPolicy_SuppressStrongLifetime, CXPrintingPolicy_SuppressTagKeyword, CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors, CXPrintingPolicy_SuppressUnwrittenScope, CXPrintingPolicy_TerseOutput, CXPrintingPolicy_UnderscoreAlignof, CXPrintingPolicy_UseVoidForZeroParams
	@cenum CXPrintingPolicyProperty {
		CXPrintingPolicy_Indentation = (@Cuint)(0)
		CXPrintingPolicy_SuppressSpecifiers = (@Cuint)(1)
		CXPrintingPolicy_SuppressTagKeyword = (@Cuint)(2)
		CXPrintingPolicy_IncludeTagDefinition = (@Cuint)(3)
		CXPrintingPolicy_SuppressScope = (@Cuint)(4)
		CXPrintingPolicy_SuppressUnwrittenScope = (@Cuint)(5)
		CXPrintingPolicy_SuppressInitializers = (@Cuint)(6)
		CXPrintingPolicy_ConstantArraySizeAsWritten = (@Cuint)(7)
		CXPrintingPolicy_AnonymousTagLocations = (@Cuint)(8)
		CXPrintingPolicy_SuppressStrongLifetime = (@Cuint)(9)
		CXPrintingPolicy_SuppressLifetimeQualifiers = (@Cuint)(10)
		CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors = (@Cuint)(11)
		CXPrintingPolicy_Bool = (@Cuint)(12)
		CXPrintingPolicy_Restrict = (@Cuint)(13)
		CXPrintingPolicy_Alignof = (@Cuint)(14)
		CXPrintingPolicy_UnderscoreAlignof = (@Cuint)(15)
		CXPrintingPolicy_UseVoidForZeroParams = (@Cuint)(16)
		CXPrintingPolicy_TerseOutput = (@Cuint)(17)
		CXPrintingPolicy_PolishForDeclaration = (@Cuint)(18)
		CXPrintingPolicy_Half = (@Cuint)(19)
		CXPrintingPolicy_MSWChar = (@Cuint)(20)
		CXPrintingPolicy_IncludeNewlines = (@Cuint)(21)
		CXPrintingPolicy_MSVCFormatting = (@Cuint)(22)
		CXPrintingPolicy_ConstantsAsWritten = (@Cuint)(23)
		CXPrintingPolicy_SuppressImplicitBase = (@Cuint)(24)
		CXPrintingPolicy_FullyQualifiedName = (@Cuint)(25)
		CXPrintingPolicy_LastProperty = (@Cuint)(25)
	}
	
	@doc raw"""
	Get a property value for the given printing policy.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4285:1)
	""" clang_PrintingPolicy_getProperty
	export clang_PrintingPolicy_getProperty
	@cextern clang_PrintingPolicy_getProperty(Policy::CXPrintingPolicy, Property::CXPrintingPolicyProperty)::@Cuint
	
	@doc raw"""
	Set a property value for the given printing policy.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4291:21)
	""" clang_PrintingPolicy_setProperty
	export clang_PrintingPolicy_setProperty
	@cextern clang_PrintingPolicy_setProperty(Policy::CXPrintingPolicy, Property::CXPrintingPolicyProperty, Value::(@Cuint))::@Cvoid
	
	@doc raw"""
	Retrieve the default policy for the cursor.
	
	The policy should be released after use with \\c
	clang_PrintingPolicy_dispose.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4301:33)
	""" clang_getCursorPrintingPolicy
	export clang_getCursorPrintingPolicy
	@cextern clang_getCursorPrintingPolicy(var"?1?"::CXCursor)::CXPrintingPolicy
	
	@doc raw"""
	Release a printing policy.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4306:21)
	""" clang_PrintingPolicy_dispose
	export clang_PrintingPolicy_dispose
	@cextern clang_PrintingPolicy_dispose(Policy::CXPrintingPolicy)::@Cvoid
	
	@doc raw"""
	Pretty print declarations.
	
	\\param Cursor The cursor representing a declaration.
	
	\\param Policy The policy to control the entities being printed. If
	NULL, a default policy is used.
	
	\\returns The pretty printed declaration or the empty string for
	other cursors.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4319:25)
	""" clang_getCursorPrettyPrinted
	export clang_getCursorPrettyPrinted
	@cextern clang_getCursorPrettyPrinted(Cursor::CXCursor, Policy::CXPrintingPolicy)::CXString
	
	@doc raw"""
	Retrieve the display name for the entity referenced by this cursor.
	
	The display name contains extra information that helps identify the cursor,
	such as the parameters of a function or template or the arguments of a
	class template specialization.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4329:25)
	""" clang_getCursorDisplayName
	export clang_getCursorDisplayName
	@cextern clang_getCursorDisplayName(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	For a cursor that is a reference, retrieve a cursor representing the
	entity that it references.
	
	Reference cursors refer to other entities in the AST. For example, an
	Objective-C superclass reference cursor refers to an Objective-C class.
	This function produces the cursor for the Objective-C class from the
	cursor for the superclass reference. If the input cursor is a declaration or
	definition, it returns that declaration or definition unchanged.
	Otherwise, returns the NULL cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4341:25)
	""" clang_getCursorReferenced
	export clang_getCursorReferenced
	@cextern clang_getCursorReferenced(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	For a cursor that is either a reference to or a declaration
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4371:25)
	""" clang_getCursorDefinition
	export clang_getCursorDefinition
	@cextern clang_getCursorDefinition(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	Determine whether the declaration pointed to by this cursor
	is also a definition of that entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4377:25)
	""" clang_isCursorDefinition
	export clang_isCursorDefinition
	@cextern clang_isCursorDefinition(var"?1?"::CXCursor)::@Cuint
	
	@doc raw"""
	Retrieve the canonical cursor corresponding to the given cursor.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4403:25)
	""" clang_getCanonicalCursor
	export clang_getCanonicalCursor
	@cextern clang_getCanonicalCursor(var"?1?"::CXCursor)::CXCursor
	
	@doc raw"""
	If the cursor points to a selector identifier in an Objective-C
	method or message expression, this returns the selector index.
	
	After getting a cursor with #clang_getCursor, this can be called to
	determine if the location points to a selector identifier.
	
	\\returns The selector index if the cursor is an Objective-C method or message
	expression and the cursor is pointing to a selector identifier, or -1
	otherwise.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4416:20)
	""" clang_Cursor_getObjCSelectorIndex
	export clang_Cursor_getObjCSelectorIndex
	@cextern clang_Cursor_getObjCSelectorIndex(var"?1?"::CXCursor)::@Cint
	
	@doc raw"""
	Given a cursor pointing to a C++ method call or an Objective-C
	message, returns non-zero if the method/message is "dynamic", meaning:
	
	For a C++ method: the call is virtual.
	For an Objective-C message: the receiver is an object instance, not 'super'
	or a specific class.
	
	If the method/message is "static" or the cursor does not point to a
	method/message, it will return zero.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4429:20)
	""" clang_Cursor_isDynamicCall
	export clang_Cursor_isDynamicCall
	@cextern clang_Cursor_isDynamicCall(C::CXCursor)::@Cint
	
	@doc raw"""
	Given a cursor pointing to an Objective-C message or property
	reference, or C++ method call, returns the CXType of the receiver.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4435:23)
	""" clang_Cursor_getReceiverType
	export clang_Cursor_getReceiverType
	@cextern clang_Cursor_getReceiverType(C::CXCursor)::CXType
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4444:3)
	""" CXObjCPropertyAttr_assign
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4445:3)
	""" CXObjCPropertyAttr_readwrite
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4455:3)
	""" CXObjCPropertyAttrKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4442:3)
	""" CXObjCPropertyAttr_readonly
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4448:3)
	""" CXObjCPropertyAttr_nonatomic
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4450:3)
	""" CXObjCPropertyAttr_atomic
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4441:3)
	""" CXObjCPropertyAttr_noattr
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4443:3)
	""" CXObjCPropertyAttr_getter
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4447:3)
	""" CXObjCPropertyAttr_copy
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4452:3)
	""" CXObjCPropertyAttr_strong
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4451:3)
	""" CXObjCPropertyAttr_weak
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4449:3)
	""" CXObjCPropertyAttr_setter
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4453:3)
	""" CXObjCPropertyAttr_unsafe_unretained
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4446:3)
	""" CXObjCPropertyAttr_retain
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4454:3)
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
	Given a cursor that represents a property declaration, return the
	associated property attributes. The bits are formed from
	\\c CXObjCPropertyAttrKind.
	
	\\param reserved Reserved for future use, pass 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4464:25)
	""" clang_Cursor_getObjCPropertyAttributes
	export clang_Cursor_getObjCPropertyAttributes
	@cextern clang_Cursor_getObjCPropertyAttributes(C::CXCursor, reserved::(@Cuint))::@Cuint
	
	@doc raw"""
	Given a cursor that represents a property declaration, return the
	name of the method that implements the getter.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4471:25)
	""" clang_Cursor_getObjCPropertyGetterName
	export clang_Cursor_getObjCPropertyGetterName
	@cextern clang_Cursor_getObjCPropertyGetterName(C::CXCursor)::CXString
	
	@doc raw"""
	Given a cursor that represents a property declaration, return the
	name of the method that implements the setter, if any.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4477:25)
	""" clang_Cursor_getObjCPropertySetterName
	export clang_Cursor_getObjCPropertySetterName
	@cextern clang_Cursor_getObjCPropertySetterName(C::CXCursor)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4490:3)
	""" CXObjCDeclQualifier_Oneway
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4485:3)
	""" CXObjCDeclQualifier_In
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4484:3)
	""" CXObjCDeclQualifier_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4486:3)
	""" CXObjCDeclQualifier_Inout
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4487:3)
	""" CXObjCDeclQualifier_Out
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4491:3)
	""" CXObjCDeclQualifierKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4488:3)
	""" CXObjCDeclQualifier_Bycopy
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4489:3)
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
	Given a cursor that represents an Objective-C method or parameter
	declaration, return the associated Objective-C qualifiers for the return
	type or the parameter respectively. The bits are formed from
	CXObjCDeclQualifierKind.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4499:25)
	""" clang_Cursor_getObjCDeclQualifiers
	export clang_Cursor_getObjCDeclQualifiers
	@cextern clang_Cursor_getObjCDeclQualifiers(C::CXCursor)::@Cuint
	
	@doc raw"""
	Given a cursor that represents an Objective-C method or property
	declaration, return non-zero if the declaration was affected by "\\@optional".
	Returns zero if the cursor is not such a declaration or it is "\\@required".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4506:25)
	""" clang_Cursor_isObjCOptional
	export clang_Cursor_isObjCOptional
	@cextern clang_Cursor_isObjCOptional(C::CXCursor)::@Cuint
	
	@doc raw"""
	Returns non-zero if the given cursor is a variadic function or method.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4511:25)
	""" clang_Cursor_isVariadic
	export clang_Cursor_isVariadic
	@cextern clang_Cursor_isVariadic(C::CXCursor)::@Cuint
	
	@doc raw"""
	Returns non-zero if the given cursor points to a symbol marked with
	external_source_symbol attribute.
	
	\\param language If non-NULL, and the attribute is present, will be set to
	the 'language' string from the attribute.
	
	\\param definedIn If non-NULL, and the attribute is present, will be set to
	the 'definedIn' string from the attribute.
	
	\\param isGenerated If non-NULL, and the attribute is present, will be set to
	non-zero if the 'generated_declaration' is set in the attribute.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4526:25)
	""" clang_Cursor_isExternalSymbol
	export clang_Cursor_isExternalSymbol
	@cextern clang_Cursor_isExternalSymbol(C::CXCursor, language::(@Ptr){CXString}, definedIn::(@Ptr){CXString}, isGenerated::(@Ptr){@Cuint})::@Cuint
	
	@doc raw"""
	Given a cursor that represents a declaration, return the associated
	comment's source range.  The range may include multiple consecutive comments
	with whitespace in between.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4535:30)
	""" clang_Cursor_getCommentRange
	export clang_Cursor_getCommentRange
	@cextern clang_Cursor_getCommentRange(C::CXCursor)::CXSourceRange
	
	@doc raw"""
	Given a cursor that represents a declaration, return the associated
	comment text, including comment markers.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4541:25)
	""" clang_Cursor_getRawCommentText
	export clang_Cursor_getRawCommentText
	@cextern clang_Cursor_getRawCommentText(C::CXCursor)::CXString
	
	@doc raw"""
	Given a cursor that represents a documentable entity (e.g.,
	declaration), return the associated \\paragraph; otherwise return the
	first paragraph.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4548:25)
	""" clang_Cursor_getBriefCommentText
	export clang_Cursor_getBriefCommentText
	@cextern clang_Cursor_getBriefCommentText(C::CXCursor)::CXString
	
	@doc raw"""
	Retrieve the CXString representing the mangled name of the cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4562:25)
	""" clang_Cursor_getMangling
	export clang_Cursor_getMangling
	@cextern clang_Cursor_getMangling(var"?1?"::CXCursor)::CXString
	
	@doc raw"""
	Retrieve the CXStrings representing the mangled symbols of the C++
	constructor or destructor at the cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4568:29)
	""" clang_Cursor_getCXXManglings
	export clang_Cursor_getCXXManglings
	@cextern clang_Cursor_getCXXManglings(var"?1?"::CXCursor)::(@Ptr){CXStringSet}
	
	@doc raw"""
	Retrieve the CXStrings representing the mangled symbols of the ObjC
	class interface or implementation at the cursor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4574:29)
	""" clang_Cursor_getObjCManglings
	export clang_Cursor_getObjCManglings
	@cextern clang_Cursor_getObjCManglings(var"?1?"::CXCursor)::(@Ptr){CXStringSet}
	
	@doc raw"""
	\\defgroup CINDEX_MODULE Module introspection
	
	The functions in this group provide access to information about modules.
	
	@{
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4588:15)
	""" CXModule
	export CXModule
	@ctypedef CXModule (@Ptr){@Cvoid}
	
	@doc raw"""
	Given a CXCursor_ModuleImportDecl cursor, return the associated module.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4593:25)
	""" clang_Cursor_getModule
	export clang_Cursor_getModule
	@cextern clang_Cursor_getModule(C::CXCursor)::CXModule
	
	@doc raw"""
	Given a CXFile header file, return the module that contains it, if one
	exists.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4599:25)
	""" clang_getModuleForFile
	export clang_getModuleForFile
	@cextern clang_getModuleForFile(var"?1?"::CXTranslationUnit, var"?2?"::CXFile)::CXModule
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the module file where the provided module object came from.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4606:23)
	""" clang_Module_getASTFile
	export clang_Module_getASTFile
	@cextern clang_Module_getASTFile(Module::CXModule)::CXFile
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the parent of a sub-module or NULL if the given module is top-level,
	e.g. for 'std.vector' it will return the 'std' module.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4614:25)
	""" clang_Module_getParent
	export clang_Module_getParent
	@cextern clang_Module_getParent(Module::CXModule)::CXModule
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the name of the module, e.g. for the 'std.vector' sub-module it
	will return "vector".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4622:25)
	""" clang_Module_getName
	export clang_Module_getName
	@cextern clang_Module_getName(Module::CXModule)::CXString
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the full name of the module, e.g. "std.vector".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4629:25)
	""" clang_Module_getFullName
	export clang_Module_getFullName
	@cextern clang_Module_getFullName(Module::CXModule)::CXString
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns non-zero if the module is a system one.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4636:20)
	""" clang_Module_isSystem
	export clang_Module_isSystem
	@cextern clang_Module_isSystem(Module::CXModule)::@Cint
	
	@doc raw"""
	\\param Module a module object.
	
	\\returns the number of top level headers associated with this module.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4643:25)
	""" clang_Module_getNumTopLevelHeaders
	export clang_Module_getNumTopLevelHeaders
	@cextern clang_Module_getNumTopLevelHeaders(var"?1?"::CXTranslationUnit, Module::CXModule)::@Cuint
	
	@doc raw"""
	\\param Module a module object.
	
	\\param Index top level header index (zero-based).
	
	\\returns the specified top level header associated with the module.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4654:8)
	""" clang_Module_getTopLevelHeader
	export clang_Module_getTopLevelHeader
	@cextern clang_Module_getTopLevelHeader(var"?1?"::CXTranslationUnit, Module::CXModule, Index::(@Cuint))::CXFile
	
	@doc raw"""
	Determine if a C++ constructor is a converting constructor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4673:25)
	""" clang_CXXConstructor_isConvertingConstructor
	export clang_CXXConstructor_isConvertingConstructor
	@cextern clang_CXXConstructor_isConvertingConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ constructor is a copy constructor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4678:25)
	""" clang_CXXConstructor_isCopyConstructor
	export clang_CXXConstructor_isCopyConstructor
	@cextern clang_CXXConstructor_isCopyConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ constructor is the default constructor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4683:25)
	""" clang_CXXConstructor_isDefaultConstructor
	export clang_CXXConstructor_isDefaultConstructor
	@cextern clang_CXXConstructor_isDefaultConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ constructor is a move constructor.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4688:25)
	""" clang_CXXConstructor_isMoveConstructor
	export clang_CXXConstructor_isMoveConstructor
	@cextern clang_CXXConstructor_isMoveConstructor(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ field is declared 'mutable'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4693:25)
	""" clang_CXXField_isMutable
	export clang_CXXField_isMutable
	@cextern clang_CXXField_isMutable(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ method is declared '= default'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4698:25)
	""" clang_CXXMethod_isDefaulted
	export clang_CXXMethod_isDefaulted
	@cextern clang_CXXMethod_isDefaulted(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ member function or member function template is
	pure virtual.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4704:25)
	""" clang_CXXMethod_isPureVirtual
	export clang_CXXMethod_isPureVirtual
	@cextern clang_CXXMethod_isPureVirtual(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ member function or member function template is
	declared 'static'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4710:25)
	""" clang_CXXMethod_isStatic
	export clang_CXXMethod_isStatic
	@cextern clang_CXXMethod_isStatic(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ member function or member function template is
	explicitly declared 'virtual' or if it overrides a virtual method from
	one of the base classes.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4717:25)
	""" clang_CXXMethod_isVirtual
	export clang_CXXMethod_isVirtual
	@cextern clang_CXXMethod_isVirtual(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ record is abstract, i.e. whether a class or struct
	has a pure virtual member function.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4723:25)
	""" clang_CXXRecord_isAbstract
	export clang_CXXRecord_isAbstract
	@cextern clang_CXXRecord_isAbstract(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if an enum declaration refers to a scoped enum.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4728:25)
	""" clang_EnumDecl_isScoped
	export clang_EnumDecl_isScoped
	@cextern clang_EnumDecl_isScoped(C::CXCursor)::@Cuint
	
	@doc raw"""
	Determine if a C++ member function or member function template is
	declared 'const'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4734:25)
	""" clang_CXXMethod_isConst
	export clang_CXXMethod_isConst
	@cextern clang_CXXMethod_isConst(C::CXCursor)::@Cuint
	
	@doc raw"""
	Given a cursor that represents a template, determine
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4753:34)
	""" clang_getTemplateCursorKind
	export clang_getTemplateCursorKind
	@cextern clang_getTemplateCursorKind(C::CXCursor)::CXCursorKind
	
	@doc raw"""
	Given a cursor that may represent a specialization or instantiation
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4783:25)
	""" clang_getSpecializedCursorTemplate
	export clang_getSpecializedCursorTemplate
	@cextern clang_getSpecializedCursorTemplate(C::CXCursor)::CXCursor
	
	@doc raw"""
	Given a cursor that references something else, return the source range
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4803:30)
	""" clang_getCursorReferenceNameRange
	export clang_getCursorReferenceNameRange
	@cextern clang_getCursorReferenceNameRange(C::CXCursor, NameFlags::(@Cuint), PieceIndex::(@Cuint))::CXSourceRange
	
	@doc raw"""
	Include the nested-name-specifier, e.g. Foo:: in x.Foo::y, in the
	range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4812:3)
	""" CXNameRange_WantQualifier
	@doc raw"""
	If the name is non-contiguous, return the full spanning range.
	
	Non-contiguous names occur in Objective-C when a selector with two or more
	parameters is used, or in C++ when using an operator:
	\\code
	[object doSomething:here withValue:there]; // Objective-C
	return some_vector[1]; // C++
	\\endcode
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4830:3)
	""" CXNameRange_WantSinglePiece
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4807:6)
	""" CXNameRefFlags
	@doc raw"""
	Include the explicit template arguments, e.g. \\<int> in x.f<int>,
	in the range.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4818:3)
	""" CXNameRange_WantTemplateArgs
	export CXNameRange_WantQualifier, CXNameRange_WantSinglePiece, CXNameRange_WantTemplateArgs, CXNameRefFlags
	@cenum CXNameRefFlags {
		CXNameRange_WantQualifier = (@Cuint)(1)
		CXNameRange_WantTemplateArgs = (@Cuint)(2)
		CXNameRange_WantSinglePiece = (@Cuint)(4)
	}
	
	@doc raw"""
	Describes a kind of token.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4850:14)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4875:3)
	""" CXTokenKind
	@doc raw"""
	A comment.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4874:3)
	""" CXToken_Comment
	@doc raw"""
	An identifier (that is not a keyword).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4864:3)
	""" CXToken_Identifier
	@doc raw"""
	A language keyword.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4859:3)
	""" CXToken_Keyword
	@doc raw"""
	A numeric, string, or character literal.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4869:3)
	""" CXToken_Literal
	@doc raw"""
	A token that contains some kind of punctuation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4854:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4883:3)
	""" CXToken
	export CXToken
	@ctypedef CXToken @cstruct {
		int_data::(@Cuint)[4]
		ptr_data::(@Ptr){@Cvoid}
	}
	
	@doc raw"""
	Get the raw lexical token starting with the given location.
	
	\\param TU the translation unit whose text is being tokenized.
	
	\\param Location the source location with which the token starts.
	
	\\returns The token starting with the given location or NULL if no such token
	exist. The returned pointer must be freed with clang_disposeTokens before the
	translation unit is destroyed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4896:25)
	""" clang_getToken
	export clang_getToken
	@cextern clang_getToken(TU::CXTranslationUnit, Location::CXSourceLocation)::(@Ptr){CXToken}
	
	@doc raw"""
	Determine the kind of the given token.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4902:28)
	""" clang_getTokenKind
	export clang_getTokenKind
	@cextern clang_getTokenKind(var"?1?"::CXToken)::CXTokenKind
	
	@doc raw"""
	Determine the spelling of the given token.
	
	The spelling of a token is the textual representation of that token, e.g.,
	the text of an identifier or keyword.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4910:25)
	""" clang_getTokenSpelling
	export clang_getTokenSpelling
	@cextern clang_getTokenSpelling(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXString
	
	@doc raw"""
	Retrieve the source location of the given token.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4915:33)
	""" clang_getTokenLocation
	export clang_getTokenLocation
	@cextern clang_getTokenLocation(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXSourceLocation
	
	@doc raw"""
	Retrieve a source range that covers the given token.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4921:30)
	""" clang_getTokenExtent
	export clang_getTokenExtent
	@cextern clang_getTokenExtent(var"?1?"::CXTranslationUnit, var"?2?"::CXToken)::CXSourceRange
	
	@doc raw"""
	Tokenize the source code described by the given range into raw
	lexical tokens.
	
	\\param TU the translation unit whose text is being tokenized.
	
	\\param Range the source range in which text should be tokenized. All of the
	tokens produced by tokenization will fall within this source range,
	
	\\param Tokens this pointer will be set to point to the array of tokens
	that occur within the given source range. The returned pointer must be
	freed with clang_disposeTokens() before the translation unit is destroyed.
	
	\\param NumTokens will be set to the number of tokens in the \\c *Tokens
	array.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4940:21)
	""" clang_tokenize
	export clang_tokenize
	@cextern clang_tokenize(TU::CXTranslationUnit, Range::CXSourceRange, Tokens::(@Ptr){(@Ptr){CXToken}}, NumTokens::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Annotate the given set of tokens by providing cursors for each token
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4973:21)
	""" clang_annotateTokens
	export clang_annotateTokens
	@cextern clang_annotateTokens(TU::CXTranslationUnit, Tokens::(@Ptr){CXToken}, NumTokens::(@Cuint), Cursors::(@Ptr){CXCursor})::@Cvoid
	
	@doc raw"""
	Free the given set of tokens.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4980:21)
	""" clang_disposeTokens
	export clang_disposeTokens
	@cextern clang_disposeTokens(TU::CXTranslationUnit, Tokens::(@Ptr){CXToken}, NumTokens::(@Cuint))::@Cvoid
	
	@doc raw"""
	\\defgroup CINDEX_DEBUG Debugging facilities
	
	These routines are used for testing and debugging, only, and should not
	be relied upon.
	
	@{
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4997:25)
	""" clang_getCursorKindSpelling
	export clang_getCursorKindSpelling
	@cextern clang_getCursorKindSpelling(Kind::CXCursorKind)::CXString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:4998:21)
	""" clang_getDefinitionSpellingAndExtent
	export clang_getDefinitionSpellingAndExtent
	@cextern clang_getDefinitionSpellingAndExtent(var"?1?"::CXCursor, startBuf::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, endBuf::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, startLine::(@Ptr){@Cuint}, startColumn::(@Ptr){@Cuint}, endLine::(@Ptr){@Cuint}, endColumn::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5005:21)
	""" clang_enableStackTraces
	export clang_enableStackTraces
	@cextern clang_enableStackTraces()::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5006:21)
	""" clang_executeOnThread
	export clang_executeOnThread
	@cextern clang_executeOnThread(fn::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){((@Ptr){@Cvoid})}, (@CDECL)}}, user_data::(@Ptr){@Cvoid}, stack_size::(@Cuint))::@Cvoid
	
	@doc raw"""
	A semantic string that describes a code-completion result.
	
	A semantic string that describes the formatting of a code-completion
	result as a single "template" of text that should be inserted into the
	source buffer when a particular code-completion result is selected.
	Each semantic string is made up of some number of "chunks", each of which
	contains some text along with a description of what that text means, e.g.,
	the name of the entity being referenced, whether the text chunk is part of
	the template, or whether it is a "placeholder" that the user should replace
	with actual code,of a specific kind. See \\c CXCompletionChunkKind for a
	description of the different kinds of chunks.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5038:15)
	""" CXCompletionString
	export CXCompletionString
	@ctypedef CXCompletionString (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5061:3)
	""" CXCompletionResult
	export CXCompletionResult
	@ctypedef CXCompletionResult @cstruct {
		CursorKind::CXCursorKind
		CompletionString::CXCompletionString
	}
	
	@doc raw"""
	A semicolon (';').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5218:3)
	""" CXCompletionChunk_SemiColon
	@doc raw"""
	A comma separator (',').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5202:3)
	""" CXCompletionChunk_Comma
	@doc raw"""
	A code-completion string that describes "optional" text that
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5104:3)
	""" CXCompletionChunk_Optional
	@doc raw"""
	An '=' sign.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5222:3)
	""" CXCompletionChunk_Equal
	@doc raw"""
	Text that a user would be expected to type to get this
	code-completion result.
	
	There will be exactly one "typed text" chunk in a semantic string, which
	will typically provide the spelling of a keyword or the name of a
	declaration that could be used at the current code point. Clients are
	expected to filter the code-completion results based on the text in this
	chunk.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5115:3)
	""" CXCompletionChunk_TypedText
	@doc raw"""
	Text that describes the current parameter when code-completion is
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
	"current parameter" chunk to "int y".
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5164:3)
	""" CXCompletionChunk_CurrentParameter
	@doc raw"""
	A left parenthesis ('('), used to initiate a function call or
	signal the beginning of a function parameter list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5169:3)
	""" CXCompletionChunk_LeftParen
	@doc raw"""
	A right bracket (']').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5182:3)
	""" CXCompletionChunk_RightBracket
	@doc raw"""
	Vertical space ('\\\\n'), after which it is generally a good idea to
	perform indentation.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5231:3)
	""" CXCompletionChunk_VerticalSpace
	@doc raw"""
	A right brace ('}').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5190:3)
	""" CXCompletionChunk_RightBrace
	@doc raw"""
	A left bracket ('[').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5178:3)
	""" CXCompletionChunk_LeftBracket
	@doc raw"""
	A right parenthesis (')'), used to finish a function call or
	signal the end of a function parameter list.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5174:3)
	""" CXCompletionChunk_RightParen
	@doc raw"""
	Text that specifies the result type of a given result.
	
	This special kind of informative chunk is not meant to be inserted into
	the text buffer. Rather, it is meant to illustrate the type that an
	expression using the given completion string would have.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5210:3)
	""" CXCompletionChunk_ResultType
	@doc raw"""
	Horizontal space (' ').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5226:3)
	""" CXCompletionChunk_HorizontalSpace
	@doc raw"""
	A colon (':').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5214:3)
	""" CXCompletionChunk_Colon
	@doc raw"""
	Text that should be inserted as part of a code-completion result.
	
	A "text" chunk represents text that is part of the template to be
	inserted into user code should this particular code-completion result
	be selected.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5123:3)
	""" CXCompletionChunk_Text
	@doc raw"""
	Placeholder text that should be replaced by the user.
	
	A "placeholder" chunk marks a place where the user should insert text
	into the code-completion template. For example, placeholders might mark
	the function parameters for a function declaration, to indicate that the
	user should provide arguments for each of those parameters. The actual
	text in a placeholder is a suggestion for the text to display before
	the user replaces the placeholder with real code.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5134:3)
	""" CXCompletionChunk_Placeholder
	@doc raw"""
	A left brace ('{').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5186:3)
	""" CXCompletionChunk_LeftBrace
	@doc raw"""
	A left angle bracket ('<').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5194:3)
	""" CXCompletionChunk_LeftAngle
	@doc raw"""
	Describes a single piece of text within a code-completion string.
	
	Each "chunk" within a code-completion string (\\c CXCompletionString) is
	either a piece of text with a specific "kind" that describes how that text
	should be interpreted by the client or is another completion string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5070:6)
	""" CXCompletionChunkKind
	@doc raw"""
	Informative text that should be displayed but never inserted as
	part of the template.
	
	An "informative" chunk contains annotations that can be displayed to
	help the user decide whether a particular code-completion result is the
	right option, but which is not part of the actual template to be inserted
	by code completion.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5144:3)
	""" CXCompletionChunk_Informative
	@doc raw"""
	A right angle bracket ('>').
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5198:3)
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
	Determine the kind of a particular chunk within a completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the kind of the chunk at the index \\c chunk_number.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5244:1)
	""" clang_getCompletionChunkKind
	export clang_getCompletionChunkKind
	@cextern clang_getCompletionChunkKind(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXCompletionChunkKind
	
	@doc raw"""
	Retrieve the text associated with a particular chunk within a
	completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the text associated with the chunk at index \\c chunk_number.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5258:1)
	""" clang_getCompletionChunkText
	export clang_getCompletionChunkText
	@cextern clang_getCompletionChunkText(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXString
	
	@doc raw"""
	Retrieve the completion string associated with a particular chunk
	within a completion string.
	
	\\param completion_string the completion string to query.
	
	\\param chunk_number the 0-based index of the chunk in the completion string.
	
	\\returns the completion string associated with the chunk at index
	\\c chunk_number.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5273:1)
	""" clang_getCompletionChunkCompletionString
	export clang_getCompletionChunkCompletionString
	@cextern clang_getCompletionChunkCompletionString(completion_string::CXCompletionString, chunk_number::(@Cuint))::CXCompletionString
	
	@doc raw"""
	Retrieve the number of chunks in the given code-completion string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5280:1)
	""" clang_getNumCompletionChunks
	export clang_getNumCompletionChunks
	@cextern clang_getNumCompletionChunks(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	Determine the priority of this code completion.
	
	The priority of a code completion indicates how likely it is that this
	particular completion is the completion that the user will select. The
	priority is selected by various internal heuristics.
	
	\\param completion_string The completion string to query.
	
	\\returns The priority of this completion string. Smaller values indicate
	higher-priority (more likely) completions.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5295:1)
	""" clang_getCompletionPriority
	export clang_getCompletionPriority
	@cextern clang_getCompletionPriority(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	Determine the availability of the entity that this code-completion
	string refers to.
	
	\\param completion_string The completion string to query.
	
	\\returns The availability of the completion string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5306:1)
	""" clang_getCompletionAvailability
	export clang_getCompletionAvailability
	@cextern clang_getCompletionAvailability(completion_string::CXCompletionString)::CXAvailabilityKind
	
	@doc raw"""
	Retrieve the number of annotations associated with the given
	completion string.
	
	\\param completion_string the completion string to query.
	
	\\returns the number of annotations associated with the given completion
	string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5318:1)
	""" clang_getCompletionNumAnnotations
	export clang_getCompletionNumAnnotations
	@cextern clang_getCompletionNumAnnotations(completion_string::CXCompletionString)::@Cuint
	
	@doc raw"""
	Retrieve the annotation associated with the given completion string.
	
	\\param completion_string the completion string to query.
	
	\\param annotation_number the 0-based index of the annotation of the
	completion string.
	
	\\returns annotation string associated with the completion at index
	\\c annotation_number, or a NULL string if that annotation is not available.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5332:1)
	""" clang_getCompletionAnnotation
	export clang_getCompletionAnnotation
	@cextern clang_getCompletionAnnotation(completion_string::CXCompletionString, annotation_number::(@Cuint))::CXString
	
	@doc raw"""
	Retrieve the parent context of the given completion string.
	
	The parent context of a completion string is the semantic parent of
	the declaration (if any) that the code completion represents. For example,
	a code completion for an Objective-C method would have the method's class
	or protocol as its context.
	
	\\param completion_string The code completion string whose parent is
	being queried.
	
	\\param kind DEPRECATED: always set to CXCursor_NotImplemented if non-NULL.
	
	\\returns The name of the completion parent, e.g., "NSObject" if
	the completion string represents a method in the NSObject class.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5352:1)
	""" clang_getCompletionParent
	export clang_getCompletionParent
	@cextern clang_getCompletionParent(completion_string::CXCompletionString, kind::(@Ptr){CXCursorKind})::CXString
	
	@doc raw"""
	Retrieve the brief documentation comment attached to the declaration
	that corresponds to the given completion string.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5360:1)
	""" clang_getCompletionBriefComment
	export clang_getCompletionBriefComment
	@cextern clang_getCompletionBriefComment(completion_string::CXCompletionString)::CXString
	
	@doc raw"""
	Retrieve a completion string for an arbitrary declaration or macro
	definition cursor.
	
	\\param cursor The cursor to query.
	
	\\returns A non-context-sensitive completion string for declaration and macro
	definition cursors, or NULL for other kinds of cursors.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5372:1)
	""" clang_getCursorCompletionString
	export clang_getCursorCompletionString
	@cextern clang_getCursorCompletionString(cursor::CXCursor)::CXCompletionString
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5392:3)
	""" CXCodeCompleteResults
	export CXCodeCompleteResults
	@ctypedef CXCodeCompleteResults @cstruct {
		Results::(@Ptr){CXCompletionResult}
		NumResults::@Cuint
	}
	
	@doc raw"""
	Retrieve the number of fix-its for the given completion index.
	
	Calling this makes sense only if CXCodeComplete_IncludeCompletionsWithFixIts
	option was set.
	
	\\param results The structure keeping all completion results
	
	\\param completion_index The index of the completion
	
	\\return The number of fix-its which must be applied before the completion at
	completion_index can be applied
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5408:1)
	""" clang_getCompletionNumFixIts
	export clang_getCompletionNumFixIts
	@cextern clang_getCompletionNumFixIts(results::(@Ptr){CXCodeCompleteResults}, completion_index::(@Cuint))::@Cuint
	
	@doc raw"""
	Fix-its that *must* be applied before inserting the text for the
	corresponding completion.
	
	By default, clang_codeCompleteAt() only returns completions with empty
	fix-its. Extra completions with non-empty fix-its should be explicitly
	requested by setting CXCodeComplete_IncludeCompletionsWithFixIts.
	
	For the clients to be able to compute position of the cursor after applying
	fix-its, the following conditions are guaranteed to hold for
	replacement_range of the stored fix-its:
	- Ranges in the fix-its are guaranteed to never contain the completion
	point (or identifier under completion point, if any) inside them, except
	at the start or at the end of the range.
	- If a fix-it range starts or ends with completion point (or starts or
	ends after the identifier under completion point), it will contain at
	least one character. It allows to unambiguously recompute completion
	point after applying the fix-it.
	
	The intuition is that provided fix-its change code around the identifier we
	complete, but are not allowed to touch the identifier itself or the
	completion point. One example of completions with corrections are the ones
	replacing '.' with '->' and vice versa:
	
	std::unique_ptr<std::vector<int>> vec_ptr;
	In 'vec_ptr.^', one of the completions is 'push_back', it requires
	replacing '.' with '->'.
	In 'vec_ptr->^', one of the completions is 'release', it requires
	replacing '->' with '.'.
	
	\\param results The structure keeping all completion results
	
	\\param completion_index The index of the completion
	
	\\param fixit_index The index of the fix-it for the completion at
	completion_index
	
	\\param replacement_range The fix-it range that must be replaced before the
	completion at completion_index can be applied
	
	\\returns The fix-it string that must replace the code at replacement_range
	before the completion at completion_index can be applied
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5454:25)
	""" clang_getCompletionFixIt
	export clang_getCompletionFixIt
	@cextern clang_getCompletionFixIt(results::(@Ptr){CXCodeCompleteResults}, completion_index::(@Cuint), fixit_index::(@Cuint), replacement_range::(@Ptr){CXSourceRange})::CXString
	
	@doc raw"""
	Whether to speed up completion by omitting top- or namespace-level entities
	defined in the preamble. There's no guarantee any particular entity is
	omitted. This may be useful if the headers are indexed externally.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5489:3)
	""" CXCodeComplete_SkipPreamble
	@doc raw"""
	Flags that can be passed to \\c clang_codeCompleteAt() to
	modify its behavior.
	
	The enumerators in this enumeration can be bitwise-OR'd together to
	provide multiple options to \\c clang_codeCompleteAt().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5465:6)
	""" CXCodeComplete_Flags
	@doc raw"""
	Whether to include macros within the set of code
	completions returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5470:3)
	""" CXCodeComplete_IncludeMacros
	@doc raw"""
	Whether to include completions with small
	fix-its, e.g. change '.' to '->' on member access, etc.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5495:3)
	""" CXCodeComplete_IncludeCompletionsWithFixIts
	@doc raw"""
	Whether to include brief documentation within the set of code
	completions returned.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5482:3)
	""" CXCodeComplete_IncludeBriefComments
	@doc raw"""
	Whether to include code patterns for language constructs
	within the set of code completions, e.g., for loops.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5476:3)
	""" CXCodeComplete_IncludeCodePatterns
	export CXCodeComplete_Flags, CXCodeComplete_IncludeBriefComments, CXCodeComplete_IncludeCodePatterns, CXCodeComplete_IncludeCompletionsWithFixIts, CXCodeComplete_IncludeMacros, CXCodeComplete_SkipPreamble
	@cenum CXCodeComplete_Flags {
		CXCodeComplete_IncludeMacros = (@Cuint)(1)
		CXCodeComplete_IncludeCodePatterns = (@Cuint)(2)
		CXCodeComplete_IncludeBriefComments = (@Cuint)(4)
		CXCodeComplete_SkipPreamble = (@Cuint)(8)
		CXCodeComplete_IncludeCompletionsWithFixIts = (@Cuint)(16)
	}
	
	@doc raw"""
	Completions for Objective-C class messages should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5605:3)
	""" CXCompletionContext_ObjCClassMessage
	@doc raw"""
	Completions for any possible value (variables, function calls, etc.)
	should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5520:3)
	""" CXCompletionContext_AnyValue
	@doc raw"""
	Bits that represent the context under which completion is occurring.
	
	The enumerators in this enumeration may be bitwise-OR'd together if multiple
	contexts are occurring simultaneously.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5504:6)
	""" CXCompletionContext
	@doc raw"""
	Natural language completions should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5621:3)
	""" CXCompletionContext_NaturalLanguage
	@doc raw"""
	Completions for fields of the member being accessed using the arrow
	operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5546:3)
	""" CXCompletionContext_ArrowMemberAccess
	@doc raw"""
	Completions for Objective-C instance messages should be included
	in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5600:3)
	""" CXCompletionContext_ObjCInstanceMessage
	@doc raw"""
	Completions for values that resolve to an Objective-C object should
	be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5525:3)
	""" CXCompletionContext_ObjCObjectValue
	@doc raw"""
	Completions for any possible type should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5514:3)
	""" CXCompletionContext_AnyType
	@doc raw"""
	Completions for values that resolve to a C++ class type should be
	included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5535:3)
	""" CXCompletionContext_CXXClassTypeValue
	@doc raw"""
	Completions for enum tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5556:3)
	""" CXCompletionContext_EnumTag
	@doc raw"""
	Completions for C++ namespaces and namespace aliases should be
	included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5574:3)
	""" CXCompletionContext_Namespace
	@doc raw"""
	Completions for Objective-C selector names should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5610:3)
	""" CXCompletionContext_ObjCSelectorName
	@doc raw"""
	Completions for C++ class names should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5569:3)
	""" CXCompletionContext_ClassTag
	@doc raw"""
	Completions for fields of the member being accessed using the dot
	operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5541:3)
	""" CXCompletionContext_DotMemberAccess
	@doc raw"""
	Completions for Objective-C interfaces (classes) should be included
	in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5585:3)
	""" CXCompletionContext_ObjCInterface
	@doc raw"""
	Completions for preprocessor macro names should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5616:3)
	""" CXCompletionContext_MacroName
	@doc raw"""
	The current context is unknown, so set all contexts.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5631:3)
	""" CXCompletionContext_Unknown
	@doc raw"""
	#include file completions should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5626:3)
	""" CXCompletionContext_IncludedFile
	@doc raw"""
	Completions for C++ nested name specifiers should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5579:3)
	""" CXCompletionContext_NestedNameSpecifier
	@doc raw"""
	Completions for Objective-C protocols should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5590:3)
	""" CXCompletionContext_ObjCProtocol
	@doc raw"""
	Completions for struct tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5564:3)
	""" CXCompletionContext_StructTag
	@doc raw"""
	The context for completions is unexposed, as only Clang results
	should be included. (This is equivalent to having no context bits set.)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5509:3)
	""" CXCompletionContext_Unexposed
	@doc raw"""
	Completions for values that resolve to an Objective-C selector
	should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5530:3)
	""" CXCompletionContext_ObjCSelectorValue
	@doc raw"""
	Completions for properties of the Objective-C object being accessed
	using the dot operator should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5551:3)
	""" CXCompletionContext_ObjCPropertyAccess
	@doc raw"""
	Completions for Objective-C categories should be included in
	the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5595:3)
	""" CXCompletionContext_ObjCCategory
	@doc raw"""
	Completions for union tags should be included in the results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5560:3)
	""" CXCompletionContext_UnionTag
	export CXCompletionContext, CXCompletionContext_AnyType, CXCompletionContext_AnyValue, CXCompletionContext_ArrowMemberAccess, CXCompletionContext_CXXClassTypeValue, CXCompletionContext_ClassTag, CXCompletionContext_DotMemberAccess, CXCompletionContext_EnumTag, CXCompletionContext_IncludedFile, CXCompletionContext_MacroName, CXCompletionContext_Namespace, CXCompletionContext_NaturalLanguage, CXCompletionContext_NestedNameSpecifier, CXCompletionContext_ObjCCategory, CXCompletionContext_ObjCClassMessage, CXCompletionContext_ObjCInstanceMessage, CXCompletionContext_ObjCInterface, CXCompletionContext_ObjCObjectValue, CXCompletionContext_ObjCPropertyAccess, CXCompletionContext_ObjCProtocol, CXCompletionContext_ObjCSelectorName, CXCompletionContext_ObjCSelectorValue, CXCompletionContext_StructTag, CXCompletionContext_Unexposed, CXCompletionContext_UnionTag, CXCompletionContext_Unknown
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
		CXCompletionContext_IncludedFile = (@Cuint)(4194304)
		CXCompletionContext_Unknown = (@Cuint)(8388607)
	}
	
	@doc raw"""
	Returns a default set of code-completion options that can be
	passed to\\c clang_codeCompleteAt().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5638:25)
	""" clang_defaultCodeCompleteOptions
	export clang_defaultCodeCompleteOptions
	@cextern clang_defaultCodeCompleteOptions()::@Cuint
	
	@doc raw"""
	Perform code completion at a given location in a translation unit.
	
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
	after the ">" in \\c p->. When the code-completion location is after the ">",
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5709:24)
	""" clang_codeCompleteAt
	export clang_codeCompleteAt
	@cextern clang_codeCompleteAt(TU::CXTranslationUnit, complete_filename::(@Ptr){(@Cconst)(@Cchar)}, complete_line::(@Cuint), complete_column::(@Cuint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), options::(@Cuint))::(@Ptr){CXCodeCompleteResults}
	
	@doc raw"""
	Sort the code-completion results in case-insensitive alphabetical
	order.
	
	\\param Results The set of results to sort.
	\\param NumResults The number of results in \\p Results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5725:6)
	""" clang_sortCodeCompletionResults
	export clang_sortCodeCompletionResults
	@cextern clang_sortCodeCompletionResults(Results::(@Ptr){CXCompletionResult}, NumResults::(@Cuint))::@Cvoid
	
	@doc raw"""
	Free the given set of code-completion results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5732:6)
	""" clang_disposeCodeCompleteResults
	export clang_disposeCodeCompleteResults
	@cextern clang_disposeCodeCompleteResults(Results::(@Ptr){CXCodeCompleteResults})::@Cvoid
	
	@doc raw"""
	Determine the number of diagnostics produced prior to the
	location where code completion was performed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5739:10)
	""" clang_codeCompleteGetNumDiagnostics
	export clang_codeCompleteGetNumDiagnostics
	@cextern clang_codeCompleteGetNumDiagnostics(Results::(@Ptr){CXCodeCompleteResults})::@Cuint
	
	@doc raw"""
	Retrieve a diagnostic associated with the given code completion.
	
	\\param Results the code completion results to query.
	\\param Index the zero-based diagnostic number to retrieve.
	
	\\returns the requested diagnostic. This diagnostic must be freed
	via a call to \\c clang_disposeDiagnostic().
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5751:14)
	""" clang_codeCompleteGetDiagnostic
	export clang_codeCompleteGetDiagnostic
	@cextern clang_codeCompleteGetDiagnostic(Results::(@Ptr){CXCodeCompleteResults}, Index::(@Cuint))::CXDiagnostic
	
	@doc raw"""
	Determines what completions are appropriate for the context
	the given code completion.
	
	\\param Results the code completion results to query
	
	\\returns the kinds of completions that are appropriate for use
	along with the given code completion results.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5764:20)
	""" clang_codeCompleteGetContexts
	export clang_codeCompleteGetContexts
	@cextern clang_codeCompleteGetContexts(Results::(@Ptr){CXCodeCompleteResults})::@Culonglong
	
	@doc raw"""
	Returns the cursor kind for the container for the current code
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5784:19)
	""" clang_codeCompleteGetContainerKind
	export clang_codeCompleteGetContainerKind
	@cextern clang_codeCompleteGetContainerKind(Results::(@Ptr){CXCodeCompleteResults}, IsIncomplete::(@Ptr){@Cuint})::CXCursorKind
	
	@doc raw"""
	Returns the USR for the container for the current code completion
	context. If there is not a container for the current context, this
	function will return the empty string.
	
	\\param Results the code completion results to query
	
	\\returns the USR for the container
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5798:10)
	""" clang_codeCompleteGetContainerUSR
	export clang_codeCompleteGetContainerUSR
	@cextern clang_codeCompleteGetContainerUSR(Results::(@Ptr){CXCodeCompleteResults})::CXString
	
	@doc raw"""
	Returns the currently-entered selector for an Objective-C message
	send, formatted like "initWithFoo:bar:". Only guaranteed to return a
	non-empty string for CXCompletionContext_ObjCInstanceMessage and
	CXCompletionContext_ObjCClassMessage.
	
	\\param Results the code completion results to query
	
	\\returns the selector (or partial selector) that has been entered thus far
	for an Objective-C message send.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5812:10)
	""" clang_codeCompleteGetObjCSelector
	export clang_codeCompleteGetObjCSelector
	@cextern clang_codeCompleteGetObjCSelector(Results::(@Ptr){CXCodeCompleteResults})::CXString
	
	@doc raw"""
	Return a version string, suitable for showing to a user, but not
	intended to be parsed (the format is not guaranteed to be stable).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5828:25)
	""" clang_getClangVersion
	export clang_getClangVersion
	@cextern clang_getClangVersion()::CXString
	
	@doc raw"""
	Enable/disable crash recovery.
	
	\\param isEnabled Flag to indicate if crash recovery is enabled.  A non-zero
	value enables crash recovery, while 0 disables it.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5836:21)
	""" clang_toggleCrashRecovery
	export clang_toggleCrashRecovery
	@cextern clang_toggleCrashRecovery(isEnabled::@Cuint)::@Cvoid
	
	@doc raw"""
	Visitor invoked for each file in a translation unit
	(used with clang_getInclusions()).
	
	This visitor function will be invoked by clang_getInclusions() for each
	file included (either at the top-level or by \\#include directives) within
	a translation unit.  The first argument is the file being included, and
	the second and third arguments provide the inclusion stack.  The
	array is sorted in order of immediate inclusion.  For example,
	the first element refers to the location that included 'included_file'.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5849:16)
	""" CXInclusionVisitor
	export CXInclusionVisitor
	@ctypedef CXInclusionVisitor (@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(CXFile), ((@Ptr){CXSourceLocation}), (@Cuint), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	Visit the set of preprocessor inclusions in a translation unit.
	The visitor function is called with the provided data for every included
	file.  This does not include headers included by the PCH file (unless one
	is inspecting the inclusions in the PCH file itself).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5860:21)
	""" clang_getInclusions
	export clang_getInclusions
	@cextern clang_getInclusions(tu::CXTranslationUnit, visitor::CXInclusionVisitor, client_data::CXClientData)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5870:3)
	""" CXEval_Other
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5867:3)
	""" CXEval_ObjCStrLiteral
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5868:3)
	""" CXEval_StrLiteral
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5874:3)
	""" CXEvalResultKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5865:3)
	""" CXEval_Int
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5872:3)
	""" CXEval_UnExposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5869:3)
	""" CXEval_CFStr
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5866:3)
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
	Evaluation result of a cursor
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5879:16)
	""" CXEvalResult
	export CXEvalResult
	@ctypedef CXEvalResult (@Ptr){@Cvoid}
	
	@doc raw"""
	If cursor is a statement declaration tries to evaluate the
	statement and if its variable, tries to evaluate its initializer,
	into its corresponding type.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5886:29)
	""" clang_Cursor_Evaluate
	export clang_Cursor_Evaluate
	@cextern clang_Cursor_Evaluate(C::CXCursor)::CXEvalResult
	
	@doc raw"""
	Returns the kind of the evaluated result.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5891:33)
	""" clang_EvalResult_getKind
	export clang_EvalResult_getKind
	@cextern clang_EvalResult_getKind(E::CXEvalResult)::CXEvalResultKind
	
	@doc raw"""
	Returns the evaluation result as integer if the
	kind is Int.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5897:20)
	""" clang_EvalResult_getAsInt
	export clang_EvalResult_getAsInt
	@cextern clang_EvalResult_getAsInt(E::CXEvalResult)::@Cint
	
	@doc raw"""
	Returns the evaluation result as a long long integer if the
	kind is Int. This prevents overflows that may happen if the result is
	returned with clang_EvalResult_getAsInt.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5904:26)
	""" clang_EvalResult_getAsLongLong
	export clang_EvalResult_getAsLongLong
	@cextern clang_EvalResult_getAsLongLong(E::CXEvalResult)::@Clonglong
	
	@doc raw"""
	Returns a non-zero value if the kind is Int and the evaluation
	result resulted in an unsigned integer.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5910:25)
	""" clang_EvalResult_isUnsignedInt
	export clang_EvalResult_isUnsignedInt
	@cextern clang_EvalResult_isUnsignedInt(E::CXEvalResult)::@Cuint
	
	@doc raw"""
	Returns the evaluation result as an unsigned integer if
	the kind is Int and clang_EvalResult_isUnsignedInt is non-zero.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5916:35)
	""" clang_EvalResult_getAsUnsigned
	export clang_EvalResult_getAsUnsigned
	@cextern clang_EvalResult_getAsUnsigned(E::CXEvalResult)::@Culonglong
	
	@doc raw"""
	Returns the evaluation result as double if the
	kind is double.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5922:23)
	""" clang_EvalResult_getAsDouble
	export clang_EvalResult_getAsDouble
	@cextern clang_EvalResult_getAsDouble(E::CXEvalResult)::@Cdouble
	
	@doc raw"""
	Returns the evaluation result as a constant string if the
	kind is other than Int or float. User must not free this pointer,
	instead call clang_EvalResult_dispose on the CXEvalResult returned
	by clang_Cursor_Evaluate.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5930:28)
	""" clang_EvalResult_getAsStr
	export clang_EvalResult_getAsStr
	@cextern clang_EvalResult_getAsStr(E::CXEvalResult)::(@Ptr){(@Cconst)(@Cchar)}
	
	@doc raw"""
	Disposes the created Eval memory.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5935:21)
	""" clang_EvalResult_dispose
	export clang_EvalResult_dispose
	@cextern clang_EvalResult_dispose(E::CXEvalResult)::@Cvoid
	
	@doc raw"""
	A remapping of original source files and their translated files.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5948:15)
	""" CXRemapping
	export CXRemapping
	@ctypedef CXRemapping (@Ptr){@Cvoid}
	
	@doc raw"""
	Retrieve a remapping.
	
	\\param path the path that contains metadata about remappings.
	
	\\returns the requested remapping. This remapping must be freed
	via a call to \\c clang_remap_dispose(). Can return NULL if an error occurred.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5958:28)
	""" clang_getRemappings
	export clang_getRemappings
	@cextern clang_getRemappings(path::(@Ptr){(@Cconst)(@Cchar)})::CXRemapping
	
	@doc raw"""
	Retrieve a remapping.
	
	\\param filePaths pointer to an array of file paths containing remapping info.
	
	\\param numFiles number of file paths.
	
	\\returns the requested remapping. This remapping must be freed
	via a call to \\c clang_remap_dispose(). Can return NULL if an error occurred.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5971:13)
	""" clang_getRemappingsFromFileList
	export clang_getRemappingsFromFileList
	@cextern clang_getRemappingsFromFileList(filePaths::(@Ptr){(@Ptr){(@Cconst)(@Cchar)}}, numFiles::(@Cuint))::CXRemapping
	
	@doc raw"""
	Determine the number of remappings.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5977:25)
	""" clang_remap_getNumFiles
	export clang_remap_getNumFiles
	@cextern clang_remap_getNumFiles(var"?1?"::CXRemapping)::@Cuint
	
	@doc raw"""
	Get the original and the associated filename from the remapping.
	
	\\param original If non-NULL, will be set to the original filename.
	
	\\param transformed If non-NULL, will be set to the filename that the original
	is associated with.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5987:21)
	""" clang_remap_getFilenames
	export clang_remap_getFilenames
	@cextern clang_remap_getFilenames(var"?1?"::CXRemapping, index::(@Cuint), original::(@Ptr){CXString}, transformed::(@Ptr){CXString})::@Cvoid
	
	@doc raw"""
	Dispose the remapping.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:5993:21)
	""" clang_remap_dispose
	export clang_remap_dispose
	@cextern clang_remap_dispose(var"?1?"::CXRemapping)::@Cvoid
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6006:3)
	""" CXVisit_Continue
	@doc raw"""
	\\defgroup CINDEX_HIGH Higher level API functions
	
	@{
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6004:6)
	""" CXVisitorResult
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6005:3)
	""" CXVisit_Break
	export CXVisit_Break, CXVisit_Continue, CXVisitorResult
	@cenum CXVisitorResult {
		CXVisit_Break = (@Cuint)(0)
		CXVisit_Continue = (@Cuint)(1)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6009:16)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6012:3)
	""" CXCursorAndRangeVisitor
	export CXCursorAndRangeVisitor
	@ctypedef CXCursorAndRangeVisitor @cstruct CXCursorAndRangeVisitor {
		context::(@Ptr){@Cvoid}
		visit::(@Ptr){(@Cfunction){(CXVisitorResult), (@Tuple){((@Ptr){@Cvoid}), (CXCursor), (CXSourceRange)}, (@CDECL)}}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6029:3)
	""" CXResult
	@doc raw"""
	Function returned successfully.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6018:3)
	""" CXResult_Success
	@doc raw"""
	One of the parameters was invalid for the function.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6022:3)
	""" CXResult_Invalid
	@doc raw"""
	The function was terminated by a callback (e.g. it returned
	CXVisit_Break)
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6027:3)
	""" CXResult_VisitBreak
	export CXResult, CXResult_Invalid, CXResult_Success, CXResult_VisitBreak
	@ctypedef CXResult @cenum {
		CXResult_Success = (@Cuint)(0)
		CXResult_Invalid = (@Cuint)(1)
		CXResult_VisitBreak = (@Cuint)(2)
	}
	
	@doc raw"""
	Find references of a declaration in a specific file.
	
	\\param cursor pointing to a declaration or a reference of one.
	
	\\param file to search for references.
	
	\\param visitor callback that will receive pairs of CXCursor/CXSourceRange for
	each reference found.
	The CXSourceRange will point inside the file; if the reference is inside
	a macro (and not a macro argument) the CXSourceRange will be invalid.
	
	\\returns one of the CXResult enumerators.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6045:25)
	""" clang_findReferencesInFile
	export clang_findReferencesInFile
	@cextern clang_findReferencesInFile(cursor::CXCursor, file::CXFile, visitor::CXCursorAndRangeVisitor)::CXResult
	
	@doc raw"""
	Find #import/#include directives in a specific file.
	
	\\param TU translation unit containing the file to query.
	
	\\param file to search for #import/#include directives.
	
	\\param visitor callback that will receive pairs of CXCursor/CXSourceRange for
	each directive found.
	
	\\returns one of the CXResult enumerators.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6060:25)
	""" clang_findIncludesInFile
	export clang_findIncludesInFile
	@cextern clang_findIncludesInFile(TU::CXTranslationUnit, file::CXFile, visitor::CXCursorAndRangeVisitor)::CXResult
	
	@doc raw"""
	The client's data object that is associated with a CXFile.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6084:15)
	""" CXIdxClientFile
	export CXIdxClientFile
	@ctypedef CXIdxClientFile (@Ptr){@Cvoid}
	
	@doc raw"""
	The client's data object that is associated with a semantic entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6089:15)
	""" CXIdxClientEntity
	export CXIdxClientEntity
	@ctypedef CXIdxClientEntity (@Ptr){@Cvoid}
	
	@doc raw"""
	The client's data object that is associated with a semantic container
	of entities.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6095:15)
	""" CXIdxClientContainer
	export CXIdxClientContainer
	@ctypedef CXIdxClientContainer (@Ptr){@Cvoid}
	
	@doc raw"""
	The client's data object that is associated with an AST file (PCH
	or module).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6101:15)
	""" CXIdxClientASTFile
	export CXIdxClientASTFile
	@ctypedef CXIdxClientASTFile (@Ptr){@Cvoid}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6109:3)
	""" CXIdxLoc
	export CXIdxLoc
	@ctypedef CXIdxLoc @cstruct {
		ptr_data::((@Ptr){@Cvoid})[2]
		int_data::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6134:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6158:3)
	""" CXIdxImportedASTFileInfo
	export CXIdxImportedASTFileInfo
	@ctypedef CXIdxImportedASTFileInfo @cstruct {
		file::CXFile
		var"module"::CXModule
		loc::CXIdxLoc
		isImplicit::@Cint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6169:3)
	""" CXIdxEntity_ObjCProtocol
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6187:3)
	""" CXIdxEntity_CXXConstructor
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6185:3)
	""" CXIdxEntity_CXXStaticMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6188:3)
	""" CXIdxEntity_CXXDestructor
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6168:3)
	""" CXIdxEntity_ObjCClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6172:3)
	""" CXIdxEntity_ObjCInstanceMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6179:3)
	""" CXIdxEntity_Union
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6164:3)
	""" CXIdxEntity_Variable
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6161:3)
	""" CXIdxEntity_Unexposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6178:3)
	""" CXIdxEntity_Struct
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6170:3)
	""" CXIdxEntity_ObjCCategory
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6190:3)
	""" CXIdxEntity_CXXTypeAlias
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6183:3)
	""" CXIdxEntity_CXXNamespaceAlias
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6177:3)
	""" CXIdxEntity_Enum
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6165:3)
	""" CXIdxEntity_Field
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6184:3)
	""" CXIdxEntity_CXXStaticVariable
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6162:3)
	""" CXIdxEntity_Typedef
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6163:3)
	""" CXIdxEntity_Function
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6186:3)
	""" CXIdxEntity_CXXInstanceMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6189:3)
	""" CXIdxEntity_CXXConversionFunction
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6166:3)
	""" CXIdxEntity_EnumConstant
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6175:3)
	""" CXIdxEntity_ObjCIvar
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6174:3)
	""" CXIdxEntity_ObjCProperty
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6181:3)
	""" CXIdxEntity_CXXClass
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6191:3)
	""" CXIdxEntity_CXXInterface
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6173:3)
	""" CXIdxEntity_ObjCClassMethod
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6182:3)
	""" CXIdxEntity_CXXNamespace
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6193:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6200:3)
	""" CXIdxEntityLang_Swift
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6198:3)
	""" CXIdxEntityLang_ObjC
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6197:3)
	""" CXIdxEntityLang_C
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6199:3)
	""" CXIdxEntityLang_CXX
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6196:3)
	""" CXIdxEntityLang_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6201:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6214:3)
	""" CXIdxEntity_NonTemplate
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6218:3)
	""" CXIdxEntityCXXTemplateKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6216:3)
	""" CXIdxEntity_TemplatePartialSpecialization
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6215:3)
	""" CXIdxEntity_Template
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6217:3)
	""" CXIdxEntity_TemplateSpecialization
	export CXIdxEntityCXXTemplateKind, CXIdxEntity_NonTemplate, CXIdxEntity_Template, CXIdxEntity_TemplatePartialSpecialization, CXIdxEntity_TemplateSpecialization
	@ctypedef CXIdxEntityCXXTemplateKind @cenum {
		CXIdxEntity_NonTemplate = (@Cuint)(0)
		CXIdxEntity_Template = (@Cuint)(1)
		CXIdxEntity_TemplatePartialSpecialization = (@Cuint)(2)
		CXIdxEntity_TemplateSpecialization = (@Cuint)(3)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6224:3)
	""" CXIdxAttr_IBOutletCollection
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6221:3)
	""" CXIdxAttr_Unexposed
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6225:3)
	""" CXIdxAttrKind
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6222:3)
	""" CXIdxAttr_IBAction
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6223:3)
	""" CXIdxAttr_IBOutlet
	export CXIdxAttrKind, CXIdxAttr_IBAction, CXIdxAttr_IBOutlet, CXIdxAttr_IBOutletCollection, CXIdxAttr_Unexposed
	@ctypedef CXIdxAttrKind @cenum {
		CXIdxAttr_Unexposed = (@Cuint)(0)
		CXIdxAttr_IBAction = (@Cuint)(1)
		CXIdxAttr_IBOutlet = (@Cuint)(2)
		CXIdxAttr_IBOutletCollection = (@Cuint)(3)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6231:3)
	""" CXIdxAttrInfo
	export CXIdxAttrInfo
	@ctypedef CXIdxAttrInfo @cstruct {
		kind::CXIdxAttrKind
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6242:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6246:3)
	""" CXIdxContainerInfo
	export CXIdxContainerInfo
	@ctypedef CXIdxContainerInfo @cstruct {
		cursor::CXCursor
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6253:3)
	""" CXIdxIBOutletCollectionAttrInfo
	export CXIdxIBOutletCollectionAttrInfo
	@ctypedef CXIdxIBOutletCollectionAttrInfo @cstruct {
		attrInfo::(@Ptr){(@Cconst)(CXIdxAttrInfo)}
		objcClass::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		classCursor::CXCursor
		classLoc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6256:3)
	""" CXIdxDeclFlag_Skipped
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6257:3)
	""" CXIdxDeclInfoFlags
	export CXIdxDeclFlag_Skipped, CXIdxDeclInfoFlags
	@ctypedef CXIdxDeclInfoFlags @cenum {
		CXIdxDeclFlag_Skipped = (@Cuint)(1)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6283:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6287:3)
	""" CXIdxObjCContainer_Interface
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6286:3)
	""" CXIdxObjCContainer_ForwardRef
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6288:3)
	""" CXIdxObjCContainer_Implementation
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6289:3)
	""" CXIdxObjCContainerKind
	export CXIdxObjCContainerKind, CXIdxObjCContainer_ForwardRef, CXIdxObjCContainer_Implementation, CXIdxObjCContainer_Interface
	@ctypedef CXIdxObjCContainerKind @cenum {
		CXIdxObjCContainer_ForwardRef = (@Cuint)(0)
		CXIdxObjCContainer_Interface = (@Cuint)(1)
		CXIdxObjCContainer_Implementation = (@Cuint)(2)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6294:3)
	""" CXIdxObjCContainerDeclInfo
	export CXIdxObjCContainerDeclInfo
	@ctypedef CXIdxObjCContainerDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		kind::CXIdxObjCContainerKind
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6300:3)
	""" CXIdxBaseClassInfo
	export CXIdxBaseClassInfo
	@ctypedef CXIdxBaseClassInfo @cstruct {
		base::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6306:3)
	""" CXIdxObjCProtocolRefInfo
	export CXIdxObjCProtocolRefInfo
	@ctypedef CXIdxObjCProtocolRefInfo @cstruct {
		protocol::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		cursor::CXCursor
		loc::CXIdxLoc
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6311:3)
	""" CXIdxObjCProtocolRefListInfo
	export CXIdxObjCProtocolRefListInfo
	@ctypedef CXIdxObjCProtocolRefListInfo @cstruct {
		protocols::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxObjCProtocolRefInfo)})}
		numProtocols::@Cuint
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6317:3)
	""" CXIdxObjCInterfaceDeclInfo
	export CXIdxObjCInterfaceDeclInfo
	@ctypedef CXIdxObjCInterfaceDeclInfo @cstruct {
		containerInfo::(@Ptr){(@Cconst)(CXIdxObjCContainerDeclInfo)}
		superInfo::(@Ptr){(@Cconst)(CXIdxBaseClassInfo)}
		protocols::(@Ptr){(@Cconst)(CXIdxObjCProtocolRefListInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6325:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6331:3)
	""" CXIdxObjCPropertyDeclInfo
	export CXIdxObjCPropertyDeclInfo
	@ctypedef CXIdxObjCPropertyDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		getter::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		setter::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6337:3)
	""" CXIdxCXXClassDeclInfo
	export CXIdxCXXClassDeclInfo
	@ctypedef CXIdxCXXClassDeclInfo @cstruct {
		declInfo::(@Ptr){(@Cconst)(CXIdxDeclInfo)}
		bases::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(CXIdxBaseClassInfo)})}
		numBases::@Cuint
	}
	
	@doc raw"""
	An implicit reference, e.g. a reference of an Objective-C method
	via the dot syntax.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6354:3)
	""" CXIdxEntityRef_Implicit
	@doc raw"""
	The entity is referenced directly in user's code.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6349:3)
	""" CXIdxEntityRef_Direct
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6355:3)
	""" CXIdxEntityRefKind
	export CXIdxEntityRefKind, CXIdxEntityRef_Direct, CXIdxEntityRef_Implicit
	@ctypedef CXIdxEntityRefKind @cenum {
		CXIdxEntityRef_Direct = (@Cuint)(1)
		CXIdxEntityRef_Implicit = (@Cuint)(2)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6369:3)
	""" CXSymbolRole_Write
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6370:3)
	""" CXSymbolRole_Call
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6372:3)
	""" CXSymbolRole_AddressOf
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6374:3)
	""" CXSymbolRole
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6365:3)
	""" CXSymbolRole_Declaration
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6366:3)
	""" CXSymbolRole_Definition
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6373:3)
	""" CXSymbolRole_Implicit
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6371:3)
	""" CXSymbolRole_Dynamic
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6367:3)
	""" CXSymbolRole_Reference
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6364:3)
	""" CXSymbolRole_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6368:3)
	""" CXSymbolRole_Read
	export CXSymbolRole, CXSymbolRole_AddressOf, CXSymbolRole_Call, CXSymbolRole_Declaration, CXSymbolRole_Definition, CXSymbolRole_Dynamic, CXSymbolRole_Implicit, CXSymbolRole_None, CXSymbolRole_Read, CXSymbolRole_Reference, CXSymbolRole_Write
	@ctypedef CXSymbolRole @cenum {
		CXSymbolRole_None = (@Cuint)(0)
		CXSymbolRole_Declaration = (@Cuint)(1)
		CXSymbolRole_Definition = (@Cuint)(2)
		CXSymbolRole_Reference = (@Cuint)(4)
		CXSymbolRole_Read = (@Cuint)(8)
		CXSymbolRole_Write = (@Cuint)(16)
		CXSymbolRole_Call = (@Cuint)(32)
		CXSymbolRole_Dynamic = (@Cuint)(64)
		CXSymbolRole_AddressOf = (@Cuint)(128)
		CXSymbolRole_Implicit = (@Cuint)(256)
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6410:3)
	""" CXIdxEntityRefInfo
	export CXIdxEntityRefInfo
	@ctypedef CXIdxEntityRefInfo @cstruct {
		kind::CXIdxEntityRefKind
		cursor::CXCursor
		loc::CXIdxLoc
		referencedEntity::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		parentEntity::(@Ptr){(@Cconst)(CXIdxEntityInfo)}
		container::(@Ptr){(@Cconst)(CXIdxContainerInfo)}
		role::CXSymbolRole
	}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6464:3)
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
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6466:20)
	""" clang_index_isEntityObjCContainerKind
	export clang_index_isEntityObjCContainerKind
	@cextern clang_index_isEntityObjCContainerKind(var"?1?"::CXIdxEntityKind)::@Cint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6468:1)
	""" clang_index_getObjCContainerDeclInfo
	export clang_index_getObjCContainerDeclInfo
	@cextern clang_index_getObjCContainerDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCContainerDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6471:1)
	""" clang_index_getObjCInterfaceDeclInfo
	export clang_index_getObjCInterfaceDeclInfo
	@cextern clang_index_getObjCInterfaceDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCInterfaceDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6475:1)
	""" clang_index_getObjCCategoryDeclInfo
	export clang_index_getObjCCategoryDeclInfo
	@cextern clang_index_getObjCCategoryDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCCategoryDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6478:1)
	""" clang_index_getObjCProtocolRefListInfo
	export clang_index_getObjCProtocolRefListInfo
	@cextern clang_index_getObjCProtocolRefListInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCProtocolRefListInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6481:1)
	""" clang_index_getObjCPropertyDeclInfo
	export clang_index_getObjCPropertyDeclInfo
	@cextern clang_index_getObjCPropertyDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxObjCPropertyDeclInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6484:1)
	""" clang_index_getIBOutletCollectionAttrInfo
	export clang_index_getIBOutletCollectionAttrInfo
	@cextern clang_index_getIBOutletCollectionAttrInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxAttrInfo)})::(@Ptr){(@Cconst)(CXIdxIBOutletCollectionAttrInfo)}
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6487:1)
	""" clang_index_getCXXClassDeclInfo
	export clang_index_getCXXClassDeclInfo
	@cextern clang_index_getCXXClassDeclInfo(var"?1?"::(@Ptr){(@Cconst)(CXIdxDeclInfo)})::(@Ptr){(@Cconst)(CXIdxCXXClassDeclInfo)}
	
	@doc raw"""
	For retrieving a custom CXIdxClientContainer attached to a
	container.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6494:1)
	""" clang_index_getClientContainer
	export clang_index_getClientContainer
	@cextern clang_index_getClientContainer(var"?1?"::(@Ptr){(@Cconst)(CXIdxContainerInfo)})::CXIdxClientContainer
	
	@doc raw"""
	For setting a custom CXIdxClientContainer attached to a
	container.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6501:1)
	""" clang_index_setClientContainer
	export clang_index_setClientContainer
	@cextern clang_index_setClientContainer(var"?1?"::(@Ptr){(@Cconst)(CXIdxContainerInfo)}, var"?2?"::CXIdxClientContainer)::@Cvoid
	
	@doc raw"""
	For retrieving a custom CXIdxClientEntity attached to an entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6507:1)
	""" clang_index_getClientEntity
	export clang_index_getClientEntity
	@cextern clang_index_getClientEntity(var"?1?"::(@Ptr){(@Cconst)(CXIdxEntityInfo)})::CXIdxClientEntity
	
	@doc raw"""
	For setting a custom CXIdxClientEntity attached to an entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6513:1)
	""" clang_index_setClientEntity
	export clang_index_setClientEntity
	@cextern clang_index_setClientEntity(var"?1?"::(@Ptr){(@Cconst)(CXIdxEntityInfo)}, var"?2?"::CXIdxClientEntity)::@Cvoid
	
	@doc raw"""
	An indexing action/session, to be applied to one or multiple
	translation units.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6519:15)
	""" CXIndexAction
	export CXIndexAction
	@ctypedef CXIndexAction (@Ptr){@Cvoid}
	
	@doc raw"""
	An indexing action/session, to be applied to one or multiple
	translation units.
	
	\\param CIdx The index object with which the index action will be associated.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6527:30)
	""" clang_IndexAction_create
	export clang_IndexAction_create
	@cextern clang_IndexAction_create(CIdx::CXIndex)::CXIndexAction
	
	@doc raw"""
	Destroy the given index action.
	
	The index action must not be destroyed until all of the translation units
	created within that index action have been destroyed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6535:21)
	""" clang_IndexAction_dispose
	export clang_IndexAction_dispose
	@cextern clang_IndexAction_dispose(var"?1?"::CXIndexAction)::@Cvoid
	
	@doc raw"""
	Skip a function/method body that was already parsed during an
	indexing session associated with a \\c CXIndexAction object.
	Bodies in system headers are always skipped.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6572:3)
	""" CXIndexOpt_SkipParsedBodiesInSession
	@doc raw"""
	Implicit function/class template instantiations should be indexed.
	If this is not set, implicit instantiations will be ignored.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6560:3)
	""" CXIndexOpt_IndexImplicitTemplateInstantiations
	@doc raw"""
	Used to indicate that no special indexing options are needed.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6541:3)
	""" CXIndexOpt_None
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6574:3)
	""" CXIndexOptFlags
	@doc raw"""
	Suppress all compiler warnings when parsing for indexing.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6565:3)
	""" CXIndexOpt_SuppressWarnings
	@doc raw"""
	Used to indicate that IndexerCallbacks#indexEntityReference should
	be invoked for only one reference of an entity per source file that does
	not also include a declaration/definition of the entity.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6548:3)
	""" CXIndexOpt_SuppressRedundantRefs
	@doc raw"""
	Function-local symbols should be indexed. If this is not set
	function-local symbols will be ignored.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6554:3)
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
	Index the given source file and the translation unit corresponding
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6601:20)
	""" clang_indexSourceFile
	export clang_indexSourceFile
	@cextern clang_indexSourceFile(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), out_TU::(@Ptr){CXTranslationUnit}, TU_options::(@Cuint))::@Cint
	
	@doc raw"""
	Same as clang_indexSourceFile but requires a full command line
	for \\c command_line_args including argv[0]. This is useful if the standard
	library paths are relative to the binary.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6619:20)
	""" clang_indexSourceFileFullArgv
	export clang_indexSourceFileFullArgv
	@cextern clang_indexSourceFileFullArgv(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), source_filename::(@Ptr){(@Cconst)(@Cchar)}, command_line_args::(@Ptr){(@Cconst)((@Ptr){(@Cconst)(@Cchar)})}, num_command_line_args::(@Cint), unsaved_files::(@Ptr){CXUnsavedFile}, num_unsaved_files::(@Cuint), out_TU::(@Ptr){CXTranslationUnit}, TU_options::(@Cuint))::@Cint
	
	@doc raw"""
	Index the given translation unit via callbacks implemented through
	#IndexerCallbacks.
	
	The order of callback invocations is not guaranteed to be the same as
	when indexing a source file. The high level order will be:
	
	-Preprocessor callbacks invocations
	-Declaration/reference callbacks invocations
	-Diagnostic callback invocations
	
	The parameters are the same as #clang_indexSourceFile.
	
	\\returns If there is a failure from which there is no recovery, returns
	non-zero, otherwise returns 0.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6642:20)
	""" clang_indexTranslationUnit
	export clang_indexTranslationUnit
	@cextern clang_indexTranslationUnit(var"?1?"::CXIndexAction, client_data::CXClientData, index_callbacks::(@Ptr){IndexerCallbacks}, index_callbacks_size::(@Cuint), index_options::(@Cuint), var"?6?"::CXTranslationUnit)::@Cint
	
	@doc raw"""
	Retrieve the CXIdxFile, file, line, column, and offset represented by
	the given CXIdxLoc.
	
	If the location refers into a macro expansion, retrieves the
	location of the macro expansion and if it refers into a macro argument
	retrieves the location of the argument.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6657:21)
	""" clang_indexLoc_getFileLocation
	export clang_indexLoc_getFileLocation
	@cextern clang_indexLoc_getFileLocation(loc::CXIdxLoc, indexFile::(@Ptr){CXIdxClientFile}, file::(@Ptr){CXFile}, line::(@Ptr){@Cuint}, column::(@Ptr){@Cuint}, offset::(@Ptr){@Cuint})::@Cvoid
	
	@doc raw"""
	Retrieve the CXSourceLocation represented by the given CXIdxLoc.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6668:18)
	""" clang_indexLoc_getCXSourceLocation
	export clang_indexLoc_getCXSourceLocation
	@cextern clang_indexLoc_getCXSourceLocation(loc::CXIdxLoc)::CXSourceLocation
	
	@doc raw"""
	Visitor invoked for each field found by a traversal.
	
	This visitor function will be invoked for each field found by
	\\c clang_Type_visitFields. Its first argument is the cursor being
	visited, its second argument is the client data provided to
	\\c clang_Type_visitFields.
	
	The visitor should return one of the \\c CXVisitorResult values
	to direct \\c clang_Type_visitFields.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6681:32)
	""" CXFieldVisitor
	export CXFieldVisitor
	@ctypedef CXFieldVisitor (@Ptr){(@Cfunction){(CXVisitorResult), (@Tuple){(CXCursor), (CXClientData)}, (@CDECL)}}
	
	@doc raw"""
	Visit the fields of a particular type.
	
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Index.h:6703:25)
	""" clang_Type_visitFields
	export clang_Type_visitFields
	@cextern clang_Type_visitFields(T::CXType, visitor::CXFieldVisitor, client_data::CXClientData)::@Cuint
	
	@doc raw"""
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:40:3)
	""" CXComment
	export CXComment
	@ctypedef CXComment @cstruct {
		ASTNode::(@Ptr){(@Cconst)(@Cvoid)}
		TranslationUnit::CXTranslationUnit
	}
	
	@doc raw"""
	Given a cursor that represents a documentable entity (e.g.,
	declaration), return the associated parsed comment as a
	\\c CXComment_FullComment AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:47:26)
	""" clang_Cursor_getParsedComment
	export clang_Cursor_getParsedComment
	@cextern clang_Cursor_getParsedComment(C::CXCursor)::CXComment
	
	@doc raw"""
	HTML end tag.  Considered inline content.
	
	For example:
	\\verbatim
	</a>
	\\endverbatim
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:92:3)
	""" CXComment_HTMLEndTag
	@doc raw"""
	Plain text.  Inline content.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:64:3)
	""" CXComment_Text
	@doc raw"""
	Describes the type of the comment AST node (\\c CXComment).  A comment
	node can be considered block content (e. g., paragraph), inline content
	(plain text) or neither (the root AST node).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:54:6)
	""" CXCommentKind
	@doc raw"""
	A verbatim line command.  Verbatim line has an opening command,
	a single line of text (up to the newline after the opening command) and
	has no closing command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:153:3)
	""" CXComment_VerbatimLine
	@doc raw"""
	A paragraph, contains inline comment.  The paragraph itself is
	block content.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:98:3)
	""" CXComment_Paragraph
	@doc raw"""
	A full comment attached to a declaration, contains block content.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:158:3)
	""" CXComment_FullComment
	@doc raw"""
	A \\\\tparam command that describes a template parameter (name and
	description).
	
	For example: \\\\tparam T description.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:128:3)
	""" CXComment_TParamCommand
	@doc raw"""
	A verbatim block command (e. g., preformatted code).  Verbatim
	block has an opening and a closing command and contains multiple lines of
	text (\\c CXComment_VerbatimBlockLine child nodes).
	
	For example:
	\\\\verbatim
	aaa
	\\\\endverbatim
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:140:3)
	""" CXComment_VerbatimBlockCommand
	@doc raw"""
	HTML start tag with attributes (name-value pairs).  Considered
	inline content.
	
	For example:
	\\verbatim
	<br> <br /> <a href="http://example.org/">
	\\endverbatim
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:82:3)
	""" CXComment_HTMLStartTag
	@doc raw"""
	A command that has zero or more word-like arguments (number of
	word-like arguments depends on command name) and a paragraph as an
	argument.  Block command is block content.
	
	Paragraph argument is also a child of the block command.
	
	For example: \\has 0 word-like arguments and a paragraph argument.
	
	AST nodes of special kinds that parser knows about (e. g., \\\\param
	command) have their own node kinds.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:112:3)
	""" CXComment_BlockCommand
	@doc raw"""
	A command with word-like arguments that is considered inline content.
	
	For example: \\\\c command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:71:3)
	""" CXComment_InlineCommand
	@doc raw"""
	A line of text that is contained within a
	CXComment_VerbatimBlockCommand node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:146:3)
	""" CXComment_VerbatimBlockLine
	@doc raw"""
	A \\\\param or \\\\arg command that describes the function parameter
	(name, passing direction, description).
	
	For example: \\\\param [in] ParamName description.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:120:3)
	""" CXComment_ParamCommand
	@doc raw"""
	Null comment.  No AST node is constructed at the requested location
	because there is no text or a syntax error.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:59:3)
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
	Command argument should be rendered in a monospaced font.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:179:3)
	""" CXCommentInlineCommandRenderKind_Monospaced
	@doc raw"""
	Command argument should be rendered in a bold font.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:174:3)
	""" CXCommentInlineCommandRenderKind_Bold
	@doc raw"""
	Command argument should be rendered emphasized (typically italic
	font).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:185:3)
	""" CXCommentInlineCommandRenderKind_Emphasized
	@doc raw"""
	The most appropriate rendering mode for an inline command, chosen on
	command semantics in Doxygen.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:165:6)
	""" CXCommentInlineCommandRenderKind
	@doc raw"""
	Command argument should be rendered in a normal font.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:169:3)
	""" CXCommentInlineCommandRenderKind_Normal
	export CXCommentInlineCommandRenderKind, CXCommentInlineCommandRenderKind_Bold, CXCommentInlineCommandRenderKind_Emphasized, CXCommentInlineCommandRenderKind_Monospaced, CXCommentInlineCommandRenderKind_Normal
	@cenum CXCommentInlineCommandRenderKind {
		CXCommentInlineCommandRenderKind_Normal = (@Cuint)(0)
		CXCommentInlineCommandRenderKind_Bold = (@Cuint)(1)
		CXCommentInlineCommandRenderKind_Monospaced = (@Cuint)(2)
		CXCommentInlineCommandRenderKind_Emphasized = (@Cuint)(3)
	}
	
	@doc raw"""
	The parameter is an input parameter.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:195:3)
	""" CXCommentParamPassDirection_In
	@doc raw"""
	The parameter is an output parameter.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:200:3)
	""" CXCommentParamPassDirection_Out
	@doc raw"""
	Describes parameter passing direction for \\\\param or \\\\arg command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:191:6)
	""" CXCommentParamPassDirection
	@doc raw"""
	The parameter is an input and output parameter.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:205:3)
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:213:35)
	""" clang_Comment_getKind
	export clang_Comment_getKind
	@cextern clang_Comment_getKind(Comment::CXComment)::CXCommentKind
	
	@doc raw"""
	\\param Comment AST node of any kind.
	
	\\returns number of children of the AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:220:25)
	""" clang_Comment_getNumChildren
	export clang_Comment_getNumChildren
	@cextern clang_Comment_getNumChildren(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment AST node of any kind.
	
	\\param ChildIdx child index (zero-based).
	
	\\returns the specified child of the AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:230:11)
	""" clang_Comment_getChild
	export clang_Comment_getChild
	@cextern clang_Comment_getChild(Comment::CXComment, ChildIdx::(@Cuint))::CXComment
	
	@doc raw"""
	A \\c CXComment_Paragraph node is considered whitespace if it contains
	only \\c CXComment_Text nodes that are empty or whitespace.
	
	Other AST nodes (except \\c CXComment_Paragraph and \\c CXComment_Text) are
	never considered whitespace.
	
	\\returns non-zero if \\c Comment is whitespace.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:241:25)
	""" clang_Comment_isWhitespace
	export clang_Comment_isWhitespace
	@cextern clang_Comment_isWhitespace(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\returns non-zero if \\c Comment is inline content and has a newline
	immediately following it in the comment text.  Newlines between paragraphs
	do not count.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:249:10)
	""" clang_InlineContentComment_hasTrailingNewline
	export clang_InlineContentComment_hasTrailingNewline
	@cextern clang_InlineContentComment_hasTrailingNewline(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_Text AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:256:25)
	""" clang_TextComment_getText
	export clang_TextComment_getText
	@cextern clang_TextComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns name of the inline command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:264:10)
	""" clang_InlineCommandComment_getCommandName
	export clang_InlineCommandComment_getCommandName
	@cextern clang_InlineCommandComment_getCommandName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns the most appropriate rendering mode, chosen on command
	semantics in Doxygen.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:273:1)
	""" clang_InlineCommandComment_getRenderKind
	export clang_InlineCommandComment_getRenderKind
	@cextern clang_InlineCommandComment_getRenderKind(Comment::CXComment)::CXCommentInlineCommandRenderKind
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\returns number of command arguments.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:281:10)
	""" clang_InlineCommandComment_getNumArgs
	export clang_InlineCommandComment_getNumArgs
	@cextern clang_InlineCommandComment_getNumArgs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_InlineCommand AST node.
	
	\\param ArgIdx argument index (zero-based).
	
	\\returns text of the specified argument.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:291:10)
	""" clang_InlineCommandComment_getArgText
	export clang_InlineCommandComment_getArgText
	@cextern clang_InlineCommandComment_getArgText(Comment::CXComment, ArgIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag or \\c CXComment_HTMLEndTag AST
	node.
	
	\\returns HTML tag name.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:300:25)
	""" clang_HTMLTagComment_getTagName
	export clang_HTMLTagComment_getTagName
	@cextern clang_HTMLTagComment_getTagName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\returns non-zero if tag is self-closing (for example, &lt;br /&gt;).
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:308:10)
	""" clang_HTMLStartTagComment_isSelfClosing
	export clang_HTMLStartTagComment_isSelfClosing
	@cextern clang_HTMLStartTagComment_isSelfClosing(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\returns number of attributes (name-value pairs) attached to the start tag.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:315:25)
	""" clang_HTMLStartTag_getNumAttrs
	export clang_HTMLStartTag_getNumAttrs
	@cextern clang_HTMLStartTag_getNumAttrs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\param AttrIdx attribute index (zero-based).
	
	\\returns name of the specified attribute.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:325:10)
	""" clang_HTMLStartTag_getAttrName
	export clang_HTMLStartTag_getAttrName
	@cextern clang_HTMLStartTag_getAttrName(Comment::CXComment, AttrIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_HTMLStartTag AST node.
	
	\\param AttrIdx attribute index (zero-based).
	
	\\returns value of the specified attribute.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:335:10)
	""" clang_HTMLStartTag_getAttrValue
	export clang_HTMLStartTag_getAttrValue
	@cextern clang_HTMLStartTag_getAttrValue(Comment::CXComment, AttrIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\returns name of the block command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:343:10)
	""" clang_BlockCommandComment_getCommandName
	export clang_BlockCommandComment_getCommandName
	@cextern clang_BlockCommandComment_getCommandName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\returns number of word-like arguments.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:351:10)
	""" clang_BlockCommandComment_getNumArgs
	export clang_BlockCommandComment_getNumArgs
	@cextern clang_BlockCommandComment_getNumArgs(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand AST node.
	
	\\param ArgIdx argument index (zero-based).
	
	\\returns text of the specified word-like argument.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:361:10)
	""" clang_BlockCommandComment_getArgText
	export clang_BlockCommandComment_getArgText
	@cextern clang_BlockCommandComment_getArgText(Comment::CXComment, ArgIdx::(@Cuint))::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_BlockCommand or
	\\c CXComment_VerbatimBlockCommand AST node.
	
	\\returns paragraph argument of the block command.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:371:11)
	""" clang_BlockCommandComment_getParagraph
	export clang_BlockCommandComment_getParagraph
	@cextern clang_BlockCommandComment_getParagraph(Comment::CXComment)::CXComment
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns parameter name.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:379:10)
	""" clang_ParamCommandComment_getParamName
	export clang_ParamCommandComment_getParamName
	@cextern clang_ParamCommandComment_getParamName(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns non-zero if the parameter that this AST node represents was found
	in the function prototype and \\c clang_ParamCommandComment_getParamIndex
	function will return a meaningful value.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:389:10)
	""" clang_ParamCommandComment_isParamIndexValid
	export clang_ParamCommandComment_isParamIndexValid
	@cextern clang_ParamCommandComment_isParamIndexValid(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns zero-based parameter index in function prototype.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:397:10)
	""" clang_ParamCommandComment_getParamIndex
	export clang_ParamCommandComment_getParamIndex
	@cextern clang_ParamCommandComment_getParamIndex(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns non-zero if parameter passing direction was specified explicitly in
	the comment.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:406:10)
	""" clang_ParamCommandComment_isDirectionExplicit
	export clang_ParamCommandComment_isDirectionExplicit
	@cextern clang_ParamCommandComment_isDirectionExplicit(Comment::CXComment)::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_ParamCommand AST node.
	
	\\returns parameter passing direction.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:414:34)
	""" clang_ParamCommandComment_getDirection
	export clang_ParamCommandComment_getDirection
	@cextern clang_ParamCommandComment_getDirection(Comment::CXComment)::CXCommentParamPassDirection
	
	@doc raw"""
	\\param Comment a \\c CXComment_TParamCommand AST node.
	
	\\returns template parameter name.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:423:10)
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:435:10)
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:451:10)
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:472:10)
	""" clang_TParamCommandComment_getIndex
	export clang_TParamCommandComment_getIndex
	@cextern clang_TParamCommandComment_getIndex(Comment::CXComment, Depth::(@Cuint))::@Cuint
	
	@doc raw"""
	\\param Comment a \\c CXComment_VerbatimBlockLine AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:480:10)
	""" clang_VerbatimBlockLineComment_getText
	export clang_VerbatimBlockLineComment_getText
	@cextern clang_VerbatimBlockLineComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	\\param Comment a \\c CXComment_VerbatimLine AST node.
	
	\\returns text contained in the AST node.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:487:25)
	""" clang_VerbatimLineComment_getText
	export clang_VerbatimLineComment_getText
	@cextern clang_VerbatimLineComment_getText(Comment::CXComment)::CXString
	
	@doc raw"""
	Convert an HTML tag AST node to string.
	
	\\param Comment a \\c CXComment_HTMLStartTag or \\c CXComment_HTMLEndTag AST
	node.
	
	\\returns string containing an HTML tag.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:497:25)
	""" clang_HTMLTagComment_getAsString
	export clang_HTMLTagComment_getAsString
	@cextern clang_HTMLTagComment_getAsString(Comment::CXComment)::CXString
	
	@doc raw"""
	Convert a given full parsed comment to an HTML fragment.
	
	Specific details of HTML layout are subject to change.  Don't try to parse
	this HTML back into an AST, use other APIs instead.
	
	Currently the following CSS classes are used:
	\\li "para-brief" for \\paragraph and equivalent commands;
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
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:530:25)
	""" clang_FullComment_getAsHTML
	export clang_FullComment_getAsHTML
	@cextern clang_FullComment_getAsHTML(Comment::CXComment)::CXString
	
	@doc raw"""
	Convert a given full parsed comment to an XML document.
	
	A Relax NG schema for the XML can be found in comment-xml-schema.rng file
	inside clang source tree.
	
	\\param Comment a \\c CXComment_FullComment AST node.
	
	\\returns string containing an XML document.
	
	[C Reference](~/.julia/artifacts/24cf82e3b0e1edd69d7399a3912c9dcd5ba0f55d/include/clang-c/Documentation.h:542:25)
	""" clang_FullComment_getAsXML
	export clang_FullComment_getAsXML
	@cextern clang_FullComment_getAsXML(Comment::CXComment)::CXString
end
