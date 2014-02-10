Return-Path: michael.marineau@coreos.com
MIME-Version: 1.0
In-Reply-To: <20140210095709.GC8506@x2.net.home>
References: <1389734390-32485-1-git-send-email-michael.marineau@coreos.com>
	<20140210095709.GC8506@x2.net.home>
Date: Mon, 10 Feb 2014 13:54:15 -0800
Message-ID: <CAGr1u3vfBTYa3pVhmmGXONJ4bUuPk4AV5xj2wS=17V-H+esrsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libblkid: add PARTTYPE tag
From: Michael Marineau <michael.marineau@coreos.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 1:57 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jan 14, 2014 at 01:19:49PM -0800, Michael Marineau wrote:
>> Add PARTTYPE to make searching for devices partition possible without
>> dropping to the low-level probe API and searching all devices by
>> PART_ENTRY_TYPE. For example to find any 'EFI System Partition' devices:
>>
>> $ blkid -t PARTTYPE=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>> ---
>>  libblkid/src/verify.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
>  I think it's unnecessary (and maybe bad idea) to add a new tags to
>  the high level part of the library. The high level tags have been
>  introduced to support mount/fsck devices by LABEL= or UUID= tags
>  (only this is reason why we have the new PARTUUID= tag there). I'd
>  like to keep this layer as minimal as possible (due the problem with
>  caching in blkid.tab file).
>
>  If you need information about devices then use lsblk(8) rather than
>  blkid(8).

My situation is actually scanning for a partitions of particular types
using the libblkid library. The high level blkid API provides a really
nice way to do this except it is completely impossible to query for
new tags even if the tool has sufficient privileges to re-scan
devices. The low level API on the other hand is good at getting lots
of detail on a single device but tedious to use for scanning an entire
system for a single device. It isn't even possible to use the high
level API to query for PTTYPE="gpt" for a list of candidates to
directly read since whole disks get dropped from the high level API
when partitions are found on them. The patch to lsblk was just an
adjunct "might as well add this there too" sort of change, it doesn't
actually do what I need since I need an API.

What's the problem with caching you refer to? Is there a different
change to the high level API that would make it more flexible while
keeping the default set of values reported/cached minimal?

One thought on how this may be useful in general, with PARTTYPE the
following following could be used mount the same partitions that
systemd-gpt-auto-generato and systemd-efi-boot-generator would:

mount PARTTYPE=c12a7328-f81f-11d2-ba4b-00a0c93ec93b /boot
mount PARTTYPE=933ac7e1-2eb4-4f13-b8440e14e2aef915 /home
