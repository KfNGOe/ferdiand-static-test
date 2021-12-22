for i in $(seq -f "%03g" 1 261); do
    FILENAME=A"$i".xml;
    URL=http://lap14-c624.uibk.ac.at/ferdinand2/api/letter/xml/Band_1/A"$i"; 
    wget $URL -O ./data/band_001/$FILENAME;
    #sleep .5
    #echo $URL
done

