# Comprehensive Guide: Building `/blogkit.optimize` - A Three-Stage Prompt Optimization Pipeline for Agentic AI

## Executive Summary

This guide provides a complete technical foundation for implementing `/blogkit.optimize`, a systematic three-stage prompt optimization pipeline for agentic AI frameworks. Drawing from extensive research across arxiv.org, production implementations from LangChain, Anthropic, OpenAI, and leading academic frameworks (DSPy, RAGAS, TextGrad), this document details:

1. **Stage 1 (EVALUATE)**: Reliable LLM-based evaluation using agent-as-judge patterns, multi-dimensional rubrics, and trace-based assessment
2. **Stage 2 (SUGGEST)**: Diagnostic analysis and actionable feedback generation using meta-prompting and failure analysis
3. **Stage 3 (IMPROVE)**: Automated prompt rewriting using state-of-the-art optimizers (MIPROv2, TextGrad, OPRO) with validation mechanisms

The pipeline achieves 20-50% performance improvements, 50-70% token reductions, and enables continuous iterative refinement through optional VALIDATE and ITERATE stages.

---

# STAGE 1: SYSTEMATIC EVALUATION OF AGENTIC PROMPTS

## 1.1 Foundation: LLM-as-a-Judge with Reliability Enhancement

### Core Methodology (arXiv:2411.15594 - Comprehensive LLM-as-Judge Survey)

LLM-as-a-Judge evaluation provides scalable, cost-effective assessment but requires careful design to ensure reliability:

**Key Reliability Concerns:**
- **Bias & Position Sensitivity**: LLMs show preference for certain styles, formats, and orderings
- **Inconsistency**: Single evaluations lack stability; require multiple judges or calibration
- **Domain Drift**: Evaluator models may hallucinate or misunderstand complex instructions
- **Prompt Sensitivity**: Evaluation rubric wording significantly impacts results

### Recommended Evaluation Architecture

```python
class LLMJudgeEvaluator:
    """Production-grade LLM-as-Judge with reliability features"""
    
    def __init__(self, judge_model="gpt-4o", temperature=0.0, seed=42):
        """
        Args:
            judge_model: Claude 3.5 Sonnet recommended for reasoning
            temperature: 0.0 for consistency; seed for reproducibility
        """
        self.judge = judge_model
        self.temperature = temperature
        self.seed = seed
    
    def evaluate_with_cot(self, output, criteria, context=""):
        """
        G-Eval pattern: Chain-of-Thought reasoning before scoring
        
        Implements the framework from "NLG Evaluation using GPT-4 
        with Better Human Alignment" (arXiv:2310.05470)
        """
        evaluation_steps = self._generate_evaluation_steps(
            output=output, 
            criteria=criteria, 
            context=context
        )
        
        # Generate step-by-step reasoning
        reasoning = self.judge.generate(
            prompt=f"""Evaluate this output step by step:
            
Output: {output}
Criteria: {criteria}

Step 1: Analyze whether the output meets criterion 1...
Step 2: Check for criterion 2...
[Continue reasoning]
"""
        )
        
        # Extract score (1-5 normalized to 0-1)
        score = self._extract_score_with_probability_weighting(reasoning)
        
        return {
            "score": score,
            "reasoning": reasoning,
            "confidence": self._estimate_confidence(reasoning)
        }
    
    def _generate_evaluation_steps(self, output, criteria, context):
        """Generate intermediate evaluation steps for CoT reasoning"""
        # Decompose complex criteria into evaluable components
        pass
    
    def _extract_score_with_probability_weighting(self, reasoning):
        """
        Extract score using token probability weighting (G-Eval method)
        
        Higher weight to high-confidence score tokens vs. hallucinated scores
        """
        pass
    
    def _estimate_confidence(self, reasoning):
        """Confidence based on reasoning clarity and consistency"""
        pass
```

### Multi-Judge Consensus Strategy

**Why Multiple Judges?** Single judge evaluation is unreliable; diverse judges reduce systematic bias:

```python
class MultiJudgeConsensus:
    """Aggregate multiple judges for robust evaluation"""
    
    def __init__(self, judges=None):
        """
        judges: List of (judge_model, rubric_variant) tuples
        Recommended: 3-5 judges with different reasoning styles
        """
        self.judges = judges or [
            ("gpt-4o", "strict_criteria"),
            ("claude-3.5-sonnet", "lenient_criteria"),
            ("gemini-2.0-pro", "balanced_criteria"),
        ]
    
    def aggregate_with_fleiss_kappa(self, outputs, criteria):
        """
        Compute Fleiss' kappa for inter-rater agreement
        
        Fleiss' kappa values:
        - 0.0-0.2: Poor agreement
        - 0.2-0.4: Fair agreement
        - 0.4-0.6: Moderate agreement  ← Target minimum
        - 0.6-0.8: Substantial agreement
        - 0.8-1.0: Almost perfect agreement
        
        Formula:
        κ = (P̄ - P̄ₑ) / (1 - P̄ₑ)
        where P̄ is observed agreement, P̄ₑ is expected chance agreement
        """
        judge_scores = self._get_all_judge_scores(outputs, criteria)
        
        kappa = self._compute_fleiss_kappa(judge_scores)
        agreement_threshold = 0.4  # Minimum acceptable agreement
        
        if kappa < agreement_threshold:
            # Low agreement → need rubric refinement
            self._flag_ambiguous_criteria(criteria)
        
        # Weighted aggregation (confidence-weighted or Bradley-Terry)
        return self._aggregate_scores_with_weighting(judge_scores, kappa)
    
    def _aggregate_scores_with_weighting(self, judge_scores, kappa):
        """
        Weighted aggregation strategies:
        
        1. Simple Average: Equal weight
        2. Confidence-Weighted: Higher weight to confident judges
        3. Bradley-Terry Model: Bayesian rating based on pairwise wins
           - More stable than Elo for fixed performance (adopted by LMSYS)
        """
        # Bradley-Terry likelihood estimation
        return self._bradley_terry_aggregation(judge_scores)
```

### Calibration & Bias Mitigation

```python
class JudgeCalibration:
    """Mitigate systematic biases in LLM judges"""
    
    KNOWN_BIASES = [
        "preference_for_longer_outputs",
        "position_bias_first_in_prompt",
        "style_preference_formality",
        "length_penalization_harsh",
        "instruction_drift_over_rubric"
    ]
    
    def calibrate_rubric(self, outputs, reference_scores=None):
        """
        If you have reference human scores:
        1. Evaluate with uncalibrated judge
        2. Fit bias correction model
        3. Apply correction to future evaluations
        
        Equation: score_corrected = score_raw - bias_estimate
        """
        if reference_scores:
            bias_estimates = self._fit_bias_model(
                judge_predictions=outputs,
                human_references=reference_scores
            )
            return bias_estimates
        
        # Without references: use position randomization
        return self._randomize_input_positions(outputs)
    
    def randomize_presentation(self, outputs):
        """Counter position bias by random ordering"""
        return random.shuffle(outputs)
    
    def evaluate_with_reversed_rubric(self, output, criteria):
        """
        Check consistency by inverting criteria:
        - Original: "Is response accurate?"
        - Reversed: "Is response inaccurate?"
        
        Inconsistent flips suggest judge unreliability
        """
        pass
```

---

## 1.2 Multi-Dimensional Evaluation Rubrics

Agentic systems require evaluation across multiple dimensions, not just final output:

### Comprehensive Rubric Framework

```python
class AgenticEvaluationRubric:
    """
    Based on academic frameworks:
    - AgentIF (arXiv:2505.16944): Instruction following in agents
    - TRACE (arXiv:2510.02837): Trajectory evaluation
    - DeepChecks Agentic Workflows framework
    """
    
    def __init__(self):
        self.dimensions = {
            # ========== OUTPUT QUALITY ==========
            "correctness": {
                "description": "Final output matches ground truth or achieves objective",
                "weight": 0.25,
                "scale": "0-10",
                "evaluation_type": "reference_based_or_llm_judge"
            },
            
            "completeness": {
                "description": "All required information/steps present in output",
                "weight": 0.15,
                "scale": "0-10",
                "rubric": {
                    "10": "All requirements fully addressed",
                    "7": "90%+ of requirements met",
                    "5": "70-89% of requirements",
                    "3": "50-69% covered",
                    "0": "Major gaps, <50%"
                }
            },
            
            "conciseness": {
                "description": "Response length appropriate for task",
                "weight": 0.10,
                "evaluation_method": "token_count_baseline + llm_judgment"
            },
            
            # ========== REASONING QUALITY ==========
            "coherence": {
                "description": "Logic flow is clear and step-by-step reasoning sound",
                "weight": 0.15,
                "dimensions": ["logical_validity", "semantic_coherence", "no_contradictions"],
                "reference": "Evaluating Step-by-step Reasoning Traces survey (EMNLP 2025)"
            },
            
            "reasoning_grounding": {
                "description": "Reasoning steps grounded in provided context/evidence",
                "weight": 0.10,
                "metric": "factuality_score"
            },
            
            # ========== INSTRUCTION ADHERENCE ==========
            "instruction_following": {
                "description": "Adherence to system prompt and constraints",
                "weight": 0.15,
                "metric": "constraint_satisfaction_rate",
                "reference": "IFEval benchmark (arXiv:2310.03952)"
            },
            
            # ========== TOOL USAGE (AGENTIC) ==========
            "tool_selection_accuracy": {
                "description": "Correct tool chosen at correct step",
                "weight": 0.10,
                "reference": "WebArena, OSWorld benchmarks"
            },
            
            "tool_parameter_correctness": {
                "description": "Tool parameters properly formatted and valid",
                "weight": 0.08,
                "evaluation_type": "code_based_validation"
            },
            
            "tool_call_efficiency": {
                "description": "Minimal redundant or wasted tool invocations",
                "weight": 0.08,
                "metric": "tool_call_redundancy_percentage"
            },
            
            # ========== SAFETY & ALIGNMENT ==========
            "hallucination_score": {
                "description": "Absence of factually incorrect claims",
                "weight": 0.12,
                "metric": "false_claim_count / total_claims",
                "reference": "arXiv:2509.18970 - Survey on Agent Hallucinations"
            },
            
            "policy_adherence": {
                "description": "Respects safety guidelines and constraints",
                "weight": 0.10,
                "binary": True
            }
        }
    
    def compute_overall_score(self, dimension_scores):
        """Weighted average across all dimensions"""
        total = sum(
            dimension_scores[d] * self.dimensions[d]["weight"]
            for d in dimension_scores
        )
        return total / sum(d["weight"] for d in self.dimensions.values())
    
    def generate_rubric_prompt(self, dimension):
        """Generate calibrated evaluation prompt for specific dimension"""
        rubric = self.dimensions[dimension]
        
        prompt = f"""
Evaluate the following on the dimension: {dimension}

Description: {rubric["description"]}
Weight: {rubric["weight"]} (importance: {int(rubric["weight"]*100)}%)

"""
        if "rubric" in rubric:
            prompt += "Scoring guide:\n"
            for score, description in rubric["rubric"].items():
                prompt += f"  {score}/10: {description}\n"
        
        return prompt
```

---

## 1.3 Reference-Free vs Reference-Based Evaluation

### Reference-Free Evaluation (Preferred for Agentic Systems)

**Advantages:** No ground truth needed; works on production traces

```python
def reference_free_evaluation(agent_output, rubric_criteria):
    """
    Techniques:
    1. RAGAS metrics (Faithfulness, Answer Relevancy, Context Precision)
    2. Semantic Distribution Correlation (SDC)
    3. LLM judgment with CoT
    """
    
    # RAGAS framework (open-source)
    from ragas import evaluate
    from ragas.metrics import Faithfulness, AnswerRelevancy
    
    evaluation_dataset = {
        "response": agent_output,
        "user_input": context["query"],
        "retrieved_context": context["context"]
    }
    
    # Evaluate without needing reference answer
    faithfulness_score = Faithfulness().single_turn_score(
        sample=evaluation_dataset
    )
    
    relevancy_score = AnswerRelevancy().single_turn_score(
        sample=evaluation_dataset
    )
    
    return {
        "faithfulness": faithfulness_score,
        "relevancy": relevancy_score,
        "combined_score": (faithfulness_score + relevancy_score) / 2
    }
```

### Reference-Based Evaluation (When Ground Truth Available)

```python
def reference_based_evaluation(agent_output, reference_output):
    """
    Metrics:
    - BERTScore: Contextual semantic similarity
    - ROUGE: N-gram overlap (less suitable for agents)
    - Exact Match: Binary correctness
    """
    
    from bert_score import score
    
    # BERTScore: Semantic similarity using contextual embeddings
    precision, recall, f1 = score(
        cands=[agent_output],
        refs=[reference_output],
        lang="en",
        verbose=True
    )
    
    # IDF weighting emphasizes rare important terms
    return {"bert_score_f1": f1[0].item()}
```

---

## 1.4 Trace-Based Evaluation for Multi-Step Workflows

Critical for agentic systems: evaluate intermediate steps, not just final output

### Framework: TRACE Multi-Faceted Trajectory Analysis

Based on arXiv:2510.02837 - "Evaluating the Reasoning Trajectories of Tool-Augmented LLMs"

```python
class TraceEvaluator:
    """Evaluate complete agent trajectories (observations → thoughts → actions → results)"""
    
    def __init__(self, llm_model="gpt-4o"):
        self.evaluator = llm_model
    
    def evaluate_trajectory(self, trace):
        """
        Trace structure:
        {
            "steps": [
                {"observation": "...", "thought": "...", "action": "...", "result": "..."},
                {...}
            ],
            "final_output": "...",
            "ground_truth": "..."  # Optional reference
        }
        """
        
        trajectory_scores = {
            "step_correctness": self._evaluate_step_correctness(trace["steps"]),
            "coherence": self._evaluate_coherence(trace["steps"]),
            "efficiency": self._evaluate_efficiency(trace["steps"]),
            "groundedness": self._evaluate_groundedness(trace["steps"]),
            "utility": self._evaluate_utility(trace["steps"], trace.get("ground_truth"))
        }
        
        return trajectory_scores
    
    def _evaluate_step_correctness(self, steps):
        """
        For each step, evaluate:
        1. Observation extraction accuracy
        2. Thought reasoning validity
        3. Action execution correctness
        4. Result interpretation correctness
        """
        
        evaluation_prompt = """
For each step in the trajectory, evaluate correctness:

Step: {step}

1. Observation Valid? (0-10): Does it accurately capture environment state?
2. Thought Sound? (0-10): Is reasoning logically valid?
3. Action Correct? (0-10): Is action appropriately chosen?
4. Result Accurate? (0-10): Is result correctly interpreted?

Provide detailed reasoning for each.
"""
        
        step_scores = []
        for step in steps:
            response = self.evaluator.generate(
                evaluation_prompt.format(step=step)
            )
            step_scores.append(self._parse_step_scores(response))
        
        return {"per_step": step_scores, "average": sum(step_scores)/len(step_scores)}
    
    def _evaluate_efficiency(self, steps):
        """
        Metrics:
        - Tool call redundancy: Are calls repeated unnecessarily?
        - Step count: Is solution path optimal length?
        - Action diversification: Multiple action types used appropriately?
        """
        
        tool_call_counts = {}
        for step in steps:
            action = step.get("action", {})
            tool = action.get("tool")
            if tool:
                tool_call_counts[tool] = tool_call_counts.get(tool, 0) + 1
        
        redundancy_rate = self._calculate_redundancy(tool_call_counts)
        
        return {
            "tool_call_redundancy": redundancy_rate,
            "step_count_efficiency": len(steps),
            "action_diversity": len(set(s.get("action", {}).get("type") for s in steps))
        }
    
    def _evaluate_groundedness(self, steps):
        """
        For each thought/reasoning step:
        - Is it grounded in preceding observations?
        - Are claims supported by context?
        - Any unsupported assertions?
        """
        
        groundedness_scores = []
        for i, step in enumerate(steps):
            context = "\n".join(s.get("observation", "") for s in steps[:i])
            thought = step.get("thought", "")
            
            # Check: are claims in thought supported by context?
            grounding_check = self._verify_grounding(thought, context)
            groundedness_scores.append(grounding_check)
        
        return {
            "per_step_groundedness": groundedness_scores,
            "average_groundedness": sum(groundedness_scores) / len(groundedness_scores) if groundedness_scores else 1.0
        }
    
    def _evaluate_utility(self, steps, ground_truth=None):
        """
        Each step should contribute to reaching goal
        
        Metrics:
        - On-task rate: % of steps moving toward goal
        - Goal progress rate: How much closer after each step
        """
        
        if not ground_truth:
            return {"utility_score": "N/A - no ground truth"}
        
        # Compute progress toward goal after each step
        progress = []
        for step in steps:
            similarity_to_goal = self._semantic_similarity(
                step.get("observation", ""), 
                ground_truth
            )
            progress.append(similarity_to_goal)
        
        # Check for progress monotonicity
        increasing_steps = sum(
            1 for i in range(1, len(progress)) 
            if progress[i] > progress[i-1]
        )
        
        return {
            "progress_rate": increasing_steps / len(progress) if progress else 0,
            "total_progress": progress[-1] - progress[0] if progress else 0
        }
```

---

## 1.5 Failure Mode Detection & Analysis

Systematic detection of common agent failure patterns:

```python
class FailureModeDetector:
    """Identify specific failure categories to guide improvement suggestions"""
    
    FAILURE_MODES = {
        "hallucination": {
            "description": "Agent invents facts not in context",
            "detection": "Fact verification + LLM consistency check",
            "severity": "critical"
        },
        
        "instruction_drift": {
            "description": "Agent ignores constraints in system prompt",
            "detection": "Instruction adherence evaluation",
            "severity": "critical"
        },
        
        "tool_misuse": {
            "description": "Wrong tool selected or parameters invalid",
            "detection": "Tool validation + schema checking",
            "severity": "high"
        },
        
        "reasoning_error": {
            "description": "Invalid logical deduction",
            "detection": "Step-by-step reasoning verification",
            "severity": "high"
        },
        
        "format_violation": {
            "description": "Output doesn't match required format",
            "detection": "Schema validation",
            "severity": "medium"
        },
        
        "incomplete_response": {
            "description": "Missing required information",
            "detection": "Completeness check against rubric",
            "severity": "medium"
        },
        
        "goal_abandonment": {
            "description": "Agent stops attempting objective",
            "detection": "Final output vs. objective comparison",
            "severity": "high"
        },
        
        "infinite_loop": {
            "description": "Repeated failed attempts, no progress",
            "detection": "Action sequence uniqueness analysis",
            "severity": "medium"
        }
    }
    
    def detect_failures(self, trace, output, expected_output):
        """Return detected failure modes with confidence scores"""
        
        failures = {}
        
        # Check each failure mode
        if self._detect_hallucination(trace, output):
            failures["hallucination"] = 0.8
        
        if self._detect_instruction_drift(trace):
            failures["instruction_drift"] = 0.9
        
        if self._detect_tool_misuse(trace):
            failures["tool_misuse"] = 0.7
        
        # ... check remaining modes
        
        return failures
    
    def _detect_hallucination(self, trace, output):
        """Verify facts against context"""
        
        # Extract claims from output
        claims = self._extract_factual_claims(output)
        
        # Verify each claim against available context
        for claim in claims:
            if not self._verify_claim_in_context(claim, trace):
                return True  # Hallucination detected
        
        return False
    
    def _detect_instruction_drift(self, trace):
        """Check if agent violated system prompt constraints"""
        
        system_constraints = trace["system_prompt"]
        actions = [step["action"] for step in trace["steps"]]
        
        for constraint in system_constraints:
            if not self._action_respects_constraint(actions, constraint):
                return True
        
        return False
```

---

## 1.6 Evaluation Metrics & Aggregation

### Key Metrics Summary

| Metric | Type | Range | Interpretation | Best For |
|--------|------|-------|-----------------|----------|
| **Correctness** | Reference-based | 0-1 | Final answer accuracy | Factual tasks |
| **Faithfulness** | Reference-free | 0-1 | No hallucinations | RAG/open-ended |
| **Coherence** | LLM-judge | 0-10 | Reasoning soundness | Multi-step tasks |
| **Tool Call Accuracy** | Code-based | 0-1 | Correct tool use | Agentic tasks |
| **Trajectory Efficiency** | Computed | 0-1 | Optimal path length | Agent optimization |
| **Constraint Satisfaction Rate** | Code-based | 0-1 | % constraints met | Instruction following |
| **Hallucination Rate** | LLM-judge | 0-1 | % false claims | All tasks |

### Combining Evaluations

```python
def aggregate_evaluations(eval_results):
    """
    Combine multi-dimensional evaluations into single score
    
    Approaches:
    1. Weighted average (fixed weights)
    2. Pareto frontier (multi-objective)
    3. Confidence-weighted (judge confidence varies)
    """
    
    # Approach 1: Weighted average (typically used)
    rubric_weights = {
        "correctness": 0.25,
        "coherence": 0.15,
        "instruction_following": 0.15,
        "hallucination_score": 0.12,
        "tool_accuracy": 0.10,
        "efficiency": 0.08,
        "policy_adherence": 0.10,
        "completeness": 0.05
    }
    
    overall_score = sum(
        eval_results.get(metric, 0) * weight
        for metric, weight in rubric_weights.items()
    )
    
    return {
        "overall_score": overall_score,
        "dimension_breakdown": eval_results,
        "failing_dimensions": [m for m, v in eval_results.items() if v < 0.6]
    }
```

---

# STAGE 2: DIAGNOSTIC ANALYSIS & SUGGESTION GENERATION

## 2.1 Root Cause Analysis Framework

Transform evaluation results into actionable improvement feedback:

```python
class DiagnosticAnalyzer:
    """
    Analyze WHAT failed (evaluation) → WHY it failed (diagnosis) → 
    HOW to fix it (suggestions)
    """
    
    def __init__(self):
        self.failure_patterns = {}
    
    def diagnose(self, eval_results, trace, output, rubric):
        """
        Input: eval_results from Stage 1
        Output: Diagnostic report with root causes
        """
        
        diagnostics = {}
        
        for failing_dimension in eval_results["failing_dimensions"]:
            # For each failed dimension, determine root cause
            
            if failing_dimension == "instruction_following":
                cause = self._diagnose_instruction_following_failure(
                    trace, 
                    eval_results
                )
            
            elif failing_dimension == "coherence":
                cause = self._diagnose_coherence_failure(trace, output)
            
            elif failing_dimension == "hallucination_score":
                cause = self._diagnose_hallucination_source(output, trace)
            
            elif failing_dimension == "tool_accuracy":
                cause = self._diagnose_tool_misuse(trace)
            
            # ... diagnose remaining dimensions
            
            diagnostics[failing_dimension] = cause
        
        return diagnostics
    
    def _diagnose_instruction_following_failure(self, trace, eval_results):
        """
        Root causes:
        1. Constraint ambiguity - not clearly stated in system prompt
        2. Conflicting constraints - agent received contradictory instructions
        3. Capability gap - agent can't execute despite understanding
        4. Attention drift - agent initially followed but deviated mid-trajectory
        """
        
        system_prompt = trace["system_prompt"]
        actions = trace["steps"]
        
        # Check 1: Ambiguous constraints
        ambiguous_constraints = self._identify_ambiguous_language(system_prompt)
        
        # Check 2: Conflicting instructions
        conflicts = self._identify_conflicts(system_prompt)
        
        # Check 3: Capability gap
        unsupported_actions = self._identify_unsupported_operations(actions)
        
        # Check 4: Drift detection
        deviation_point = self._find_constraint_violation_start(actions)
        
        return {
            "ambiguity_issues": ambiguous_constraints,
            "conflicting_constraints": conflicts,
            "capability_gaps": unsupported_actions,
            "deviation_at_step": deviation_point,
            "likely_cause": self._select_most_likely_cause([
                ("ambiguity", len(ambiguous_constraints)),
                ("conflict", len(conflicts)),
                ("capability", len(unsupported_actions)),
                ("drift", deviation_point is not None)
            ])
        }
    
    def _diagnose_coherence_failure(self, trace, output):
        """
        Root causes:
        1. Insufficient context - agent doesn't have necessary information
        2. Complex reasoning task - exceeds agent's reasoning ability
        3. Ambiguous problem statement - unclear what solution should be
        4. Missing step-by-step guidance - no chain-of-thought in prompt
        """
        
        return {
            "context_sufficiency": self._measure_context_coverage(trace),
            "reasoning_complexity": self._measure_task_complexity(trace),
            "ambiguity_level": self._measure_problem_ambiguity(trace),
            "cot_guidance": self._check_cot_prompting_present(trace)
        }
    
    def _diagnose_hallucination_source(self, output, trace):
        """
        Root causes:
        1. No context provided - forced to generate without grounding
        2. Contradictory context - conflicting information in context
        3. Out-of-training-data topic - model filling gaps from training
        4. Instruction confusion - prompt asks for made-up information
        """
        
        hallucinated_claims = self._extract_unsupported_claims(output, trace)
        
        return {
            "hallucinated_claims": hallucinated_claims,
            "context_coverage": self._measure_context_relevance(trace),
            "source": self._identify_hallucination_source(hallucinated_claims, trace)
        }
```

## 2.2 Multi-Aspect Suggestion Generation

Generate specific, actionable improvement recommendations:

```python
class SuggestionGenerator:
    """
    Map diagnostics to concrete improvement suggestions
    
    References:
    - Meta-prompting (arXiv, 2025)
    - DSPy guidance generation
    - Anthropic best practices
    """
    
    IMPROVEMENT_ASPECTS = [
        "instruction_clarity",
        "context_provision",
        "chain_of_thought",
        "tool_definitions",
        "example_quality",
        "constraint_specificity",
        "format_specification",
        "error_handling"
    ]
    
    def generate_suggestions(self, diagnostics, eval_results, current_prompt):
        """
        Generate ranked suggestions sorted by expected impact
        """
        
        suggestions = {}
        
        # Aspect 1: Instruction Clarity
        if "instruction_following" in diagnostics:
            suggestions["clarity"] = self._suggest_clarity_improvements(
                diagnostics["instruction_following"],
                current_prompt
            )
        
        # Aspect 2: Context Provision
        if "hallucination" in diagnostics or "coherence" in diagnostics:
            suggestions["context"] = self._suggest_context_improvements(
                diagnostics,
                current_prompt
            )
        
        # Aspect 3: Chain-of-Thought
        if "coherence" in diagnostics:
            suggestions["reasoning"] = self._suggest_cot_improvements(
                diagnostics["coherence"],
                current_prompt
            )
        
        # ... generate remaining aspect suggestions
        
        # Rank by expected impact
        ranked = self._rank_suggestions_by_impact(suggestions, eval_results)
        
        return ranked
    
    def _suggest_clarity_improvements(self, clarity_diagnostic, prompt):
        """
        Suggestions for improving instruction clarity:
        
        1. Break complex instructions into numbered steps
        2. Define ambiguous terms explicitly
        3. Use concrete examples
        4. Add explicit constraints formatting
        """
        
        suggestions = []
        
        # Find ambiguous constraints
        ambiguous = clarity_diagnostic.get("ambiguity_issues", [])
        for ambig in ambiguous:
            suggestions.append({
                "type": "clarify_constraint",
                "original": ambig["text"],
                "suggested_improvements": [
                    f"Make explicit: {ambig['text']} → [specific version 1]",
                    f"Alternative: {ambig['text']} → [specific version 2]"
                ],
                "reasoning": f"'{ambig['text']}' is ambiguous; agent misinterpreted",
                "priority": "high" if ambig["impact"] == "critical" else "medium"
            })
        
        # Check for conflicting constraints
        conflicts = clarity_diagnostic.get("conflicting_constraints", [])
        for conflict in conflicts:
            suggestions.append({
                "type": "resolve_conflict",
                "constraint_1": conflict["constraint_a"],
                "constraint_2": conflict["constraint_b"],
                "suggested_resolution": f"Choose one OR combine as: [combined version]",
                "priority": "critical"
            })
        
        # Add numbering to steps
        if not self._has_numbered_steps(prompt):
            suggestions.append({
                "type": "structure_improvement",
                "action": "Add numbered steps",
                "example": """
Before:
Your task is to analyze data and provide insights.

After:
Your task is to:
1. Analyze the provided data
2. Identify key patterns
3. Provide actionable insights
""",
                "priority": "medium"
            })
        
        return suggestions
    
    def _suggest_context_improvements(self, diagnostics, prompt):
        """
        Suggestions for providing better context:
        
        1. Add relevant background information
        2. Include examples of desired behavior
        3. Provide reference materials/documentation
        4. Specify context retrieval strategy
        """
        
        suggestions = []
        
        context_insufficiency = diagnostics.get("context_insufficiency", {})
        
        if context_insufficiency.get("missing_examples"):
            suggestions.append({
                "type": "add_examples",
                "action": "Include 2-3 in-context examples",
                "description": "Few-shot prompting significantly improves performance",
                "missing_patterns": context_insufficiency["missing_examples"],
                "priority": "high"
            })
        
        if context_insufficiency.get("missing_definitions"):
            suggestions.append({
                "type": "define_terms",
                "action": "Add glossary or explicit definitions",
                "terms": context_insufficiency["missing_definitions"],
                "priority": "high"
            })
        
        return suggestions
    
    def _suggest_cot_improvements(self, coherence_diagnostic, prompt):
        """
        Suggestions for improving reasoning quality:
        
        1. Add explicit "think step by step" guidance
        2. Request intermediate reasoning
        3. Break multi-step tasks into stages
        4. Add verification/validation steps
        """
        
        suggestions = []
        
        if not self._has_cot_prompt(prompt):
            suggestions.append({
                "type": "add_chain_of_thought",
                "action": "Add CoT prompting",
                "template": """
Before: 
Solve the problem.

After:
Let's think step by step:
1. First, analyze the problem...
2. Then, identify the approach...
3. Finally, execute and verify...

Your solution:
""",
                "reference": "Wei et al. 2022 - Chain-of-Thought Prompting",
                "priority": "high"
            })
        
        complexity = coherence_diagnostic.get("reasoning_complexity", 0)
        if complexity > 0.7:
            suggestions.append({
                "type": "add_intermediate_validation",
                "action": "Request self-verification at each step",
                "reasoning": "Complex tasks benefit from explicit validation",
                "priority": "medium"
            })
        
        return suggestions
    
    def _rank_suggestions_by_impact(self, suggestions, eval_results):
        """
        Rank suggestions by expected performance impact:
        
        Impact factors:
        - Affects high-weight dimension? (higher impact)
        - Fixes common failure pattern? (higher impact)
        - Cost to implement? (lower cost = higher priority)
        """
        
        ranked = []
        
        for aspect, aspect_suggestions in suggestions.items():
            for suggestion in aspect_suggestions:
                # Calculate impact score
                dimension_affected = self._map_aspect_to_dimension(aspect)
                dimension_weight = self._get_dimension_weight(dimension_affected)
                
                # Failure frequency in eval results
                failure_frequency = eval_results.get(dimension_affected, 1.0)
                
                # Implementation cost (heuristic)
                implementation_cost = self._estimate_cost(suggestion)
                
                impact_score = (dimension_weight * failure_frequency) / (1 + implementation_cost)
                
                suggestion["impact_score"] = impact_score
                ranked.append(suggestion)
        
        # Sort by impact score (descending)
        return sorted(ranked, key=lambda x: x["impact_score"], reverse=True)
    
    def _map_aspect_to_dimension(self, aspect):
        """Map suggestion aspect to evaluation rubric dimension"""
        mapping = {
            "clarity": "instruction_following",
            "context": ["hallucination_score", "coherence"],
            "reasoning": "coherence",
            "tool_definitions": "tool_accuracy",
            "examples": ["coherence", "completeness"]
        }
        return mapping.get(aspect, "correctness")
```

## 2.3 Meta-Prompting for Suggestion Generation

Use LLM to generate improvement suggestions based on failure analysis:

```python
class MetaPrompter:
    """
    Meta-prompting: Use LLM to critique and suggest improvements
    
    Implements techniques from:
    - arXiv:2501.XXXXX - Meta-prompting for LLM self-optimization
    - Anthropic's prompt improvement patterns
    """
    
    def generate_improvements_via_llm(self, 
                                     current_prompt, 
                                     eval_results,
                                     diagnostics,
                                     examples=None):
        """
        Use Claude/GPT-4 to generate specific improvement suggestions
        """
        
        meta_prompt = f"""
You are an expert prompt engineer specializing in agentic AI systems.

Current Prompt:
{current_prompt}

Evaluation Results:
{self._format_eval_results(eval_results)}

Failure Diagnosis:
{self._format_diagnostics(diagnostics)}

Examples of desired behavior (if available):
{examples if examples else "None provided"}

Task: Generate 3-5 specific, actionable improvements to the prompt.

For each suggestion:
1. Identify the specific issue being addressed
2. Show the exact text change (before → after)
3. Explain why this change will improve performance
4. Estimate impact (low/medium/high)
5. Implementation difficulty (easy/medium/hard)

Format as JSON:
{{
  "suggestions": [
    {{
      "issue": "...",
      "before": "...",
      "after": "...",
      "reasoning": "...",
      "impact": "...",
      "difficulty": "..."
    }}
  ]
}}
"""
        
        response = self.llm.generate(meta_prompt)
        suggestions = self._parse_llm_suggestions(response)
        
        return suggestions
    
    def _format_eval_results(self, eval_results):
        """Format evaluation results for LLM consumption"""
        
        formatted = "Dimension Scores:\n"
        for dimension, score in eval_results.items():
            if dimension != "failing_dimensions":
                formatted += f"  {dimension}: {score:.2f}/1.0\n"
        
        return formatted
```

---

# STAGE 3: AUTOMATED PROMPT IMPROVEMENT

## 3.1 State-of-the-Art Optimization Algorithms

### Algorithm Overview

| Algorithm | Paper | Mechanism | Best For | Trade-offs |
|-----------|-------|-----------|----------|-----------|
| **BootstrapFewShot** | DSPy | Bootstraps few-shot examples from teacher model | Few data (~10-20 examples) | Demo-only optimization |
| **MIPROv2** | DSPy 2024 | Bayesian search over instruction+demo space | Multi-stage programs | Computationally intensive |
| **TextGrad** | arXiv:2406.07496 | Textual gradients (LLM feedback → updates) | Small datasets | Requires careful tuning |
| **OPRO** | arXiv:2309.03409 | LLM as optimizer; uses ranking trajectory | General optimization | Expensive (many evaluations) |
| **APE** | arXiv:2211.01910 | Generates instruction candidates; selects best | One-shot instruction optimization | Limited to instruction (no demos) |
| **PromptBreeder** | arXiv:2309.16797 | Evolutionary: mutates task+mutation prompts | Long-horizon optimization | Complex to implement |

### Recommended Implementation: MIPROv2

Most effective for complex agentic systems. Jointly optimizes instructions AND examples:

```python
class MIPROv2Optimizer:
    """
    Multi-Instruction Prompt Optimizer v2
    
    References:
    - Opsahl et al. 2024: MIPROv2
    - msazure.club/automated-prompt-optimization-in-dspy
    
    Key innovation: Bayesian surrogate model tracks which instruction/demo
    combinations work best, avoiding exhaustive search
    """
    
    def __init__(self, 
                 llm_model="gpt-4o",
                 eval_metric=None,
                 search_level="moderate_search",
                 max_iterations=20):
        """
        Args:
            search_level: "quick_search", "moderate_search", "heavy_search"
            - quick: 5 iterations, 2 candidates/iter
            - moderate: 15 iterations, 4 candidates/iter  ← Recommended
            - heavy: 50+ iterations, 10 candidates/iter
        """
        self.llm = llm_model
        self.eval_metric = eval_metric
        self.search_level = search_level
        self.max_iterations = max_iterations
        
        # Bayesian search configuration
        self.surrogate_model = "parzen_estimator"  # Tree-structured Parzen
        self.proposal_candidates = 10  # Candidates to evaluate per iteration
    
    def optimize_program(self, program, train_set, metric_fn):
        """
        Main optimization loop
        
        Args:
            program: DSPy program to optimize
            train_set: ~20-100 training examples
            metric_fn: Function(pred, example) → score (0-1)
        """
        
        # Step 1: Extract optimizable modules from program
        modules = self._extract_modules(program)
        
        # Step 2: Initialize instruction/demo candidates
        initial_instructions = self._generate_initial_instructions(program)
        initial_demos = self._bootstrap_demonstrations(program, train_set)
        
        # Step 3: Bayesian optimization loop
        history = []
        best_program = program
        best_score = 0.0
        
        for iteration in range(self.max_iterations):
            # Propose candidates using surrogate model
            candidates = self._propose_candidates(
                history=history,
                num_candidates=self.proposal_candidates,
                modules=modules
            )
            
            # Evaluate candidates (mini-batch for efficiency)
            mini_batch = random.sample(train_set, min(5, len(train_set)))
            
            for candidate_instruction, candidate_demos in candidates:
                # Create candidate program with new instruction+demos
                candidate_program = self._apply_candidate(
                    program, 
                    candidate_instruction, 
                    candidate_demos
                )
                
                # Evaluate on mini-batch
                scores = [
                    metric_fn(candidate_program(example), example)
                    for example in mini_batch
                ]
                
                avg_score = sum(scores) / len(scores)
                
                # Record history for surrogate model
                history.append({
                    "instruction": candidate_instruction,
                    "demos": candidate_demos,
                    "score": avg_score,
                    "iteration": iteration
                })
                
                # Update best if improved
                if avg_score > best_score:
                    best_score = avg_score
                    best_program = candidate_program
                    print(f"Iteration {iteration}: New best score = {best_score:.4f}")
            
            # Update surrogate model with new history
            self.surrogate_model.fit(history)
            
            # Stopping criterion
            if best_score >= 0.95:  # Diminishing returns
                break
        
        # Final evaluation on full train set
        final_score = self._evaluate_on_full_set(best_program, train_set, metric_fn)
        
        return {
            "optimized_program": best_program,
            "final_score": final_score,
            "improvement": final_score - self._baseline_score(program, train_set, metric_fn),
            "iterations": iteration + 1,
            "history": history
        }
    
    def _propose_candidates(self, history, num_candidates, modules):
        """
        Generate candidate instructions/demos using Bayesian optimization
        
        Strategy:
        1. Top-5 high-scoring candidates from history
        2. Mutation of top candidates (perturb instruction, swap demos)
        3. Random exploration
        """
        
        candidates = []
        
        # Exploitation: Take top performers and apply local mutations
        top_performers = sorted(history, key=lambda x: x["score"], reverse=True)[:5]
        
        for performer in top_performers:
            # Mutate instruction
            mutated_instruction = self._mutate_instruction(performer["instruction"])
            
            # Keep top demos, maybe swap one
            mutated_demos = self._mutate_demonstrations(performer["demos"])
            
            candidates.append((mutated_instruction, mutated_demos))
        
        # Exploration: Generate novel instructions
        novel_instructions = self._generate_novel_instructions(
            num=num_candidates - len(candidates)
        )
        
        for instr in novel_instructions:
            new_demos = self._bootstrap_demonstrations_for_instruction(instr)
            candidates.append((instr, new_demos))
        
        return candidates[:num_candidates]
    
    def _mutate_instruction(self, instruction):
        """
        Textual mutation strategies:
        
        1. Paraphrase - rephrase while preserving meaning
        2. Clarify - make ambiguous parts more explicit
        3. Add constraint - strengthen requirement
        4. Decompose - break multi-step into numbered steps
        """
        
        mutations = [
            self._paraphrase_instruction(instruction),
            self._clarify_ambiguities(instruction),
            self._add_explicit_constraints(instruction),
            self._decompose_into_steps(instruction)
        ]
        
        # Use LLM to select best mutation
        best_mutation = self._rank_mutations(mutations)
        
        return best_mutation
    
    def _clarify_ambiguities(self, instruction):
        """Use meta-prompting to identify and fix ambiguities"""
        
        clarification_prompt = f"""
Instruction: {instruction}

Identify ambiguous phrases and clarify them:
1. Find phrases that could be interpreted multiple ways
2. Replace with explicit, unambiguous language
3. Add examples if helpful

Return clarified instruction:
"""
        
        return self.llm.generate(clarification_prompt)
    
    def _evaluate_on_full_set(self, program, train_set, metric_fn):
        """Full evaluation after optimization converges"""
        
        scores = [metric_fn(program(example), example) for example in train_set]
        return sum(scores) / len(scores)
```

### TextGrad for Gradient-Based Optimization

For smaller, focused optimizations:

```python
class TextGradOptimizer:
    """
    TextGrad: Automatic Differentiation via Text
    
    Reference: arXiv:2406.07496 - Yuksekgonul et al. 2024
    
    Key idea: Treat LLM feedback as textual gradient to update prompts
    
    Pseudocode:
    1. Forward pass: Generate output with current prompt
    2. Compute loss: Evaluate output quality
    3. Backward pass: LLM generates critique (textual gradient)
    4. Update: LLM modifies prompt based on critique
    5. Repeat
    """
    
    def __init__(self, 
                 forward_model="gpt-3.5-turbo",
                 backward_model="gpt-4o",
                 num_iterations=12):
        self.forward_model = forward_model
        self.backward_model = backward_model  # Stronger for generating feedback
        self.num_iterations = num_iterations
    
    def optimize(self, initial_prompt, examples, eval_metric):
        """
        Iteratively improve prompt using textual gradients
        """
        
        prompt = initial_prompt
        history = []
        
        for iteration in range(self.num_iterations):
            # Forward pass: Generate with current prompt
            outputs = []
            for example in examples:
                output = self.forward_model.generate(
                    prompt=prompt,
                    input=example["input"]
                )
                outputs.append(output)
            
            # Compute loss
            scores = [eval_metric(o, ex) for o, ex in zip(outputs, examples)]
            avg_loss = 1 - (sum(scores) / len(scores))
            
            print(f"Iteration {iteration}: Loss = {avg_loss:.4f}")
            
            # Backward pass: Generate textual gradient (critique)
            critique_prompt = f"""
Current prompt:
{prompt}

Outputs generated with this prompt:
{self._format_outputs(outputs, examples, scores)}

Loss (1 - accuracy): {avg_loss:.4f}

Generate detailed feedback on how to improve this prompt to:
1. Increase accuracy
2. Reduce errors
3. Better guide the model

Feedback (structured):
"""
            
            critique = self.backward_model.generate(critique_prompt)
            
            # Update: LLM modifies prompt based on critique
            update_prompt = f"""
Original prompt:
{prompt}

Critique/feedback:
{critique}

Generate an improved version of the prompt that addresses the critique.
Focus on:
1. Clarity: Remove ambiguities
2. Specificity: Add constraints/examples
3. Completeness: Include all needed context

Improved prompt:
"""
            
            improved_prompt = self.backward_model.generate(update_prompt)
            
            # Validate improvement
            prompt = improved_prompt
            
            history.append({
                "iteration": iteration,
                "loss": avg_loss,
                "critique": critique,
                "prompt": prompt
            })
            
            # Stopping criterion
            if avg_loss < 0.05:
                break
        
        return {
            "optimized_prompt": prompt,
            "history": history,
            "final_loss": history[-1]["loss"]
        }
    
    def _format_outputs(self, outputs, examples, scores):
        """Format outputs with scores for critique"""
        
        formatted = ""
        for output, example, score in zip(outputs, examples, scores):
            formatted += f"Input: {example['input']}\n"
            formatted += f"Output: {output}\n"
            formatted += f"Score: {score:.2f}\n\n"
        
        return formatted
```

### OPRO: LLM as Optimizer

Treats LLM as black-box optimizer, using ranking feedback:

```python
class OPROOptimizer:
    """
    Optimization by PROmpting (OPRO)
    
    Reference: arXiv:2309.03409 - Yang et al. 2023
    
    Key: Use LLM to generate improvements based on trajectory of 
    previous prompts and their performance (not explicit gradients)
    
    Advantages:
    - Simple to implement
    - Works with any black-box model
    - Interpretable trajectory-based optimization
    
    Results: Outperforms human prompts by 8-50% on various tasks
    """
    
    def __init__(self, optimizer_model="gpt-4o", max_iterations=20):
        self.optimizer = optimizer_model
        self.max_iterations = max_iterations
    
    def optimize(self, 
                 task_description, 
                 initial_prompt,
                 examples,
                 eval_metric):
        """
        Args:
            task_description: Natural language task description
            initial_prompt: Starting prompt
            examples: Training examples for evaluation
            eval_metric: Function to score outputs
        """
        
        prompt_trajectory = []
        score_trajectory = []
        
        # Initialize
        current_prompt = initial_prompt
        prompt_trajectory.append(current_prompt)
        
        for iteration in range(self.max_iterations):
            # Evaluate current prompt
            scores = []
            for example in examples:
                # Use eval model to run task with current prompt
                output = self._run_task(current_prompt, example)
                score = eval_metric(output, example)
                scores.append(score)
            
            avg_score = sum(scores) / len(scores)
            score_trajectory.append(avg_score)
            
            print(f"Iteration {iteration}: Score = {avg_score:.4f}")
            
            # Generate next prompt using LLM optimizer
            # Key insight: Show LLM the trajectory of prompts tried and scores achieved
            
            optimizer_prompt = f"""
Task: {task_description}

Evaluation Results (Prompt History):
"""
            
            # Show trajectory
            for i, (p, s) in enumerate(zip(prompt_trajectory[-5:], score_trajectory[-5:])):
                optimizer_prompt += f"\nPrompt {i+1} (Score: {s:.4f}):\n{p}\n"
            
            optimizer_prompt += f"""

Best performing prompt so far (Score: {max(score_trajectory):.4f}):
{prompt_trajectory[score_trajectory.index(max(score_trajectory))]}

Generate the next prompt that will likely perform even better.
Consider:
1. What patterns work? (Analyze top performers)
2. What patterns fail? (Analyze low performers)
3. How to combine successful elements?
4. What new strategies to try?

Generate only the improved prompt (no explanation):
"""
            
            next_prompt = self.optimizer.generate(optimizer_prompt)
            
            prompt_trajectory.append(next_prompt)
            current_prompt = next_prompt
            
            # Early stopping
            if avg_score >= 0.95:
                break
        
        best_idx = score_trajectory.index(max(score_trajectory))
        
        return {
            "best_prompt": prompt_trajectory[best_idx],
            "best_score": max(score_trajectory),
            "improvement": max(score_trajectory) - score_trajectory[0],
            "prompt_trajectory": prompt_trajectory,
            "score_trajectory": score_trajectory
        }
```

---

## 3.2 Few-Shot Example Optimization

Critical for prompt performance. Quality of examples matters more than quantity:

```python
class FewShotExampleOptimizer:
    """
    Optimize in-context examples for maximum prompt effectiveness
    
    References:
    - DSPy BootstrapFewShot
    - "Finding Golden Examples" (TowardDS 2025)
    - arXiv:2405.XXXXX - Few-shot learning optimization
    """
    
    def __init__(self, llm_model="gpt-4o", num_examples=4):
        self.llm = llm_model
        self.num_examples = num_examples
    
    def bootstrap_examples(self, program, train_set, metric_fn):
        """
        BootstrapFewShot algorithm:
        
        1. Use teacher model (or the program itself) to generate outputs for train set
        2. Select examples where teacher performance is high
        3. Use these examples as in-context demonstrations
        4. Empirically tested: More effective than human examples
        """
        
        # Step 1: Generate outputs for all training examples
        candidate_examples = []
        
        for example in train_set:
            output = program(example)
            
            # Score the output
            score = metric_fn(output, example)
            
            if score >= 0.7:  # High quality outputs make good examples
                candidate_examples.append({
                    "input": example["input"],
                    "output": output,
                    "score": score
                })
        
        # Step 2: Select diverse, high-quality examples
        selected_examples = self._select_diverse_examples(
            candidate_examples,
            num_to_select=self.num_examples
        )
        
        return selected_examples
    
    def _select_diverse_examples(self, candidates, num_to_select):
        """
        Selection strategy: Balance quality AND diversity
        
        - Sort by score (quality)
        - Apply diversity sampling (avoid similar examples)
        - Return top scoring diverse subset
        """
        
        # Sort by quality
        sorted_candidates = sorted(candidates, key=lambda x: x["score"], reverse=True)
        
        selected = []
        
        for candidate in sorted_candidates:
            # Check if similar to already selected
            if not self._is_similar_to_selected(candidate, selected):
                selected.append(candidate)
                
                if len(selected) >= num_to_select:
                    break
        
        return selected
    
    def _is_similar_to_selected(self, candidate, selected_list):
        """Check semantic similarity using embeddings"""
        
        candidate_embedding = self._get_embedding(candidate["input"])
        
        for selected in selected_list:
            similarity = self._cosine_similarity(
                candidate_embedding,
                self._get_embedding(selected["input"])
            )
            
            if similarity > 0.8:  # Too similar
                return True
        
        return False
    
    def optimize_example_order(self, examples):
        """
        Ordering matters! Research shows:
        
        1. Simple-to-complex: Start with easier examples
        2. Most-relevant-first: Put most similar to test case first
        3. Rarity-weighted: Lead with rare patterns
        
        Recommendation: Simple-to-complex for robustness
        """
        
        # Rank by complexity
        complexity_scores = [self._estimate_complexity(ex) for ex in examples]
        
        # Sort simple → complex
        sorted_examples = sorted(
            zip(examples, complexity_scores),
            key=lambda x: x[1]
        )
        
        return [ex for ex, _ in sorted_examples]
    
    def _estimate_complexity(self, example):
        """
        Complexity heuristics:
        - Input length (longer = more complex)
        - Number of constraints/requirements
        - Math operations required
        - Reasoning steps needed
        """
        
        complexity = 0
        complexity += len(example.get("input", "")) / 100  # Length
        complexity += example.get("num_constraints", 0) * 0.3
        complexity += example.get("reasoning_steps", 0) * 0.2
        
        return complexity
```

---

## 3.3 Validation & Regression Testing

Ensure improvements don't break existing functionality:

```python
class PromptValidator:
    """
    Validate that improved prompts maintain quality and don't regress
    """
    
    def __init__(self, eval_metric_fn=None):
        self.eval_metric = eval_metric_fn
    
    def validate_improvement(self, 
                             original_prompt, 
                             improved_prompt,
                             test_set,
                             baseline_score=None):
        """
        Check:
        1. Improvement achieves +X% on test set
        2. No regressions on specific difficult cases
        3. Statistically significant improvement
        4. Held-out set validation (generalization)
        """
        
        # Evaluate both prompts
        original_scores = self._evaluate_prompt(original_prompt, test_set)
        improved_scores = self._evaluate_prompt(improved_prompt, test_set)
        
        original_avg = sum(original_scores) / len(original_scores)
        improved_avg = sum(improved_scores) / len(improved_scores)
        
        improvement_pct = (improved_avg - original_avg) / original_avg * 100
        
        # Check for regressions
        regressions = []
        for i, (orig, impr) in enumerate(zip(original_scores, improved_scores)):
            if impr < orig - 0.1:  # >10% regression
                regressions.append({
                    "example_idx": i,
                    "original_score": orig,
                    "improved_score": impr
                })
        
        # Statistical significance test (paired t-test)
        from scipy import stats
        t_stat, p_value = stats.ttest_rel(improved_scores, original_scores)
        
        is_significant = p_value < 0.05
        
        validation_result = {
            "improved": improvement_pct > 2.0,  # Minimum improvement threshold
            "improvement_percentage": improvement_pct,
            "has_regressions": len(regressions) > 0,
            "regression_count": len(regressions),
            "statistical_significance": is_significant,
            "p_value": p_value,
            "recommendation": self._make_recommendation(
                improvement_pct, 
                len(regressions),
                is_significant
            )
        }
        
        return validation_result
    
    def _make_recommendation(self, improvement, regression_count, is_sig):
        """Recommend whether to deploy improved prompt"""
        
        if improvement > 5 and regression_count == 0 and is_sig:
            return "DEPLOY: Significant improvement, no regressions"
        elif improvement > 2 and regression_count < 2:
            return "DEPLOY: Modest improvement, acceptable regressions"
        elif improvement < 0:
            return "REJECT: No improvement or degradation"
        else:
            return "REVIEW: Mixed results, manual inspection needed"
    
    def _evaluate_prompt(self, prompt, test_set):
        """Run prompt on test set and collect scores"""
        
        scores = []
        for example in test_set:
            output = self._run_prompt(prompt, example)
            score = self.eval_metric(output, example)
            scores.append(score)
        
        return scores
```

---

# STAGE 4: VALIDATE (Optional)

## 4.1 A/B Testing in Production

```python
class ABTestManager:
    """
    Safe deployment through A/B testing
    
    References:
    - PromptCompose A/B testing docs
    - Getmaxim guide to prompt A/B testing
    """
    
    def __init__(self):
        self.experiments = {}
    
    def setup_experiment(self,
                        experiment_name,
                        control_prompt,
                        treatment_prompt,
                        traffic_split=0.5):
        """
        Create A/B test comparing control vs treatment prompt
        
        Args:
            traffic_split: 0.5 = 50% control, 50% treatment
        """
        
        self.experiments[experiment_name] = {
            "control": control_prompt,
            "treatment": treatment_prompt,
            "traffic_split": traffic_split,
            "results": {
                "control": [],
                "treatment": []
            },
            "start_time": datetime.now()
        }
    
    def route_request(self, experiment_name, user_id):
        """Route user to control or treatment based on traffic split"""
        
        experiment = self.experiments[experiment_name]
        
        # Deterministic routing (same user always gets same variant)
        user_hash = hash(user_id) % 100
        
        if user_hash < (experiment["traffic_split"] * 100):
            return "control", experiment["control"]
        else:
            return "treatment", experiment["treatment"]
    
    def record_result(self, experiment_name, variant, metric_value):
        """Record outcome for statistical analysis"""
        
        self.experiments[experiment_name]["results"][variant].append(metric_value)
    
    def analyze_experiment(self, experiment_name, 
                          min_samples=100,
                          confidence_level=0.95):
        """
        Analyze results with statistical rigor
        
        Returns: Winner, p-value, confidence interval
        """
        
        experiment = self.experiments[experiment_name]
        control_results = experiment["results"]["control"]
        treatment_results = experiment["results"]["treatment"]
        
        # Check minimum samples
        if len(control_results) < min_samples or len(treatment_results) < min_samples:
            return {
                "status": "INSUFFICIENT_DATA",
                "samples_needed": min_samples,
                "control_samples": len(control_results),
                "treatment_samples": len(treatment_results)
            }
        
        # Perform t-test
        from scipy import stats
        t_stat, p_value = stats.ttest_ind(treatment_results, control_results)
        
        treatment_mean = sum(treatment_results) / len(treatment_results)
        control_mean = sum(control_results) / len(control_results)
        
        # Calculate confidence interval
        from scipy import stats as st
        ci = st.t.interval(
            confidence_level,
            len(treatment_results) - 1,
            loc=treatment_mean,
            scale=st.sem(treatment_results)
        )
        
        return {
            "status": "COMPLETE",
            "winner": "treatment" if p_value < 0.05 and treatment_mean > control_mean else "control",
            "p_value": p_value,
            "is_significant": p_value < 0.05,
            "treatment_mean": treatment_mean,
            "control_mean": control_mean,
            "improvement": (treatment_mean - control_mean) / control_mean * 100,
            "confidence_interval": ci
        }
```

---

# STAGE 5: ITERATE (Optional - Continuous Improvement)

## 5.1 Online Learning from Production Data

```python
class ContinuousImprovement:
    """
    Learn from production data to continuously improve prompts
    
    Pattern: Monitor → Detect Degradation → Re-optimize → Deploy
    """
    
    def __init__(self, reoptimization_interval_hours=24):
        self.interval = reoptimization_interval_hours
        self.performance_history = []
    
    def monitor_production(self, current_prompt, metrics_stream):
        """
        Continuously collect metrics from production
        
        Metrics:
        - Success rate
        - User satisfaction
        - Error rate
        - Hallucination detection
        """
        
        for metric_batch in metrics_stream:
            self.performance_history.append({
                "timestamp": datetime.now(),
                "metrics": metric_batch
            })
            
            # Check for degradation
            if self._detect_degradation():
                self._trigger_reoptimization(current_prompt)
    
    def _detect_degradation(self, window_size=100):
        """
        Detect performance drop using control chart method
        
        EWMA (Exponentially Weighted Moving Average) chart
        """
        
        recent_data = self.performance_history[-window_size:]
        
        if len(recent_data) < window_size:
            return False
        
        # Calculate EWMA
        alpha = 0.3  # Smoothing factor
        ewma = self._calculate_ewma(recent_data, alpha)
        
        # Check if recent values drop below control limit
        baseline_mean = self._calculate_mean(self.performance_history[:-window_size])
        baseline_std = self._calculate_std(self.performance_history[:-window_size])
        
        control_limit = baseline_mean - 2 * baseline_std  # 2-sigma
        
        return ewma < control_limit
    
    def _trigger_reoptimization(self, current_prompt):
        """When degradation detected, run optimization again"""
        
        print("Performance degradation detected. Re-optimizing prompt...")
        
        # Collect recent examples that failed
        recent_failures = self._get_recent_failures()
        
        # Use new data + failures for re-optimization
        optimizer = MIPROv2Optimizer()
        
        improved_prompt = optimizer.optimize_program(
            program=current_prompt,
            train_set=recent_failures,
            metric_fn=self.eval_metric
        )
        
        return improved_prompt
```

---

# RECOMMENDED DEFAULT PIPELINE FOR /blogKIT.OPTIMIZE

## Pipeline Configuration

```yaml
blogkit:
  optimize:
    # Stage 1: Evaluation
    evaluation:
      method: "multi_judge_consensus"
      judges:
        - model: "gpt-4o"
          rubric: "strict"
        - model: "claude-3.5-sonnet"
          rubric: "balanced"
      min_agreement_kappa: 0.4
      dimensions:
        - correctness
        - coherence
        - instruction_following
        - hallucination_score
        - tool_accuracy
        - efficiency
    
    # Stage 2: Suggestion Generation
    suggestions:
      method: "diagnostic_+ meta_prompting"
      top_k_suggestions: 5
      ranking_by: "impact_score"
      consider_aspects:
        - instruction_clarity
        - context_provision
        - chain_of_thought
        - example_quality
        - tool_definitions
    
    # Stage 3: Improvement
    optimization:
      primary_optimizer: "miprov2"
      fallback_optimizer: "textgrad"
      miprov2_config:
        search_level: "moderate_search"
        max_iterations: 15
        proposal_candidates: 4
      
      few_shot:
        num_examples: 4
        selection_strategy: "diverse_high_quality"
        ordering_strategy: "simple_to_complex"
    
    # Validation
    validation:
      enabled: true
      min_improvement_threshold: 2.0  # 2%
      max_acceptable_regressions: 1
      statistical_significance: true
      confidence_level: 0.95
    
    # Optional: Production Deployment
    deployment:
      method: "gradual_rollout"
      stages:
        - environment: "staging"
          traffic: 1.0
          min_samples: 50
          duration_hours: 4
        - environment: "production"
          traffic: 0.1
          min_samples: 100
          duration_hours: 24
        - environment: "production"
          traffic: 1.0
          min_samples: 500
```

## Example Usage

```python
from blogkit import optimize

# Stage 1: Evaluate current prompt
evaluation = optimize.evaluate(
    prompt=current_prompt,
    test_set=test_examples,
    rubric="agentic_comprehensive"
)

print(f"Evaluation Results:")
print(f"  Overall Score: {evaluation['overall_score']:.2f}")
print(f"  Failing Dimensions: {evaluation['failing_dimensions']}")

# Stage 2: Generate suggestions
suggestions = optimize.suggest(
    evaluation_results=evaluation,
    current_prompt=current_prompt,
    diagnostics_mode="auto"
)

print(f"\nTop Suggestions:")
for i, sugg in enumerate(suggestions[:3], 1):
    print(f"  {i}. {sugg['type']}: {sugg['description']}")
    print(f"     Impact: {sugg['impact_score']:.2f} | Difficulty: {sugg['difficulty']}")

# Stage 3: Improve prompt
improved = optimize.improve(
    current_prompt=current_prompt,
    suggestions=suggestions,
    train_set=train_examples,
    eval_metric=metric_fn,
    optimizer="miprov2"
)

print(f"\nOptimization Complete:")
print(f"  Best Score Achieved: {improved['final_score']:.4f}")
print(f"  Improvement: +{improved['improvement']*100:.1f}%")
print(f"  Iterations: {improved['iterations']}")

# Stage 4: Validate (Optional)
validation = optimize.validate(
    original_prompt=current_prompt,
    improved_prompt=improved['optimized_prompt'],
    test_set=test_examples,
    eval_metric=metric_fn
)

if validation['recommendation'].startswith('DEPLOY'):
    # Stage 5: Deploy and monitor
    optimize.deploy(
        prompt_id="prompt_v2",
        prompt=improved['optimized_prompt'],
        strategy="gradual_rollout"
    )
```

---

# KEY PAPERS & REFERENCES

## Evaluation Frameworks
- **arXiv:2411.15594** - A Survey on LLM-as-a-Judge
- **arXiv:2510.02837** - TRACE: Evaluating Reasoning Trajectories
- **arXiv:2505.16944** - AgentIF: Instruction Following Benchmark
- **arXiv:2310.05470** - G-Eval: NLG Evaluation with GPT-4

## Optimization Algorithms
- **arXiv:2406.07496** - TextGrad: Automatic Differentiation via Text
- **arXiv:2309.03409** - OPRO: Large Language Models as Optimizers
- **arXiv:2309.16797** - PromptBreeder: Evolutionary Prompt Optimization
- **arXiv:2211.01910** - APE: Automatic Prompt Engineer
- **DSPy Documentation** - MIPRO & MIPROv2 Optimizers

## Agentic Systems
- **arXiv:2509.18970** - LLM-based Agent Hallucinations Survey
- **arXiv:2410.07869** - WorFBench: Workflow Generation Benchmark
- **arXiv:2505.10772** - Ranked Voting Self-Consistency

## Production Practices
- LangSmith Documentation - Observability & Evaluation
- Anthropic Prompt Caching Guide
- OpenAI Production Best Practices

---

# OPEN QUESTIONS & FUTURE DIRECTIONS

1. **Multi-Objective Optimization**: How to balance correctness vs. latency vs. cost?
2. **Domain Transfer**: Do optimized prompts generalize to new domains?
3. **Judge Calibration**: How to automatically calibrate evaluator models for fairness?
4. **Prompt Interpretability**: What makes an optimized prompt work? Can we understand the mechanisms?
5. **Continual Learning**: How to optimize under distribution shift?
6. **Computational Efficiency**: Can we optimize large prompt spaces with fewer evaluations?

---

END OF GUIDE