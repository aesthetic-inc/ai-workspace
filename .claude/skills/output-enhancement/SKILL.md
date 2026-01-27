---
name: output-enhancement
description: AI出力品質を60点→100点以上に引き上げる構造化プロンプト。2形式：YAML版（複雑タスク・明示性重視、~120トークン）、圧縮版（高頻度使用・コスト最適化、~40トークン）。トリガー：「出力を改善」「100点にして」「品質向上」「再構築」「不足を補って」
---

# Output Enhancement Skill

## 使用判断

| 条件 | 形式 | 理由 |
|------|------|------|
| 複雑・多段階タスク | YAML | 明示的制約が必要 |
| 戦略・フレームワーク構築 | YAML | 包括性重視 |
| 単純な品質向上 | 圧縮 | トークン効率 |
| 高頻度反復使用 | 圧縮 | コスト最適化 |
| 不明 | YAML | 安全側倒し |

## 圧縮版テンプレート（~40トークン）

```
REFINE{
  in:{current}→out:≥100
  ①gaps:[quality,precision,scalability,futureproof]
  ②regen:concrete+executable+comprehensive
  ③framework:sustainable+maxpotential+allscenarios
  ④split:ok|priority=quality
  gates:realistic∧specific∧actionable∧scalable∧adaptive
}
```

## パラメータ

| 変数 | 説明 | デフォルト |
|------|------|-----------|
| {current} | 現在スコア | 60 |
| TARGET_SCORE | 目標スコア | ≥100 |
| multi_message | 分割許可 | allowed |

## 拡張オプション

特定ドメイン向け追加制約：

- education: [age_appropriate, safety_check, public_ready]
- business: [roi_driven, automation_first, leverage_max]
- technical: [scalable, maintainable, documented]
