Class DWH.Patient Extends (%Persistent, %Populate) [ ClassType = persistent, Inheritance = right, LegacyInstanceContext, ProcedureBlock ]
{

Property Age As %Integer(POPSPEC = "##Class(Sample.PopulateUtils).Age()");

Property City As %String(POPSPEC = "##Class(Sample.PopulateUtils).City()", TRUNCATE = 1);

Property Name As %String(POPSPEC = "##Class(Sample.PopulateUtils).Name()", TRUNCATE = 1);

Property Practice As %String(POPSPEC = "##Class(Sample.PopulateUtils).Practice()", TRUNCATE = 1);

Property Sex As %String(POPSPEC = "##Class(Sample.PopulateUtils).Sex()", TRUNCATE = 1);

Property TotalBill As %Integer(POPSPEC = "##Class(Sample.PopulateUtils).Bill()");

Index AgeIndex1 On Age [ Type = bitmap ];

// columnar のベンチマークを実施する際には、以下のインデックス定義をコメント化する
Index CityIndex1 On City [ Type = bitmap ];
// columnar のベンチマークを実施する際には、以下のインデックス定義をコメントアウト
//Index CityIndex1 On City [ Type = columnar ];

Index NameIndex1 On Name [ Type = bitmap ];

Index PracticeIndex1 On Practice [ Type = bitmap ];

Index SexIndex1 On Sex [ Type = bitmap ];

// columnar のベンチマークを実施する際には、以下のインデックス定義をコメント化する
Index TotalBillIndex1 On TotalBill [ Type = bitslice ];
// columnar のベンチマークを実施する際には、以下のインデックス定義をコメントアウト
//Index TotalBillIndex1 On TotalBill [ Type = columnar ];

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Age</Value>
</Value>
<Value name="3">
<Value>City</Value>
</Value>
<Value name="4">
<Value>Name</Value>
</Value>
<Value name="5">
<Value>Practice</Value>
</Value>
<Value name="6">
<Value>Sex</Value>
</Value>
<Value name="7">
<Value>TotalBill</Value>
</Value>
</Data>
<DataLocation>^DWH.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<ExtentSize>5000000</ExtentSize>
<IdLocation>^DWH.PatientD</IdLocation>
<IndexLocation>^DWH.PatientI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>4.99</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Age">
<AverageFieldSize>2.99</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<Property name="City">
<AverageFieldSize>8.15</AverageFieldSize>
<Selectivity>4.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>11.88</AverageFieldSize>
<Selectivity>0.0046%</Selectivity>
</Property>
<Property name="Practice">
<AverageFieldSize>7.44</AverageFieldSize>
<Selectivity>14.2857%</Selectivity>
</Property>
<Property name="Sex">
<AverageFieldSize>4</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="TotalBill">
<AverageFieldSize>4.31</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<SQLMap name="$Patient">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="AgeIndex1">
<BlockCount>-8112</BlockCount>
</SQLMap>
<SQLMap name="CityIndex1">
<BlockCount>-7904</BlockCount>
</SQLMap>
<SQLMap name="IDKEY">
<BlockCount>-128908</BlockCount>
</SQLMap>
<SQLMap name="NameCityIndex">
<BlockCount>-31208</BlockCount>
</SQLMap>
<SQLMap name="NameIndex1">
<BlockCount>-20884</BlockCount>
</SQLMap>
<SQLMap name="PracticeIndex1">
<BlockCount>-2212</BlockCount>
</SQLMap>
<SQLMap name="SexIndex1">
<BlockCount>-636</BlockCount>
</SQLMap>
<SQLMap name="TotalBillIndex1">
<BlockCount>-4496</BlockCount>
</SQLMap>
<StreamLocation>^DWH.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Index NameCityIndex On (Name, City);

}
