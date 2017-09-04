Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/1] Two changes before we go to rc
To: Karel Zak <kzak@redhat.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
Date: Sun, 3 Sep 2017 21:14:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


With the recent comment regarding the pending rc, I'd like to make
two small string changes before we send them off for translation.

During this cycle all of hwclock usage strings have been changed, but
I still do not like the debug description.

I looked at what the other utils are using; there are only two others
with a debug option and their strings are no better for hwclock, IMO.
So I looked at usage strings for the verbose option. In 27
occurrences there are 15 different descriptions. The most recent one,
written by Karel, I think is good for both debug (except uuidd) and
verbose (it could be made a usage constant to reduce 17 strings to
1). It is: "display more details"

The second change was the subject of a long discussion which ended
without a consensus. My last volley went unanswered:
https://marc.info/?l=util-linux-ng&m=150124890123757&w=2

So this patch also makes the usage constants for help and version use
the same verb; which Karel originally said was an improvement:
https://marc.info/?l=util-linux-ng&m=149794873321562&w=2


CURRENT DEBUG AND VERBOSE USAGE STRINGS.

ldattach.c:    -d, --debug   print verbose messages to stderr
hwclock.c:     -D, --debug   use debug mode
uuidd.c:       -d, --debug   run in debugging mode

setarch.c:     -v, --verbose say what options are being switched on
ipcrm.c:       -v, --verbose explain what is being done
swapon.c:      -v, --verbose verbose mode
swapoff.c:     -v, --verbose verbose mode
chmem.c:       -v, --verbose verbose output
mount.c:       -v, --verbose say what is being done
eject.c:       -v, --verbose enable verbose output
readprofile.c: -v, --verbose print verbose data
fstrim.c:      -v, --verbose print number of discarded bytes
prlimit.c:         --verbose verbose output
losetup.c:     -v, --verbose verbose mode
umount.c:      -v, --verbose say what is being done
fallocate.c:   -v, --verbose verbose mode
blkzone.c:     -v, --verbose display more details
blkdiscard.c:  -v, --verbose print aligned length and offset
rtcwake.c:     -v, --verbose verbose messages
rename.c:      -v, --verbose explain what is being done
mcookie.c:     -v, --verbose explain what is being done
chrt.c:        -v, --verbose display status information
mesg.c:        -v, --verbose explain what is being done
mkfs.bfs.c:    -v, --verbose explain what is being done
fsck.minix.c:  -v, --verbose be verbose
mkfs.c:        -v            be verbose
mkfs.c:        -V, --verbose explain what is being done;
blockdev.c:    -v            verbose mode
fsck.c:        -v, --verbose be more verbose
partx.c:       -v, --verbose verbose mode

J William Piggott (1):
  hwclock: update usage()

 include/c.h         | 2 +-
 sys-utils/hwclock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
