Class Demo2.ProcessInfo
{

/// Get some process info
ClassMethod GetInfo(Output array)
{

	kill array
	set array("System Name") = $system
	set array("Namespace") = $namespace
	set array("Username") = $username
}

}
