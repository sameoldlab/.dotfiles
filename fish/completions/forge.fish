complete -c forge -n "__fish_use_subcommand" -s h -l help -d 'Print help'
complete -c forge -n "__fish_use_subcommand" -s V -l version -d 'Print version'
complete -c forge -n "__fish_use_subcommand" -f -a "test" -d 'Run the project\'s tests.'
complete -c forge -n "__fish_use_subcommand" -f -a "script" -d 'Run a smart contract as a script, building transactions that can be sent onchain.'
complete -c forge -n "__fish_use_subcommand" -f -a "coverage" -d 'Generate coverage reports.'
complete -c forge -n "__fish_use_subcommand" -f -a "bind" -d 'Generate Rust bindings for smart contracts.'
complete -c forge -n "__fish_use_subcommand" -f -a "build" -d 'Build the project\'s smart contracts.'
complete -c forge -n "__fish_use_subcommand" -f -a "debug" -d 'Debugs a single smart contract as a script.'
complete -c forge -n "__fish_use_subcommand" -f -a "update" -d 'Update one or multiple dependencies.'
complete -c forge -n "__fish_use_subcommand" -f -a "install" -d 'Install one or multiple dependencies.'
complete -c forge -n "__fish_use_subcommand" -f -a "remove" -d 'Remove one or multiple dependencies.'
complete -c forge -n "__fish_use_subcommand" -f -a "remappings" -d 'Get the automatically inferred remappings for the project.'
complete -c forge -n "__fish_use_subcommand" -f -a "verify-contract" -d 'Verify smart contracts on Etherscan.'
complete -c forge -n "__fish_use_subcommand" -f -a "verify-check" -d 'Check verification status on Etherscan.'
complete -c forge -n "__fish_use_subcommand" -f -a "create" -d 'Deploy a smart contract.'
complete -c forge -n "__fish_use_subcommand" -f -a "init" -d 'Create a new Forge project.'
complete -c forge -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions script.'
complete -c forge -n "__fish_use_subcommand" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec.'
complete -c forge -n "__fish_use_subcommand" -f -a "clean" -d 'Remove the build artifacts and cache directories.'
complete -c forge -n "__fish_use_subcommand" -f -a "cache" -d 'Manage the Foundry cache.'
complete -c forge -n "__fish_use_subcommand" -f -a "snapshot" -d 'Create a snapshot of each test\'s gas usage.'
complete -c forge -n "__fish_use_subcommand" -f -a "config" -d 'Display the current config.'
complete -c forge -n "__fish_use_subcommand" -f -a "flatten" -d 'Flatten a source file and all of its imports into one file.'
complete -c forge -n "__fish_use_subcommand" -f -a "fmt" -d 'Formats Solidity source files.'
complete -c forge -n "__fish_use_subcommand" -f -a "inspect" -d 'Get specialized information about a smart contract.'
complete -c forge -n "__fish_use_subcommand" -f -a "upload-selectors" -d 'Uploads abi of given contract to https://sig.eth.samczsun.com function selector database.'
complete -c forge -n "__fish_use_subcommand" -f -a "tree" -d 'Display a tree visualization of the project\'s dependency graph.'
complete -c forge -n "__fish_use_subcommand" -f -a "geiger" -d 'Detects usage of unsafe cheat codes in a foundry project and its dependencies.'
complete -c forge -n "__fish_use_subcommand" -f -a "doc" -d 'Generate documentation for the project.'
complete -c forge -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from test" -s m -l match -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l debug -d 'Run a test in the debugger' -r
complete -c forge -n "__fish_seen_subcommand_from test" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l etherscan-api-key -d 'Set etherscan api key to better decode traces' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from test" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from test" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fuzz-seed -d 'Set seed used to generate randomness during your fuzz runs' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-report -d 'Print a gas report'
complete -c forge -n "__fish_seen_subcommand_from test" -l allow-failure -d 'Exit with code 0 even if a test fails'
complete -c forge -n "__fish_seen_subcommand_from test" -s j -l json -d 'Output test results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from test" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from test" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from test" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from test" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from test" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from test" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from test" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from test" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from test" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from test" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from test" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from test" -s l -l list -d 'List tests instead of running them'
complete -c forge -n "__fish_seen_subcommand_from test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from script" -l target-contract -l tc -d 'The name of the contract you want to run' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s s -l sig -d 'The signature of the function you want to call in the contract, or raw calldata' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s g -l gas-estimate-multiplier -d 'Relative percentage to multiply gas estimates by' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from script" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l skip -d 'Skip building whose names contain SKIP. `test` and `script` are aliases for `.t.sol` and `.s.sol`. (this flag can be used multiple times)' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from script" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s i -l interactives -d 'Open an interactive prompt to enter your private key. Takes a value for the number of keys to enter' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l private-keys -d 'Use the provided private keys.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l private-key -d 'Use the provided private key.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonics -d 'Use the mnemonic phrases or mnemonic files at the specified paths.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-passphrases -d 'Use a BIP39 passphrases for the mnemonic.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-derivation-paths -d 'The wallet derivation path. Works with both --mnemonic-path and hardware wallets.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-indexes -d 'Use the private key from the given mnemonic index. Used with --mnemonic-paths.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l keystore -l keystores -d 'Use the keystore in the given folder or file.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l password -d 'The keystore password. Used with --keystore.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l password-file -d 'The keystore password file path. Used with --keystore.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s a -l froms -d 'The sender account.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l etherscan-api-key -r
complete -c forge -n "__fish_seen_subcommand_from script" -l verifier -d 'Contract verification provider to use `etherscan`, `sourcify` or `blockscout`' -r -f -a "{etherscan	,sourcify	,blockscout	}"
complete -c forge -n "__fish_seen_subcommand_from script" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l with-gas-price -d 'Gas price for legacy transactions, or max fee per gas for EIP1559 transactions.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l delay -d 'Optional delay to apply inbetween verification attempts in seconds.' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l legacy -d 'Use legacy transactions instead of EIP1559 ones. this is auto-enabled for common networks without EIP1559.'
complete -c forge -n "__fish_seen_subcommand_from script" -l broadcast -d 'Broadcasts the transactions.'
complete -c forge -n "__fish_seen_subcommand_from script" -l skip-simulation -d 'Skips on-chain simulation'
complete -c forge -n "__fish_seen_subcommand_from script" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from script" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from script" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from script" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from script" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from script" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from script" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from script" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from script" -l names -d 'Print compiled contract names.'
complete -c forge -n "__fish_seen_subcommand_from script" -l sizes -d 'Print compiled contract sizes.'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from script" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from script" -s l -l ledger -d 'Use a Ledger hardware wallet.'
complete -c forge -n "__fish_seen_subcommand_from script" -s t -l trezor -d 'Use a Trezor hardware wallet.'
complete -c forge -n "__fish_seen_subcommand_from script" -l aws -d 'Use AWS Key Management Service'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from script" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from script" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from script" -l unlocked -d 'Send via `eth_sendTransaction` using the `--sender` argument or `$ETH_FROM` as sender'
complete -c forge -n "__fish_seen_subcommand_from script" -l resume -d 'Resumes submitting transactions that failed or timed-out previously'
complete -c forge -n "__fish_seen_subcommand_from script" -l multi -d 'If present, --resume or --verify will be assumed to be a multi chain deployment.'
complete -c forge -n "__fish_seen_subcommand_from script" -l debug -d 'Open the script in the debugger. Takes precedence over broadcast.'
complete -c forge -n "__fish_seen_subcommand_from script" -l slow -d 'Makes sure a transaction is sent, only after its previous one has been confirmed and succeeded.'
complete -c forge -n "__fish_seen_subcommand_from script" -l verify -d 'If it finds a matching broadcast log, it tries to verify every contract found in the receipts.'
complete -c forge -n "__fish_seen_subcommand_from script" -l json -d 'Output results in JSON format.'
complete -c forge -n "__fish_seen_subcommand_from script" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l report -d 'The report type to use for coverage. This flag can be used multiple times.' -r -f -a "{summary	,lcov	,debug	}"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s m -l match -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from coverage" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from bind" -s b -l bindings-path -d 'Path to where the contract artifacts are stored' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l select -d 'Create bindings only for contracts whose names match the specified filter(s)' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip -d 'Create bindings only for contracts whose names do not match the specified filter(s)' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l crate-name -d 'The name of the Rust crate to generate. This should be a valid crates.io crate name. However, it is not currently validated by this command.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l crate-version -d 'The version of the Rust crate to generate. This should be a standard semver version string. However, it is not currently validated by this command.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from bind" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l select-all -d 'By default all contracts ending with `Test` or `Script` are excluded. This will explicitly generate bindings for all contracts'
complete -c forge -n "__fish_seen_subcommand_from bind" -l module -d 'Generate the bindings as a module instead of a crate'
complete -c forge -n "__fish_seen_subcommand_from bind" -l overwrite -d 'Overwrite existing generated bindings. By default, the command will check that the bindings are correct, and then exit. If --overwrite is passed, it will instead delete and overwrite the bindings.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l single-file -d 'Generate bindings as a single file.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip-cargo-toml -d 'Skip Cargo.toml consistency checks.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip-build -d 'Skips running forge build before generating binding'
complete -c forge -n "__fish_seen_subcommand_from bind" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from bind" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from bind" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from bind" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from build" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from build" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l skip -d 'Skip building whose names contain SKIP. `test` and `script` are aliases for `.t.sol` and `.s.sol`. (this flag can be used multiple times)' -r
complete -c forge -n "__fish_seen_subcommand_from build" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from build" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from build" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from build" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from build" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from build" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from build" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from build" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from build" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from build" -l names -d 'Print compiled contract names.'
complete -c forge -n "__fish_seen_subcommand_from build" -l sizes -d 'Print compiled contract sizes.'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from build" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from debug" -l target-contract -l tc -d 'The name of the contract you want to run' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -s s -l sig -d 'The signature of the function you want to call in the contract, or raw calldata' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from debug" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l debug -d 'Open the script in the debugger'
complete -c forge -n "__fish_seen_subcommand_from debug" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from debug" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from debug" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from debug" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from install" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from install" -l no-git -d 'Install without adding the dependency as a submodule.'
complete -c forge -n "__fish_seen_subcommand_from install" -l no-commit -d 'Do not create a commit.'
complete -c forge -n "__fish_seen_subcommand_from install" -s q -l quiet -d 'Do not print any messages.'
complete -c forge -n "__fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from remove" -l root -d 'The project\'s root path. By default, this is the root directory of the current Git repository or the current working directory if it is not part of a Git repository' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from remappings" -l root -d 'The project\'s root path. By default, this is the root directory of the current Git repository or the current working directory if it is not part of a Git repository' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from remappings" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l constructor-args -d 'The ABI-encoded constructor arguments.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l constructor-args-path -d 'The path to a file containing the constructor arguments.' -r -F
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l compiler-version -d 'The compiler version used to build the smart contract.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l num-of-optimizations -l optimizer-runs -d 'The number of optimization runs used to build the smart contract.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l chain -l chain-id -d 'The chain ID the contract is deployed to.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l delay -d 'Optional delay to apply inbetween verification attempts in seconds.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l verifier -d 'Contract verification provider to use `etherscan`, `sourcify` or `blockscout`' -r -f -a "{etherscan	,sourcify	,blockscout	}"
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l flatten -d 'Flatten the source code before verifying.'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s f -l force -d 'Do not compile the flattened smart contract before verifying (if --flatten is passed).'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l watch -d 'Wait for verification result after submission'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l show-standard-json-input -d 'Prints the standard json compiler input.'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l chain -l chain-id -d 'The chain ID the contract is deployed to.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l delay -d 'Optional delay to apply inbetween verification attempts in seconds.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l etherscan-key -d 'Your Etherscan API key.' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l verifier -d 'Contract verification provider to use `etherscan`, `sourcify` or `blockscout`' -r -f -a "{etherscan	,sourcify	,blockscout	}"
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from create" -l constructor-args -d 'The constructor arguments.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l constructor-args-path -d 'The path to a file containing the constructor arguments.' -r -F
complete -c forge -n "__fish_seen_subcommand_from create" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from create" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l gas-limit -d 'Gas limit for the transaction.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l gas-price -d 'Gas price for legacy transactions, or max fee per gas for EIP1559 transactions.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l priority-gas-price -d 'Max priority fee per gas for EIP1559 transactions.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l value -d 'Ether to send in the transaction.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l nonce -d 'Nonce for the transaction.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l rpc-url -d 'The RPC endpoint.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l etherscan-api-key -r
complete -c forge -n "__fish_seen_subcommand_from create" -l chain -r
complete -c forge -n "__fish_seen_subcommand_from create" -l private-key -d 'Use the provided private key.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic -d 'Use the mnemonic phrase of mnemonic file at the specified path.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-passphrase -d 'Use a BIP39 passphrase for the mnemonic.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-derivation-path -d 'The wallet derivation path. Works with both --mnemonic-path and hardware wallets.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-index -d 'Use the private key from the given mnemonic index. Used with --mnemonic-path.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l keystore -d 'Use the keystore in the given folder or file.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l password -d 'The keystore password. Used with --keystore.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l password-file -d 'The keystore password file path. Used with --keystore.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s f -l from -d 'The sender account.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l verifier -d 'Contract verification provider to use `etherscan`, `sourcify` or `blockscout`' -r -f -a "{etherscan	,sourcify	,blockscout	}"
complete -c forge -n "__fish_seen_subcommand_from create" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l delay -d 'Optional delay to apply inbetween verification attempts in seconds.' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from create" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from create" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from create" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from create" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from create" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from create" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from create" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from create" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from create" -l legacy -d 'Send a legacy transaction instead of an EIP1559 transaction.'
complete -c forge -n "__fish_seen_subcommand_from create" -l flashbots -d 'Use the flashbots RPC URL (https://rpc.flashbots.net)'
complete -c forge -n "__fish_seen_subcommand_from create" -s i -l interactive -d 'Open an interactive prompt to enter your private key.'
complete -c forge -n "__fish_seen_subcommand_from create" -s l -l ledger -d 'Use a Ledger hardware wallet.'
complete -c forge -n "__fish_seen_subcommand_from create" -s t -l trezor -d 'Use a Trezor hardware wallet.'
complete -c forge -n "__fish_seen_subcommand_from create" -l aws -d 'Use AWS Key Management Service'
complete -c forge -n "__fish_seen_subcommand_from create" -l json -d 'Print the deployment information as JSON.'
complete -c forge -n "__fish_seen_subcommand_from create" -l verify -d 'Verify contract after creation.'
complete -c forge -n "__fish_seen_subcommand_from create" -l unlocked -d 'Send via `eth_sendTransaction` using the `--from` argument or `$ETH_FROM` as sender'
complete -c forge -n "__fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from init" -s t -l template -d 'The template to start from.' -r
complete -c forge -n "__fish_seen_subcommand_from init" -l no-git -d 'Do not create a git repository.'
complete -c forge -n "__fish_seen_subcommand_from init" -l no-commit -d 'Do not create an initial commit.'
complete -c forge -n "__fish_seen_subcommand_from init" -s q -l quiet -d 'Do not print any messages.'
complete -c forge -n "__fish_seen_subcommand_from init" -l offline -l no-deps -d 'Do not install dependencies from the network.'
complete -c forge -n "__fish_seen_subcommand_from init" -l force -d 'Create the project even if the specified root directory is not empty.'
complete -c forge -n "__fish_seen_subcommand_from init" -l vscode -d 'Create a .vscode/settings.json file with Solidity settings, and generate a remappings.txt file.'
complete -c forge -n "__fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from generate-fig-spec" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from clean" -l root -d 'The project\'s root path. Defaults to the current working directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from clean" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Cleans cached data from ~/.foundry.'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "ls" -d 'Shows cached data from ~/.foundry.'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -s b -l blocks -r
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -l etherscan
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from ls" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Cleans cached data from ~/.foundry.'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "ls" -d 'Shows cached data from ~/.foundry.'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s m -l match -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l debug -d 'Run a test in the debugger' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l etherscan-api-key -d 'Set etherscan api key to better decode traces' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fuzz-seed -d 'Set seed used to generate randomness during your fuzz runs' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l min -d 'Only include tests that used more gas that the given amount.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l max -d 'Only include tests that used less gas that the given amount.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l diff -d 'Output a diff against a pre-existing snapshot' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l check -d 'Compare against a pre-existing snapshot, exiting with code 1 if they do not match' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l format -d 'How to format the output.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l snap -d 'Output file for the snapshot.' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l tolerance -d 'Tolerates gas deviations up to the specified percentage.' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-report -d 'Print a gas report'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l allow-failure -d 'Exit with code 0 even if a test fails'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s j -l json -d 'Output test results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s l -l list -d 'List tests instead of running them'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l asc -d 'Sort results by gas used (ascending).'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l desc -d 'Sort results by gas used (descending).'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from config" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from config" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l skip -d 'Skip building whose names contain SKIP. `test` and `script` are aliases for `.t.sol` and `.s.sol`. (this flag can be used multiple times)' -r
complete -c forge -n "__fish_seen_subcommand_from config" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from config" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from config" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l chain-id -d 'The chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l memory-limit -d 'The memory limit of the EVM in bytes (32 MB by default)' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l basic -d 'Print only a basic set of the currently set config values.'
complete -c forge -n "__fish_seen_subcommand_from config" -l json -d 'Print currently set config values as JSON.'
complete -c forge -n "__fish_seen_subcommand_from config" -l fix -d 'Attempt to fix any configuration warnings.'
complete -c forge -n "__fish_seen_subcommand_from config" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from config" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from config" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from config" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from config" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from config" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from config" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from config" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from config" -l names -d 'Print compiled contract names.'
complete -c forge -n "__fish_seen_subcommand_from config" -l sizes -d 'Print compiled contract sizes.'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from config" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from config" -l ffi -d 'Enables the FFI cheatcode.'
complete -c forge -n "__fish_seen_subcommand_from config" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node provider.'
complete -c forge -n "__fish_seen_subcommand_from config" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from flatten" -s o -l output -d 'The path to output the flattened contract.' -r -F
complete -c forge -n "__fish_seen_subcommand_from flatten" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from flatten" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from flatten" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from flatten" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from flatten" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from fmt" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from fmt" -l check -d 'run in \'check\' mode. Exits with 0 if input is formatted correctly. Exits with 1 if formatting is required.'
complete -c forge -n "__fish_seen_subcommand_from fmt" -s r -l raw -d 'in \'check\' and stdin modes, outputs raw formatted code instead of diff'
complete -c forge -n "__fish_seen_subcommand_from fmt" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l libraries -d 'Set pre-linked libraries.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l evm-version -d 'The target EVM version.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l optimizer-runs -d 'The number of optimizer runs.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l ignored-error-codes -d 'Ignore solc warnings by error code.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from inspect" -s o -l out -d 'The path to the contract artifacts folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l revert-strings -d 'Revert string configuration. Possible values are "default", "strip" (remove), "debug" (Solidity-generated revert strings) and "verboseDebug"' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l build-info-path -d 'Output path to directory that build info files will be written to.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l pretty -d 'Pretty print the selected field, if supported.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l force -d 'Clear the cache and artifacts folder and recompile.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l optimize -d 'Activate the Solidity optimizer.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l no-auto-detect -d 'Do not auto-detect solc.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l offline -d 'Do not access the network.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l silent -d 'Don\'t print anything on startup.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l build-info -d 'Generate build info files.'
complete -c forge -n "__fish_seen_subcommand_from inspect" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l all -d 'Upload selectors for all contracts in the project.'
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from upload-selectors" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from tree" -l charset -d 'Character set to use in output: utf8, ascii' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -s c -l contracts -d 'The contracts source directory.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -s r -l remappings -d 'The project\'s remappings.' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l remappings-env -d 'The project\'s remappings from the environment.' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l cache-path -d 'The path to the compiler cache.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -l lib-paths -d 'The path to the library folder.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -l config-path -d 'Path to the config file.' -r -F
complete -c forge -n "__fish_seen_subcommand_from tree" -l no-dedupe -d 'Do not de-duplicate (repeats all shared dependencies)'
complete -c forge -n "__fish_seen_subcommand_from tree" -l hardhat -l hh -d 'Use the Hardhat-style project layout.'
complete -c forge -n "__fish_seen_subcommand_from tree" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from geiger" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from geiger" -l ignore -d 'Globs to ignore.' -r -F
complete -c forge -n "__fish_seen_subcommand_from geiger" -l check -d 'run in \'check\' mode. Exits with 0 if no unsafe cheat codes were found. Exits with 1 if unsafe cheat codes are detected.'
complete -c forge -n "__fish_seen_subcommand_from geiger" -l full -d 'print a full report of all files even if no unsafe functions are found.'
complete -c forge -n "__fish_seen_subcommand_from geiger" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from doc" -l root -d 'The project\'s root path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from doc" -s o -l out -d 'The doc\'s output path.' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from doc" -l hostname -d 'Hostname for serving documentation.' -r
complete -c forge -n "__fish_seen_subcommand_from doc" -s p -l port -d 'Port for serving documentation.' -r
complete -c forge -n "__fish_seen_subcommand_from doc" -s b -l build -d 'Build the `mdbook` from generated files.'
complete -c forge -n "__fish_seen_subcommand_from doc" -s s -l serve -d 'Serve the documentation.'
complete -c forge -n "__fish_seen_subcommand_from doc" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "test" -d 'Run the project\'s tests.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "script" -d 'Run a smart contract as a script, building transactions that can be sent onchain.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "coverage" -d 'Generate coverage reports.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "bind" -d 'Generate Rust bindings for smart contracts.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "build" -d 'Build the project\'s smart contracts.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "debug" -d 'Debugs a single smart contract as a script.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "update" -d 'Update one or multiple dependencies.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "install" -d 'Install one or multiple dependencies.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove one or multiple dependencies.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "remappings" -d 'Get the automatically inferred remappings for the project.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "verify-contract" -d 'Verify smart contracts on Etherscan.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "verify-check" -d 'Check verification status on Etherscan.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "create" -d 'Deploy a smart contract.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "init" -d 'Create a new Forge project.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate shell completions script.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Remove the build artifacts and cache directories.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "cache" -d 'Manage the Foundry cache.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "snapshot" -d 'Create a snapshot of each test\'s gas usage.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "config" -d 'Display the current config.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "flatten" -d 'Flatten a source file and all of its imports into one file.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "fmt" -d 'Formats Solidity source files.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "inspect" -d 'Get specialized information about a smart contract.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "upload-selectors" -d 'Uploads abi of given contract to https://sig.eth.samczsun.com function selector database.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "tree" -d 'Display a tree visualization of the project\'s dependency graph.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "geiger" -d 'Detects usage of unsafe cheat codes in a foundry project and its dependencies.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "doc" -d 'Generate documentation for the project.'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from upload-selectors; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls" -f -a "clean" -d 'Cleans cached data from ~/.foundry.'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls" -f -a "ls" -d 'Shows cached data from ~/.foundry.'
