 #!/bin/bash
 # Check Laundryview and report number of available washing machines
 curl http://www.laundryview.com/laundry_room.php?lr=870017400352 | grep WASHERS | sed s/.*span..// | sed s/of.*/washers\ available/
