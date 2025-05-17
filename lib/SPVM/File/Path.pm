package SPVM::File::Path;

our $VERSION = "0.012";

1;

=head1 Name

SPVM::File::Path - Creating and Removing Multi-Level Path

=head1 Description

File::Path in L<SPVM> has methods to create a multi-level path and to remove a directory that contain files or directories within them.

=head1 Usage

  use File::Path;
  
  File::Path->mkpath("foo/bar");
  
  File::Path->rmtree("foo");

=head1 Class Methods

=head2 mkpath

C<static method mkpath : int ($path : string, $options : object[] = undef);>

Creates a multi-level path given the $path and the options $otptions.

Options:

=over 2

=item C<mode : L<Int|SPVM::Int> = -1>

The mode that is used by L<mkdir|SPVM::Sys::IO/"mkdir"> to create directories.

If the value is less than C<0>, it becomes C<0777>.

=back

See Perl's L<File::Path/"mkpath"> for details.

=head2 make_path

C<static method make_path : int ($path : string, $options : object[] = undef);>

The same as L</"mkpath"> method.

=head2 rmtree

C<static method rmtree : int ($path : string);>

Removes a directory $path that contain files or directories within them.

See Perl's L<File::Path/"rmtree"> for details.

=head2 remove_tree

C<static method remove_tree : int ($path : string);>

The same as L</"rmtree"> method.

=head1 Porting

C<SPVM::File::Path> is a Perl's L<File::Path> porting to L<SPVM>.

=head1 See Also

=over 2

=item * L<Sys|SPVM::Sys>

=item * L<IO|SPVM::IO>

=item * L<File::Spec|SPVM::File::Spec>

=item * L<File::Basename|SPVM::File::Basename>

=back

=head1 Repository

L<SPVM::File::Path - Github|https://github.com/yuki-kimoto/SPVM-File-Path>

=head1 Author

Yuki Kimoto C<kimoto.yuki@gmail.com>

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License

