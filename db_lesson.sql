-- Q1 新しいテーブルを追加
-- 現在、db_lessonにはpeopleとreportsの2つのテーブルがありますが、新たに部署のテーブルを追加してください。

CREATE TABLE departments(
    departement_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Q2 peopleテーブルに新しいカラムを追加して、
-- 誰がどこ所属しているかがわかるようにしましょう。

ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED NULL AFTER email;

-- Q3-1 departments テーブルへのデータ挿入 （「；」文のおわり・「,」文の要素を区切る）
INSERT INTO departments (name) VALUES ('営業');
INSERT INTO departments (name) VALUES ('開発');
INSERT INTO departments (name) VALUES ('経理');
INSERT INTO departments (name) VALUES ('人事');
INSERT INTO departments (name) VALUES ('情報システム');

-- departments テーブルの構造を確認
DESC departments;

-- departments テーブルのデータを全て表示
SELECT * FROM departments;

-- Q3-2 people テーブルに department_id カラムを追加 
-- 営業 (department_id = 1): 3人
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員1', 'shain1@gizumo.jp', 25, 1, 1);
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員2', 'shain2@gizumo.jp', 30, 2, 1);
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員3', 'shain3@gizumo.jp', 28, 1, 1);

-- 開発 (department_id = 2): 4人
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員4', 'shain4@gizumo.jp', 35, 1, 2);
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員5', 'shain5@gizumo.jp', 29, 2, 2);
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員6', 'shain6@gizumo.jp', 32, 1, 2);
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員7', 'shain7@gizumo.jp', 27, 2, 2);

-- 経理 (department_id = 3): 1人
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員8', 'shain8@gizumo.jp', 40, 1, 3);

-- 人事 (department_id = 4): 1人
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員9', 'shain9@gizumo.jp', 33, 2, 4);

-- 情報システム (department_id = 5): 1人
INSERT INTO people (name, email, age, gender, department_id) VALUES ('社員10', 'shain10@gizumo.jp', 38, 1, 5);

-- people テーブルの構造を確認
DESC people;

-- people テーブルのデータを全て表示
SELECT * FROM people;

-- Q3-3 reports テーブルの作成
CREATE TABLE reports (
    report_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_id INT UNSIGNED NOT NULL, -- peopleテーブルのperson_idと紐付け
    content TEXT NOT NULL,           -- 日報の内容 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES people(person_id)
);

-- reports テーブルへのデータ挿入 (合計10件)
INSERT INTO reports (person_id, content) VALUES
(1, '営業の業務報告 社員1 1'), -- 営業の社員1
(2, '開発の業務報告 社員2 2'), -- 開発の社員2
(3, '営業の業務報告 社員3 3'), -- 営業の社員3
(4, '開発の業務報告 社員4 4'), -- 開発の社員4
(2, '開発の業務報告 社員2 5'), -- 開発の社員2 
(1, '営業の業務報告 社員1 6'), -- 営業の社員1 
(2, '開発の業務報告 社員2 7'), -- 開発の社員2 
(3, '営業の業務報告 社員3 8'), -- 営業の社員3 
(4, '開発の業務報告 社員4 9'), -- 開発の社員4 
(5, '情報システムの業務報告 社員5 10'); -- 情報システムの社員5

-- reports テーブルの構造を確認
DESC reports;

-- reports テーブルのデータを全て表示
SELECT * FROM reports;

-- Q4　必ずWHEREを使って条件を絞る
UPDATE people SET department_id = 1 WHERE person_id = 1; -- 鈴木たかし
UPDATE people SET department_id = 2 WHERE person_id = 2; -- 田中ゆうこ
UPDATE people SET department_id = 3 WHERE person_id = 3; -- 福田だいすけ
UPDATE people SET department_id = 4 WHERE person_id = 4; -- 豊島はなこ
UPDATE people SET department_id = 5 WHERE person_id = 5; -- 不思議みちこ

-- Q5 年齢の降順で男性の名前と年齢を取得
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC; -- 降順：DESC

-- Q6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明
SELECT
  `name`, `email`, `age` -- カラム
FROM
  `people` -- テーブル
WHERE
  `department_id` = 1 -- レコード
ORDER BY
  `created_at`; -- カラム
--  「people」テーブルの中から、department_idが1（営業部）であるレコードを抽出し、
-- そのレコードのname、email、ageというカラムの情報を、created_atの昇順で取得する

-- Q7 20代の女性と40代の男性の名前一覧を取得
SELECT name
FROM people
WHERE (gender = 2 AND age >= 20 AND age <= 29) -- 20~29歳の女性
   OR (gender = 1 AND age >= 40 AND age <= 49); -- または：OR
                                                -- 40~49歳の男性
-- Q8 営業部に所属する人だけを年齢の昇順で取得
SELECT name, age, department_id
FROM people
WHERE department_id = 1
ORDER BY age ASC; -- 昇順：ASC

-- Q9 開発部に所属している女性の平均年齢を取得
--  条件：カラム名はaverage_ageとなるように
SELECT AVG(age) AS average_age -- 平均：AVG　別名：AS
FROM people
WHERE department_id = 2 AND gender = 2;

-- Q10 名前と部署名とその人が提出した日報の内容を同時に取得
--  条件：日報を提出していない人は含めない
SELECT 
people.name, -- どのテーブルの、どのカラムか
departments.name,
reports.content 
FROM
people
INNER JOIN -- テーブル結合：INNER JOIN 
           -- 結合条件に一致するレコードが両方のテーブルに存在する場合にのみ、そのレコードを結果セットに含む
departments ON people.department_id = departments.departement_id
           -- 比較演算子：「＝」左辺と右辺の値が等しいかどうかを比較
INNER JOIN
reports ON people.person_id = reports.person_id;

-- Q11 日報を一つも提出していない人の名前一覧を取得
SELECT
people.name
FROM
people
LEFT JOIN -- テーブル結合：LEFT JOIN 
           -- 左側のテーブルのすべてのレコードと、右側のテーブルに該当するレコードを抽出
reports ON people.person_id = reports.person_id
WHERE
reports.report_id IS NULL;