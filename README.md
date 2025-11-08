<img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg" width="180"/>

# Netflix SQL Analytics Project (Learning Project)

This repository contains my full hands-on SQL project using the Netflix Movies & TV Shows dataset.

I did this project mainly to **practice Business Analytics skills** — especially:
- SQL data cleaning
- aggregation queries
- category filtering
- date-based analysis
- exploratory analytics thinking

The dataset contains Netflix titles with:
`type`, `title`, `director`, `cast`, `country`, `release_year`, `date_added`, `rating`, `duration`, `listed_in`, `description`.

---

## What I Learned

| Skill | How I practiced |
|-------|-----------------|
| Basic SQL filtering | `WHERE`, `ILIKE` usage |
| Date functions | `CURRENT_DATE - interval` |
| Data splitting | `unnest(string_to_array())` |
| Data grouping | `GROUP BY` & `COUNT()` |
| BA thinking | turning vague business questions → measurable SQL |

---

## Queries I answered

I wrote SQL queries for:

1) Movies vs TV Shows count  
2) Most common rating  
3) Movies released in 2020  
4) Top 5 content countries  
5) Longest movie  
6) Content added last 5 years  
7) Content by Rajiv Chilaka  
8) TV shows with > 5 seasons  
9) Content count by genre  
10) Yearly avg India content (Top 5 years)  
11) Documentary movies  
12) Content with no director  
13) Salman Khan movies in last 10y  
14) Top 10 Indian movie actors  
15) "Bad vs Good" content based on keywords "kill" / "violence"

---

## technology stack

| Component | Tool |
|----------|------|
| Database | PostgreSQL |
| Client | pgAdmin |
| Versioning | GitHub |
| Dataset | netflix_titles.csv |

---

## Dataset Source

The data used in this project comes from the public **Netflix Movies and TV Shows Dataset** on Kaggle.

I have also uploaded the same CSV inside this repository so anyone can view it directly — along with my SQL query file that contains all the queries used in this analysis.


This project is **for learning only**.  
I do not represent Netflix — this is a personal education exercise for building my Business Analytics skills.
