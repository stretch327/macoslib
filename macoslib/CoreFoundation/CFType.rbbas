#tag ClassClass CFType	#tag Method, Flags = &h0		Sub Operator_Convert(theRef as Ptr)		  me.Ref = theRef		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Destructor()		  #if TargetMacOS		    if me.Ref <> nil then		      soft declare sub CFRelease lib CarbonFramework (ref as Ptr)		      		      CFRelease me.Ref		      me.Ref = nil		    end if		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Equals(theObj as CFType) As Boolean		  if theObj is nil then		    return (me = nil)		  end if		  		  #if TargetMacOS		    soft declare function CFEqual lib CarbonFramework (cf1 as Ptr, cf2 as Ptr) as Boolean		    		    return CFEqual(me, theObj)		  #endif		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TypeID() As UInt32		  if me = nil then		    return 0		  end if		  		  #if TargetMacOS		    soft declare function CFGetTypeID lib CarbonFramework (cf as Ptr) as UInt32		    		    Return CFGetTypeID(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Description() As String		  if me = nil then		    return ""		  end if		  		  #if TargetMacOS		    soft declare function CFCopyDescription lib CarbonFramework (cf as Ptr) as CFStringRef		    		    return CFCopyDescription(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TypeDescription() As String		  if me = nil then		    return ""		  end if		  		  #if TargetMacOS		    soft declare function CFCopyTypeIDDescription lib CarbonFramework (cf as Ptr) as CFStringRef		    		    return CFCopyTypeIDDescription(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function RefCount() As Integer		  if me = nil then		    return 0		  end if		  		  #if TargetMacOS		    soft declare function CFGetRetainCount lib CarbonFramework (cf as Ptr) as Int32		    		    return CFGetRetainCount(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Hash() As UInt32		  if me = nil then		    return 0		  end if		  		  #if TargetMacOS		    soft declare function CFHash lib CarbonFramework (cf as Ptr) as UInt32		    		    return CFHash(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Convert() As Ptr		  Return me.Ref		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Show()		  if me = nil then		    return		  end if		  		  #if TargetMacOS		    soft declare sub CFShow lib CarbonFramework (obj as Ptr)		    		    CFShow me		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Retain()		  if me = nil then		    return		  end if		  		  soft declare function CFRetain lib CarbonFramework (cf as Ptr) as Integer		  		  call CFRetain(me.Ref)		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Release()		  if me = nil then		    return		  end if		  		  soft declare sub CFRelease lib CarbonFramework (cf as  Ptr)		  		  CFRelease me.Ref		End Sub	#tag EndMethod	#tag Method, Flags = &h0		 Shared Function NewObject(p as Ptr) As CFType		  if p = nil then		    return nil		  end if		  		  soft declare function CFGetTypeID lib CarbonFramework (cf as Ptr) as UInt32		  		  dim theTypeID as UInt32 = CFGetTypeID(p)		  		  		  select case theTypeID		  case CFArray.ClassID		    dim b as CFArray = p		    return b		    		  case CFBoolean.ClassID		    dim b as CFType = CFBoolean.GetTrue //needed to get the compiler to see the private Ref property		    if p = b.Ref then		      return CFBoolean.GetTrue		    else		      return CFBoolean.GetFalse		    end if		    		  case CFBundle.ClassID		    dim b as CFBundle = p		    return b		    		  case CFData.ClassID		    dim b as CFData = p		    return b		    		  case CFDate.ClassID		    dim b as CFDate = p		    return b		    		  case CFDictionary.ClassID		    dim b as CFDictionary = p		    return b		    		  case CFNumber.ClassID		    dim b as CFNumber = p		    return b		    		  case CFString.ClassID		    dim s as CFString = p		    return s		    		  case CFURL.ClassID		    dim url as CFURL = p		    return url		    		  case CFType.ClassID(p)		    dim cf as CFType = p		    return cf		    		  else		    #if DebugBuild		      soft declare function CFCopyTypeIDDescription lib CarbonFramework (cfid as UInt32) as CFStringRef		      soft declare function CFCopyDescription lib CarbonFramework (cf as Ptr) as CFStringRef		      soft declare sub CFShow  lib CarbonFramework ( obj as Ptr )		      		      dim cfs as CFStringRef = CFCopyTypeIDDescription ( theTypeID )		      dim cfd as CFStringRef = CFCopyDescription ( p )		      System.DebugLog( "type id = " + str(theTypeID) )		      System.DebugLog( cfs )		      System.DebugLog( cfd )		      CFShow(p)		    #endif		    		    return nil		    		  end select		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Compare(t as CFType) As Integer		  if t <> nil then		    return UInt32(me.Operator_Convert) - UInt32(t.Operator_Convert)		  else		    return UInt32(me.Operator_Convert)		  end if		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Shared Function ClassID(p as ptr) As UInt32		  #if targetMacOS		    		    soft declare function CFGetTypeID lib CarbonFramework (cfp as Ptr) as UInt32		    		    dim id as Uint32 = CFGetTypeID(cfp)		    return id		  #else		    return 0		  #endif		  		  		End Function	#tag EndMethod	#tag Note, Name = To Do		test constructor value for type in subclasses, so that a CFStringRef isn't passed to a CFDate, for example	#tag EndNote	#tag Note, Name = Memory Management		CFType follows the same memory management scheme used by CFStringRef. A CFType object is		created with whatever reference count the CFTypeRef has, and the CFTypeRef is always released by the destructor.				This means that CFType objects created from a Core Foundation Get* function may need to have		their reference counts incremented by hand.	#tag EndNote	#tag Property, Flags = &h21		Private Ref As Ptr	#tag EndProperty	#tag Constant, Name = ClassName, Type = String, Dynamic = False, Default = \"CFType", Scope = Private	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass