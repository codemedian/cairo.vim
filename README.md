# cairo.vim

> A [Cairo lang](https://www.cairo-lang.org/) plugin for Vim

## Install with Plug

```vim
Plug 'codemedian/cairo.vim'
```

## Combine with Cairo language server when using COC

Check out the cairo 1.0 project https://github.com/starkware-libs/cairo and build their language server as instructed [here](https://github.com/starkware-libs/cairo#install-the-language-server)

Once built, you'll find the binary in the `target/release` directory. To make it work with COC, specify the binary as illustrated below
```
{
    "languageserver": {
        "cairo": {
            "command": "<YOUR_PROJECT_PATH>/cairo/target/release/cairo-language-server",
            "rootPatterns": [".git/", "hardhat.config.ts"],
            "trace.server": "verbose",
            "filetypes": ["cairo"]
       }
    }
}
```

## License

[MIT](LICENSE)
