
module Smi
  module Wrapper
  
  extend NiceFFI::Library
  ffi_lib 'libsmi'
  SMI_LIBRARY_VERSION = "2:27:0"
  SMI_VERSION_MAJOR = 0
  SMI_VERSION_MINOR = 4
  SMI_VERSION_PATCHLEVEL = 8
  SMI_VERSION_STRING = "0.4.8"
  SMI_FLAG_NODESCR = 0x0800
  SMI_FLAG_VIEWALL = 0x1000
  SMI_FLAG_ERRORS = 0x2000
  SMI_FLAG_RECURSIVE = 0x4000
  SMI_FLAG_STATS = 0x8000
  SMI_FLAG_MASK = (0x0800|0x1000|0x8000|0x4000|0x2000)
  SMI_LANGUAGE_UNKNOWN = 0
  SMI_LANGUAGE_SMIV1 = 1
  SMI_LANGUAGE_SMIV2 = 2
  SMI_LANGUAGE_SMING = 3
  SMI_LANGUAGE_SPPI = 4

  SMI_BASETYPE_UNKNOWN = 0
  SMI_BASETYPE_INTEGER32 = 1
  SMI_BASETYPE_ENUM = 10
  SMI_BASETYPE_BITS = 11
  SMI_BASETYPE_POINTER = 12
  SMI_BASETYPE_OCTETSTRING = 2
  SMI_BASETYPE_OBJECTIDENTIFIER = 3
  SMI_BASETYPE_UNSIGNED32 = 4
  SMI_BASETYPE_INTEGER64 = 5
  SMI_BASETYPE_UNSIGNED64 = 6
  SMI_BASETYPE_FLOAT32 = 7
  SMI_BASETYPE_FLOAT64 = 8
  SMI_BASETYPE_FLOAT128 = 9

  SMI_BASETYPE_UNSIGNED32_MIN = 0
  SMI_BASETYPE_UNSIGNED64_MIN = 0
  SMI_STATUS_UNKNOWN = 0
  SMI_STATUS_CURRENT = 1
  SMI_STATUS_DEPRECATED = 2
  SMI_STATUS_MANDATORY = 3
  SMI_STATUS_OPTIONAL = 4
  SMI_STATUS_OBSOLETE = 5

  SMI_ACCESS_UNKNOWN = 0
  SMI_ACCESS_NOT_IMPLEMENTED = 1
  SMI_ACCESS_NOT_ACCESSIBLE = 2
  SMI_ACCESS_NOTIFY = 3
  SMI_ACCESS_READ_ONLY = 4
  SMI_ACCESS_READ_WRITE = 5
  SMI_ACCESS_INSTALL = 6
  SMI_ACCESS_INSTALL_NOTIFY = 7
  SMI_ACCESS_REPORT_ONLY = 8
  SMI_ACCESS_EVENT_ONLY = 9

  SMI_NODEKIND_UNKNOWN = 0x0000
  SMI_NODEKIND_NODE = 0x0001
  SMI_NODEKIND_SCALAR = 0x0002
  SMI_NODEKIND_TABLE = 0x0004
  SMI_NODEKIND_ROW = 0x0008
  SMI_NODEKIND_COLUMN = 0x0010
  SMI_NODEKIND_NOTIFICATION = 0x0020
  SMI_NODEKIND_GROUP = 0x0040
  SMI_NODEKIND_COMPLIANCE = 0x0080
  SMI_NODEKIND_CAPABILITIES = 0x0100
  SMI_NODEKIND_ANY = 0xffff
  SMI_DECL_UNKNOWN = 0
  SMI_DECL_IMPLICIT_TYPE = 1
  SMI_DECL_TRAPTYPE = 10
  SMI_DECL_OBJECTGROUP = 11
  SMI_DECL_NOTIFICATIONGROUP = 12
  SMI_DECL_MODULECOMPLIANCE = 13
  SMI_DECL_AGENTCAPABILITIES = 14
  SMI_DECL_TEXTUALCONVENTION = 15
  SMI_DECL_MACRO = 16
  SMI_DECL_COMPL_GROUP = 17
  SMI_DECL_COMPL_OBJECT = 18
  SMI_DECL_IMPL_OBJECT = 19
  SMI_DECL_TYPEASSIGNMENT = 2
  SMI_DECL_MODULE = 33
  SMI_DECL_EXTENSION = 34
  SMI_DECL_TYPEDEF = 35
  SMI_DECL_NODE = 36
  SMI_DECL_SCALAR = 37
  SMI_DECL_TABLE = 38
  SMI_DECL_ROW = 39
  SMI_DECL_IMPL_SEQUENCEOF = 4
  SMI_DECL_COLUMN = 40
  SMI_DECL_NOTIFICATION = 41
  SMI_DECL_GROUP = 42
  SMI_DECL_COMPLIANCE = 43
  SMI_DECL_IDENTITY = 44
  SMI_DECL_CLASS = 45
  SMI_DECL_ATTRIBUTE = 46
  SMI_DECL_EVENT = 47
  SMI_DECL_VALUEASSIGNMENT = 5
  SMI_DECL_OBJECTTYPE = 6
  SMI_DECL_OBJECTIDENTITY = 7
  SMI_DECL_MODULEIDENTITY = 8
  SMI_DECL_NOTIFICATIONTYPE = 9

  SMI_INDEX_UNKNOWN = 0
  SMI_INDEX_INDEX = 1
  SMI_INDEX_AUGMENT = 2
  SMI_INDEX_REORDER = 3
  SMI_INDEX_SPARSE = 4
  SMI_INDEX_EXPAND = 5
  
  SMI_RENDER_NUMERIC = 0x01
  SMI_RENDER_NAME = 0x02
  SMI_RENDER_QUALIFIED = 0x04
  SMI_RENDER_FORMAT = 0x08
  SMI_RENDER_PRINTABLE = 0x10
  SMI_RENDER_UNKNOWN = 0x20
  SMI_RENDER_ALL = 0xff
  SMI_UNKNOWN_LABEL = "<unknown>"
  
  #FFI::SizeTypes.merge!({FFI::NativeType::FLOAT128 => 16})
  #FFI::add_typedef(FFI::NativeType::FLOAT128, :long_double)
  
  
      
  class SmiValueValue < FFI::Union
    layout(
           :unsigned64, :ulong_long, 
           :integer64, :long_long, 
           :unsigned32, :ulong,
           :integer32, :long,
           :float32, :float,
           :float64, :double,
           :float128, [:double, 2], #:long_double,
           :oid, :pointer,
           :ptr, :pointer
    )

  end
  
  #puts "size of SmiValueValue = #{SmiValueValue.size}"
# FIXME: Nested structures are not correctly supported at the moment.
# Please check the order of the declarations in the structure below.
   class SmiValue < NiceFFI::Struct
     layout(
            :basetype, :int,#enum
            :len, :uint,
            :value, SmiValueValue
#            :padding, [:uint, 2]
     )
   end
   #puts FFI.find_type(:int).size   
   #puts FFI.find_type(:uint).size
   #puts "sizeof SmiValue = #{SmiValue.size}"
  class SmiNamedNumber < NiceFFI::Struct
    layout(
           :name, :pointer,
           :value, SmiValue
    )
  end
  class SmiRange < NiceFFI::Struct
    layout(
           :minValue, SmiValue,
           :maxValue, SmiValue
    )
  end
  class SmiModule < NiceFFI::Struct
    layout(
           :name, :string,
           :path, :string,
           :organization, :string,
           :contactinfo, :string,
           :description, :string,
           :reference, :string,
           :language, :int,
           :conformance, :int
    )


  end
  
  #puts "size SmiModule = #{SmiModule.size}"
  class SmiRevision < NiceFFI::Struct
    layout(
           :date, :time_t,
           :description, :pointer
    )
  end
  class SmiImport < NiceFFI::Struct
    layout(
           :module, :pointer,
           :name, :pointer
    )

  end
  class SmiMacro < NiceFFI::Struct
    layout(
           :name, :pointer,
           :decl, :int,
           :status, :int,
           :description, :pointer,
           :reference, :pointer,
           :abnf, :pointer
    )

  end
  class SmiIdentity < NiceFFI::Struct
    layout(
           :name, :pointer,
           :decl, :int,
           :status, :int,
           :description, :pointer,
           :reference, :pointer
    )

  end
  class SmiType < NiceFFI::Struct
    layout(
           :name, :pointer,
           :basetype, :int,
           :decl, :int,
           :format, :pointer,
           :value, SmiValue,
           :units, :pointer,
           :status, :int,
           :description, :pointer,
           :reference, :pointer
    )
 
  end
  class SmiNode < NiceFFI::Struct
     #packed
     #align 4
     layout(
           :name, :string,
           :oidlen, :uint,
           :oid, :pointer,
           :decl, :int,   #enum
           :access, :int, #enum
           :status, :int, #enum
           :format, :string,
           :value, SmiValue,
           :units, :pointer,
           :description, :string,
           :reference, :string,
           :indexkind, :int,
           :implied, :int,
           :create, :int,
           :nodekind, :uint    )

  end
  
  #puts "size SmiNode = #{SmiNode.size}"
  class SmiElement < NiceFFI::Struct
    layout(
           :dummy, :char
    )
  end
  class SmiOption < NiceFFI::Struct
    layout(
           :description, :pointer
    )
  end
  class SmiRefinement < NiceFFI::Struct
    layout(
           :access, :int,
           :description, :pointer
    )
  end
  class SmiClass < NiceFFI::Struct
    layout(
           :name, :pointer,
           :decl, :int,
           :status, :int,
           :description, :pointer,
           :reference, :pointer
    )
  end
  class SmiAttribute < NiceFFI::Struct
    layout(
           :name, :pointer,
           :basetype, :int,
           :decl, :int,
           :format, :pointer,
           :value, SmiValue,
           :units, :pointer,
           :status, :int,
           :description, :pointer,
           :reference, :pointer,
           :access, :int
    )
  end
  class SmiEvent < NiceFFI::Struct
    layout(
           :name, :pointer,
           :decl, :int,
           :status, :int,
           :description, :pointer,
           :reference, :pointer
    )
  end
  attach_function :smiInit, [ :string ], :int
  attach_function :smiExit, [  ], :void
  attach_function :smiSetErrorLevel, [ :int ], :void
  attach_function :smiGetFlags, [  ], :int
  attach_function :smiSetFlags, [ :int ], :void
  attach_function :smiGetPath, [  ], :string
  attach_function :smiSetPath, [ :string ], :int
  attach_function :smiSetSeverity, [ :string, :int ], :void
  attach_function :smiReadConfig, [ :string, :string ], :int
  attach_function :smiLoadModule, [ :string ], :string
  attach_function :smiIsLoaded, [ :string ], :int
#  attach_function :SmiErrorHandler, [ :string, :int, :int, :string, :string ], :void
  attach_function :smiSetErrorHandler, [ :pointer ], :void
  attach_function :smiGetModule, [ :string ], NiceFFI::TypedPointer(SmiModule)
  attach_function :smiGetFirstModule, [  ], NiceFFI::TypedPointer( SmiModule )
  attach_function :smiGetNextModule, [ :pointer ], NiceFFI::TypedPointer( SmiModule )
  attach_function :smiGetModuleIdentityNode, [ :pointer ], :pointer
  attach_function :smiGetFirstImport, [ :pointer ], :pointer
  attach_function :smiGetNextImport, [ :pointer ], :pointer
  attach_function :smiIsImported, [ :pointer, :pointer, :string ], :int
  attach_function :smiGetFirstRevision, [ :pointer ], :pointer
  attach_function :smiGetNextRevision, [ :pointer ], :pointer
  attach_function :smiGetRevisionLine, [ :pointer ], :int
  attach_function :smiGetFirstIdentity, [ :pointer ], :pointer
  attach_function :smiGetNextIdentity, [ :pointer ], :pointer
  attach_function :smiGetParentIdentity, [ :pointer ], :pointer
  attach_function :smiGetIdentityLine, [ :pointer ], :int
  attach_function :smiGetIdentityModule, [ :pointer ], :pointer
  attach_function :smiGetIdentity, [ :pointer, :string ], :pointer
  attach_function :smiGetType, [ :pointer, :string ], :pointer
  attach_function :smiGetFirstType, [ :pointer ], :pointer
  attach_function :smiGetNextType, [ :pointer ], :pointer
  attach_function :smiGetParentType, [ :pointer ], :pointer
  attach_function :smiGetTypeModule, [ :pointer ], :pointer
  attach_function :smiGetTypeLine, [ :pointer ], :int
  attach_function :smiGetFirstRange, [ :pointer ], :pointer
  attach_function :smiGetNextRange, [ :pointer ], :pointer
  attach_function :smiGetMinMaxRange, [ :pointer, :pointer, :pointer ], :int
  attach_function :smiGetFirstNamedNumber, [ :pointer ], :pointer
  attach_function :smiGetNextNamedNumber, [ :pointer ], :pointer
  attach_function :smiGetFirstClass, [ :pointer ], :pointer
  attach_function :smiGetNextClass, [ :pointer ], :pointer
  attach_function :smiGetParentClass, [ :pointer ], :pointer
  attach_function :smiGetClassModule, [ :pointer ], :pointer
  attach_function :smiGetClass, [ :pointer, :string ], :pointer
  attach_function :smiGetClassLine, [ :pointer ], :int
  attach_function :smiGetAttribute, [ :pointer, :string ], :pointer
  attach_function :smiGetFirstAttribute, [ :pointer ], :pointer
  attach_function :smiGetNextAttribute, [ :pointer ], :pointer
  attach_function :smiGetAttributeParentType, [ :pointer ], :pointer
  attach_function :smiGetAttributeParentClass, [ :pointer ], :pointer
  attach_function :smiGetFirstUniqueAttribute, [ :pointer ], :pointer
  attach_function :smiGetNextUniqueAttribute, [ :pointer ], :pointer
  attach_function :smiIsClassScalar, [ :pointer ], :int
  attach_function :smiGetAttributeFirstNamedNumber, [ :pointer ], :pointer
  attach_function :smiGetAttributeNextNamedNumber, [ :pointer ], :pointer
  attach_function :smiGetAttributeFirstRange, [ :pointer ], :pointer
  attach_function :smiGetAttributeNextRange, [ :pointer ], :pointer
  attach_function :smiGetAttributeLine, [ :pointer ], :int
  #attach_function :smiGetEvent, [ :pointer, :string ], :pointer
  attach_function :smiGetFirstEvent, [ :pointer ], :pointer
  attach_function :smiGetNextEvent, [ :pointer ], :pointer
  attach_function :smiGetEventLine, [ :pointer ], :int
  attach_function :smiGetMacro, [ :pointer, :string ], :pointer
  attach_function :smiGetFirstMacro, [ :pointer ], :pointer
  attach_function :smiGetNextMacro, [ :pointer ], :pointer
  attach_function :smiGetMacroModule, [ :pointer ], :pointer
  attach_function :smiGetMacroLine, [ :pointer ], :int
  attach_function :smiGetNode, [ :pointer, :string ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetNodeByOID, [ :uint, :pointer ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetFirstNode, [ :pointer, :uint ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetNextNode, [ :pointer, :uint ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetParentNode, [ :pointer ], SmiNode.typed_pointer
  attach_function :smiGetRelatedNode, [ :pointer ], SmiNode.typed_pointer
  attach_function :smiGetFirstChildNode, [ :pointer ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetNextChildNode, [ :pointer ], NiceFFI::TypedPointer(SmiNode)
  attach_function :smiGetNodeModule, [ :pointer ], :pointer
  attach_function :smiGetNodeType, [ :pointer ], NiceFFI::TypedPointer(SmiType)
  attach_function :smiGetNodeLine, [ :pointer ], :int
  attach_function :smiGetFirstElement, [ :pointer ], :pointer
  attach_function :smiGetNextElement, [ :pointer ], :pointer
  attach_function :smiGetElementNode, [ :pointer ], :pointer
  attach_function :smiGetFirstOption, [ :pointer ], :pointer
  attach_function :smiGetNextOption, [ :pointer ], :pointer
  attach_function :smiGetOptionNode, [ :pointer ], :pointer
  attach_function :smiGetOptionLine, [ :pointer ], :int
  attach_function :smiGetFirstRefinement, [ :pointer ], :pointer
  attach_function :smiGetNextRefinement, [ :pointer ], :pointer
  attach_function :smiGetRefinementNode, [ :pointer ], :pointer
  attach_function :smiGetRefinementType, [ :pointer ], :pointer
  attach_function :smiGetRefinementWriteType, [ :pointer ], :pointer
  attach_function :smiGetRefinementLine, [ :pointer ], :int
  attach_function :smiGetFirstUniquenessElement, [ :pointer ], :pointer
  attach_function :smiRenderOID, [ :uint, :pointer, :int ], :string
  attach_function :smiRenderValue, [ :pointer, :pointer, :int ], :string
  attach_function :smiRenderNode, [ :pointer, :int ], :string
  attach_function :smiRenderType, [ :pointer, :int ], :string

  attach_function :smiGetMinSize, [ :pointer ], :uint
  attach_function :smiGetMaxSize, [ :pointer ], :uint
  attach_function :smiUnpack, [ :pointer, :pointer, :uint, :pointer, :pointer ], :int
  #attach_function :smiPack, [ :pointer, :pointer, :int, :pointer, :pointer ], :int
  attach_function :smiAsprintf, [ :pointer, :string, :varargs ], :int
  attach_function :smiVasprintf, [ :pointer, :string, :varargs ], :int
  attach_function :smiMalloc, [ :uint ], :pointer
  attach_function :smiRealloc, [ :pointer, :uint ], :pointer
  attach_function :smiStrdup, [ :string ], :string
  attach_function :smiStrndup, [ :string, :uint ], :string
  attach_function :smiFree, [ :pointer ], :void

end
end
