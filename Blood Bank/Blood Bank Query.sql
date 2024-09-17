/*  1. Find the names of donors who have donated the same blood group as the 
       hospital's needed blood group  and the manager who handled the donation.  */
      


SELECT
	
	   h2.hosp_id AS Hospital_Id, 
	   h2.hosp_name AS Hospital_name , 
       h2.hosp_needed_bgrp AS Needed_blood_group,
	   bm.m_name  AS Manager_Name,
	   bd.bd_name AS Blood_Donor_Name 
	
FROM hospital_info_2 AS h2
	
INNER JOIN  bloodspecimen AS bs ON h2.hosp_needed_bgrp = bs.b_group
	
INNER JOIN bb_manager AS bm ON bs.m_id = bm.m_id
	
INNER JOIN blood_donor AS bd ON h2.hosp_needed_bgrp = bd.bd_bgroup
	
WHERE bs.status = '1'
	
ORDER BY  h2.hosp_id , h2.hosp_needed_bgrp



/*   2. Find the most frequently requested blood group by hospitals and the total quantity requested.  */


	
WITH cte AS(
	
SELECT 
	
	   hosp_needed_bgrp , 
	   COUNT(*) AS Number_Of_Times_Requested, 
	   SUM(hosp_needed_bqnty) AS Total_Quantity ,
	   RANK() OVER(ORDER BY COUNT(*) DESC)  AS rnk
	  
FROM hospital_info_2
	
GROUP BY hosp_needed_bgrp
)

SELECT  *  FROM cte
	
WHERE cte.rnk = 1
	
ORDER BY Total_Quantity DESC



/*    3. Retrieve the list of donors whose blood group is rare 
         (i.e., they are the only donors with that blood group in their city).  */

WITH cte AS( 
	
SELECT 
	   city_id, 
	   bd_bgroup AS Blood_Group
	
FROM blood_donor

GROUP BY city_id , bd_bgroup
	
HAVING  COUNT(*) = 1
	
)

SELECT 
	
	 c.city_name AS City,
	 bd.bd_name  AS Donor_Name,
	 bd.bd_bgroup AS  Blood_Group
	
FROM   Blood_Donor AS bd
	
INNER JOIN cte ON cte.city_id = bd.city_id AND cte.Blood_Group = bd.bd_bgroup

INNER JOIN city AS c ON bd.city_id = c.city_id

ORDER BY City , Blood_Group	
	

	
/*   4. Find the average age of blood donors and recipients for each blood group.  */



SELECT
	
    bg.blood_group,
    AVG(bg.donor_age) AS avg_donor_age,
    AVG(bg.recipient_age) AS avg_recipient_age
	
FROM (
	
    SELECT 
        d.bd_Bgroup AS blood_group,
        d.bd_age AS donor_age,
        NULL AS recipient_age
    FROM 
        blood_donor d
	
    UNION ALL
	
    SELECT 
        r.reci_Bgrp AS blood_group,
        NULL AS donor_age,
        r.reci_age AS recipient_age
    FROM 
        recipient r
) bg
	
GROUP BY 
    bg.blood_group	

	


/*     5. Find the number of donors and recipient registers by each recording staff   */


SELECT  
	
	  rs.reco_id  as Staff_Id, 
	  rs.reco_name as Staff_Name,
	  COUNT(DISTINCT(bd.bd_id))  AS Number_Of_Donors, 
	  COUNT(DISTINCT(r.reci_id)) AS Number_Of_Recipient
	
FROM recording_staff AS rs

LEFT JOIN blood_donor AS bd ON  rs.reco_id  = bd.reco_id 

LEFT JOIN recipient AS r ON r.reco_id = rs.reco_id

GROUP BY rs.reco_id

ORDER BY rs.reco_id



/*    6. Identify the donor and recipient pairs who are from the same city and have the same blood group  */


SELECT
	
        bd.bd_name AS Donor_Name ,
        r.reci_name AS Recipient_Name,
	    bd.bd_bgroup AS Blood_Group,
	    c.city_name AS City

FROM blood_donor AS bd
	
INNER JOIN recipient AS r  ON bd.bd_bgroup = r.reci_bgrp
AND r.city_id = bd.city_id

INNER JOIN city AS c ON r.city_id = c.city_id




/*   7. Find the  number of blood donations in each city.   */

	

SELECT 
	
	 c.city_name  AS City_Name , 
	 COUNT(*) AS Number_Of_Donations
	
FROM blood_donor AS  bd
	
INNER JOIN city AS c ON c.city_id = bd.city_id
	
GROUP BY c.city_name

ORDER BY City_Name



/*  8. Determine the total quantity of blood needed by each hospital and the number of different
       blood groups required.   */


SELECT
	
    h.hosp_name AS Hospital_Name,
    SUM(h.hosp_needed_Bqnty) AS total_blood_quantity_needed,
    COUNT(DISTINCT h.hosp_needed_Bgrp) AS different_blood_groups_needed
	
FROM   hospital_info_2 AS h
    
GROUP BY   h.hosp_name
   
ORDER BY h.hosp_name












