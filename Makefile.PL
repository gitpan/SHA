use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile being created.
WriteMakefile(
    'NAME'		=>	'SHA',
    'VERSION_FROM'	=>	'SHA.pm',
    'OBJECT'		=>	q[SHA$(OBJ_EXT) sha_func$(OBJ_EXT)],
);
