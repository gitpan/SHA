use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile being created.
WriteMakefile(
	'DISTNAME' => 'SHA',
	'VERSION' => '1.0',
	'OBJECT' => 'SHA.o sha_func.o',
);
