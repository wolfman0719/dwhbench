/// 
Class DWH.SumByCity Extends %SQL.CustomResultSet
{

Property subtotal As %Double;

Property %openflag As %Boolean [ InitialExpression = "0", Private ];

Method %OpenCursor(city As %String) As %Library.Status [ ProcedureBlock = 0 ]
{
	set bsgn = "^DWH.PatientI(""TotalBillIndex1"")"
	set cdgn = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	set ..subtotal = ##class(DWH.BitOperation).bitslicesum(bsgn,cdgn)
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
/// 	{call DWH.SumByCity_GetResults('金沢市')}
/// 
/// コマンドプロンプトからの実行方法
/// 
/// 		do ##class(DWH.SumByCity).GetResults("大阪市")
/// 		do %sqlcontext.DumpResults()
/// 
ClassMethod GetResults(city As %String) As %Status [ ProcedureBlock = 0, ReturnResultsets, SqlProc ]
{
	if '$isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
	set rs = ..%New($system.SQL.Util.GetOption(),city)
	#; コンテキストオブジェクトに結果セットを設定
	do %sqlcontext.AddResultSet(rs)
	quit $$$OK
}

}
