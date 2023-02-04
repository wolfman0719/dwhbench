Include %occCommon

Class DWH.Utility
{

ClassMethod BuildIndex1(sortbegin As %Boolean)
{
	kill ^DWH.PatientIdx
	h 5
	set start = $piece($zts,",",2)
	set id = ""
	set:sortbegin sts = $sortbegin(^DWH.PatientIdx)
	for {
		set id = $Order(^DWH.PatientD(id))
		if id = "" quit
		set record = ^DWH.PatientD(id)
		set city = $list(record,3)
		set ^DWH.PatientIdx(city,id) = ""		
	}
	set:sortbegin sts = $sortend(^DWH.PatientIdx)
	set end = $piece($zts,",",2)
	write "elasped time = ",end - start,!
}

ClassMethod CreateShard()
{
  &sql(create table dwh.shardpatient (name varchar(50), age int, city varchar(50), practice varchar(50), sex varchar(3), totalbill int, shard))
  if SQLCODE=0 { write "ok",! }
  else { write !,"ExecDirect1 SQLCODE=",SQLCODE,!  quit}
  &sql(create bitmap index cityindex on table dwh.shardpatient (city))
  if SQLCODE=0 { write "ok",! }
  else { write !,"ExecDirect2 SQLCODE=",SQLCODE,!  quit}
}

ClassMethod LoadDataToShard(count As %Integer)
{
  set start = $piece($zts,",",2)
  set sql = "insert into dwh.shardpatient(name,age,city,practice,sex,totalbill) values(?,?,?,?,?,?)"
  set Statement = ##class(%SQL.Statement).%New()
  set Status = Statement.%Prepare(sql)
  if Status'=$$$OK {write "%Prepare failed:" do $System.Status.DisplayError(Status) quit}
  for i = 1:1:count {
    set name = ##class(Sample.PopulateUtils).Name()
    set age = ##class(Sample.PopulateUtils).Age()
    set city = ##class(Sample.PopulateUtils).City()
    set practice = ##class(Sample.PopulateUtils).Practice()
    set sex = ##class(Sample.PopulateUtils).Sex()
    set totalbill = ##class(Sample.PopulateUtils).Bill()
    set rset = Statement.%Execute(name,age,city,practice,sex,totalbill)
    if rset.%SQLCODE=0 { }
    else { write !,"Exec SQLCODE=",rset.%SQLCODE,!,rset.%Message  quit}
  }
  
  set end = $piece($zts,",",2)
  
  write "elapsed time = ",(end - start),!
}

}
