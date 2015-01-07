def hashRowAsElement ( csvString, keyWord )
    termMap, res, startTag, temp = {}, [], FALSE, {}

    csvString.each do | eachRow |
	eachRow = eachRow.split( ',' )

	if startTag
	    temp.clear

	    eachRow.each_with_index do | element, key |
		temp[ termMap[key] ] = element
	    end

	    res.push( temp )
	elsif eachRow[0].to_s == keyWord
	    eachRow.each_with_index do | term, key |
		termMap[key] = term
	    end

	    startTag = TRUE
	end
    end

    res.inspect
end
