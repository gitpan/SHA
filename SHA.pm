package SHA;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Exporter;
require DynaLoader;
require AutoLoader;
@ISA = qw(Exporter AutoLoader DynaLoader);
# Items to export into callers namespace by default
@EXPORT = qw();
@EXPORT_OK = qw(sha_version);
$VERSION = '1.2';

bootstrap SHA $VERSION;

sub addfile
{
    no strict 'refs';
    my ($self, $handle) = @_;
    my ($package, $file, $line) = caller;
    my $data = ' ' x 8192;

    if (!ref($handle)) {
	$handle = "$package::$handle" unless ($handle =~ /(\:\:|\')/);
    }
    while (read($handle, $data, 8192)) {
	$self->add($data);
    }
}

sub hexdigest
{
    my ($self) = shift;
    my ($tmp);

    $tmp = unpack("H*", ($self->digest()));
    return(substr($tmp, 0,8) . " " . substr($tmp, 8,8) . " " .
	   substr($tmp,16,8) . " " . substr($tmp,24,8) . " " .
	   substr($tmp,32,8));
}

sub hash
{
    my($self, $data) = @_;

    if (ref($self)) {
	$self->reset();
    } else {
	$self = new SHA;
    }
    $self->add($data);
    $self->digest();
}

sub hexhash
{
    my($self, $data) = @_;

    if (ref($self)) {
	$self->reset();
    } else {
	$self = new SHA;
    }
    $self->add($data);
    $self->hexdigest();
}

1;
__END__
