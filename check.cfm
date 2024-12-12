<cfset aset=StructNew()> 
<cfset aset["paper"] = "letter"> 
<cfset aset["sides"] = "duplex"> 
<cfset aset["copies"] = "5"> 

<cfprint type="pdf" source="Assets/Docs/contact.pdf" attributeStruct="#aset#">