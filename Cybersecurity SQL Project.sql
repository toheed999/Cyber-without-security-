SELECT * 
FROM `cybersecurity_data`.`cyberattackdata`;

#Global Cybersecurity Attack Analysis 2015 - 2024

# 1. What has been the number one attack source used?
SELECT `Attack Source`, COUNT(*) AS frequency
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Attack Source`
ORDER BY frequency
LIMIT 1;

# 2. What have been the top 3 most used cyber attack defences?
SELECT `Defense Mechanism Used`, COUNT(*) AS frequency
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Defense Mechanism Used`
ORDER BY frequency
LIMIT 3;

# 3. What was the most common Attack Type per year?
WITH Ranked_Attacks AS(
SELECT `Year`, `Attack Type`, COUNT(*) AS attack_count, 
	ROW_NUMBER() OVER(PARTITION BY `Year` ORDER BY COUNT(*) DESC) AS rnk
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Year`, `Attack Type`
)
SELECT `Year`, `Attack Type`, attack_count
FROM Ranked_Attacks
WHERE rnk = 1;

# 4. What is the average number of people affected per industry?
SELECT `Target Industry`, FORMAT(AVG(`Number of Affected Users`), 0) AS `Average number of people affected`
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Target Industry`;

# 5. What is the average financial loss per attack type? 
SELECT `Attack Type`, FORMAT (AVG(`Financial Loss (in Million $)`), 0) AS Financial_Loss_in_$M
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Attack Type`
;

# 6. What are the top 3 Security Vulnerability Types 
SELECT `Security Vulnerability Type`, COUNT(*) AS frequency
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Security Vulnerability Type`
ORDER BY frequency;

# 7 Which country had the least number of cyber attacks?
SELECT `Country`, COUNT(*) AS frequency
FROM `cybersecurity_data`.`cyberattackdata`
GROUP BY `Country`
ORDER BY frequency DESC
LIMIT 1;

# 8. Which top 3 countries had the most "Unknown" attacks? 
SELECT `Country`, `Attack Source`, COUNT(*) AS frequency
FROM `cybersecurity_data`.`cyberattackdata`
WHERE `Attack Source` = 'Unknown'
GROUP BY `Country`
ORDER BY frequency DESC
LIMIT 3;

# 9. Which top 3 countries had the most government targeted attacks? 
SELECT `Country`, `Target Industry`, COUNT(*) AS Attacks 
FROM `cybersecurity_data`.`cyberattackdata`
WHERE `Target Industry` = 'Government'
GROUP BY `Country`
ORDER BY Attacks DESC
LIMIT 3;