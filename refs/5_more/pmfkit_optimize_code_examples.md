# Code Implementation Examples: `/blogkit.optimize`

## Quick Start Examples

### Example 1: Complete Optimization Pipeline

```python
from blogkit import optimize
from dspy import ChainOfThought, Retrieve
import dspy

# Initialize models
dspy.settings.configure(lm=dspy.OpenAI(model="gpt-4o"))
evaluator_lm = dspy.OpenAI(model="gpt-4o")

# Define your program/agent
class QAAgent(dspy.Module):
    def __init__(self):
        super().__init__()
        self.retrieve = Retrieve(k=3)
        self.generate_answer = ChainOfThought("context, question -> answer")
    
    def forward(self, question):
        context = self.retrieve(question).passages
        prediction = self.generate_answer(
            context="\n".join(context),
            question=question
        )
        return prediction

# Load training data
train_set = [
    {"question": "What is X?", "answer": "X is ..."},
    # ... 20-50 examples
]

test_set = [
    {"question": "What is Y?", "answer": "Y is ..."},
    # ... 10 examples
]

# Define evaluation metric
def metric_fn(pred, example):
    """Score prediction against ground truth"""
    from bert_score import score
    
    p, r, f1 = score([pred.answer], [example["answer"]], lang="en")
    return f1.item()

# ============ STAGE 1: EVALUATE ============
program = QAAgent()

evaluation_result = optimize.evaluate(
    program=program,
    test_set=test_set,
    rubric="comprehensive_agentic",
    judges=[
        {"model": "gpt-4o", "rubric_variant": "strict"},
        {"model": "claude-3.5-sonnet", "rubric_variant": "balanced"}
    ],
    eval_metric=metric_fn
)

print("\n=== EVALUATION RESULTS ===")
print(f"Overall Score: {evaluation_result['overall_score']:.2f}/1.0")
print(f"Correctness: {evaluation_result['dimensions']['correctness']:.2f}")
print(f"Coherence: {evaluation_result['dimensions']['coherence']:.2f}")
print(f"Instruction Following: {evaluation_result['dimensions']['instruction_following']:.2f}")
print(f"\nFailing Dimensions: {evaluation_result['failing_dimensions']}")

# ============ STAGE 2: SUGGEST ============
suggestions = optimize.suggest(
    evaluation_results=evaluation_result,
    current_prompts={
        "system_prompt": program.generate_answer.input_prefix,
        "retrieve_instruction": program.retrieve.input_prefix
    },
    diagnostic_mode="auto"
)

print("\n=== IMPROVEMENT SUGGESTIONS ===")
for i, sugg in enumerate(suggestions[:5], 1):
    print(f"\n{i}. {sugg['type'].upper()}")
    print(f"   Affected Dimension: {sugg['dimension']}")
    print(f"   Impact Score: {sugg['impact_score']:.2f}")
    print(f"   Description: {sugg['description']}")
    if 'before' in sugg:
        print(f"   Before: {sugg['before'][:100]}...")
        print(f"   After: {sugg['after'][:100]}...")

# ============ STAGE 3: IMPROVE ============
from dspy.teleprompt import MIPROv2

optimizer = MIPROv2(
    metric=metric_fn,
    num_candidates=4,
    iterations=15
)

compiled_program = optimizer.compile(
    program,
    trainset=train_set,
    eval_kwargs={"num_threads": 4}
)

# Measure improvement
baseline_score = sum(metric_fn(program(ex), ex) for ex in test_set) / len(test_set)
improved_score = sum(metric_fn(compiled_program(ex), ex) for ex in test_set) / len(test_set)

print("\n=== OPTIMIZATION RESULTS ===")
print(f"Baseline Score: {baseline_score:.4f}")
print(f"Improved Score: {improved_score:.4f}")
print(f"Improvement: +{(improved_score - baseline_score) * 100:.1f}%")

# ============ STAGE 4: VALIDATE ============
validation = optimize.validate(
    original_program=program,
    improved_program=compiled_program,
    test_set=test_set,
    eval_metric=metric_fn,
    confidence_level=0.95
)

print("\n=== VALIDATION RESULTS ===")
print(f"Statistically Significant: {validation['is_significant']}")
print(f"P-value: {validation['p_value']:.4f}")
print(f"Regressions: {validation['regression_count']}")
print(f"Recommendation: {validation['recommendation']}")

# ============ STAGE 5: DEPLOY ============
if validation['recommendation'].startswith('DEPLOY'):
    deployment = optimize.deploy(
        prompt_id="qa_agent_v2",
        program=compiled_program,
        strategy="gradual_rollout",
        stages=[
            {"environment": "staging", "traffic": 1.0, "duration_hours": 4},
            {"environment": "production", "traffic": 0.1, "duration_hours": 24},
            {"environment": "production", "traffic": 1.0}
        ]
    )
    
    print("\n=== DEPLOYMENT INITIATED ===")
    print(f"Deployment ID: {deployment['id']}")
    print(f"Current Stage: {deployment['current_stage']}")
```

---

## Example 2: Custom Evaluation Rubric

```python
from blogkit import optimize
from typing import Dict

class CustomAgenticRubric:
    """Define custom evaluation dimensions for your specific task"""
    
    def __init__(self):
        self.dimensions = {
            "api_call_correctness": {
                "weight": 0.30,
                "description": "API parameters correct and in right order",
                "evaluation_type": "code_based",
                "scoring_fn": self.score_api_correctness
            },
            
            "error_recovery": {
                "weight": 0.20,
                "description": "Agent handles API errors gracefully",
                "evaluation_type": "trajectory_based",
                "scoring_fn": self.score_error_recovery
            },
            
            "response_clarity": {
                "weight": 0.25,
                "description": "Final response is clear and complete",
                "evaluation_type": "llm_judge",
                "scoring_fn": None  # Uses LLM judge
            },
            
            "efficiency": {
                "weight": 0.15,
                "description": "Minimal API calls to achieve goal",
                "evaluation_type": "computed",
                "scoring_fn": self.score_efficiency
            },
            
            "factuality": {
                "weight": 0.10,
                "description": "No hallucinations about API responses",
                "evaluation_type": "llm_judge",
                "scoring_fn": None
            }
        }
    
    def score_api_correctness(self, trace: Dict, output: str) -> float:
        """Code-based scoring for API call correctness"""
        
        api_calls = self._extract_api_calls(trace)
        correct_calls = 0
        
        for call in api_calls:
            if self._validate_api_call(call):
                correct_calls += 1
        
        return correct_calls / len(api_calls) if api_calls else 1.0
    
    def score_error_recovery(self, trace: Dict) -> float:
        """Score ability to handle errors gracefully"""
        
        steps = trace.get("steps", [])
        recoveries = 0
        errors = 0
        
        for i, step in enumerate(steps):
            if "error" in step.get("result", "").lower():
                errors += 1
                
                # Check if next step attempts recovery
                if i + 1 < len(steps):
                    next_action = steps[i + 1].get("action", "")
                    if self._is_recovery_attempt(next_action):
                        recoveries += 1
        
        if errors == 0:
            return 1.0  # No errors = perfect recovery
        
        return min(1.0, recoveries / errors)
    
    def score_efficiency(self, trace: Dict) -> float:
        """Score efficient use of API calls"""
        
        api_call_count = len(self._extract_api_calls(trace))
        
        # Heuristic: 3-5 calls is efficient, more is wasteful
        if api_call_count <= 3:
            return 1.0
        elif api_call_count <= 5:
            return 0.8
        elif api_call_count <= 7:
            return 0.6
        else:
            return 0.4
    
    def _extract_api_calls(self, trace):
        """Extract API calls from trace"""
        api_calls = []
        for step in trace.get("steps", []):
            action = step.get("action", {})
            if action.get("type") == "api_call":
                api_calls.append(action)
        return api_calls
    
    def _validate_api_call(self, call):
        """Validate API call structure"""
        required_fields = ["endpoint", "method", "params"]
        return all(field in call for field in required_fields)
    
    def _is_recovery_attempt(self, action):
        """Check if action is attempting to recover from error"""
        recovery_indicators = [
            "retry", "alternative", "fallback", 
            "different_endpoint", "different_params"
        ]
        action_str = str(action).lower()
        return any(ind in action_str for ind in recovery_indicators)

# Use custom rubric
rubric = CustomAgenticRubric()

evaluation = optimize.evaluate(
    program=my_agent,
    test_set=test_examples,
    custom_rubric=rubric.dimensions,
    eval_metric=metric_fn
)
```

---

## Example 3: TextGrad-Based Optimization

```python
from blogkit import optimize
import textgrad as tg

class TextGradOptimization:
    """Gradient-based prompt optimization using TextGrad"""
    
    def __init__(self, forward_model="gpt-3.5-turbo", 
                 backward_model="gpt-4o"):
        self.forward_model = forward_model
        self.backward_model = backward_model
    
    def optimize_agentic_prompt(self, 
                                initial_prompt: str,
                                examples: list,
                                eval_metric,
                                num_iterations: int = 10):
        """
        Use TextGrad to iteratively improve prompt
        """
        
        # Initialize prompt as variable requiring gradients
        prompt = tg.Variable(
            initial_prompt, 
            requires_grad=True, 
            role_description="agentic system prompt"
        )
        
        # Define forward and backward models
        forward_engine = tg.BlackBoxLLM(
            model_name=self.forward_model,
            system_prompt=prompt
        )
        
        backward_engine = tg.BlackBoxLLM(
            model_name=self.backward_model
        )
        
        # Initialize optimizer
        optimizer = tg.TextGradientDescent(
            parameters=[prompt],
            backward_engine=backward_engine,
            batch_size=3,
            learning_rate=1.0  # For text, this is arbitrary
        )
        
        best_loss = float('inf')
        best_prompt = initial_prompt
        
        for iteration in range(num_iterations):
            # Forward pass
            outputs = []
            losses = []
            
            for example in examples[:5]:  # Mini-batch
                # Generate with current prompt
                output = forward_engine(
                    input_str=example["input"],
                    temperature=0.7
                )
                
                # Compute loss
                loss_value = 1 - eval_metric(output, example)
                
                outputs.append(output)
                losses.append(tg.Variable(loss_value, requires_grad=True))
            
            # Average loss
            total_loss = sum(losses) / len(losses)
            
            # Backward pass (textual gradient)
            total_loss.backward()
            
            # Update prompt
            optimizer.step()
            
            current_loss = float(total_loss.value)
            
            if current_loss < best_loss:
                best_loss = current_loss
                best_prompt = str(prompt)
                print(f"Iteration {iteration}: Loss = {current_loss:.4f} ✓")
            else:
                print(f"Iteration {iteration}: Loss = {current_loss:.4f}")
        
        return best_prompt, best_loss

# Usage
textgrad_opt = TextGradOptimization()

optimized_prompt, final_loss = textgrad_opt.optimize_agentic_prompt(
    initial_prompt="""You are an AI agent. Follow these steps:
1. Analyze the user query
2. Determine required actions
3. Execute actions using available tools
4. Return clear final answer""",
    examples=training_examples,
    eval_metric=my_metric_fn,
    num_iterations=10
)

print(f"\nOptimized Prompt:\n{optimized_prompt}")
print(f"Final Loss: {final_loss:.4f}")
```

---

## Example 4: OPRO Trajectory-Based Optimization

```python
from blogkit import optimize
from dspy import OpenAI

class OPROOptimization:
    """LLM-as-optimizer using trajectory information"""
    
    def __init__(self, task_description: str, 
                 optimizer_model: str = "gpt-4o"):
        self.task_description = task_description
        self.optimizer = OpenAI(model=optimizer_model)
        self.prompt_history = []
        self.score_history = []
    
    def optimize(self, initial_prompt: str, 
                 examples: list, 
                 eval_metric,
                 max_iterations: int = 20):
        """
        OPRO: Use LLM as optimizer based on prompt trajectory
        """
        
        current_prompt = initial_prompt
        self.prompt_history.append(current_prompt)
        
        for iteration in range(max_iterations):
            # Evaluate current prompt
            scores = [
                eval_metric(self._run_prompt(current_prompt, ex), ex)
                for ex in examples[:10]  # Mini-batch
            ]
            
            avg_score = sum(scores) / len(scores)
            self.score_history.append(avg_score)
            
            print(f"Iteration {iteration}: Score = {avg_score:.4f}")
            
            # Generate next prompt using optimizer
            next_prompt = self._generate_next_prompt()
            
            self.prompt_history.append(next_prompt)
            current_prompt = next_prompt
            
            # Early stopping
            if avg_score >= 0.95:
                print("Converged to excellent performance!")
                break
        
        best_idx = self.score_history.index(max(self.score_history))
        best_prompt = self.prompt_history[best_idx]
        
        return best_prompt, max(self.score_history)
    
    def _generate_next_prompt(self) -> str:
        """Use LLM to generate improved prompt based on trajectory"""
        
        # Show last 5 prompts and their scores
        trajectory_context = "Prompt Optimization History:\n\n"
        
        for i in range(max(0, len(self.prompt_history) - 5), 
                       len(self.prompt_history)):
            trajectory_context += f"Attempt {i+1} (Score: {self.score_history[i]:.4f}):\n"
            trajectory_context += f"{self.prompt_history[i]}\n\n"
        
        # Add analysis
        best_idx = self.score_history.index(max(self.score_history))
        trajectory_context += f"\nBest performing prompt (Score: {max(self.score_history):.4f}):\n"
        trajectory_context += self.prompt_history[best_idx]
        
        optimization_prompt = f"""Task: {self.task_description}

{trajectory_context}

Based on this optimization trajectory, generate the NEXT prompt that will likely 
perform even better. 

Consider:
1. What patterns appear in successful prompts?
2. What did unsuccessful prompts miss?
3. How can you combine the best elements?
4. What new strategies haven't been tried?

Generate only the improved prompt (no explanation):"""
        
        next_prompt = self.optimizer(optimization_prompt)
        return next_prompt
    
    def _run_prompt(self, prompt: str, example: dict) -> str:
        """Execute prompt on example"""
        # Implementation depends on your task
        pass

# Usage
opro_optimizer = OPROOptimization(
    task_description="Generate concise, accurate API documentation"
)

best_prompt, best_score = opro_optimizer.optimize(
    initial_prompt="Generate API documentation",
    examples=training_examples,
    eval_metric=doc_quality_metric,
    max_iterations=20
)

print(f"\nBest Prompt:\n{best_prompt}")
print(f"Best Score: {best_score:.4f}")
```

---

## Example 5: Few-Shot Example Optimization

```python
from blogkit import optimize
import json

class FewShotOptimizer:
    """Bootstrap and optimize in-context examples"""
    
    def __init__(self, num_examples: int = 4):
        self.num_examples = num_examples
    
    def bootstrap_examples(self, program, train_set: list, 
                          eval_metric, teacher_model=None):
        """
        BootstrapFewShot: Use teacher to generate high-quality examples
        """
        
        teacher = teacher_model or program
        
        # Step 1: Generate outputs for all training examples
        candidates = []
        
        for i, example in enumerate(train_set):
            output = teacher(example["input"])
            score = eval_metric(output, example)
            
            candidates.append({
                "input": example["input"],
                "output": output,
                "score": score,
                "index": i
            })
            
            if i % 10 == 0:
                print(f"  Generated {i}/{len(train_set)} examples")
        
        # Step 2: Filter high-quality examples
        quality_threshold = 0.7
        high_quality = [c for c in candidates if c["score"] >= quality_threshold]
        
        print(f"High-quality examples: {len(high_quality)}/{len(candidates)}")
        
        # Step 3: Select diverse subset
        selected = self._select_diverse(high_quality, self.num_examples)
        
        # Step 4: Order by complexity
        ordered = self._order_by_complexity(selected)
        
        return ordered
    
    def _select_diverse(self, candidates: list, num_to_select: int) -> list:
        """Select diverse, high-quality examples"""
        
        from sklearn.metrics.pairwise import cosine_similarity
        from sentence_transformers import SentenceTransformer
        
        model = SentenceTransformer('all-MiniLM-L6-v2')
        
        # Embed all candidates
        embeddings = [
            model.encode(c["input"]) for c in candidates
        ]
        
        # Greedy diversity selection
        selected_indices = [0]  # Start with highest quality
        
        for _ in range(num_to_select - 1):
            # Find candidate most different from already selected
            best_idx = 0
            best_diversity = 0
            
            for i, emb in enumerate(embeddings):
                if i in selected_indices:
                    continue
                
                # Measure diversity: min similarity to selected
                similarities = [
                    cosine_similarity([emb], [embeddings[j]])[0][0]
                    for j in selected_indices
                ]
                
                min_similarity = min(similarities)
                
                if min_similarity > best_diversity:
                    best_diversity = min_similarity
                    best_idx = i
            
            selected_indices.append(best_idx)
        
        return [candidates[i] for i in selected_indices]
    
    def _order_by_complexity(self, examples: list) -> list:
        """Order examples from simple to complex"""
        
        def estimate_complexity(example):
            # Heuristics
            complexity = 0
            complexity += len(example["input"]) / 100  # Length
            complexity += example["input"].count(",") * 0.2  # Structure
            complexity += example["input"].count("and") * 0.1  # Conjunctions
            return complexity
        
        sorted_examples = sorted(
            examples,
            key=lambda x: estimate_complexity(x)
        )
        
        return sorted_examples
    
    def format_for_prompt(self, examples: list) -> str:
        """Format selected examples for in-context learning"""
        
        formatted = "Examples:\n\n"
        
        for i, example in enumerate(examples, 1):
            formatted += f"Example {i}:\n"
            formatted += f"Input: {example['input']}\n"
            formatted += f"Output: {example['output']}\n"
            formatted += f"Score: {example['score']:.2f}\n\n"
        
        return formatted

# Usage
fewshot_optimizer = FewShotOptimizer(num_examples=4)

optimized_examples = fewshot_optimizer.bootstrap_examples(
    program=my_agent,
    train_set=training_data,
    eval_metric=quality_metric
)

# Format for use in prompt
examples_text = fewshot_optimizer.format_for_prompt(optimized_examples)

# Add to system prompt
new_system_prompt = f"""You are a helpful AI agent.

{examples_text}

Now, follow the same pattern for new inputs:"""
```

---

## Example 6: Production Monitoring & Reoptimization

```python
from blogkit import optimize
from datetime import datetime, timedelta
import numpy as np

class ProductionMonitor:
    """Monitor production performance and trigger reoptimization"""
    
    def __init__(self, alert_threshold: float = 0.03):
        """
        alert_threshold: Trigger reoptimization if performance drops >3%
        """
        self.alert_threshold = alert_threshold
        self.performance_history = []
        self.baseline_score = None
    
    def log_metric(self, timestamp: datetime, success: bool, 
                   score: float, response_time: float, 
                   error_message: str = None):
        """Log production metric"""
        
        self.performance_history.append({
            "timestamp": timestamp,
            "success": success,
            "score": score,
            "response_time": response_time,
            "error": error_message
        })
    
    def check_degradation(self, window_size: int = 100) -> bool:
        """Detect performance degradation using control chart method"""
        
        if len(self.performance_history) < window_size * 2:
            return False
        
        # Split into baseline and recent
        baseline = self.performance_history[:-window_size]
        recent = self.performance_history[-window_size:]
        
        # Calculate EWMA (Exponentially Weighted Moving Average)
        baseline_scores = [m["score"] for m in baseline if m["success"]]
        recent_scores = [m["score"] for m in recent if m["success"]]
        
        if not baseline_scores or not recent_scores:
            return False
        
        baseline_mean = np.mean(baseline_scores)
        baseline_std = np.std(baseline_scores)
        
        recent_mean = np.mean(recent_scores)
        
        # Z-score
        z_score = (baseline_mean - recent_mean) / (baseline_std + 1e-6)
        
        # Alert if 2-sigma below baseline (>95% confidence degradation)
        if z_score > 2.0:
            print(f"⚠️  Performance degradation detected!")
            print(f"   Baseline: {baseline_mean:.4f}")
            print(f"   Recent:   {recent_mean:.4f}")
            print(f"   Z-score:  {z_score:.2f}")
            return True
        
        return False
    
    def get_failure_patterns(self) -> dict:
        """Analyze failure patterns in recent data"""
        
        recent = self.performance_history[-100:]
        failures = [m for m in recent if not m["success"]]
        
        error_types = {}
        for failure in failures:
            error = failure.get("error", "unknown")
            error_types[error] = error_types.get(error, 0) + 1
        
        return {
            "failure_rate": len(failures) / len(recent),
            "error_types": error_types,
            "recent_scores": [m["score"] for m in recent if m["success"]]
        }
    
    def trigger_reoptimization(self, 
                               current_prompt,
                               collect_recent_failures: bool = True) -> str:
        """Trigger prompt reoptimization"""
        
        print("\n🔄 Triggering reoptimization...")
        
        # Collect recent failures as new training data
        if collect_recent_failures:
            failure_patterns = self.get_failure_patterns()
            print(f"   Failure rate: {failure_patterns['failure_rate']:.1%}")
            print(f"   Top errors: {failure_patterns['error_types']}")
        
        # Run optimization pipeline
        from dspy.teleprompt import MIPROv2
        
        optimizer = MIPROv2(
            metric=self.eval_metric,
            iterations=10,  # Quick reoptimization
            num_candidates=3
        )
        
        print("   Running MIPROv2 optimization...")
        reoptimized = optimizer.compile(
            program=current_prompt,
            trainset=self.get_recent_examples(),
            eval_kwargs={"num_threads": 4}
        )
        
        print("   ✓ Reoptimization complete")
        
        return reoptimized
    
    def get_recent_examples(self, num_recent: int = 50) -> list:
        """Extract recent examples for reoptimization"""
        # Implementation depends on your logging system
        pass
    
    def generate_report(self) -> str:
        """Generate monitoring report"""
        
        recent = self.performance_history[-100:]
        
        report = f"""
📊 Production Monitoring Report
Generated: {datetime.now()}

Performance Summary (Last 100 requests):
- Success Rate: {sum(1 for m in recent if m['success']) / len(recent):.1%}
- Average Score: {np.mean([m['score'] for m in recent if m['success']]):.4f}
- Avg Response Time: {np.mean([m['response_time'] for m in recent]):.2f}s

Error Analysis:
"""
        
        error_types = {}
        for m in recent:
            if not m["success"] and m["error"]:
                error_types[m["error"]] = error_types.get(m["error"], 0) + 1
        
        for error, count in sorted(error_types.items(), 
                                   key=lambda x: x[1], 
                                   reverse=True):
            report += f"  - {error}: {count} occurrences\n"
        
        return report

# Usage in production
monitor = ProductionMonitor()

# Log metrics continuously
def log_agent_execution(result):
    monitor.log_metric(
        timestamp=datetime.now(),
        success=result["success"],
        score=result["score"],
        response_time=result["latency"],
        error_message=result.get("error")
    )
    
    # Check for degradation periodically
    if len(monitor.performance_history) % 100 == 0:
        if monitor.check_degradation():
            # Reoptimize
            improved_prompt = monitor.trigger_reoptimization(
                current_prompt=production_prompt
            )
            
            # Update production after A/B test
            deploy_with_ab_test(improved_prompt)
        
        # Generate report
        print(monitor.generate_report())
```

---

## Example 7: A/B Testing Deployment

```python
from blogkit import optimize
from typing import Callable
import random

class ABTestDeployment:
    """Safe production deployment via A/B testing"""
    
    def __init__(self, experiment_name: str):
        self.name = experiment_name
        self.results = {"control": [], "treatment": []}
    
    def run_ab_test(self, 
                    control_prompt: str,
                    treatment_prompt: str,
                    traffic_split: float = 0.5,
                    eval_fn: Callable = None,
                    min_samples: int = 100) -> dict:
        """Run A/B test comparing two prompts"""
        
        print(f"\n🧪 A/B Test: {self.name}")
        print(f"   Control: Original prompt")
        print(f"   Treatment: Optimized prompt")
        print(f"   Traffic split: {traffic_split*100:.0f}% control, {(1-traffic_split)*100:.0f}% treatment")
        
        # Simulate traffic routing
        request_count = 0
        converged = False
        
        while not converged:
            # Route request
            if random.random() < traffic_split:
                variant = "control"
                prompt = control_prompt
            else:
                variant = "treatment"
                prompt = treatment_prompt
            
            # Execute prompt and record result
            score = eval_fn(prompt)  # Your evaluation
            self.results[variant].append(score)
            
            request_count += 1
            
            # Check convergence
            if min_samples <= len(self.results["control"]) and \
               min_samples <= len(self.results["treatment"]):
                
                converged = self._check_statistical_significance()
            
            if request_count % 50 == 0:
                print(f"   {request_count} requests...")
        
        return self._generate_report()
    
    def _check_statistical_significance(self, 
                                       confidence: float = 0.95) -> bool:
        """Check if difference is statistically significant"""
        
        from scipy import stats
        
        if len(self.results["control"]) < 2 or \
           len(self.results["treatment"]) < 2:
            return False
        
        # Perform t-test
        t_stat, p_value = stats.ttest_ind(
            self.results["treatment"],
            self.results["control"]
        )
        
        return p_value < (1 - confidence)
    
    def _generate_report(self) -> dict:
        """Generate A/B test results report"""
        
        from scipy import stats
        
        control_mean = np.mean(self.results["control"])
        treatment_mean = np.mean(self.results["treatment"])
        
        improvement = (treatment_mean - control_mean) / control_mean * 100
        
        t_stat, p_value = stats.ttest_ind(
            self.results["treatment"],
            self.results["control"]
        )
        
        # Calculate 95% confidence interval
        ci = stats.t.interval(
            0.95,
            len(self.results["treatment"]) - 1,
            loc=treatment_mean,
            scale=stats.sem(self.results["treatment"])
        )
        
        report = {
            "control_mean": control_mean,
            "treatment_mean": treatment_mean,
            "improvement_pct": improvement,
            "p_value": p_value,
            "is_significant": p_value < 0.05,
            "confidence_interval": ci,
            "control_samples": len(self.results["control"]),
            "treatment_samples": len(self.results["treatment"]),
            "recommendation": self._make_recommendation(
                improvement, p_value
            )
        }
        
        return report
    
    def _make_recommendation(self, improvement: float, p_value: float) -> str:
        """Make deployment recommendation"""
        
        if improvement > 5 and p_value < 0.05:
            return "✅ DEPLOY: Significant improvement"
        elif improvement > 2 and p_value < 0.05:
            return "✅ DEPLOY: Meaningful improvement"
        elif improvement > 0 and p_value < 0.10:
            return "⚠️  MARGINAL: Consider deploying carefully"
        else:
            return "❌ REJECT: No significant improvement"

# Usage
ab_test = ABTestDeployment("qa_system_v2")

report = ab_test.run_ab_test(
    control_prompt=original_prompt,
    treatment_prompt=optimized_prompt,
    traffic_split=0.5,
    eval_fn=metric_fn,
    min_samples=200
)

print(f"\n📈 A/B Test Results:")
print(f"   Control: {report['control_mean']:.4f}")
print(f"   Treatment: {report['treatment_mean']:.4f}")
print(f"   Improvement: {report['improvement_pct']:.1f}%")
print(f"   P-value: {report['p_value']:.4f}")
print(f"   Recommendation: {report['recommendation']}")
```

---

## Key Implementation Tips

### 1. Memory & Efficiency
```python
# Use mini-batches during optimization
for batch in batch_iterator(train_set, batch_size=5):
    scores = [eval_metric(program(ex), ex) for ex in batch]
    # Update based on mini-batch, not full dataset
```

### 2. Reproducibility
```python
# Set seeds for consistent results
import random
import numpy as np

random.seed(42)
np.random.seed(42)
dspy.settings.configure(lm=dspy.OpenAI(..., seed=42))
```

### 3. Cost Tracking
```python
# Monitor API costs during optimization
total_cost = 0

for iteration in range(20):
    cost_this_iter = estimate_cost(iteration)
    total_cost += cost_this_iter
    
    if total_cost > BUDGET:
        print(f"Budget exceeded: ${total_cost:.2f}")
        break
```

### 4. Error Handling
```python
# Handle LLM API failures gracefully
max_retries = 3

for attempt in range(max_retries):
    try:
        result = llm.generate(prompt)
        break
    except RateLimitError:
        wait_time = 2 ** attempt
        print(f"Rate limited. Waiting {wait_time}s...")
        time.sleep(wait_time)
```

---

END OF CODE EXAMPLES