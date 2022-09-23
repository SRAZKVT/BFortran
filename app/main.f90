program main
    use Brainfuck
    implicit none

    character(len=:), allocatable :: filepath, code
    logical :: exists


    call get_arg(1, filepath)

    if (LEN_TRIM(filepath) == 0) then
        print *, "Please insert a file path"
    else
        inquire(file=filepath, exist=exists)
        if (exists) then
            call read_file(filepath, code)
            call interpret(code)
        else
            print *, "Please insert a valid file path"
        end if
    end if
end program main
