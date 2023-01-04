= (t as table) =>
let
    Source0 = Table.TransformColumnNames(t, each Text.Replace(Text.Proper(_), "_", "")  ),
    Source = 
    Table.TransformColumnNames(
        Source0, 
        each Text.Combine(
            Splitter.SplitTextByPositions(
                Text.PositionOfAny(_, {"A".."Z"},2)
                ) 
                (_),
                 " ")
    )
in
    Source
