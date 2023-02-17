let
    Source = Sql.Database("YOUR_SEVER_NAME", "YOUR_DATABASE_NAME"),
    // The following two variables are from Power Query parameters and
    // they're for incremental refresh, but you can use parameters for different purposes
    QueryRangeStart = Text.From(RangeStart),
    QueryRangeEnd = Text.From(RangeEnd),
    CustomQuery = "
        
        SELECT YOUR_COLUMNS
        FROM YOUR_TABLE
        WHERE 
            Date >= '" & QueryRangeStart & "'
        AND Date < '" & QueryRangeEnd & "' 
    ",
    QueryFoldableQuery = Value.NativeQuery(Source, CustomQuery, null, [EnableFolding=true]),
in
    QueryFoldableQuery
