/// 
Class DWH.SelectCityAndAge Extends %SQL.CustomResultSet
{

/// select count(*) from dwh.patient where city = ? and age = ?と同等の処理をObjectScriptで実装
Property Count As %Integer;

Property %openflag As %Boolean [ InitialExpression = "0", Private ];

Method %OpenCursor(city As %String, age As %Integer) As %Library.Status [ ProcedureBlock = 0 ]
{
	set cdgn = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	set adgn = "^DWH.PatientI(""AgeIndex1"","_age_")"
	set result = "^||result"
	do ##class(DWH.BitOperation).bitand(cdgn,adgn,.result)
	set ..Count = ##class(DWH.BitOperation).bitcount(result)
	set ..%openflag = 1
	set ..%SQLCode = 0
	quit $$$OK
}

Method %Next(ByRef sc As %Status) As %Integer [ ProcedureBlock = 0 ]
{
	if ..%openflag = 0  {
		quit 0
	}
	set ..%openflag = 0
	quit $$$OK
}

Method %CloseCursor() As %Status [ ProcedureBlock = 0 ]
{
 
	Quit $$$OK
}

/// xDBCクライアントでのテスト法:
/// 
/// 	{call DWH.SelectCityAndAge_GetResults('金沢市',24)}
/// 
/// コマンドプロンプトからの実行方法
/// 
/// 		do ##class(DWH.SelectCityAndAge).GetResults("大阪市",30)
/// 		do %sqlcontext.DumpResults()
/// 
ClassMethod GetResults(city As %String, age As %Integer) As %Status [ ProcedureBlock = 0, ReturnResultsets, SqlProc ]
{
	if '$isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
	set rs = ..%New($system.SQL.Util.GetOption(),city,age)
	#; コンテキストオブジェクトに結果セットを設定
	do %sqlcontext.AddResultSet(rs)
	quit $$$OK
}

}
