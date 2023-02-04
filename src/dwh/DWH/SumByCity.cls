/// 
Class DWH.SumByCity Extends %SQL.CustomResultSet
{

Property subtotal As %Float;

Property %openflag As %Boolean [ InitialExpression = "0", Private ];

Method %OpenCursor(city As %String) As %Library.Status
{
	set bsgn = "^DWH.PatientI(""TotalBillIndex1"")"
	set cdgn = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	set ..subtotal = ##class(DWH.BitOperation).bitslicesum(bsgn,cdgn)
	set ..%openflag = 1
	set ..%SQLCode = 0
	quit $$$OK
}

Method %Next(ByRef sc As %Status) As %Integer
{
	if ..%openflag = 0  {
		quit 0
	}
	set ..%openflag = 0
	quit $$$OK
}

Method %CloseCursor() As %Status
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
ClassMethod GetResults(city As %String) As %Status [ ReturnResultsets, SqlProc ]
{
	if '$isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
	set rs = ..%New($system.SQL.GetSelectMode(),city)
	#; コンテキストオブジェクトに結果セットを設定
	do %sqlcontext.AddResultSet(rs)
	quit $$$OK
}

}
