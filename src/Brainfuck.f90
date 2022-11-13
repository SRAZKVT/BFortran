module Brainfuck
    implicit none
    private

    public :: interpret, get_arg, read_file
contains
    subroutine get_arg(n, filepath)
        implicit none

        character(len=:), allocatable, intent(out) :: filepath
        integer, intent(in) :: n
        integer :: arglen

        call GET_COMMAND_ARGUMENT(n, length=arglen)
        allocate(character(arglen) :: filepath)
        call GET_COMMAND_ARGUMENT(n, value=filepath)
    end subroutine get_arg

    subroutine read_file(filepath, buffer)
        character(len=*), intent(in) :: filepath
        character(len=:), allocatable, intent(out) :: buffer
        integer :: file_size, io

        inquire(file=filepath, size=file_size)
        allocate(character(len=file_size) :: buffer)
        open(newunit=io, file=filepath, form="unformatted", access="stream", action="read")
        read(io) buffer
        close(io)
    end subroutine read_file
    
    subroutine interpret(code)
        character(len=:), allocatable :: code
        integer :: ip = 1, tp = 1, i
        character(len=65536) :: tape

        do while (ip <= len_trim(code))
            if (code(ip:ip) == ">") then
                tp = tp + 1
                ip = ip + 1
            else if (code(ip:ip) == "<") then
                tp = tp - 1
                ip = ip + 1
            else if (code(ip:ip) == "+") then
                tape(tp:tp) = char(ichar(tape(tp:tp)) + 1)
                ip = ip + 1
            else if (code(ip:ip) == "-") then
                tape(tp:tp) = char(ichar(tape(tp:tp)) - 1)
                ip = ip + 1
            else if (code(ip:ip) == ",") then
                tape(tp:tp) = get_char()
                ip = ip + 1
            else if (code(ip:ip) == ".") then
                write(*, fmt="(a)", advance="no") tape(tp:tp)
                ip = ip + 1
            else if (code(ip:ip) == "[") then
                if (ichar(tape(tp:tp)) == 0) then
                    i = 1
                    do while (i > 0)
                        ip = ip + 1
                        if (code(ip:ip) == "[") then
                            i = i + 1
                        else if (code(ip:ip) == "]") then
                            i = i - 1
                        end if
                    end do
                end if
                ip = ip + 1
            else if (code(ip:ip) == "]") then
                i = 1
                do while (i > 0)
                    ip = ip - 1
                    if (code(ip:ip) == "[") then
                        i = i - 1
                    else if (code(ip:ip) == "]") then
                        i = i + 1
                    end if
                end do
            else
                ip = ip + 1
            end if
        end do
    end subroutine interpret

    function get_char() result(buf)
        character(len=1) :: buf
        read (*,'(a)') buf
        return
    end function
end module Brainfuck
