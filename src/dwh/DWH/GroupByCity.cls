/// 
Class DWH.GroupByCity Extends %SQL.CustomResultSet
{

Property subtotal As %Float;

Property %city As %String [ Private ];

Property city As %String;

Method %OpenCursor() As %Library.Status
{
  set ..%city = ""
  set ..%SQLCode = 0
  quit $$$OK
}

Method %Next(ByRef sc As %Status) As %Integer
{
  set city = ..%city
  set city = $order(^DWH.PatientI("CityIndex1",city))
  if city = ""  {
    set ..%city = city
    quit 0
  }
  set bsgn = "^DWH.PatientI(""TotalBillIndex1"")"
  set cdgn = "^DWH.PatientI(""CityIndex1"","""_city_""")"
  set ..subtotal = ##class(DWH.BitOperation).bitslicesum(bsgn,cdgn)
  set ..%city = city
  set ..city = $extract(city,2,*)
  quit $$$OK
}

/// xDBCクライアントでのテスト法:
/// 
/// 	{call DWH.GroupByCity_GetResults()}
/// 
/// コマンドプロンプトからの実行方法
/// 
/// 		do ##class(DWH.GroupByCity).GetResults()
/// 		do %sqlcontext.DumpResults()
/// 
ClassMethod GetResults() As %Status [ ReturnResultsets, SqlProc ]
{
  if '$isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
  set rs = ..%New($system.SQL.GetSelectMode())
  #; コンテキストオブジェクトに結果セットを設定
  do %sqlcontext.AddResultSet(rs)
  #; Successful - you can test this method from a command prompt by executing these commands:
  #;		do ##class(Sample.ResultSets).GetResults()
  #;		do %sqlcontext.DumpResults()
  quit $$$OK
}

}
