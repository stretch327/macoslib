#tag Class
Class NSTableColumn
Inherits NSObject
	#tag Method, Flags = &h1000
		Sub Constructor(identifier as String)
		  #if targetCocoa
		    declare function initWithIdentifier lib CocoaLib selector "initWithIdentifier:" (obj_id as Ptr, identifier as CFStringRef) as Ptr
		    
		    dim p as Ptr = initWithIdentifier(Allocate("NSTableColumn"), identifier)
		    self.Constructor(p)
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Title(assigns value as String)
		  #if targetCocoa
		    declare function headerCell lib CocoaLib selector "headerCell" (obj_id as Ptr) as Ptr
		    declare sub setStringValue lib CocoaLib selector "setStringValue:" (obj_id as Ptr, aString as CFStringRef)
		    dim c as Ptr = headerCell(self)
		    if c <> nil then
		      setStringValue(c, value)
		    else
		      break
		    end if
		  #endif
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetCocoa
			    declare function width lib CocoaLib selector "width" (obj_id as Ptr) as Single
			    
			    return width(self)
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if targetCocoa
			    declare sub setWidth lib CocoaLib selector "setWidth:" (obj_id as Ptr, newWidth as Single)
			    
			    setWidth self, CType(Value, Single)
			  #endif
			  
			  
			End Set
		#tag EndSetter
		Width As Double
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="NSObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass