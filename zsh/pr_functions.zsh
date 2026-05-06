
pr_merged_local_branches() {
  command -v gh >/dev/null || { echo 'gh CLI is required'; return 1; }

  local current limit
  current="$(git branch --show-current)"
  limit="${1:-1000}"

  if [[ -n "$current" ]]; then
    comm -12 \
      <(git for-each-ref --format='%(refname:short)' refs/heads | sort) \
      <(gh pr list --state merged --limit "$limit" --json headRefName --jq '.[].headRefName' | sort -u) \
      | grep -vxE 'main|master|develop' \
      | grep -Fxv "$current"
  else
    comm -12 \
      <(git for-each-ref --format='%(refname:short)' refs/heads | sort) \
      <(gh pr list --state merged --limit "$limit" --json headRefName --jq '.[].headRefName' | sort -u) \
      | grep -vxE 'main|master|develop'
  fi
}

pr_delete_merged_local_branches() {
  local branches
  branches="$(pr_merged_local_branches "$@")" || return 1
  [[ -z "$branches" ]] && { echo 'No local branches with merged PRs.'; return 0; }

  printf '%s\n' "$branches"
  echo
  read -q "REPLY?Delete these branches? [y/N] "
  echo
  [[ "$REPLY" == [Yy] ]] || return 0

  printf '%s\n' "$branches" | while IFS= read -r b; do
  git branch -D "$b"
  done
}

ghprs () {
  local url

  url="$(gh api graphql -f query='
  {
  search(query: "org:zeroheight is:pr is:open draft:false  -author:@me -review:approved -review:changes_requested", type: ISSUE, first: 100) {
    nodes {
      ... on PullRequest {
        title
        number
        url
        author {
          login
        }
        createdAt
        repository {
          name
        }
      }
    }
  }
}' --jq '.data.search.nodes | sort_by(.createdAt) | reverse[] | [.author.login, .repository.name, .title, .url] | @tsv' \
    | gum table --separator $'\t' --columns "Author,Repo,Title,URL" --return-column 4)"

  [[ -n "$url" ]] && gh pr view --web "$url"
}
