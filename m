Return-Path: nik2087@gmail.com
MIME-Version: 1.0
References: <CALY=dt+aJC0aXm6j4wg-T-RbOKAv-+q7NuzMaH_fwPO3Hdss2A@mail.gmail.com>
 <20180510095215.fpxoerxvan7hx3ac@ws.net.home>
In-Reply-To: <20180510095215.fpxoerxvan7hx3ac@ws.net.home>
From: Nikhil <nik2087@gmail.com>
Date: Thu, 10 May 2018 10:13:01 +0000
Message-ID: <CALY=dt+6zebO8jAmW-3R36U5tJEyopzZjJSyTjLDDOutZCLjPg@mail.gmail.com>
Subject: Re: blkid -> attempt to access beyond end of device if start sector
 is > 128
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

Thanks a lot for reply.  Here's the output:

root@ebboard:~# blkid -v
blkid from util-linux 2.30  (libblkid 2.30.0, 02-Jun-2017)

root@ebboard:~#  LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0p1
491: libblkid:     INIT: library debug mask: 0xffff
491: libblkid:     INIT: library ver[  129.635888] attempt to access beyond
end of device
sion: 2.30.0 [02-Jun-2017]
Avai[  129.641600] unknown-block(179,0): rw=0, want=1953793, limit=1953792
lable "LIBBLKID_DEBUG=<name>[,..[  129.650266] Buffer I/O error on dev
mmcblk0p1, logical block 244207, async page read
.]|<mask>" debug masks:
    all      [0xffff] : info about all subsystems
    cache    [0x0004] : blkid tags cache
    config   [0x0008] : config file utils
    dev      [0x0010] : device utils
    devname  [0x0020] : /proc/partitions evaluation
    devno    [0x0040] : conversions to device name
    evaluate [0x0080] : tags resolving
    help     [0x0001] : this help
    lowprobe [0x0100] : superblock/raids/partitions probing
    buffer   [0x2000] : low-probing buffers
    probe    [0x0200] : devices verification
    read     [0x0400] : cache parsing
    save     [0x0800] : cache writing
    tag      [0x1000] : tags utils
491: libblkid: LOWPROBE: allocate a new probe 0x1d731a0
491: libblkid: LOWPROBE: zeroize wiper
491: libblkid: LOWPROBE: ready for low-probing, offset=0, size=1000275456
491: libblkid: LOWPROBE: whole-disk: NO, regfile: NO
491: libblkid: LOWPROBE: 0x1d731a0: start probe
491: libblkid: LOWPROBE: zeroize wiper
491: libblkid: LOWPROBE: chain safeprobe superblocks ENABLED
491: libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=-1]
491: libblkid: LOWPROBE: [0] linux_raid_member:
491: libblkid: LOWPROBE:        call probefunc()
491: libblkid: LOWPROBE:        read 0x1d73410: off=1000144896 len=64
491: libblkid: LOWPROBE:        read 0x1d73478: off=1000263680 len=256
491: libblkid: LOWPROBE:        read 0x1d735a0: off=0 len=256
491: libblkid: LOWPROBE:        read 0x1d736c8: off=4096 len=256
491: libblkid: LOWPROBE: [1] ddf_raid_member:
491: libblkid: LOWPROBE:        call probefunc()
491: libblkid: LOWPROBE:        read 0x1d737f0: off=1000274944 len=512
491: libblkid: LOWPROBE:        read failed: Input/output error
491: libblkid: LOWPROBE: <-- leaving probing loop (failed=-5) [SUBLKS idx=1]
491: libblkid: LOWPROBE: freeing values list
491: libblkid: LOWPROBE: 0x1d731a0: end probe
491: libblkid: LOWPROBE: zeroize wiper
491: libblkid:   BUFFER: Resetting probing buffers pr=0x1d731a0
491: libblkid:   BUFFER:  remove buffer: 0x1d73410 [off=1000144896, len=64]
491: libblkid:   BUFFER:  remove buffer: 0x1d73478 [off=1000263680, len=256]
491: libblkid:   BUFFER:  remove buffer: 0x1d735a0 [off=0, len=256]
491: libblkid:   BUFFER:  remove buffer: 0x1d736c8 [off=4096, len=256]
491: libblkid: LOWPROBE:  buffers summary: 832 bytes by 4 read() calls
491: libblkid: LOWPROBE: free probe 0x1d731a0
On Thu, May 10, 2018 at 3:22 PM Karel Zak <kzak@redhat.com> wrote:

> On Thu, May 10, 2018 at 09:00:36AM +0000, Nikhil wrote:
> > We have i.Mx35 based embedded system running Linux 4.14.  The
distribution
> > is built using yocto (rocko branch).  Before we moved on to Linux 4.14
we
> > used Linux 2.6, distribution was again built using yocto(danny branch).
> > After upgrade to rocko and linux 4.14, we see some error messages on the
> > console on executing blkid.  These messages appear for the SD card.
Error
> > messages appear only if SD Card is mounted and if the start sector for
sd
> > card is 129 or more,  doesnt appear is start sector is 128 or less.
> >
> > Error Message:
> > root@ebboard:~# blkid
> > [ 8707.475004] attempt to access beyond end of device
> > [ 8707.479894] unknown-block(179,0): rw=0, want=1953793, limit=1953792
> > [ 8707.488054] Buffer I/O error on dev mmcblk0p1, logical block 244207,
> > async page read
> >
> > fdisk output:
> > root@ebboard:~# fdisk -ul
> >
> > Disk /dev/mmcblk0: 1000 MB, 1000341504 bytes
> > 4 heads, 16 sectors/track, 30528 cylinders, total 1953792 sectors
> > Units = sectors of 1 * 512 = 512 bytes
> >
> >          Device Boot      Start         End      Blocks  Id System
> > /dev/mmcblk0p1             129     1953791      976831+  6 FAT16
> >
> > If anyone has any idea as to why these warnings are printed depending on
> > whether the start sector is > 128  would be very much helpful.  Thanks.

> Maybe kernel returns incorrect size for the device, or it's blkid bug.

> Can you try

>      LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0p1

> or for /dev/mmcblk0 (not sure if kernel reports it for whole-disk
> probing or for the partition).

> util-linux version ? (blkid -V).

>      Karel

> --
>   Karel Zak  <kzak@redhat.com>
>   http://karelzak.blogspot.com
