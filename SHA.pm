package SHA;

require Exporter;
require DynaLoader;
@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default
@EXPORT = qw();
# Other items we are prepared to export if requested
@EXPORT_OK = qw();

bootstrap SHA;

sub addfile
{
    my ($self, $handle) = @_;
    my ($len, $data);

    while ($len = read($handle, $data, 8192))
    {
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

1;
