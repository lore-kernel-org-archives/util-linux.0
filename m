Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: test sfdisk, optimal_iosize
Date: Fri, 29 Jan 2016 14:02:14 +0100
Cc: util-linux@vger.kernel.org
References: <201601291131.29201.sweet_f_a@gmx.de> <20160129113110.o76pvon3wormblgd@ws.net.home>
In-Reply-To: <20160129113110.o76pvon3wormblgd@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201601291402.14306.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Friday 29 January 2016, Karel Zak wrote:
> On Fri, Jan 29, 2016 at 11:31:28AM +0100, Ruediger Meier wrote:
> > Hi,
> >
> > I've got some test failures like
> >
> > ---
> > /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/expe
> >cted/sfdisk/dos-activate +++
> > /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/outp
> >ut/sfdisk/dos-activate @@ -6,7 +6,7 @@
> >  Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
> >  Units: sectors of 1 * 512 = 512 bytes
> >  Sector size (logical/physical): 512 bytes / 4096 bytes
> > -I/O size (minimum/optimal): 4096 bytes / 32768 bytes
> > +I/O size (minimum/optimal): 4096 bytes / 64 bytes
>
> Very very strange. It seems like the number is in sectors (64 * 512 =
> 32768) rather than in bytes.
>
> >  Disklabel type: dos
> >  Disk identifier: <removed>
> >
> >
> > optimal < minimum ... is this a bug?
> >
> > Where does this optimal iosize come from, scsi_debug module?
> > Is there a commandline tool to get this iosize, maybe blkid?
>
>  cat /sys/block/sda/queue/{optimal,minimum}_io_size
>  cat /sys/block/sda/queue/{physical,logical}_block_size
>
> The optimal IO size is often 0 (in /sys) in this case libfdisk
> fallback to minimal IO size.
>
> Try
>     LIBFDISK_DEBUG=all fdisk -l /dev/sda

Thx.

I get this on the "broken systems":

## sector_size=512
$ modprobe -r scsi_debug
$ modprobe scsi_debug dev_size_mb=100 sector_size=512
$ devname=$(grep --with-filename scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
$ cat /sys/block/$devname/queue/{logical_block_size,physical_block_size,minimum_io_size,optimal_io_size}
512
512
512
64

## sector_size=4096
$ modprobe -r scsi_debug
$ modprobe scsi_debug dev_size_mb=100 sector_size=4096
$ devname=$(grep --with-filename scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}') 
$ cat /sys/block/$devname/queue/{logical_block_size,physical_block_size,minimum_io_size,optimal_io_size}
4096
4096
4096
512

These odd optimal iosizes only happen for "scsi_debug" devices (not the loop
nor md devices used in our test suite).

Reproduced on kernel 4.1.15 and 4.4.0.
Was correct on kernel 3.16.7 (and maybe even 4.1.13).

Maybe it's not only about the kernel version but also something about
other host specific settings.

Could somebody please reproduce this on kernel 4.4.0?

cu,
Rudi
