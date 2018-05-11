#tag Class
Class CFUUID
Inherits CFType
	#tag Event
		Function ClassID() As UInt32
		  return  me.ClassID
		End Function
	#tag EndEvent

	#tag Event
		Function VariantValue() As Variant
		  return  me.StringValue
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ClassID() As UInt32
		  #if targetMacOS
		    declare function TypeID lib CoreFoundation.framework alias "CFUUIDGetTypeID" () as UInt32
		    static id as UInt32 = TypeID
		    return id
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(mb as MemoryBlock)
		  #if TargetMacOS
		    soft declare function CFUUIDCreateFromUUIDBytes lib CoreFoundation.framework (alloc as Ptr, bytes as CFUUIDBytesStructure ) as Ptr
		    
		    dim bytes as CFUUIDBytesStructure
		    bytes.StringValue( mb.LittleEndian ) = mb.StringValue( 0, 16 )
		    
		    Super.Constructor   CFUUIDCreateFromUUIDBytes( nil, bytes ), true
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(uuid as String)
		  #if TargetMacOS
		    soft declare function CFUUIDCreateFromString lib CoreFoundation.framework (alloc as Ptr, uuidStr as CFStringRef ) as Ptr
		    
		    Super.Constructor   CFUUIDCreateFromString( nil, uuid ), true
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBytes() As MemoryBlock
		  //Get the UUID as a group of endianness-independent MemoryBlock
		  
		  #if TargetMacOS
		    soft declare function CFUUIDGetUUIDBytes lib CoreFoundation.framework (ref as Ptr) as CFUUIDBytesStructure
		    
		    dim bytes as CFUUIDBytesStructure = CFUUIDGetUUIDBytes( me.Reference )
		    dim mb as new MemoryBlock( 16 )
		    
		    mb.StringValue( 0, 16 ) = bytes.StringValue( mb.LittleEndian )
		    return   mb
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  #if TargetMacOS
		    return  me.StringValue
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(uuid as String)
		  #if TargetMacOS
		    me.Constructor( uuid )
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  #if TargetMacOS
		    soft declare function CFUUIDCreateString lib CoreFoundation.framework (alloc as ptr, uuid as Ptr) as CFStringRef
		    
		    return   CFUUIDCreateString( nil, me.Reference )
		  #endif
		End Function
	#tag EndMethod


	#tag Note, Name = Documentation
		CFUUID is the RB object corresponding to CFUUIDRef in CoreFoundation. It is an endianness-independent group of 16 bytes (128 bits)
		
		You can create it as:
		uuid = new CFUUID( "07AE3B9B-587E-397C-A731-AD4B1BA1B00E" )
		uuid = "07AE3B9B-587E-397C-A731-AD4B1BA1B00E"  //Involves Operator_Convert
		
		uuid = new CFUUID( my128bitsMemoryBlock )
		
		
		You can get the string value using:
		s = uuid.StringValue
		s = uuid.VariantValue   //"VariantValue" is an event used shared by all the CFType objects
		
		s = uuid  //Involves Operator_Convert
	#tag EndNote


	#tag Structure, Name = CFUUIDBytesStructure, Flags = &h0
		byte0 as Int8
		  byte1 as Int8
		  byte2 as Int8
		  byte3 as Int8
		  byte4 as Int8
		  byte5 as Int8
		  byte6 as Int8
		  byte7 as Int8
		  byte8 as Int8
		  byte9 as Int8
		  byte10 as Int8
		  byte11 as Int8
		  byte12 as Int8
		  byte13 as Int8
		  byte14 as Int8
		byte15 as Int8
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
