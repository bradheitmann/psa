#!/bin/bash
# Scan projects and build registry

REGISTRY_FILE="${PSA_HOME:-$HOME/.psa}/data/projects-registry.json"
PROJECTS_DIRS=("$HOME/projects" "$HOME/work")

echo "🔍 Scanning projects..."

# Initialize registry
cat > "$REGISTRY_FILE" <<EOF
{
  "lastUpdated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "projects": []
}
EOF

# Find all git projects
for base_dir in "${PROJECTS_DIRS[@]}"; do
  if [[ ! -d "$base_dir" ]]; then
    continue
  fi

  while IFS= read -r git_dir; do
    project_dir=$(dirname "$git_dir")
    project_name=$(basename "$project_dir")

    # Skip if node_modules or other noise
    if [[ "$project_dir" == *"node_modules"* ]] || [[ "$project_dir" == *".git"* ]]; then
      continue
    fi

    echo "  Found: $project_name"

    # Get basic info
    github_url=$(git -C "$project_dir" remote get-url origin 2>/dev/null || echo "")
    last_commit=$(git -C "$project_dir" log -1 --format="%aI" 2>/dev/null || echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ")")

    # Check for PROJECT.json
    if [[ -f "$project_dir/PROJECT.json" ]]; then
      # Merge with existing data
      project_json=$(cat "$project_dir/PROJECT.json")
    else
      # Create minimal entry
      project_json=$(cat <<PROJECT_EOF
{
  "name": "$project_name",
  "displayName": "$project_name",
  "status": "active",
  "type": "unknown",
  "progress": 0,
  "path": "$project_dir",
  "github": "$github_url",
  "lastCommit": "$last_commit"
}
PROJECT_EOF
)
    fi

    # Append to registry
    tmp_file=$(mktemp)
    jq --argjson project "$project_json" '.projects += [$project]' "$REGISTRY_FILE" > "$tmp_file"
    mv "$tmp_file" "$REGISTRY_FILE"

  done < <(find "$base_dir" -maxdepth 3 -type d -name ".git" 2>/dev/null)
done

# Sort by name
tmp_file=$(mktemp)
jq '.projects |= sort_by(.name)' "$REGISTRY_FILE" > "$tmp_file"
mv "$tmp_file" "$REGISTRY_FILE"

echo "✅ Registry created: $REGISTRY_FILE"
echo "   Found $(jq '.projects | length' "$REGISTRY_FILE") projects"
