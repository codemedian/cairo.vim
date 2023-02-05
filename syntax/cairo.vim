" Vim syntax file
"
" Language: CAIRO

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "cairo"

syntax region cairoTypeParams matchgroup=cairoDelimiter start='<' end='>' keepend contains=TOP

"
" Variables
"

syntax match cairoUserIdent '\v[a-z][a-z0-9_]*'

"
" Module
"

syntax match cairoModule '\v(::)@<=[a-z][a-z0-9_]*'
syntax match cairoModule '\v[a-z][a-z0-9_]*(::)@='

"
" Conditionals
"

syntax keyword cairoElse else
syntax keyword cairoIf if
syntax keyword cairoMatch match

highlight default link cairoElse cairoConditional
highlight default link cairoIf cairoConditional
highlight default link cairoMatch cairoConditional

"
" Repeat
"

syntax keyword cairoFor for
syntax keyword cairoLoop loop
syntax keyword cairoWhile while

highlight default link cairoFor cairoRepeat
highlight default link cairoLoop cairoRepeat
highlight default link cairoWhile cairoRepeat

"
" Includes
"

syntax keyword cairoUse use
highlight default link cairoUse cairoInclude

"
" Other keywords
"

syntax keyword cairoAs as
syntax keyword cairoAsync async
syntax keyword cairoAwait await
syntax keyword cairoBreak break
syntax keyword cairoConst const nextgroup=cairoIdentDef,cairoUnusedIdentDef skipwhite skipempty
syntax keyword cairoContinue continue
syntax keyword cairoCrate crate
syntax keyword cairoDyn dyn
syntax keyword cairoEnum enum nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoExtern extern
syntax keyword cairoFn fn nextgroup=cairoFuncDef,cairoUnusedFuncDef skipwhite skipempty
syntax keyword cairoImpl impl nextgroup=cairoTypeDefParams
syntax keyword cairoIn in
syntax keyword cairoLet let nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoMut,cairoRef,cairoPattern skipwhite skipempty
syntax keyword cairoMod mod
syntax keyword cairoMove move
syntax keyword cairoMut mut nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoLibraryType,cairoSelfType,cairoSelfValue,cairoUserType skipwhite skipempty
syntax keyword cairoPub pub
syntax keyword cairoRef ref nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoMut skipwhite skipempty
syntax keyword cairoReturn return
syntax keyword cairoSelfType Self
syntax keyword cairoSelfValue self
syntax keyword cairoStatic static nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoRef skipwhite skipempty
syntax keyword cairoStruct struct nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoSuper super
syntax keyword cairoTrait trait nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoTypeAlias type nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoUndecairocore _
syntax keyword cairoUnion union nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoUnsafe unsafe
syntax keyword cairoWhere where

highlight default link cairoAs cairoKeyword
highlight default link cairoAsync cairoKeyword
highlight default link cairoAwait cairoKeyword
highlight default link cairoBreak cairoKeyword
highlight default link cairoConst cairoKeyword
highlight default link cairoContinue cairoKeyword
highlight default link cairoCrate cairoKeyword
highlight default link cairoDyn cairoKeyword
highlight default link cairoEnum cairoKeyword
highlight default link cairoExtern cairoKeyword
highlight default link cairoFn cairoKeyword
highlight default link cairoImpl cairoKeyword
highlight default link cairoIn cairoKeyword
highlight default link cairoLet cairoKeyword
highlight default link cairoMod cairoKeyword
highlight default link cairoMove cairoKeyword
highlight default link cairoMut cairoKeyword
highlight default link cairoPub cairoKeyword
highlight default link cairoRef cairoKeyword
highlight default link cairoReturn cairoKeyword
highlight default link cairoSelfType cairoKeyword
highlight default link cairoSelfValue cairoKeyword
highlight default link cairoStatic cairoKeyword
highlight default link cairoStruct cairoKeyword
highlight default link cairoSuper cairoKeyword
highlight default link cairoTrait cairoKeyword
highlight default link cairoTypeAlias cairoKeyword
highlight default link cairoUndecairocore cairoKeyword
highlight default link cairoUnion cairoKeyword
highlight default link cairoUnsafe cairoKeyword
highlight default link cairoWhere cairoKeyword

"
" Booleans
"

syntax keyword cairoTrue true
syntax keyword cairoFalse false

highlight default link cairoTrue cairoBoolean
highlight default link cairoFalse cairoBoolean

"
" Strings
"

syntax region cairoString
            \ matchgroup=cairoQuote
            \ start='b\?"'
            \ skip='\\"'
            \ end='"'
            \ contains=@Spell

"
" Field access
"

syntax match cairoFieldAccess '\v(\.)@<=[a-z][a-z0-9_]*>(\()@!'

"
" Helpecairo for matching foreign and crate-local items
"

" Foreign items are always preceded by zero or more type names separated by ‘::’
" (think nested enum variants) and at least one module path. This module path is
" preceded by a word separator to prevent matching partially on type names (i.e.
" skipping the instal capital letter).
function! MatchForeign(regex, groupName, extraParams)
    execute 'syntax match ' . a:groupName . ' "\v(<[a-z][a-z0-9_]*::([A-Z][A-Za-z0-9]*::)*)@<=' . a:regex . '"' . a:extraParams
endfunction

" Crate-local items are also preceded by zero or more types names separated by
" ‘::’, which is then preceded by zero or more module names separated by ‘::’,
" which is finally preceded by ‘crate::’.
function! MatchCrateLocal(regex, groupName, extraParams)
    execute 'syntax match ' . a:groupName . ' "\v(crate::([a-z][a-z0-9_]*::)*([A-Z][A-Za-z0-9]*::)*)@<=' . a:regex . '"' . a:extraParams
endfunction

"
" Types
"

syntax match cairoUserType '\v<[A-Z][A-Za-z0-9]*' nextgroup=cairoTypeParams
call MatchForeign('[A-Z][A-Za-z0-9]*', 'cairoForeignType', ' nextgroup=cairoTypeParams')
call MatchCrateLocal('[A-Z][A-Za-z0-9]*', 'cairoCrateType', ' nextgroup=cairoTypeParams')

" Standard library types

let s:standardLibraryTypes = ["AccessError", "AcqRel", "Acquire", "Add", "AddAssign", "AddrInUse", "AddrNotAvailable", "AddrPacairoeError", "AdminLocal", "Alignment", "Alloc", "AllocErr", "AllocError", "AlreadyExists", "Ancestocairo", "Any", "Arc", "Args", "ArgsOs", "Arguments", "AsMut", "AsRawFd", "AsRawHandle", "AsRawSocket", "AsRef", "AsciiExt", "AssertUnwindSafe", "AtomicBool", "AtomicI16", "AtomicI32", "AtomicI64", "AtomicI8", "AtomicIsize", "AtomicPtr", "AtomicU16", "AtomicU32", "AtomicU64", "AtomicU8", "AtomicUsize", "BTreeMap", "BTreeSet", "Backtrace", "BacktraceStatus", "Barrier", "BarrierWaitResult", "Binary", "BinaryHeap", "BitAnd", "BitAndAssign", "BitOr", "BitOrAssign", "BitXor", "BitXorAssign", "Borrow", "BorrowError", "BorrowMut", "BorrowMutError", "Borrowed", "Both", "Bound", "Box", "BrokenPipe", "BufRead", "BufReader", "BufWriter", "BuildHasher", "BuildHasherDefault", "Builder", "Bytes", "CStr", "CString", "CannotReallocInPlace", "CapacityOverflow", "Captured", "Cell", "Center", "Chain", "CharIndices", "CharPredicateSearcher", "CharSearcher", "CharSliceSearcher", "CharTryFromError", "Chacairo", "Child", "ChildStderr", "ChildStdin", "ChildStdout", "Chunks", "ChunksExact", "ChunksExactMut", "ChunksMut", "Clone", "Cloned", "CoerceUnsized", "Command", "CommandExt", "Complete", "Component", "Components", "Concat", "Condvar", "ConnectionAborted", "ConnectionRefused", "ConnectionReset", "Context", "Copied", "Copy", "Cow", "CurDir", "Current", "Cucairoor", "Cycle", "Debug", "DebugList", "DebugMap", "DebugSet", "DebugStruct", "DebugTuple", "DecodeUtf16", "DecodeUtf16Error", "Default", "DefaultHasher", "Deref", "DerefMut", "DeviceNS", "Difference", "DirBuilder", "DirBuilderExt", "DirEntry", "DirEntryExt", "Disabled", "Disconnected", "Discriminant", "Disk", "DispatchFromDyn", "Display", "Div", "DivAssign", "Done", "DoubleEndedIterator", "DoubleEndedSearcher", "Drain", "DrainFilter", "DrainSorted", "Drop", "Duration", "Empty", "EncodeUtf16", "EncodeWide", "End", "Entry", "Enumerate", "Eq", "Equal", "Err", "ErrorKind", "EscapeDebug", "EscapeDefault", "EscapeUnicode", "ExactSizeIterator", "Excess", "Excluded", "ExitCode", "ExitStatus", "ExitStatusExt", "Extend", "File", "FileExt", "FileType", "FileTypeExt", "Filter", "FilterMap", "FixedSizeArray", "FlatMap", "Flatten", "FloatToInt", "Fn", "FnMut", "FnOnce", "Formatter", "FpCategory", "From", "FromBytesWithNulError", "FromFn", "FromIterator", "FromRawFd", "FromRawHandle", "FromRawSocket", "FromStr", "FromUtf16Error", "FromUtf8Error", "Full", "Fuse", "FusedIterator", "Future", "Generator", "GeneratorState", "Global", "GlobalAlloc", "Greater", "HANDLE", "Hash", "HashMap", "HashSet", "Hasher", "Included", "Incoming", "Index", "IndexMut", "Infallible", "Infinite", "Initializer", "Inspect", "Instant", "IntErrorKind", "InterfaceLocal", "Interrupted", "Intecairoection", "Into", "IntoInnerError", "IntoIter", "IntoIterSorted", "IntoIterator", "IntoRawFd", "IntoRawHandle", "IntoRawSocket", "IntoStringError", "InvalidData", "InvalidDigit", "InvalidInput", "IoSlice", "IoSliceMut", "IpAddr", "Ipv4Addr", "Ipv6Addr", "Ipv6MulticastScope", "Iter", "IterMut", "Iterator", "Join", "JoinHandle", "JoinHandleExt", "JoinPathsError", "Keys", "Layout", "LayoutErr", "Left", "LengthAtMost32", "Less", "LineWriter", "Lines", "LinesAny", "LinkLocal", "LinkedList", "LocalKey", "Location", "LockResult", "LowerExp", "LowerHex", "ManuallyDrop", "Map", "Match", "MatchIndices", "Matches", "MaybeUninit", "Metadata", "MetadataExt", "Mul", "MulAssign", "Mutex", "MutexGuard", "Nan", "Neg", "NonNull", "NonZeroI128", "NonZeroI16", "NonZeroI32", "NonZeroI64", "NonZeroI8", "NonZeroIsize", "NonZeroU128", "NonZeroU16", "NonZeroU32", "NonZeroU64", "NonZeroU8", "NonZeroUsize", "None", "NoneError", "Normal", "Not", "NotConnected", "NotFound", "NotPresent", "NotUnicode", "NulError", "Occupied", "OccupiedEntry", "Octal", "Ok", "Once", "OnceState", "OnceWith", "OpenOptions", "OpenOptionsExt", "Option", "Ord", "Ordering", "OrganizationLocal", "OsStr", "OsStrExt", "OsString", "OsStringExt", "Other", "Output", "Overflow", "Owned", "PanicInfo", "ParentDir", "PacairoeBoolError", "PacairoeCharError", "PacairoeError", "PacairoeFloatError", "PacairoeIntError", "PartialEq", "PartialOrd", "Path", "PathBuf", "Pattern", "PeekMut", "Peekable", "Pending", "PermissionDenied", "Permissions", "PermissionsExt", "PhantomData", "PhantomPinned", "Pin", "Pointer", "PoisonError", "Poisoned", "Poll", "Prefix", "PrefixComponent", "Product", "RChunks", "RChunksExact", "RChunksExactMut", "RChunksMut", "RMatchIndices", "RMatches", "RSplit", "RSplitMut", "RSplitN", "RSplitNMut", "RSplitTerminator", "RandomState", "Range", "RangeBounds", "RangeFrom", "RangeFull", "RangeInclusive", "RangeMut", "RangeTo", "RangeToInclusive", "RawEntryBuilder", "RawEntryBuilderMut", "RawEntryMut", "RawFd", "RawHandle", "RawOccupiedEntryMut", "RawPthread", "RawSocket", "RawVacantEntryMut", "RawWaker", "RawWakerVTable", "Rc", "Read", "ReadDir", "Ready", "RealmLocal", "Receiver", "RecvError", "RecvTimeoutError", "Ref", "RefCell", "RefMut", "RefUnwindSafe", "Reject", "Relaxed", "Release", "Rem", "RemAssign", "Repeat", "RepeatWith", "Result", "Rev", "Revecairoe", "RevecairoeSearcher", "Right", "RootDir", "RwLock", "RwLockReadGuard", "RwLockWriteGuard", "SOCKET", "Scan", "SearchStep", "Searcher", "Seek", "SeekFrom", "Send", "SendError", "Sender", "SeqCst", "Shl", "ShlAssign", "Shr", "ShrAssign", "Shutdown", "Sink", "SipHasher", "SiteLocal", "Sized", "Skip", "SkipWhile", "SliceIndex", "SocketAddr", "SocketAddrV4", "SocketAddrV6", "Some", "Splice", "Split", "SplitAsciiWhitespace", "SplitMut", "SplitN", "SplitNMut", "SplitPaths", "SplitTerminator", "SplitWhitespace", "Start", "Stderr", "StderrLock", "Stdin", "StdinLock", "Stdio", "Stdout", "StdoutLock", "Step", "StepBy", "StrSearcher", "String", "StripPrefixError", "StructuralEq", "StructuralPartialEq", "Sub", "SubAssign", "Subnormal", "Successocairo", "Sum", "SymmetricDifference", "Sync", "SyncSender", "System", "SystemTime", "SystemTimeError", "Take", "TakeWhile", "TcpListener", "TcpStream", "Termination", "Thread", "ThreadId", "TimedOut", "Timeout", "ToLowercase", "ToOwned", "ToSocketAddcairo", "ToString", "ToUppercase", "TraitObject", "TrustedLen", "Try", "TryFrom", "TryFromIntError", "TryFromSliceError", "TryInto", "TryIter", "TryLockError", "TryLockResult", "TryRecvError", "TryReserveError", "TrySendError", "TypeId", "UNC", "UdpSocket", "Unbounded", "Underflow", "UnexpectedEof", "UnicodeVecairoion", "Union", "UnixDatagram", "UnixListener", "UnixStream", "Unpin", "UnsafeCell", "Unsize", "Unsupported", "UnwindSafe", "UpperExp", "UpperHex", "Utf8Error", "V4", "V6", "VaList", "VaListImpl", "Vacant", "VacantEntry", "Values", "ValuesMut", "VarError", "Vacairo", "VacairoOs", "Vec", "VecDeque", "Verbatim", "VerbatimDisk", "VerbatimUNC", "WaitTimeoutResult", "Waker", "Weak", "TokenStream", "Windows", "WouldBlock", "Wrapping", "Write", "WriteZero", "Yielded", "Zero", "Zip", "blkcnt_t", "blksize_t", "bool", "c_char", "c_double", "c_float", "c_int", "c_long", "c_longlong", "c_schar", "c_short", "c_uchar", "c_uint", "c_ulong", "c_ulonglong", "c_ushort", "char", "dev_t", "f32", "f64", "gid_t", "i128", "i16", "i32", "i64", "i8", "ino_t", "isize", "mode_t", "nlink_t", "off_t", "pid_t", "pthread_t", "str", "time_t", "u128", "u16", "u32", "u64", "u8", "uid_t", "usize"]

for s:standardLibraryType in s:standardLibraryTypes
    execute 'syntax keyword cairoLibraryType ' . s:standardLibraryType . ' nextgroup=cairoTypeParams'
endfor

"
" Constants
"

syntax match cairoUserConst '\v<[A-Z][A-Z0-9_]+>'
call MatchForeign('[A-Z][A-Z0-9_]+>', 'cairoForeignConst', '')
call MatchCrateLocal('[A-Z][A-Z0-9_]+>', 'cairoCrateConst', '')

" Standard library constants

let s:standardLibraryConsts = ["ARCH", "ATOMIC_BOOL_INIT", "ATOMIC_I16_INIT", "ATOMIC_I32_INIT", "ATOMIC_I64_INIT", "ATOMIC_I8_INIT", "ATOMIC_ISIZE_INIT", "ATOMIC_U16_INIT", "ATOMIC_U32_INIT", "ATOMIC_U64_INIT", "ATOMIC_U8_INIT", "ATOMIC_USIZE_INIT", "DIGITS", "DLL_EXTENSION", "DLL_PREFIX", "DLL_SUFFIX", "EPSILON", "EXE_EXTENSION", "EXE_SUFFIX", "FAMILY", "FRAC_1_PI", "FRAC_1_SQRT_2", "FRAC_2_PI", "FRAC_2_SQRT_PI", "FRAC_PI_2", "FRAC_PI_3", "FRAC_PI_4", "FRAC_PI_6", "FRAC_PI_8", "INFINITY", "LN_10", "LN_2", "LOG10_2", "LOG10_E", "LOG2_10", "LOG2_E", "MAIN_SEPARATOR", "MANTISSA_DIGITS", "MAX", "MAX_10_EXP", "MAX_EXP", "MIN", "MIN_10_EXP", "MIN_EXP", "MIN_POSITIVE", "NAN", "NEG_INFINITY", "ONCE_INIT", "OS", "PI", "RADIX", "REPLACEMENT_CHARACTER", "SQRT_2", "TAU", "UNICODE_VERSION", "UNIX_EPOCH"]

for s:standardLibraryConst in s:standardLibraryConsts
    execute 'syntax keyword cairoLibraryConst ' . s:standardLibraryConst
endfor

"
" Macros
"

syntax match cairoUserMacro '\v<[a-z][a-z0-9_]*!'
call MatchForeign('[a-z][a-z0-9_]*!', 'cairoForeignMacro', '')
call MatchCrateLocal('[a-z][a-z0-9_]*!', 'cairoCrateMacro', '')

" Standard library macros

let s:standardLibraryMacros = ["asm", "assert", "assert_eq", "assert_ne", "cfg", "column", "compile_error", "concat", "concat_idents", "dbg", "debug_assert", "debug_assert_eq", "debug_assert_ne", "env", "eprint", "eprintln", "file", "format", "format_args", "format_args_nl", "global_asm", "include", "include_bytes", "include_str", "is_aarch64_feature_detected", "is_arm_feature_detected", "is_mips64_feature_detected", "is_mips_feature_detected", "is_powerpc64_feature_detected", "is_powerpc_feature_detected", "is_x86_feature_detected", "line", "log_syntax", "matches", "module_path", "option_env", "panic", "print", "println", "stringify", "thread_local", "todo", "trace_macros", "try", "unimplemented", "unreachable", "vec", "write", "writeln"]

for s:standardLibraryMacro in s:standardLibraryMacros
    execute 'syntax match cairoLibraryMacro "\v<' . s:standardLibraryMacro . '!"'
endfor

"
" Functions
"

syntax match cairoUserFunc '\v[a-z][a-z0-9_]*(\()@='

call MatchForeign('[a-z][a-z0-9_]*(\()@=', 'cairoForeignFunc', '')
call MatchCrateLocal('[a-z][a-z0-9_]*(\()@=', 'cairoCrateFunc', '')

syntax match cairoUserMethod '\v(\.)@<=[a-z][a-z0-9_]*(\(|::)@='
highlight default link cairoUserMethod cairoUserFunc

" Standard library functions

let s:standardLibraryFuncs = ["abort", "add_with_overflow", "align_of", "align_of_val", "alloc", "alloc_zeroed", "args", "args_os", "arith_offset", "assume", "atomic_and", "atomic_and_acq", "atomic_and_acqrel", "atomic_and_rel", "atomic_and_relaxed", "atomic_cxchg", "atomic_cxchg_acq", "atomic_cxchg_acq_failrelaxed", "atomic_cxchg_acqrel", "atomic_cxchg_acqrel_failrelaxed", "atomic_cxchg_failacq", "atomic_cxchg_failrelaxed", "atomic_cxchg_rel", "atomic_cxchg_relaxed", "atomic_cxchgweak", "atomic_cxchgweak_acq", "atomic_cxchgweak_acq_failrelaxed", "atomic_cxchgweak_acqrel", "atomic_cxchgweak_acqrel_failrelaxed", "atomic_cxchgweak_failacq", "atomic_cxchgweak_failrelaxed", "atomic_cxchgweak_rel", "atomic_cxchgweak_relaxed", "atomic_fence", "atomic_fence_acq", "atomic_fence_acqrel", "atomic_fence_rel", "atomic_load", "atomic_load_acq", "atomic_load_relaxed", "atomic_load_unordered", "atomic_max", "atomic_max_acq", "atomic_max_acqrel", "atomic_max_rel", "atomic_max_relaxed", "atomic_min", "atomic_min_acq", "atomic_min_acqrel", "atomic_min_rel", "atomic_min_relaxed", "atomic_nand", "atomic_nand_acq", "atomic_nand_acqrel", "atomic_nand_rel", "atomic_nand_relaxed", "atomic_or", "atomic_or_acq", "atomic_or_acqrel", "atomic_or_rel", "atomic_or_relaxed", "atomic_singlethreadfence", "atomic_singlethreadfence_acq", "atomic_singlethreadfence_acqrel", "atomic_singlethreadfence_rel", "atomic_store", "atomic_store_rel", "atomic_store_relaxed", "atomic_store_unordered", "atomic_umax", "atomic_umax_acq", "atomic_umax_acqrel", "atomic_umax_rel", "atomic_umax_relaxed", "atomic_umin", "atomic_umin_acq", "atomic_umin_acqrel", "atomic_umin_rel", "atomic_umin_relaxed", "atomic_xadd", "atomic_xadd_acq", "atomic_xadd_acqrel", "atomic_xadd_rel", "atomic_xadd_relaxed", "atomic_xchg", "atomic_xchg_acq", "atomic_xchg_acqrel", "atomic_xchg_rel", "atomic_xchg_relaxed", "atomic_xor", "atomic_xor_acq", "atomic_xor_acqrel", "atomic_xor_rel", "atomic_xor_relaxed", "atomic_xsub", "atomic_xsub_acq", "atomic_xsub_acqrel", "atomic_xsub_rel", "atomic_xsub_relaxed", "bitrevecairoe", "black_box", "breakpoint", "bswap", "caller_location", "canonicalize", "catch_unwind", "ceilf32", "ceilf64", "channel", "compiler_fence", "copy", "copy_nonoverlapping", "copysignf32", "copysignf64", "cosf32", "cosf64", "create_dir", "create_dir_all", "ctlz", "ctlz_nonzero", "ctpop", "cttz", "cttz_nonzero", "current", "current_dir", "current_exe", "dealloc", "decode_utf16", "discriminant", "discriminant_value", "drop", "drop_in_place", "empty", "eq", "escape_default", "exact_div", "exit", "exp2f32", "exp2f64", "expf32", "expf64", "fabsf32", "fabsf64", "fadd_fast", "fdiv_fast", "fence", "float_to_int_approx_unchecked", "floorf32", "floorf64", "fmaf32", "fmaf64", "fmul_fast", "forget", "forget_unsized", "format", "frem_fast", "from_boxed_utf8_unchecked", "from_digit", "from_fn", "from_mut", "from_raw_parts", "from_raw_parts_mut", "from_ref", "from_u32", "from_u32_unchecked", "from_utf8", "from_utf8_mut", "from_utf8_unchecked", "from_utf8_unchecked_mut", "fsub_fast", "handle_alloc_error", "hard_link", "hash", "home_dir", "id", "identity", "init", "is_separator", "join_paths", "likely", "log10f32", "log10f64", "log2f32", "log2f64", "logf32", "logf64", "max", "max_by", "max_by_key", "maxnumf32", "maxnumf64", "metadata", "min", "min_align_of", "min_align_of_val", "min_by", "min_by_key", "minnumf32", "minnumf64", "miri_start_panic", "move_val_init", "mul_with_overflow", "nearbyintf32", "nearbyintf64", "needs_drop", "nontemporal_store", "null", "null_mut", "offset", "once", "once_with", "panic_if_uninhabited", "panicking", "parent_id", "park", "park_timeout", "park_timeout_ms", "powf32", "powf64", "powif32", "powif64", "pref_align_of", "prefetch_read_data", "prefetch_read_instruction", "prefetch_write_data", "prefetch_write_instruction", "ptr_offset_from", "read", "read_dir", "read_link", "read_to_string", "read_unaligned", "read_volatile", "realloc", "remove_dir", "remove_dir_all", "remove_file", "remove_var", "rename", "repeat", "repeat_with", "replace", "resume_unwind", "rintf32", "rintf64", "rotate_left", "rotate_right", "roundf32", "roundf64", "rustc_peek", "saturating_add", "saturating_sub", "set_alloc_error_hook", "set_current_dir", "set_hook", "set_permissions", "set_var", "sinf32", "sinf64", "sink", "size_of", "size_of_val", "sleep", "sleep_ms", "slice_from_raw_parts", "slice_from_raw_parts_mut", "soft_link", "spawn", "spin_loop", "spin_loop_hint", "split_paths", "sqrtf32", "sqrtf64", "stderr", "stdin", "stdout", "sub_with_overflow", "successocairo", "swap", "swap_nonoverlapping", "symlink", "symlink_dir", "symlink_file", "symlink_metadata", "sync_channel", "take", "take_alloc_error_hook", "take_hook", "temp_dir", "transmute", "transmute_copy", "truncf32", "truncf64", "try", "type_id", "type_name", "type_name_of_val", "unaligned_volatile_load", "unaligned_volatile_store", "unchecked_add", "unchecked_div", "unchecked_mul", "unchecked_rem", "unchecked_shl", "unchecked_shr", "unchecked_sub", "uninit", "uninitialized", "unlikely", "unreachable", "unreachable_unchecked", "var", "var_os", "vacairo", "vacairo_os", "volatile_copy_memory", "volatile_copy_nonoverlapping_memory", "volatile_load", "volatile_set_memory", "volatile_store", "wrapping_add", "wrapping_mul", "wrapping_sub", "write", "write_bytes", "write_unaligned", "write_volatile", "yield_now", "zeroed"]

for s:standardLibraryFunc in s:standardLibraryFuncs
    execute 'syntax match cairoLibraryFunc "\v'. s:standardLibraryFunc . '(\()@="'
endfor

"
" Lifetimes
"

syntax match cairoUserLifetime "'[a-z][a-z0-9_]*"

syntax match cairoInferredLifetime "'_"
syntax match cairoStaticLifetime "'static"

highlight default link cairoInferredLifetime cairoSpecialLifetime
highlight default link cairoStaticLifetime cairoSpecialLifetime

"
" Type definitions
"

syntax match cairoTypeDef '\v[A-Z][A-Za-z0-9]*'
            \ contained
            \ nextgroup=cairoTypeDefParams

syntax match cairoUnusedTypeDef '\v_[A-Za-z0-9]+'
            \ contained
            \ nextgroup=cairoTypeDefParams

highlight default link cairoUnusedTypeDef cairoTypeDef

" Type parametecairo
syntax region cairoTypeDefParams
            \ matchgroup=cairoDelimiter
            \ start='<'
            \ end='>'
            \ keepend
            \ contains=TOP

syntax match cairoTypeParamDef '\v(:\s*)@<![A-Z][A-Za-z0-9]*'
            \ contained
            \ containedin=cairoTypeDefParams

highlight default link cairoTypeParamDef cairoTypeDef

"
" Function definitions
"

syntax match cairoFuncDef '\v<[a-z][a-z0-9_]*'
            \ contained
            \ nextgroup=cairoTypeDefParams

syntax match cairoUnusedFuncDef '\v<_[a-z0-9_]+'
            \ contained
            \ nextgroup=cairoTypeDefParams

highlight default link cairoUnusedFuncDef cairoFuncDef

"
" Identifier definitions
"

syntax match cairoIdentDef '\v<[a-z][a-z0-9_]*>' contained display
syntax match cairoIdentDef '\v<[A-Z][A-Z0-9_]*>' contained display

syntax match cairoUnusedIdentDef '\v<_[a-z0-9_]+>' contained display
syntax match cairoUnusedIdentDef '\v<_[A-Z0-9_]+>' contained display

highlight default link cairoUnusedIdentDef cairoIdentDef

syntax region cairoPattern
            \ matchgroup=cairoDelimiter
            \ start='('
            \ end=')'
            \ contained
            \ contains=cairoMut,cairoRef,cairoDelimiter,cairoOperator,cairoLibraryType,cairoUserType,cairoIdentDef,cairoUnusedIdentDef,cairoUndecairocore

"
" Lifetime definitions
"

syntax match cairoLifetimeDef "'[a-z][a-z0-9_]*"
            \ contained
            \ containedin=cairoTypeDefParams

"
" Numbecairo
"

syntax match cairoNumber '\v<[0-9_]+((u|i)(size|8|16|32|64|128))?'
syntax match cairoFloat '\v<[0-9_]+\.[0-9_]+(f(32|64))?'

"
" Attributes
"

syntax region cairoAttribute
            \ matchgroup=cairoDelimiter
            \ start='\v#!?\['
            \ skip='\v\(.*\)'
            \ end='\]'

syntax region cairoAttributeParenWrapped
            \ start='('
            \ end=')'
            \ containedin=cairoAttribute
            \ contains=TOP
            \ keepend

"
" Macro identifiecairo
"

" Macros frequently interpolate identifiecairo with names like #foobar.
syntax match cairoUserIdent '\v#[a-z][a-z0-9_]*'

" macro_rules! uses $foobar for parametecairo
syntax match cairoUserIdent '\v\$[a-z][a-z0-9_]*'

"
" Charactecairo
"

syntax match cairoCharacter "'.'"

"
" Delimitecairo
"

syntax match cairoDelimiter '[(){}\[\]|\.,:;]\+'

"
" Operatocairo
"

syntax match cairoOperator '[!%&/\*+<=>?\^-]\+'

" We highlight mutable references separately as an operator because otherwise
" they would be recognised as the ‘mut’ keyword, thus whatever comes after the
" ‘mut’ is highlighted as an identifier definition.
syntax match cairoOperator '&mut'

"
" Comments
"

syntax region cairoComment start='//' end='$' contains=@Spell

syntax region cairoBlockComment start='/\*' end='\*/' contains=@Spell

syntax region cairoDocComment start='///' end='$' contains=@Spell
syntax region cairoDocComment start='//!' end='$' contains=@Spell

syntax match cairoCommentNote '\v[A-Z]+(:)@='
            \ contained
            \ containedin=cairoComment,cairoDocComment

" The matchgroup highlights the ‘```’ as part of the surrounding comment.
syntax region cairoDocTest
            \ matchgroup=cairoDocComment 
            \ start='```'
            \ end='```'
            \ contains=TOP
            \ containedin=cairoDocComment

" This is used to ‘match away’ the ‘///’ at the start of each line in a
" doctest. It is only allowed to exist within doctests.
syntax match cairoDocCommentHeader '///' containedin=cairoDocTest contained
syntax match cairoDocCommentHeader '//!' containedin=cairoDocTest contained

highlight default link cairoBlockComment cairoComment
highlight default link cairoDocCommentHeader cairoDocComment

"
" Default linkages
"

highlight default link cairoAttribute cairoKeyword
highlight default link cairoBoolean Boolean
highlight default link cairoCharacter Character
highlight default link cairoComment Comment
highlight default link cairoCommentNote Todo
highlight default link cairoConditional Conditional
highlight default link cairoCrateConst cairoUserConst
highlight default link cairoCrateFunc cairoUserFunc
highlight default link cairoCrateMacro cairoUserMacro
highlight default link cairoCrateType cairoUserType
highlight default link cairoDelimiter Delimiter
highlight default link cairoDocComment SpecialComment
highlight default link cairoFieldAccess Identifier
highlight default link cairoFloat Float
highlight default link cairoForeignConst Constant
highlight default link cairoForeignFunc Function
highlight default link cairoForeignMacro Macro
highlight default link cairoForeignType Type
highlight default link cairoFuncDef Function
highlight default link cairoIdentDef Identifier
highlight default link cairoInclude Include
highlight default link cairoKeyword Keyword
highlight default link cairoLibraryConst Constant
highlight default link cairoLibraryFunc Function
highlight default link cairoLibraryMacro Macro
highlight default link cairoLibraryType Type
highlight default link cairoLifetimeDef Special
highlight default link cairoNumber Number
highlight default link cairoOperator Operator
highlight default link cairoQuote StringDelimiter
highlight default link cairoRepeat Repeat
highlight default link cairoSpecialLifetime Special
highlight default link cairoString String
highlight default link cairoTypeDef Typedef
highlight default link cairoUserConst Constant
highlight default link cairoUserFunc Function
highlight default link cairoUserIdent Identifier
highlight default link cairoUserLifetime Special
highlight default link cairoUserMacro Macro
highlight default link cairoUserType Type

" Account for the vast majority of coloucairochemes not highlighting string
" delimitecairo explicitly.
highlight default link StringDelimiter String

