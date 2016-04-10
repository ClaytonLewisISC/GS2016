/// Logs messages with timestamps
/// A simple Logger
Class Demo2.Logger Extends (%Persistent, %XML.Adaptor) {

Property TimeStamp As %TimeStamp;

Index ts On TimeStamp;

Property Username As %String;

Index un On Username;

/// The message we show to the user
Property Message As %String(MAXLEN = 200);

ClassMethod SaveNew(username As %String, message As %String) As %Status
{
	set obj = ..%New()
	set obj.TimeStamp = $zDateTime($horolog, 3)
	set obj.Username = username
	set obj.Message = message
	return obj.%Save()
}

ClassMethod Report()
{

	&sql(DECLARE C1 CURSOR FOR
		SELECT TimeStamp, Username, Message
		INTO :ts, :un, :msg
		FROM Logger
	)
	
	&sql(OPEN C1)
	for {
		&sql(FETCH C1) quit:(SQLCODE '= 0)
		write !, ts, ?20, un, ?40, msg
	}
	
	&sql(CLOSE C1)
}

Storage Default
{
<Data name="LoggerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TimeStamp</Value>
</Value>
<Value name="3">
<Value>Username</Value>
</Value>
<Value name="4">
<Value>Message</Value>
</Value>
</Data>
<DataLocation>^Demo2.LoggerD</DataLocation>
<DefaultData>LoggerDefaultData</DefaultData>
<IdLocation>^Demo2.LoggerD</IdLocation>
<IndexLocation>^Demo2.LoggerI</IndexLocation>
<StreamLocation>^Demo2.LoggerS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
