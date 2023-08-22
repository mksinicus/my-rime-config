# u.nu: utils
# should be imported before use

use std assert

export def main [] {
  # default function
  assert-pwd
  let msg = date now | date format %F | "Update " + $in
  gacp -m $msg
}

# Git add, commit.
export def gacp [
  --message (-m): string
] {
  assert-pwd
  git diff
  input -s "Press enter to continue, C-c to interrupt"
  git add .
  match ($message | describe) {
    'string' => {git commit -m $message}
    _ => {git commit}
  }
  git push
}
export alias g = gacp

def assert-pwd [] {
  assert (ls -a | '.git' in $in.name)
}