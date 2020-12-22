-- Question:
-- For all users that received a notification, what is the difference in average transactions 7 days before the notification arrived vs. 7 days after the notification arrived, by country and age group?

-- Assumptions:
-- 1. Transactions can exhibit any transaction_state (not limited to "COMPLETED") for the calculation of average transactions.
-- 2. Difference is calculated as (average transactions 7 days after the notification arrived - average transactions 7 days before the notification arrived) and not the other way round.

-- Note: Query takes ~4.5 minutes to execute completely.

SELECT 
  q.country, 
  q.age_group, 
  q.avg_post_transactions, 
  q.avg_prev_transactions, 
  (
    q.avg_post_transactions - q.avg_prev_transactions
  ) AS difference 
FROM 
  (
    SELECT 
      q4.country, 
      CASE WHEN q4.age <= 20 THEN '<= 20' WHEN q4.age <= 30 THEN '21 - 30' WHEN q4.age <= 40 THEN '31 - 40' WHEN q4.age <= 50 THEN '41 - 50' WHEN q4.age <= 60 THEN '51 - 60' WHEN q4.age <= 70 THEN '61 - 70' WHEN q4.age <= 80 THEN '71 - 80' WHEN q4.age <= 90 THEN '80 - 90' ELSE '> 90' END AS age_group, 
      AVG(
        CAST(q4.prev_transactions AS FLOAT)
      ) AS avg_prev_transactions, 
      AVG(
        CAST(q4.post_transactions AS FLOAT)
      ) AS avg_post_transactions 
    FROM 
      (
        SELECT 
          q3.user_id, 
          u.country, 
          (2019 - u.birth_year) AS age, 
          q3.created_date, 
          q3.prev_transactions, 
          q3.post_transactions 
        FROM 
          (
            SELECT 
              q1.user_id, 
              q1.created_date, 
              q1.prev_transactions, 
              q2.post_transactions 
            FROM 
              (
                SELECT 
                  n.user_id, 
                  n.created_date, 
                  COUNT(distinct prev.transaction_id) AS prev_transactions 
                FROM 
                  (
                    SELECT 
                      user_id, 
                      created_date 
                    FROM 
                      notifications 
                    WHERE 
                      status = 'SENT'
                  ) n 
                  LEFT OUTER JOIN transactions prev ON n.user_id = prev.user_id 
                  AND prev.created_date < n.created_date 
                  AND prev.created_date > n.created_date - INTERVAL '7' DAY 
                GROUP BY 
                  n.user_id, 
                  n.created_date
              ) q1 
              INNER JOIN (
                SELECT 
                  n.user_id, 
                  n.created_date, 
                  COUNT(distinct post.transaction_id) AS post_transactions 
                FROM 
                  (
                    SELECT 
                      user_id, 
                      created_date 
                    FROM 
                      notifications 
                    WHERE 
                      status = 'SENT'
                  ) n 
                  LEFT OUTER JOIN transactions post ON n.user_id = post.user_id 
                  AND post.created_date > n.created_date 
                  AND post.created_date < n.created_date + INTERVAL '7' DAY 
                GROUP BY 
                  n.user_id, 
                  n.created_date
              ) q2 ON q1.user_id = q2.user_id 
              AND q1.created_date = q2.created_date
          ) q3 
          INNER JOIN users u ON q3.user_id = u.user_id
      ) q4 
    GROUP BY 
      country, 
      age_group
  ) q