
When things fail:


```bash
nvim --headless -c "TSUpdate" -c "sleep 30" -c "qa"
```

# GLIBC too old

```bash
sudo apt install libclang-dev
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tree-sitter-cli

# remove mason installed tree-sitter
# `:lua print(vim.fn.exepath('tree-sitter'))`
rm -rf .local/share/nvim/mason/bin/tree-sitter

```
