Return-Path: giulioo@gmail.com
MIME-Version: 1.0
Reply-To: giulioo@pobox.com
In-Reply-To: <20110817124400.GA699@nb.net.home>
References: <20110817061256.BB29DF815@i3.golden.dom>
	<20110817075613.GB28856@nb.net.home>
	<20110817093146.860D9F815@i3.golden.dom>
	<20110817124400.GA699@nb.net.home>
Date: Wed, 17 Aug 2011 15:46:54 +0200
Message-ID: <CAMec4M1Eg3PqU9RvKy655BP_cZNfpAHR24ZurHMj9h3SeD9pZQ@mail.gmail.com>
Subject: Re: sfdisk: trying to create aligned partitions: fail
From: Giulio Orsero <giulioo@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 14:44, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 17, 2011 at 11:31:56AM +0200, Giulio wrote:
>> I know sfdisk won't automatically align partitions and didn't expect it =
to
>> do it, my email was about sfdisk behaving in an unexpected way:
>> - not respecting 1MB as start of partition when I ask for it
>> - creating partitions out of order when using sectors
>
> =C2=A0Try --in-order command line option, the option is undocumented in o=
ld
> =C2=A0versions ;-(

With "--in-order" the issue with partitions out of order (the case in
which I was using -uS) is solved.

However, there still is an isse when using -uM
I was trying with a 200GB VMware disk and when I used -uM and 1 as
start of 1st partition sfdisk would create a partition starting at
sector 1 (not MB 1).

I see you used a 100MB disk, so I tried different sizes until I found
when the error appears, unfortunately I'm not able to fine grain sizes
in VMware more than the following:

=3D=3D command used
DEV=3D$1
dd if=3D/dev/zero of=3D/dev/$DEV bs=3D1 count=3D512
sfdisk --in-order -L -uM /dev/$DEV <<-EOF
1,10,83
,,83
;
;
EOF
=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D with a  1062MB, OK:
Disk /dev/sdc: 1062 MB, 1062207488 bytes
64 heads, 32 sectors/track, 1013 cylinders, total 2074624 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1            2048       22527       10240   83  Linux
<=3D=3D=3D=3D start sector 2048
/dev/sdc2           22528     2074623     1026048   83  Linux
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D with a  1073MB, NOT-OK:
Disk /dev/sdb: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders, total 2097152 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1       32129       16064+  83  Linux
<=3D=3D=3D=3D=3D start sector 1
/dev/sdb2           32130     2088449     1028160   83  Linux
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks
