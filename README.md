# INSIGHTS-INTO-EMPLOYEES-STRESS-LEVEL-VISUALIZING-EMPLOYEE-WELLBEING-WITH-DATA
This project explores employee stress levels using real-world survey data provided by Stress Care Clinic. Through data analysis and visualization, it uncovers key stress factors affecting workplace well-being and offers actionable insights to help organizations improve employee health, productivity, and overall workforce performance.

![Screenshot (342)](https://github.com/user-attachments/assets/c5e20f58-2710-44a6-9dd4-31a921877313)

![Screenshot (347)](https://github.com/user-attachments/assets/9f3e2db3-a6f0-4f08-a9c5-8beaf43eb519)

## **INTRODUCTION**

In today’s fast-moving and demanding work culture, employee stress is a rising challenge, affecting not only personal well-being but also productivity and performance. Stress Care Clinic, a wellness organization, has decided to look into this as they are committed to improving employee well-being. By analyzing their survey and monitoring data, this project focuses on understanding the root causes of workplace stress to uncover patterns, identify key stress triggers, and provide practical, data-driven solutions that companies can use to build healthier, more supportive work environments.

## **INDUSTRY TYPE OF DATA**

This project falls under the Health Industry. It is important for everyone, including employers, employees, students, and individuals worldwide.

## **PROJECT OBJECTIVES**

This project aims to uncover some pointers for the stress care clinic:

1. Identify the primary sources of stress among employees.
2. Analyze symptoms most commonly associated with high stress levels.
3. Determine which groups of employees (by role, age, or other factors) are most affected by stress.
4. Discover what strategies or conditions help reduce stress and improve well-being.
5. Develop an interactive dashboard to monitor and manage stress levels in real time.

## **DATA CLEANING STEPS TAKEN**

- I first imported the dataset into the SQL Workbench by creating a database named StressCare, then used the flat file import feature to bring in the raw data.
- I previewed the dataset with a SQL SELECT query to ensure the file was correctly loaded without import errors.
- To enhance readability and ease of access, I renamed the original dataset to StressCare_Data using the SP_RENAME command.
- I renamed all column names to more meaningful and standardized names for clarity throughout the analysis.
- I checked for and removed duplicate records using a combination of ROW_NUMBER(), CTE (Common Table Expression), and DELETE queries. This helped eliminate 19 duplicate rows that could skew results.
- I handled missing values by identifying NULLs and replacing them appropriately. Most were handled during duplicate removal, while the missing stress score was filled using the average stress level (via subquery).
- I verified each column's data type using EXEC_sp_help and ensured numeric fields had no extra spaces or text formatting issues.
- I removed unwanted white spaces from text-based columns using the TRIM, LTRIM, and RTRIM functions.
- I standardized date formats for Date of Birth and Test Date, ensuring they were properly formatted and checked for outliers (e.g., future or unrealistically old birthdates).
- I created new calculated columns, such as Age, by subtracting the date of birth from the current date.
- I categorized key fields like Age, Stress Level Score, Stress Duration, Heart Rate, and Cortisol Level into meaningful groups using the CASE statement for easier analysis and segmentation.

## **METHODOLOGIES**

To gain deeper insights from the cleaned data, I applied SQL-based data transformation and analysis techniques:
1. I used SQL Queries throughout for data cleaning, including identifying duplicates, handling nulls, updating formats, and transforming values.
2. I used CASE statements to group numerical data like age and stress scores into categorical segments (e.g., “Young,” “Adult,” “High Stress”), to simplify my analysis and storytelling.
3. Data Profiling via MIN(), MAX(), and AVG() functions was used to understand data ranges and identify anomalies.
4. I created Calculated Fields such as Age and Age Group directly in the SQL environment to ensure the dataset was ready for exploration before exporting.
5. After cleaning, I exported the dataset into Excel for further analysis and visualization.

## **KEY METRICS AND PATTERNS**

- The StressCare dataset contains a total of 5,000 employees, with an average age of 33 years. On average, employees recorded a stress level score of 1.36, experienced stress for 94 days, and had a cortisol level of 15.57.
- Based on the data, most employees are dealing with either mild (39.58%) or moderate (40.06%) stress. Only 20.36% are facing severe stress, but that’s still a big concern. If the moderate cases aren’t handled well, they could easily slip into severe stress over time.
- Work is the biggest source of stress, with 1,339 employees feeling overwhelmed by deadlines, workload, or poor communication.
- Financial issues affect 1,224 employees, driven by rising bills, daily expenses, and the pressure to keep up with responsibilities.
- Family issues (998 employees), health (783 employees), and relationship stress (515 employees) all contribute significantly, with family duties, health problems, and relationship issues adding more pressure
- Fatigue (1,254 employees) and back pain (1,172 employees) are the top physical symptoms, likely caused by poor work posture or stress from workload and other sources.
- Other common symptoms include insomnia (947 employees), headaches (809 employees), and high blood pressure (676 employees), all of which negatively impact employee health and productivity.
- Emotional discomfort is a key factor driving up stress levels, with anxiety, depression, irritability, and mood swings being the most common complaints from employees.
- Stress levels were lowest in January (15.31), then started rising from February (15.59) with a slight dip in March (15.43).
- From April to June, cortisol levels steadily increased, reaching their highest in June at 15.75, indicating rising stress over time.
- The Young and Adult groups have the highest average stress levels at 1.36, likely due to career pressures, family duties, and societal expectations.
- The Aged group shows a slightly lower stress level of 1.34, possibly because they face fewer challenges than younger groups.
- The Old group has the lowest stress level at 1.33, likely due to fewer responsibilities and a more relaxed lifestyle, with younger groups needing more support to manage stress.
- Both male and female employees have nearly the same stress levels (1.36 for females, 1.35 for males), which shows that stress affects everyone almost equally, even if the reasons behind it might be different.
- People with poor sleep have the highest stress level at 1.62, while those with fair sleep score 1.41, and good sleepers have the lowest at 1.22. This clearly shows that bad sleep makes stress worse, while good sleep helps reduce it.
- Sleep and stress go hand in hand. Not sleeping well can make stress harder to manage, and being stressed can make it harder to sleep. Good rest helps the body recover and handle daily stress better.
- Employees feel the most stressed at 8 AM, 12 PM, and 5–6 PM, likely due to the pressure of starting the day, mid-day workload, and end-of-day fatigue.
- Stomach ache, shortness of breath, and insomnia are the top stress symptoms with the highest average stress levels, showing these employees may be under serious stress and need urgent support.
- People use different stress coping methods depending on how long or intense the stress is. Activities like art, sleeping, and therapy are common for extreme stress, while walking, reading, and talking to family help with short-term stress.
- Coping styles also vary by age and gender. Younger people lean more on therapy, hobbies, and meditation, while older adults prefer calming activities like gardening, walking, and reading to manage stress
- Adult female employees are the most stressed, mainly from work, finances, and family. They often deal with headaches, insomnia, fatigue, and mood swings. Younger females show more emotional signs like fear, anger, and depression, while older females struggle with health issues and loneliness.
- Male employees face high stress too, mostly from work and money problems. Adult and aged males often experience physical symptoms like back pain, high blood pressure, and arthritis. Older and younger males also deal with emotional symptoms like insomnia, fear, and depression.
- Overall, both men and women across all age groups show signs of stress, but the symptoms and causes differ.
- The analysis shows that a higher heart rate is linked to higher stress levels. Severe stress (1.54) leads to a significant heart rate increase, while normal stress levels show a slight increase (1.28), and very low stress levels (1.12) are associated with healthier heart rates.

## **RECOMMENDATION**

- Offer regular counseling sessions for all employees, no matter their stress level. Make sure mental health resources like apps and hotlines are available to everyone. Addressing stress early can lead to better overall performance and a healthier work environment.
- Work-related stress can be alleviated by encouraging task delegation and hiring additional staff when needed. Teach employees time management and set realistic deadlines to manage workload.
- Team-building activities and manager training can resolve workplace conflicts effectively, while money management workshops can reduce financial stress.
- To reduce complaints related to physical and emotional symptoms, provide ergonomic chairs and desks to improve posture and reduce back pain. Invest in quiet relaxation spaces to minimize fatigue, insomnia, and headaches, and offer a healthy snack bar to encourage hydration.
- During stressful months like February, May, and June, consider lightening workloads and adjusting deadlines to reduce pressure. Plan team bonding events or wellness days to give employees a much-needed break and show support during challenging times.
- Offer younger employees stress management workshops and career guidance to help with anxiety. For adults, financial counseling and work-life balance support can be extremely beneficial. For older employees, health check-ups and training to stay current with technology can make a huge difference.
- Encourage better sleep hygiene by providing tools like sleep trackers or relaxation apps. If possible, create quiet areas for short naps or breaks to help employees recharge and improve overall well-being.
- Schedule work around stress peaks by avoiding tough tasks early in the day or around noon. Save complex tasks for calmer afternoons. Encourage short breaks when stress levels are high to help employees stay balanced and productive.
- Offer a variety of stress relief options, from therapy and meditation sessions for severe stress, to walking, reading, or socializing for milder stress. This way, every employee can find something that works for them.
- Partner with healthcare providers for regular health screenings, focusing on stress-related symptoms like high blood pressure or insomnia. Encourage employees to stay active, eat well, and engage in calming activities like yoga or music to keep stress in check.
- Stress affects everyone differently, so make sure to regularly check in with employees. Use surveys to monitor employee well-being and quickly respond to anyone struggling. Promote healthy habits like good nutrition and regular exercise to naturally reduce stress and contribute to a healthier workplace.

In conclusion, addressing employee stress through data-driven insights and proactive measures is crucial for creating a supportive and productive work environment. By following these strategic recommendations, companies can reduce stress and improve overall well-being. Small, consistent efforts to manage stress can create a happier, more productive workplace. 
