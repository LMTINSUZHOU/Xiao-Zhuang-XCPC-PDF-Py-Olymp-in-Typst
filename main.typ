#import "template.typ": contest-conf
#import "problems.typ": problems  // 或者从您的题目文件中导入
#import "@preview/mitex:0.2.6": *

#show: contest-conf.with(
  title: "2026年南晓开放原子社大学生程序设计新年赛",
  subtitle: "正式赛",
  author: "本次竞赛由南晓开放原子社ICPC竞赛集训队命题",
  problems: problems
)
