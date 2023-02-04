Include bitutil

/// 
Class DWH.SumByCityDirectOptimize2 Extends %SQL.CustomResultSet
{

Property subtotal As %Float;

Property %openflag As %Boolean [ InitialExpression = "0", Private ];

Method %OpenCursor(city As %String) As %Library.Status
{
	//間接指定ではなく、直接グローバルを参照
	set subtotal = 0
	//set cityindexstring = "^DWH.PatientI(""CityIndex1"","" "_city_""")"
	
	set cityno = 0
	set on = 1
	for {
	  //set cityno = ##class(DWH.BitOperation).bitfind(cityindexstring,1,cityno)
      //Cache SQLで使用するビットマップインデックスの1ビット目は使用していないため,1ずらす
	  set cityno = cityno + 1
      Set chunk=(cityno-1)\$$$CHUNKSIZE,offset=cityno-(chunk*$$$CHUNKSIZE)
      //chunkでループ
      Set start = chunk*$$$CHUNKSIZE
      For  {
	     Set chunk=$Order(^DWH.PatientI("CityIndex1"," "_city,chunk))
	     Quit:chunk=""							
	     Set pos = $BITFIND(^DWH.PatientI("CityIndex1"," "_city,chunk),on,offset)
	     If pos=0 {
		    Set offset = 0 	
            Set start = start + $$$CHUNKSIZE
	     }
        Quit:pos
	  }
	  If chunk="" {
		  Set start = 0
		  Set pos = 0
	  }
	  set cityno = start+pos

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
/// 	{call DWH.SumByCityDirectOptimize2_GetResults('金沢市')}
/// 
/// コマンドプロンプトからの実行方法
/// 
/// 		do ##class(DWH.SumByCityDirectOptimize2).GetResults("大阪市")
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
	set st = $piece($zts,",",2)
	//間接指定ではなく、直接グローバルを参照
	set subtotal = 0
	
	set cityno = 0
	set on = 1
	for {
	  set cityno = cityno + 1
      For  {
	    write "cityno = ",cityno,!  
	    Set cityno = $BITFIND(^DWH.PatientI("CityIndex1"," "_city),on,cityno)

	    if cityno {
		   set subtotal = subtotal + $list($get(^DWH.PatientD(cityno-1)),7)
	    }
	    else {
		  quit
	    }
      }
	}
	set end = $piece($zts,",",2)
	write "subtotal = ",subtotal,!
	write "elapsed time = ", end - st,!
	quit $$$OK
}

}
