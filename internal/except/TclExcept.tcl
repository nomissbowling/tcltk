# TclExcept.tcl --
#
# version 2.0, frederic.bonnet@ciril.fr
# This file provides procedures to handle exceptions and to perform
# assertions in Tcl scripts

package provide TclExcept 2.0


# assert --
# This procedure performs a series of tests on boolean conditions and fails
# if any is not satisfied
#
# Arguments:
# condblock - A newline-separated list of boolean conditions

proc assert {condblock} {
    # get the command name
    set commandName [lindex [info level 0] 0]

    # split the condition list at newlines
    set l [split $condblock \n]
    set line 0
    foreach lcond $l {
        foreach cond [split $lcond \;] {
            if {[llength $cond] > 0} {
                # perform test
                if {[set c [catch {uplevel expr $cond} r]] == 0} {
                    if {!$r} {
                        # the assertion failed
                        set msg "assertion failed: \"$cond\""
                        return -code error -errorcode [list EXCEPTION Assertion $msg] $msg
                    }
                } else {
                    # an error occurred during the test
                    return -code $c -errorinfo "$r\n    (\"$commandName\" body line $line)" $r
                }
            }
        }
        incr line
    }
    return
}

# throw --
# This procedure is used to throw exceptions
# 
# Arguments:
# type    - Exception type, an arbitrary Tcl string
# message - Human-readable description of the exception

proc throw args {
    if {[llength $args] == 0} {
        # re-trowing the current exception
        global errorCode _TclExcept_Thrown
        if {![info exists _TclExcept_Thrown] || !$_TclExcept_Thrown} {
            return -code error "no exception have been thrown and thus can't be rethrown"
        }
        return -code error -errorcode RETHROW
    } elseif {[llength $args] == 2} {
        # throwing an exception
        set type [lindex $args 0]
        set message [lindex $args 1]
        return -code error -errorcode [list EXCEPTION $type $message] "$type exception thrown: $message"
    } else {
        # error
        return -code error "wrong # args: should be \"[lindex [info level 0] 0] ?type message?\""
    }
}

# exception --
# This procedure is used to manipulate exception types
# 
# Arguments:
# type    - Exception type, an arbitrary Tcl string
# args    - first argument may contain a parents list

proc exception {type args} {
    global _TclExcept_ExceptionHierarchies
    if {[llength $args] == 0} {
        if {[info exists _TclExcept_ExceptionHierarchies($type)]} {
            return $_TclExcept_ExceptionHierarchies($type)
        } else {
            return {}
        }
    } elseif {[llength $args] == 1} {
        set _TclExcept_ExceptionHierarchies($type) [lindex $args 0]
    } else {
        return -code error "wrong # args: should be \"[lindex [info level 0] 0] type ?parents?\""
    }
}


# _TclExcept_GetException --
# TclExcept private procedure. Used to get exception info from a caught error.

proc _TclExcept_GetException {errorCode errorInfo returnValue ecv emv} {
    upvar $ecv exceptionCode $emv exceptionMsg

    switch -glob $errorCode {
        {EXCEPTION *} {
            # regular exception
            set exceptionCode [lindex $errorCode 1]
            set exceptionMsg [lindex $errorCode 2]
        }
        default {
            # Tcl error -> generating exception info
            set exceptionCode Error
            set exceptionMsg $returnValue
        }
    }
}

# _TclExcept_ExceptionIsKindOf --
# TclExcept private procedure. Used to check if an exception is of a certain type. 

proc _TclExcept_ExceptionIsKindOf {exceptionCode exceptionType} {
    global _TclExcept_ExceptionHierarchies
    if {[string compare $exceptionCode $exceptionType] == 0} {
        return 1
    }
    if {[info exists _TclExcept_ExceptionHierarchies($exceptionCode)]} {
        foreach code $_TclExcept_ExceptionHierarchies($exceptionCode) {
            if {[_TclExcept_ExceptionIsKindOf $code $exceptionType]} {
                return 1
            }
        }
    }

    return 0
}

# _TclExcept_MatchException --
# TclExcept private procedure. Used to match an exception code against a catch block. 

proc _TclExcept_MatchException {exceptionCode cb cs} {
    upvar $cb catchBlock $cs catchScript

    set code {}
    foreach {code catchScript} $catchBlock {
        if {[_TclExcept_ExceptionIsKindOf $exceptionCode $code]} {
            # exception matched
            return 1
        }
    }
    # an ending default keyword matches any exception
    return [expr {[string compare $code "default"] == 0}]
}


# _TclExcept_ConvertErrorInfo --
# TclExcept private procedure. Used to convert errorInfo strings for call stack trace from within try. 

proc _TclExcept_ConvertErrorInfo {info ndel sstring rstring} {
    set l [split $info \n]
    set ll [llength $l]
    set i [lrange $l 0 [expr {$ll-$ndel-1}]]
    regsub $sstring [lindex $l [expr {$ll-$ndel}]] $rstring r
    lappend i $r
    join $i \n
}

# try --
# This procedure is used to handle exceptions thrown from within a script
# 
# Synopsis:
#   try <script> ?catch <msg> <catchblock>? ?finally <finallyscript>? ?<varName>?
#
# Arguments:
# script       - Tcl script from within exceptions are likely to be thrown
# catchblock   - List of exception type - exception handling script pairs
# msg          - Description of the thrown exception
# finallscript - Script evaluated at the end, whatever happens
# varName      - Variable name that will contain the result of the lat action performed
#
# Return value:
# the error code of the last action performed within script

proc try {script args} {
    set commandName [lindex [info level 0] 0]

    set bReturnVar 0
    set bCatch 0
    set bFinally 0

    # parse command line
    set l [llength $args]
    set i 0
    while {$l-$i > 0} {
        set option [lindex $args $i]
        switch [expr {$l-$i}] {
            1 {
                upvar $option returnVar
                set bReturnVar 1
                incr i
            }
            2 {
                switch $option {
                    catch {
                        return -code error -errorinfo {} "syntax error: \"$commandName ... $option \" takes 2 args"
                    }
                    finally {
                        set finallyScript [lindex $args [expr {$i+1}]]
                        set bFinally 1
                        incr i 2
                    }
                    default {
                        return -code error -errorinfo {} "unsupported option \"$option\""
                    }
                }
            }
            default {
                switch $option {
                    catch {
                        set catchVars [lindex $args [expr {$i+1}]]
                        if {[llength $catchVars] > 1} {
                            upvar [lindex $catchVars 0] catchException
                            upvar [lindex $catchVars 1] catchMsg
                        } else {
                            upvar [lindex $catchVars 0] catchMsg
                        }
                        set catchBlock [lindex $args [expr {$i+2}]]
                        set bCatch 1
                        incr i 3
                    }
                    finally {
                        set finallyScript [lindex $args [expr {$i+1}]]
                        set bFinally 1
                        incr i 2
                    }
                    default {
                        return -code error -errorinfo {} "unsupported option \"$option\""
                    }
                }
            }
        }
    }

    global errorCode errorInfo
    global _TclExcept_Thrown
    if {[set bThrown [info exists _TclExcept_Thrown]]} {
        set oldThrown $_TclExcept_Thrown
    }
    set _TclExcept_Thrown 0

    # eval the main block and catch errors
    set c [catch {uplevel $script} returnVar]
    set ec $errorCode; set ei [_TclExcept_ConvertErrorInfo $errorInfo 3 uplevel $commandName]; set rv $returnVar
    switch $c {
        1 {
            set errorInfo $ei
            set _TclExcept_Thrown 1
        }
        default {
            # normal result, or control flow exception (return, break or continue) caught
            # nothing to do
        }
    } 

    set bCaught 0
    if {($c == 1) && $bCatch} { # if an exception occurred and there is a catch block
        # get exception info
        _TclExcept_GetException $errorCode $errorInfo $returnVar exceptionCode exceptionMsg

        # try to match the exception
        set bCaught [_TclExcept_MatchException $exceptionCode catchBlock catchScript]

        if {$bCaught} {
            # eval the matched exception handler
            set catchMsg $exceptionMsg
            set catchException $exceptionCode
            set cCatch [catch {uplevel $catchScript} returnVar]
            set catchEi [_TclExcept_ConvertErrorInfo $errorInfo 3 uplevel "$commandName ... catch"]

            switch $cCatch {
                0 {
                    # normal result, nothing to do
                }
                1 {
                    # error caught during a catch
                    if {[string compare $errorCode "RETHROW"] == 0} {
                        # the exception has been rethrown
                        set bCaught 0
                    } else {
                        if {$bThrown} {
                            set _TclExcept_Thrown $oldThrown
                        } else {
                            catch {unset _TclExcept_Thrown}
                        }
                        return -code $cCatch -errorcode $errorCode -errorinfo $catchEi $returnVar
                    }
                }
                default {
                    # control flow exception (return, break or continue) caught
                    # set the error code and info to the caught values
                    set c  $cCatch
                    set ei $catchEi
                }
            }
        }
    }

    if {$bThrown} {
        set _TclExcept_Thrown $oldThrown
    } else {
        catch {unset _TclExcept_Thrown}
    }

    if $bFinally { # if there is a finally block
        # eval the finally block
        set cFinally [catch {uplevel $finallyScript} returnVar]
        set finallyEi [_TclExcept_ConvertErrorInfo $errorInfo 3 uplevel "$commandName ... finally"]
        switch $cFinally {
            0 {}
            default {
                # error or control flow exception (return, break or continue) caught
                return -code $cFinally -errorcode $errorCode -errorinfo $finallyEi $returnVar
            }
        }
    }

    # set correct error info then return
    set errorCode $ec
    set errorInfo $ei
    switch $c {
        0 {
            # normal result
            return $c
        }
        1 {
            if {!$bCaught} { # if the exception is unhandled
                # propagate exception
                uplevel [list return -code $c -errorcode $ec -errorinfo $ei $rv]
            }
            return $c
        }
        default {
            # control flow exception (return, break or continue) caught
            return -code $c -errorcode $errorCode -errorinfo $ei $returnVar
        }
    }
}

