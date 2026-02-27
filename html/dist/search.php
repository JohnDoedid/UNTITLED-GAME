<?php
$q = $_GET['q'] ?? '';

/*
    === SPECIAL KEYWORDS DETECTION ===
    Replace "secretword" or "anotherword" with whatever triggers custom HTML
*/

if ($q === "secretword") {
    // Replace entire page HTML
    echo <<<HTML
HTML;
    exit; // Stop further PHP execution
}
else if ($q === "anotherword") {
    echo <<<HTML
HTML;
    exit;
}
else {
    // Default search results (normal forum search)
    echo "<h1>Search Results for: " . htmlspecialchars($q) . "</h1>";
    // Example: fetch posts from database matching $q
}
?>
