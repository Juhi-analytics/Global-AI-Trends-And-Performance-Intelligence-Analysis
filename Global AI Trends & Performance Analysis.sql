-- CREATE DATABASE ai_analysis;
-- USE ai_analysis;

-- CREATE TABLE global_ai_index (
--     country VARCHAR(50),
--     year INT,
--     ai_index_score FLOAT,
--     ai_global_rank INT,
--     ai_adoption_consumer FLOAT,
--     ai_adoption_enterprise FLOAT,
--     ai_investment_billion_usd FLOAT,
--     ai_startups_count INT,
--     tech_workforce_pct FLOAT,
--     ai_talent_rank INT,
--     cloud_infrastructure FLOAT,
--     gpu_availability_index FLOAT,
--     ai_policy_score FLOAT,
--     ai_readiness_score FLOAT,
--     ai_growth_rate FLOAT
-- );

-- SELECT DATABASE();

-- SELECT * FROM global_ai_index LIMIT 10;

-- SELECT *
-- FROM global_ai_index
-- WHERE country IS NULL OR year IS NULL;



-- Check Unique Countries & Years
-- SELECT COUNT(DISTINCT country) AS countries,
--        COUNT(DISTINCT year) AS years
-- FROM global_ai_index;



-- Check Duplicates
-- SELECT country, year, COUNT(*)
-- FROM global_ai_index
-- GROUP BY country, year
-- HAVING COUNT(*) > 1;




-- Check Missing Values
-- SELECT *
-- FROM global_ai_index
-- WHERE ai_index_score IS NULL;



-- Top AI Countries
-- SELECT 
--     country,
--     ROUND(AVG(ai_index_score),2) AS avg_ai_score
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY avg_ai_score DESC
-- LIMIT 10;



-- Yearly AI Growth Trend
-- SELECT 
--     year,
--     ROUND(AVG(ai_index_score),2) AS avg_ai_score
-- FROM global_ai_index
-- GROUP BY year
-- ORDER BY year DESC;


-- Fastest Growing Countries
-- SELECT 
--     country,
--     ROUND(AVG(ai_growth_rate),2) AS avg_growth
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY avg_growth DESC
-- LIMIT 10;


-- Year-over-Year Growth
-- SELECT 
--     country,
--     year,
--     ai_index_score,
--     ai_index_score - LAG(ai_index_score) 
--     OVER (PARTITION BY country ORDER BY year) AS yoy_growth
-- FROM global_ai_index;




-- Ranking Improvement
-- SELECT 
--     country,
--     year,
--     ai_global_rank,
--     LAG(ai_global_rank) OVER (PARTITION BY country ORDER BY year) AS prev_rank,
--     (LAG(ai_global_rank) OVER (PARTITION BY country ORDER BY year) - ai_global_rank) 
--     AS rank_improvement
-- FROM global_ai_index;


-- AI Leader Segmentation
-- SELECT 
--     country,
--     year,
--     ai_index_score,
--     CASE 
--         WHEN ai_index_score >= 80 THEN 'Leader'
--         WHEN ai_index_score >= 60 THEN 'Strong'
--         WHEN ai_index_score >= 40 THEN 'Emerging'
--         ELSE 'Developing'
--     END AS category
-- FROM global_ai_index;



-- Investment vs Performance
-- SELECT 
--     country,
--     ROUND(SUM(ai_investment_billion_usd),2) AS total_investment,
--     ROUND(AVG(ai_index_score),2) AS avg_score
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY total_investment DESC;



-- Efficiency Analysis
-- SELECT 
--     country,
--     ROUND(AVG(ai_index_score) / NULLIF(AVG(ai_investment_billion_usd),0),2) 
--     AS efficiency_score
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY efficiency_score DESC;


-- Adoption Gap Analysis
-- SELECT 
--     country,
--     ROUND(AVG(ai_adoption_enterprise - ai_adoption_consumer),2) AS adoption_gap
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY adoption_gap DESC;



-- Top Countries by Talent
-- SELECT 
--     country,
--     AVG(tech_workforce_pct) AS workforce,
--     AVG(ai_talent_rank) AS talent_rank
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY workforce DESC;


-- Policy Impact on AI
-- SELECT 
--     ai_policy_score,
--     ROUND(AVG(ai_index_score),2) AS avg_score
-- FROM global_ai_index
-- GROUP BY ai_policy_score
-- ORDER BY ai_policy_score;



-- Infrastructure Impact
-- SELECT 
--     ROUND(AVG(cloud_infrastructure),2) AS cloud,
--     ROUND(AVG(ai_index_score),2) AS ai_score
-- FROM global_ai_index;



-- Top 5 Countries Each Year
-- SELECT *
-- FROM (
--     SELECT 
--         country,
--         year,
--         ai_index_score,
--         RANK() OVER (PARTITION BY year ORDER BY ai_index_score DESC) AS rank_position
--     FROM global_ai_index
-- ) t
-- WHERE rank_position <= 5;



-- AI Leaders Consistency (Who stays top over time)
-- SELECT 
--     country,
--     COUNT(*) AS years_in_top_10
-- FROM (
--     SELECT 
--         country,
--         year,
--         RANK() OVER (PARTITION BY year ORDER BY ai_index_score DESC) AS rank_position
--     FROM global_ai_index
-- ) t
-- WHERE rank_position <= 10
-- GROUP BY country
-- ORDER BY years_in_top_10 DESC;



-- Countries with Declining Performance
-- SELECT *
-- FROM (
--     SELECT 
--         country,
--         year,
--         ai_index_score,
--         LAG(ai_index_score) OVER (PARTITION BY country ORDER BY year) AS prev_score
--     FROM global_ai_index
-- ) t
-- WHERE ai_index_score < prev_score;



-- Talent vs AI Score Relationship
-- SELECT 
--     country,
--     ROUND(AVG(tech_workforce_pct),2) AS workforce,
--     ROUND(AVG(ai_index_score),2) AS score
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY workforce DESC;

-- Infrastructure Impact on AI
-- SELECT 
--     country,
--     ROUND(AVG(cloud_infrastructure),2) AS cloud,
--     ROUND(AVG(gpu_availability_index),2) AS gpu,
--     ROUND(AVG(ai_index_score),2) AS score
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY score DESC;


-- Balanced Countries (Adoption + Infra + Talent)
-- SELECT 
--     country,
--     ROUND(AVG(ai_adoption_enterprise),2) AS adoption,
--     ROUND(AVG(cloud_infrastructure),2) AS infra,
--     ROUND(AVG(tech_workforce_pct),2) AS talent
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY adoption DESC;

-- AI Readiness vs Performance Gap
-- SELECT 
--     country,
--     ROUND(AVG(ai_readiness_score),2) AS readiness,
--     ROUND(AVG(ai_index_score),2) AS performance,
--     ROUND(AVG(ai_readiness_score - ai_index_score),2) AS gap
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY gap DESC;

-- Top Country Each Year
-- SELECT *
-- FROM (
--     SELECT 
--         country,
--         year,
--         ai_index_score,
--         ROW_NUMBER() OVER (PARTITION BY year ORDER BY ai_index_score DESC) AS rn
--     FROM global_ai_index
-- ) t
-- WHERE rn = 1;


-- Most Volatile Countries (Fluctuating Scores)
-- SELECT 
--     country,
--     STDDEV(ai_index_score) AS volatility
-- FROM global_ai_index
-- GROUP BY country
-- ORDER BY volatility DESC;



-- SELECT COUNT(*) FROM global_ai_index;



-- CREATE VIEW vw_ai_analysis AS
-- SELECT 
--     country,
--     year,
--     ai_index_score,
--     ai_global_rank,
--     ai_adoption_consumer,
--     ai_adoption_enterprise,
--     (ai_adoption_enterprise - ai_adoption_consumer) AS adoption_gap,
--     ai_investment_billion_usd,
--     ai_startups_count,
--     tech_workforce_pct,
--     ai_talent_rank,
--     cloud_infrastructure,
--     gpu_availability_index,
--     ai_policy_score,
--     ai_readiness_score,
--     ai_growth_rate
-- FROM global_ai_index;


-- Multi-Metric Ranking
-- SELECT 
--     country,
--     RANK() OVER (ORDER BY AVG(ai_index_score) DESC) AS score_rank,
--     RANK() OVER (ORDER BY AVG(ai_investment_billion_usd) DESC) AS investment_rank,
--     RANK() OVER (ORDER BY AVG(ai_adoption_enterprise) DESC) AS adoption_rank
-- FROM vw_ai_analysis
-- GROUP BY country;

-- Composite Score
-- SELECT 
--     country,
--     ROUND(
--         (AVG(ai_index_score)*0.4 +
--          AVG(ai_adoption_enterprise)*0.2 +
--          AVG(cloud_infrastructure)*0.2 +
--          AVG(ai_policy_score)*0.2),2
--     ) AS composite_score
-- FROM vw_ai_analysis
-- GROUP BY country
-- ORDER BY composite_score DESC;



-- Correlation-Style Insight Query
-- SELECT 
--     CASE 
--         WHEN ai_investment_billion_usd > 50 THEN 'High Investment'
--         WHEN ai_investment_billion_usd > 20 THEN 'Medium Investment'
--         ELSE 'Low Investment'
--     END AS investment_category,
--     ROUND(AVG(ai_index_score),2) AS avg_score
-- FROM vw_ai_analysis
-- GROUP BY investment_category;


-- Final Insight Table
-- SELECT 
--     country,
--     ROUND(AVG(ai_index_score),2) AS score,
--     ROUND(AVG(ai_growth_rate),2) AS growth,
--     ROUND(AVG(ai_adoption_enterprise),2) AS adoption,
--     ROUND(AVG(ai_investment_billion_usd),2) AS investment
-- FROM vw_ai_analysis
-- GROUP BY country
-- ORDER BY score DESC
-- LIMIT 10;