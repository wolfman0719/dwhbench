/// 
Class DWH.SumByCityDirect Extends %SQL.CustomResultSet
{

Property subtotal As %Float;

Property %openflag As %Boolean [ InitialExpression = "0", Private ];

Method %OpenCursor(city As %String) As %Library.Status
{
  set subtotal = 0
  set cityindexstring = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	
  set cityno = 0
  for {
    set cityno = ##class(DWH.BitOperation).bitfind(cityindexstring,1,cityno)
    if cityno {
      set subtotal = subtotal + $list($get(^DWH.PatientD(cityno-1)),7)
    }
    else {
      quit
    }
  }
  set ..%openflag = 1
  set ..subtotal = subtotal
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
/// 	{call DWH.SumByCityDirect_GetResults('金沢市')}
/// 
/// コマンドプロンプトからの実行方法
/// 
/// 		do ##class(DWH.SumByCityDirect).GetResults("大阪市")
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

ClassMethod GlobalAccess(city As %String) As %Library.Status
{
  set start = $piece($zts,",",2)
  set subtotal = 0
  set cityindexstring = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	
  set cityno = 0
  for {
    set cityno = ##class(DWH.BitOperation).bitfind(cityindexstring,1,cityno)
    if cityno {
      set line = $get(^DWH.PatientD(cityno-1))
      set subtotal = subtotal + $list(line,7)
    }
    else {
      quit
    }
  }
  set end = $piece($zts,",",2)
  write "subtotal = ",subtotal,!
  write "elapsed time = ", end - start,!
  quit $$$OK
}

}
