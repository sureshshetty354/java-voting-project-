
package com.example.voting;

import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@RestController
public class VotingController {

    private final Map<String, AtomicInteger> votes =
        new ConcurrentHashMap<>();

    public VotingController() {
        votes.put("Java", new AtomicInteger(0));
        votes.put("Python", new AtomicInteger(0));
        votes.put("JavaScript", new AtomicInteger(0));
    }

    @PostMapping("/api/vote")
    public Map<String, String> vote(@RequestParam String option) {

        AtomicInteger count = votes.get(option);

        if (count == null) {
            throw new IllegalArgumentException("Invalid voting option");
        }

        count.incrementAndGet();

        return Map.of(
            "message", "Your vote was submitted!",
            "option", option
        );
    }

    @GetMapping("/api/results")
    public Map<String, Integer> results() {

        Map<String, Integer> result = new ConcurrentHashMap<>();

        votes.forEach((key, value) ->
            result.put(key, value.get())
        );

        return result;
    }

    @GetMapping("/health")
    public Map<String, String> health() {
        return Map.of("status", "UP");
    }
}
