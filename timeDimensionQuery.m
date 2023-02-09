let
    Source = List.Times(#time(0, 0, 0), 3600*24, #duration(0, 0, 0, 1)),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Changed Type" = Table.TransformColumnTypes(#"Converted to Table",{{"Column1", type time}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "Time"}}),
    #"Added Index" = Table.AddIndexColumn(#"Renamed Columns", "Index", 1, 1, Int64.Type),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Index",{{"Index", "TimeKey"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns1",{"TimeKey", "Time"}),
    #"Added Custom" = Table.AddColumn(#"Reordered Columns", "Hour", each Time.Hour([Time])),
    #"Added Custom1" = Table.AddColumn(#"Added Custom", "Minute", each Time.Minute([Time])),
    #"Added Custom2" = Table.AddColumn(#"Added Custom1", "Second", each Time.Second([Time])),
    #"Added Conditional Column" = Table.AddColumn(#"Added Custom2", "AM/PM", each if [Hour] >= 12 then "PM" else "AM"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Conditional Column",{{"Hour", Int64.Type}, {"Minute", Int64.Type}, {"Second", Int64.Type}, {"AM/PM", type text}})
in
    #"Changed Type1"
