use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use File::Temp;

use SPVM 'Fn';
use SPVM::File::Path;

use SPVM 'File::Path';
use SPVM 'Int';

use SPVM 'TestCase::File::Path';

ok(SPVM::TestCase::File::Path->test);

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count();

# mkpath
{
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    my $created = SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
    is($created, 4);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/";
    
    my $dir = "$temp_dir/$dir_base";
    
    my $created = SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
    is($created, 2);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo";
    
    my $dir = "$temp_dir/$dir_base";
    
    my $created = SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
    is($created, 1);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->mkpath($dir, $api->new_any_object_array([$api->new_string("mode"), SPVM::Int->new(0777)]));
    
    ok(-d $dir);
  }
}

# make_path
{
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->make_path($dir);
    
    ok(-d $dir);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->make_path($dir);
    
    ok(-d $dir);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->make_path($dir);
    
    ok(-d $dir);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->make_path($dir);
    
    ok(-d $dir);
  }
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->make_path($dir, $api->new_any_object_array([$api->new_string("mode"), SPVM::Int->new(0777)]));
    
    ok(-d $dir);
  }
}

# rmtree
{
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
    
    {
      open my $fh, '>', "$dir/a.txt"
        or die;
      ok(-f "$dir/a.txt");
    }
    {
      open my $fh, '>', "$dir/b.txt"
        or die;
      ok(-f "$dir/b.txt");
    }
    
    my $remove_dir = "$temp_dir/foo";
    
    ok(-d $remove_dir);
    
    my $removed_count = SPVM::File::Path->rmtree($remove_dir);
    
    ok(!-d $remove_dir);
    ok(!-f "$dir/a.txt");
    ok(!-f "$dir/b.txt");
    is($removed_count, 6);
  }
}

# remove_tree
{
  {
    my $temp_dir = File::Temp->newdir;
    
    my $dir_base = "foo/bar/baz/hello";
    
    my $dir = "$temp_dir/$dir_base";
    
    SPVM::File::Path->mkpath($dir);
    
    ok(-d $dir);
    
    {
      open my $fh, '>', "$dir/a.txt"
        or die;
      ok(-f "$dir/a.txt");
    }
    {
      open my $fh, '>', "$dir/b.txt"
        or die;
      ok(-f "$dir/b.txt");
    }
    
    my $remove_dir = "$temp_dir/foo";
    
    ok(-d $remove_dir);
    
    my $removed_count = SPVM::File::Path->remove_tree($remove_dir);
    
    ok(!-d $remove_dir);
    ok(!-f "$dir/a.txt");
    ok(!-f "$dir/b.txt");
    is($removed_count, 6);
  }
}

# Version
{
  is($SPVM::File::Path::VERSION, SPVM::Fn->get_version_string('File::Path'));
}

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
