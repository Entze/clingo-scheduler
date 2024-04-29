
:~ inversion(Error, Args), penalty(Error, Weight, Priority). [Weight@Priority, Error, Args]

:~ inversion(Error, Severity, Args), penalty(Error, Scale, Shift, Priority). [((Severity * Scale) + Shift)@Priority, Error, Args]
