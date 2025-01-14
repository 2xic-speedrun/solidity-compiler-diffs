{
    function do_revert() -> ret { revert(0, 0) }
    function do_return() -> ret { return(0, 0) }
    function func(a, b) {}

    // do_revert() is expected to run first
    func(do_return(), do_revert())
}