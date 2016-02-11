Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: Karel Zak <kzak@redhat.com>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BC9101.60908@suse.cz>
Date: Thu, 11 Feb 2016 14:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <20160211094352.6ncnnirhyd4jjd34@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Feb 02, 2016 at 09:14:48PM +0100, Stanislav Brabec wrote:
>> Stanislav Brabec wrote:
>> +mkdir -p s3/bind-mnt
>
> So, this is enough to fix the testcase, right? I'd like to merge it.
>
>      Karel
>
Well, not.


There are missing umount commands in the middle of the test, which 
trigger following problem:

truncate -s10M source.img
mkdir -p /source/subdir
mkdir -p /dest
/sbin/mkfs.ext4 source.img
losetup /dev/loop0 $PWD/source.img
mount -text4 /dev/loop0 /source
mkdir -p /source/subdir
mount -o bind /source /dest
mount -o bind /source/subdir /dest

Mounting a bind mount over a root of existing bind mount causes mounting 
over the bind mount source. I expected mounting over the target 
directory I specified.

I am not sure, whether it is correct behavior, but for sure it is 
surprising.


Additionally, I am working on a reproducer of an invalid "mount -a" 
behavior triggered by kernel bug reporting false subvol. Now I have only 
a reproducer outside testsuite:

#/btrfs_test.img /btrfs_mnt_root auto loop,subvol=/ 0 0
#/btrfs_test.img /btrfs_mnt auto loop,subvolid=257 0 0
#/btrfs_mnt_root/d0/dd0/ddd0/s1/bind-mnt /btrfs_bind auto bind 0 0

Round 1:
Uncomment 1st and 3rd line and call mount -a.

Round 2:
Uncomment 2nd line and call mount -a.

Result:
Only two mounts exist.

I am working on a subtest that will trigger it inside the test suite.

I already have a possible fix for it, but I want to confirm that it is 
correct before sending it upstream.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
