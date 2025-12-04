# Executive Summary: `/blogkit.optimize` Implementation Guide

## Quick Reference

### Pipeline Overview

```
INPUT: Current Agentic Prompt
   ↓
[STAGE 1: EVALUATE]
  ├─ Multi-judge LLM evaluation (agent-as-judge)
  ├─ Multi-dimensional rubrics (8-10 dimensions)
  ├─ Trace-based analysis (intermediate steps)
  └─ Failure mode detection
   ↓
OUTPUT: Comprehensive evaluation scores + failure diagnosis
   ↓
[STAGE 2: SUGGEST]
  ├─ Root cause analysis per dimension
  ├─ Meta-prompting for improvement ideas
  ├─ Impact prioritization
  └─ Specific before/after suggestions
   ↓
OUTPUT: Ranked list of actionable suggestions
   ↓
[STAGE 3: IMPROVE]
  ├─ MIPROv2 optimization (primary)
  ├─ Few-shot example bootstrapping
  ├─ Validation on held-out set
  └─ Statistical significance testing
   ↓
OUTPUT: Optimized prompt with measured improvement
   ↓
[STAGE 4: VALIDATE] (Optional)
  ├─ A/B testing on production data
  └─ Regression detection
   ↓
[STAGE 5: ITERATE] (Optional)
  ├─ Continuous monitoring
  ├─ Production performance tracking
  └─ Auto-reoptimization on degradation
```

---

## Stage 1: Evaluation - Key Techniques

### 1.1 LLM-as-Judge Architecture

**Reliability Enhancements (Required):**

| Technique | Purpose | Implementation |
|-----------|---------|-----------------|
| **G-Eval CoT** | Reasoning-based scores | Use Claude/GPT-4; request step-by-step analysis before score |
| **Multi-Judge Consensus** | Reduce single-judge bias | 3-5 judges with different models/rubrics; Fleiss' kappa ≥ 0.4 |
| **Calibration** | Correct systematic biases | Fit correction model if reference scores available |
| **Position Randomization** | Reduce ordering effects | Randomize input presentation across judges |
| **Rubric Inversion** | Detect inconsistency | Evaluate both "Is X good?" and "Is X bad?" |

**Recommended Setup:**
```
- Judge 1: GPT-4o (strict rubric)
- Judge 2: Claude 3.5 Sonnet (balanced rubric)  
- Judge 3: Gemini 2.0 Pro (lenient rubric)
- Aggregation: Bradley-Terry model (more stable than Elo)
- Min agreement: Fleiss' kappa ≥ 0.4
```

### 1.2 Multi-Dimensional Evaluation Rubric

**8-10 Core Dimensions (Weighted):**

| Dimension | Weight | Evaluation Method | Target Range |
|-----------|--------|-------------------|--------------|
| **Correctness** | 25% | Reference/LLM match | 0-1.0 |
| **Coherence** | 15% | Reasoning trajectory | 0-10 |
| **Instruction Following** | 15% | Constraint satisfaction | CSR metric |
| **Hallucination** | 12% | Fact verification | 0-1.0 |
| **Tool Accuracy** | 10% | Tool selection/params | 0-1.0 |
| **Grounding** | 10% | Evidence support | 0-1.0 |
| **Efficiency** | 8% | Step count optimality | 0-1.0 |
| **Policy Adherence** | 5% | Safety compliance | Binary |

**Reference-Free Evaluation (Preferred for Agentic Systems):**
- Use RAGAS metrics (Faithfulness, AnswerRelevancy, ContextPrecision)
- No ground truth needed; works on production traces
- Combine with LLM judgment for comprehensive assessment

### 1.3 Trace-Based Multi-Step Evaluation

**For Multi-Step Agentic Workflows:**

Evaluate complete trajectory, not just final output:
```
Input: trace = [step1, step2, ..., stepN] with final_output

Evaluate each step on:
1. Step correctness (observation, thought, action, result valid?)
2. Trajectory coherence (logical flow)
3. Efficiency (unnecessary steps?)
4. Groundedness (grounded in prior steps?)
5. Utility (progressing toward goal?)
```

Framework: TRACE (arXiv:2510.02837)
- Multi-faceted analysis
- Works with small open-source LLMs
- Cost-effective vs. human evaluation

### 1.4 Failure Mode Detection

**Systematic Failure Categories:**

```
Hallucination: Agent invents facts → Fix: Add context/grounding
Instruction Drift: Ignores constraints → Fix: Make constraints explicit
Tool Misuse: Wrong tool selected → Fix: Define tool selection logic
Reasoning Error: Invalid deduction → Fix: Add CoT prompting
Format Violation: Output format wrong → Fix: Add format examples
Incomplete Response: Missing info → Fix: Increase completeness check
Goal Abandonment: Stops attempting → Fix: Add fallback strategies
Infinite Loop: Repeated attempts → Fix: Add step diversity check
```

**Detection Approach:** LLM-based classification with confidence scores

---

## Stage 2: Suggestions - Key Techniques

### 2.1 Root Cause Analysis

**Map Evaluation Failures → Root Causes:**

```python
Instruction Following Failure
├─ Ambiguous constraints (unclear language)
├─ Conflicting constraints (contradictory rules)
├─ Capability gap (can't execute)
└─ Attention drift (initially followed, then deviated)

Coherence Failure
├─ Insufficient context
├─ Complex reasoning task
├─ Ambiguous problem statement
└─ Missing step-by-step guidance

Hallucination
├─ No context provided
├─ Contradictory context
├─ Out-of-training-data topic
└─ Instruction confusion
```

### 2.2 Multi-Aspect Improvement Suggestions

**8 Key Improvement Aspects:**

1. **Instruction Clarity**
   - Break complex instructions into numbered steps
   - Define ambiguous terms explicitly
   - Add concrete constraints formatting

2. **Context Provision**
   - Add relevant background information
   - Include 2-3 in-context examples
   - Provide glossaries/definitions

3. **Chain-of-Thought**
   - Add "think step by step" guidance
   - Request intermediate reasoning
   - Break multi-step tasks into stages

4. **Tool Definitions**
   - Document each tool clearly
   - Include parameter specifications
   - Show successful tool use examples

5. **Example Quality**
   - Use high-quality demonstrations
   - Ensure diversity in examples
   - Order: simple → complex

6. **Constraint Specificity**
   - Make implicit constraints explicit
   - Use examples of constraint violations
   - Add validation checks

7. **Format Specification**
   - Specify exact output format
   - Provide format examples
   - Include schema/validation rules

8. **Error Handling**
   - Define fallback strategies
   - Document error recovery
   - Add self-correction prompts

### 2.3 Suggestion Ranking by Impact

**Impact Score Formula:**
```
Impact = (Dimension_Weight × Failure_Frequency) / (1 + Implementation_Cost)
```

**Typical Priority Order:**
1. Ambiguous constraint clarification (high weight, high frequency)
2. Adding few-shot examples (high impact, easy)
3. Chain-of-thought prompting (high impact, easy)
4. Tool definition improvements (high weight for agents, medium)
5. Format specification (medium impact, easy)

### 2.4 Meta-Prompting for Suggestions

**Use LLM to Generate Improvement Ideas:**

```
Input to LLM:
- Current prompt
- Evaluation results (dimension scores)
- Failure diagnosis (root causes)
- Examples of failures

Output: 
- 3-5 specific suggestions
- Before/after text comparisons
- Impact estimates
- Implementation difficulty
```

**Prompt Template:**
```
You are a prompt engineering expert specializing in agentic AI.

Current Prompt:
[PROMPT]

Evaluation Scores: [SCORES]
Failed Dimensions: [FAILURES]
Root Causes: [DIAGNOSIS]

Generate 3-5 specific, actionable improvements.
For each: explain issue, show before→after, estimate impact.
```

---

## Stage 3: Improvement - Key Techniques

### 3.1 Optimization Algorithm Comparison

| Algorithm | Best For | Mechanism | Cost | Results |
|-----------|----------|-----------|------|---------|
| **MIPROv2** ⭐ | Multi-stage programs | Bayesian search + instruction+demo tuning | Medium | +13-15% improvement |
| **TextGrad** | Small datasets | Textual gradients (LLM feedback) | Low | +10-20% improvement |
| **OPRO** | General tasks | LLM optimizer with ranking trajectory | Medium | +8-50% improvement |
| **APE** | Instruction-only | Instruction generation + filtering | Medium | +5-8% improvement |
| **BootstrapFewShot** | Demo optimization | Teacher generates examples, filters good ones | Low | +8-12% improvement |
| **PromptBreeder** | Complex tasks | Evolutionary with self-referential mutation | High | +20-40% improvement |

**Recommendation:** Primary = MIPROv2, Fallback = TextGrad

### 3.2 MIPROv2 Algorithm (Recommended)

**Three Main Stages:**

```python
Stage 1: Extract Modules
  ├─ Identify optimizable components
  ├─ Define input/output contracts (signatures)
  └─ Prepare training set

Stage 2: Bayesian Search Loop (15-20 iterations)
  ├─ Propose candidates (instruction + demo combinations)
  ├─ Evaluate on mini-batch (5 examples)
  ├─ Update Bayesian surrogate model
  ├─ Record history
  └─ Repeat

Stage 3: Final Validation
  ├─ Evaluate best program on full dataset
  ├─ Measure improvement vs. baseline
  └─ Return optimized program
```

**Configuration:**
```yaml
Search Level: moderate_search (15 iterations, 4 candidates/iter)
Surrogate Model: Tree-structured Parzen Estimator
Proposal Strategy: Top-5 performers + mutations + novel generation
Stopping Criterion: Score ≥ 0.95 or max iterations reached
```

**Results:**
- Achieves 13-15% accuracy improvements
- Joint instruction + example optimization
- No module-level labels required

### 3.3 Few-Shot Example Optimization

**BootstrapFewShot Algorithm:**

```
1. Generate outputs for ALL training examples (teacher model)
2. Score each output
3. Select top-scoring examples (quality threshold ≥ 0.7)
4. Apply diversity sampling (avoid similar examples)
5. Order examples: simple → complex
6. Embed as in-context examples
```

**Heuristics:**
- **Number**: 3-5 examples optimal (diminishing returns beyond 5)
- **Quality**: Use high-confidence outputs only
- **Diversity**: Select covering different input patterns
- **Ordering**: Simple-to-complex for robustness

**Result:** Few-shot examples often more important than instruction wording

### 3.4 TextGrad for Gradient-Based Improvement

**When to Use:** Small, focused optimizations (1-2 iterations)

**Algorithm:**
```
Iteration:
1. Forward Pass: Generate outputs with current prompt
2. Compute Loss: Score outputs with eval metric
3. Backward Pass: LLM critiques current prompt
4. Update: LLM modifies prompt based on critique
5. Repeat: Max 12 iterations

Key: Stronger model (GPT-4o) for generating feedback
```

**Advantages:**
- Interpretable feedback
- Fewer evaluations needed
- Works with limited data

### 3.5 OPRO for Trajectory-Based Optimization

**When to Use:** Black-box optimization with interpretable trajectory

**Algorithm:**
```
1. Initialize: Start with seed prompt
2. Loop (20+ iterations):
   a. Evaluate current prompt on examples
   b. Record score and prompt in trajectory
   c. Show LLM: trajectory of best/worst prompts + scores
   d. LLM generates next prompt based on trajectory patterns
3. Return: Highest-scoring prompt from trajectory
```

**Advantages:**
- Highly interpretable optimization process
- Works with any base model
- Shows clear progression of prompt improvements

**Results:** +8-50% improvement depending on task

### 3.6 Validation & Regression Testing

**Pre-Deployment Checklist:**

```
□ Improvement > 2% on held-out test set
□ No regressions: <10% drop on specific examples
□ Statistical significance: p-value < 0.05
□ Generalization: Performance stable on diverse inputs
□ Token efficiency: Cost reduction while maintaining quality
□ Edge cases: Tested on rare/difficult examples
```

**Statistical Test:** Paired t-test or Mann-Whitney U

```python
Minimum improvement threshold: 2%
Maximum acceptable regressions: 1-2 examples
Confidence level: 95% (p < 0.05)
```

---

## Stage 4: Validate - A/B Testing

**Safe Production Deployment:**

```yaml
Phase 1 (Staging):
  Traffic: 100%
  Min Samples: 50
  Duration: 4 hours
  
Phase 2 (Production - Limited):
  Traffic: 10%
  Min Samples: 100
  Duration: 24 hours
  
Phase 3 (Production - Full):
  Traffic: 100%
  Min Samples: 500+
  Action: Monitor for continued performance
```

**Key Metrics:**
- Success rate
- User satisfaction
- Error rate
- Hallucination detection
- Cost (tokens/request)
- Latency

**Stopping Rule:** If p-value < 0.05 and treatment > control → Deploy

---

## Stage 5: Iterate - Continuous Improvement

**Monitoring & Reoptimization Loop:**

```
1. Continuous Metrics Collection
   ├─ Success rate
   ├─ Error categories
   ├─ User feedback
   └─ Failure patterns

2. Degradation Detection
   ├─ EWMA control chart
   ├─ 2-sigma control limits
   └─ Alert on drift

3. Reoptimization Trigger
   ├─ When: Performance drops >2-3%
   ├─ What: Collect recent failures + new data
   ├─ How: Run Stage 3 optimization again

4. Deployment
   ├─ A/B test new optimized prompt
   ├─ Monitor carefully
   └─ Deploy if significant improvement
```

---

## Production Implementation Checklist

### Pre-Optimization
- [ ] Define evaluation rubric with stakeholders
- [ ] Collect 30-50 representative examples
- [ ] Create test/validation split (80/10/10)
- [ ] Establish baseline performance metrics
- [ ] Choose evaluation models (judges)

### Stage 1: Evaluation
- [ ] Run multi-judge evaluation
- [ ] Calculate Fleiss' kappa (check ≥ 0.4)
- [ ] Identify failing dimensions
- [ ] Perform failure mode analysis
- [ ] Document diagnostic insights

### Stage 2: Suggestions
- [ ] Generate root cause analysis
- [ ] Apply meta-prompting for ideas
- [ ] Rank suggestions by impact
- [ ] Manual review top-3 suggestions
- [ ] Adjust suggestions based on feasibility

### Stage 3: Improvement
- [ ] Select optimizer (MIPROv2 recommended)
- [ ] Run optimization (15-20 iterations)
- [ ] Bootstrap few-shot examples
- [ ] Compare to baseline
- [ ] Document improvement metrics

### Stage 4: Validation
- [ ] Test on held-out set
- [ ] Run statistical significance test
- [ ] Check for regressions
- [ ] Get stakeholder approval
- [ ] Prepare deployment plan

### Stage 5: Deploy
- [ ] A/B test in staging (4 hours)
- [ ] A/B test in production (10% traffic, 24 hours)
- [ ] Full production rollout
- [ ] Set up monitoring dashboard
- [ ] Schedule iteration cadence

---

## Common Patterns & Anti-Patterns

### ✅ Best Practices

1. **Start with Evaluation**
   - Always measure before optimizing
   - Use multiple judges for reliability
   - Evaluate multi-dimensional quality

2. **Generate Diverse Suggestions**
   - Consider multiple improvement aspects
   - Prioritize by impact, not just frequency
   - Allow for trade-offs (quality vs. cost)

3. **Automated Improvement**
   - Use MIPROv2 for complex programs
   - Rely on few-shot examples
   - Validate before deployment

4. **Continuous Monitoring**
   - Track metrics over time
   - Alert on performance degradation
   - Schedule regular re-optimization

### ❌ Anti-Patterns to Avoid

1. **Over-Optimization**
   - Avoid optimizing on too small train set
   - Watch for overfitting (performance drop on test set)
   - Remember: generalization matters more than perfect scores

2. **Ignoring Trade-Offs**
   - Longer prompts → higher cost, better quality
   - More examples → better quality, slower response
   - Focus on business objectives, not just accuracy

3. **Single-Judge Evaluation**
   - One judge is unreliable and biased
   - Always use 3+ judges with diversity
   - Calibrate for fairness

4. **Skipping Validation**
   - Always test on held-out data
   - Statistical significance matters
   - A/B test before full deployment

---

## Quick Performance Benchmarks

### Typical Improvements by Optimization Method

| Method | Accuracy Gain | Token Reduction | Cost Reduction | Time |
|--------|---------------|-----------------|----------------|------|
| Add examples | +8-12% | 0% | -10% | 1 hour |
| Add CoT | +5-15% | 0% | -20% | 1 hour |
| Clarify instructions | +5-10% | 0% | -5% | 30 min |
| MIPROv2 optimization | +13-15% | 20-30% | 30-50% | 2-4 hours |
| TextGrad | +10-20% | 10-20% | 20-30% | 1-2 hours |
| Full pipeline | +20-50% | 50-70% | 60-90% | 4-8 hours |

*Note: Results vary by task complexity and baseline quality*

---

## Reference Resources

### Papers (ArXiv)
- **arXiv:2411.15594** - LLM-as-a-Judge Survey (reliability focus)
- **arXiv:2406.07496** - TextGrad (textual gradients)
- **arXiv:2309.03409** - OPRO (LLM as optimizer)
- **arXiv:2510.02837** - TRACE (trajectory evaluation)
- **arXiv:2505.16944** - AgentIF (instruction following)

### Production Frameworks
- **DSPy**: DSPy.ai - Teleprompter, optimizers
- **LangSmith**: Observability, evaluation, monitoring
- **Anthropic Docs**: Prompt caching, best practices
- **OpenAI Docs**: Production best practices

### Tools
- LangSmith (LangChain) - Evaluation & monitoring
- Braintrust - Prompt versioning
- PromptLayer - Deployment & A/B testing
- Latitude - End-to-end optimization
- DeepEval - Evaluation framework

---

## Support & Troubleshooting

### "Evaluation scores too low (< 0.5)"
→ Check: Are judges properly calibrated? Use reference examples
→ Action: Add more context, examples to prompt

### "MIPROv2 not improving (< 2% gain)"
→ Check: Is training set representative? Try different search level
→ Action: Switch to OPRO or TextGrad; collect more examples

### "Regressions on edge cases"
→ Check: Did you test on diverse inputs?
→ Action: Add edge cases to training set; re-optimize with mixed data

### "Performance degrades in production"
→ Check: Are production inputs different from training?
→ Action: Collect production failures; retrain on mixed data

---

Version: 1.0
Last Updated: 2025-12-04
Status: Ready for Implementation