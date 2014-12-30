Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:59645 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbaL3IDr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Dec 2014 03:03:47 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NHD008JIXDCDR10@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Tue, 30 Dec 2014 04:03:45 -0400 (AST)
Received: from tesla ([10.0.0.17])	by llama.cordes.ca with esmtp
 (Exim 3.36 #1 (Debian))	id 1Y5rmL-0001ig-00	for <util-linux@vger.kernel.org>;
 Tue, 30 Dec 2014 04:03:45 -0400
From: Peter Cordes <peter@cordes.ca>
To: util-linux@vger.kernel.org
Subject: [PATCH] WIP: fallocate --dig-holes tweaks to suit my use-case
Date: Tue, 30 Dec 2014 04:03:33 -0400
Message-id: <1419926613-7946-1-git-send-email-peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

 This is kinda messy, just posting for review / comment.  I'll tidy
this up and submit a good patch once we decide what should be in it.

 My use-case is primarily sparsifying unwritten pre-allocated regions
in files created by bittorrent clients.

 I also want it to not make a mess if run on every file in a big tree.

* special case at EOF: punch past EOF to end of block

 Otherwise you end up with the last block still allocated, since allocation
can extend beyond EOF.  Linux (3.13) doesn't detect the special-case
of EOF in the middle of the last pre-allocated block, so it leaves a
single allocated block at the end of a file.

 FIEMAP would be needed to detect unwritten extents beyond EOF, I
believe.  Would maybe be nice if fallocate could detect and interact
with that situation.


* Set a minimum size for holes of 1MB, or half the file size if smaller.
The special case for small files allows turning all-zero files into a
hole.  A cmdline option to override the min size would be good for other
use-cases.  Maybe --dig-holes=4k, having -d take an optional argument?
Otherwise a new option is needed, since --length selects the range to
dig in.

* More useful logging of what's happening, only printing stuff about
unchanged files if verbose > 2.  (-vvv on the cmdline.)  Logging is
very much a WIP.  Current state of what's printed is from sorting out
what happens with the last block of a file.  IDK if we want to concern
users with the special-casing at EOF.

 nice ionice -c3 find ... -xdev -type f -size +2M -exec fallocate-local -v -d {} \;
generated a lot of useless lines that hid the lines showing anything
actually getting done.  This fixes that, by logging only when zero blocks
are detected.

* Punch out unwritten pre-allocated space.
 SEEK_DATA doesn't distinguish between holes and pre-allocated extents,
so for now just brute-force scan.  Having fallocate unable to reverse
its own action is kinda silly. :P

 TODO: detect it more efficiently.  Maybe keep using SEEK_DATA, but then
always do FALLOC_FL_PUNCH_HOLE, since it shouldn't be harmful to call on
a hole.  The is_nul() loop is pretty fast, but the mem copy from
pread() really hurts.  mmap would be faster, since I think Linux has
some tricks for mmaping every page of holes / unwritten regions /
/dev/zero to a single physical page (copy-on-write all-zero).

 More --dig-holes functionality could end up taking as much code as
all the rest of fallocate.  And having some difference in command-line
parsing.  (e.g. supporting multiple file arguments, and a knobs or two
to control the digging.)  Would also want to document the caveats of
FIEMAP / FIBMAP, like e2fsprog's filefrag(8).

 I'd also like to have a --show-layout option with output like
xfs_bmap -vpl, or filefrag -e, but without the clutter of locations on
the FS's underlying blockdev.  It would make sense to be able to query
the results of preallocating, hole punching, etc. using the same tool
used to do them.  Also, filefrag doesn't show where there are holes,
unless you do the math to see if there are gaps between the extents.
xfs_bmap does, but only works on xfs.  (Which isn't the default FS
for most distros.)

 A dedicated tool for hole-punching could also incorporate options
for recursive operation over directories, (although that's not really
needed because find -exec {} + works great).  Summarizing results
across all the files it operated on would be good.  I was about to
start hacking something up when I googled to see if someone else had,
and saw that the latest fallocate got that feature.  Thoughts on
whether fallocate should stay simple, or if it's fine to have
different behaviour and cmdline handling for different modes.

 No reason fallocate couldn't loop over args for the other modes, but
-c, -p and -z especially are dangerous if the user accidentally leaves
an unintended file on the command line while editting a previous ls
command into a fallocate, or makes a copy/paste error.
---
 sys-utils/fallocate.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 9af3bb8ce1492defda57cc17764197790bb34c8e..9d9e9617d8eb12e33af41f842ba9d5a24aab7cef 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -195,6 +195,7 @@ static void dig_holes(int fd, off_t off, off_t len)
 		err(EXIT_FAILURE, _("stat failed %s"), filename);
 
 	bufsz = st.st_blksize;
+	const off_t min_holesz = min((off_t)1024*1024, st.st_size / 2);  // TODO: check --length?
 
 	if (lseek(fd, off, SEEK_SET) < 0)
 		err(EXIT_FAILURE, _("seek on %s failed"), filename);
@@ -218,18 +219,25 @@ static void dig_holes(int fd, off_t off, off_t len)
 
 		if (is_nul(buf, rsz)) {
 			if (!hole_sz) {				/* new hole detected */
+#if 0	/* FIXME: preallocated areas look like holes to SEEK_DATA */
 				int rc = skip_hole(fd, &off);
 				if (rc == 0)
 					continue;	/* hole skipped */
 				else if (rc == 1)
 					break;		/* end of file */
+#endif
 				hole_start = off;
 			}
 			hole_sz += rsz;
-		 } else if (hole_sz) {
-			xfallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE,
-				   hole_start, hole_sz);
-			ct += hole_sz;
+		} else if (hole_sz) {
+			if (hole_sz < min_holesz) {
+				if (verbose)
+					fprintf(stdout, "not holepunching only %jd kiB in %s\n", (intmax_t)(hole_sz / 1024), filename);
+			} else {
+				xfallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE,
+					   hole_start, hole_sz);
+				ct += hole_sz;
+			}
 			hole_sz = hole_start = 0;
 		}
 
@@ -247,6 +255,25 @@ static void dig_holes(int fd, off_t off, off_t len)
 	}
 
 	if (hole_sz) {
+		if (verbose) {
+			if (hole_sz < min_holesz) // even a small hole at end of file should be fine
+				fprintf(stdout, "allowing small hole (%jd kiB) at end of file\n", (intmax_t)(hole_sz / 1024));
+			else
+				fprintf(stdout, "hole %jd B (%jd kiB) at end of file\n", (intmax_t)hole_sz, (intmax_t)(hole_sz / 1024));
+		}
+		/* XFS and EXT4 (or maybe Linux in general) require us to
+		   punch all the way to the end of the block containing the end of the file.
+		   A punch that goes only to EOF will be treated as a partial-block punch,
+		   resulting in a block of allocated and zeroed space.  Tested on 3.13.0 (Ubuntu)
+		*/
+		const off_t remainder = hole_sz % bufsz;  // bufsz = st.st_blksize
+		if (end == 0 && remainder)
+			hole_sz += bufsz - remainder;
+		//hole_sz += bufsz - 1;		// Don't do anything stupid if used on a weird
+		//hole_sz &= ~(bufsz - 1);	// system where st_blksze isn't a power of 2
+
+		if (verbose > 1)
+			fprintf(stdout, "hole %jd B (%jd kiB) after rounding at end of file\n", (intmax_t)hole_sz, (intmax_t)(hole_sz / 1024));
 		xfallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE,
 				hole_start, hole_sz);
 		ct += hole_sz;
@@ -254,7 +281,7 @@ static void dig_holes(int fd, off_t off, off_t len)
 
 	free(buf);
 
-	if (verbose) {
+	if ((ct > 0 && verbose) || verbose > 2) {
 		char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE, ct);
 		fprintf(stdout, _("%s: %s (%ju bytes) converted to sparse holes.\n"),
 				filename, str, ct);
-- 
2.2.1



 Demonstration of how current version leaves a 4k block allocated at
the end of the file, if it isn't a multiple of st_blksize.  Also of
how you have to be careful with FIEMAP on files that are being
written.  Although if we don't care where on disk the region ended up,
then we might NOT need to fdatasync the file.  Note how filefrag
prints delalloc right after I dd some zeros.  xfs_bmap has the sync
thing as a side effect, since it uses an XFS ioctl instead of FIEMAP.

peter@tesla:/var/tmp/peter/tmp$ dd if=/dev/zero of=ztest4k bs=512 count=32
32+0 records in
32+0 records out
16384 bytes (16 kB) copied, 0.00027062 s, 60.5 MB/s
peter@tesla:/var/tmp/peter/tmp$ filefrag -e ztest4k 
Filesystem type is: 58465342
File size of ztest4k is 16384 (4 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       3:          0..         3:      4:             unknown,delalloc,eof
ztest4k: 1 extent found
peter@tesla:/var/tmp/peter/tmp$ xfs_bmap -vpl ztest4k 
ztest4k:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL FLAGS
   0: [0..31]:         7685000..7685031  0 (7685000..7685031)    32 00000
peter@tesla:/var/tmp/peter/tmp$ filefrag -e ztest4k 
Filesystem type is: 58465342
File size of ztest4k is 16384 (4 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       3:     960625..    960628:      4:             eof
ztest4k: 1 extent found
peter@tesla:/var/tmp/peter/tmp$ fallocate-2.25.2 -vvd ztest4k 
ztest4k: 16 KiB (16384 bytes) converted to sparse holes.
peter@tesla:/var/tmp/peter/tmp$ xfs_bmap -vpl ztest4k 
ztest4k: no extents
peter@tesla:/var/tmp/peter/tmp$ dd if=/dev/zero of=ztest.odd bs=512 count=33
33+0 records in
33+0 records out
16896 bytes (17 kB) copied, 0.000512697 s, 33.0 MB/s
peter@tesla:/var/tmp/peter/tmp$ xfs_bmap -vpl ztest.odd 
ztest.odd:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL FLAGS
   0: [0..39]:         7685000..7685039  0 (7685000..7685039)    40 00000
peter@tesla:/var/tmp/peter/tmp$ fallocate-2.25.2 -vvd ztest.odd 
ztest.odd: 16.5 KiB (16896 bytes) converted to sparse holes.
peter@tesla:/var/tmp/peter/tmp$ xfs_bmap -vpl ztest.odd 
ztest.odd:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL FLAGS
   0: [0..31]:         hole                                      32
   1: [32..39]:        7685032..7685039  0 (7685032..7685039)     8 00000
peter@tesla:/var/tmp/peter/tmp$ filefrag -e ztest.odd 
Filesystem type is: 58465342
File size of ztest.odd is 16896 (5 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        4..       4:     960629..    960629:      1:             eof
ztest.odd: 1 extent found
peter@tesla:/var/tmp/peter/tmp$ fallocate-local -vvd ztest.odd 
hole 16896 B (16 kiB) at end of file
hole 20480 B (20 kiB) after rounding at end of file
ztest.odd: 20 KiB (20480 bytes) converted to sparse holes.
peter@tesla:/var/tmp/peter/tmp$ xfs_bmap -vpl ztest.odd 
ztest.odd: no extents



strace -f xfs_bmap -vpl ztest.odd
[pid  8159] open("ztest.odd", O_RDONLY) = 3
[pid  8159] fstatfs(3, {f_type=0x58465342, f_bsize=4096, f_blocks=13100800, f_bfree=4007762, f_bavail=4007762, f_files=52428800, f_ffree=52041931, f_fsid={2067, 0}, f_namelen=255, f_frsize=4096}) = 0
[pid  8159] ioctl(3, 0xffffffff8070587c, 0x7fffceea1d90) = 0
[pid  8159] fstatfs(3, {f_type=0x58465342, f_bsize=4096, f_blocks=13100800, f_bfree=4007762, f_bavail=4007762, f_files=52428800, f_ffree=52041931, f_fsid={2067, 0}, f_namelen=255, f_frsize=4096}) = 0

 for those of you who are curious, but don't have an XFS mount available.


Also: check fragmentation on XFS (usable online, while FS is mounted,
but requires root because other xfs_db commands can do stuff.):

$ sudo xfs_db -c frag -r /dev/sdc1
actual 49988, ideal 47367, fragmentation factor 5.24%

xfs_fsr can defrag xfs.

I sometimes use this:
alias prealloc-mv='rsync --remove-source-files --preallocate -a'

It's not a good idea to always preallocate for everything, esp. small
files, because on XFS, preallocate also implies allocate start of file
on a RAID stripe boundary, so you fragment your free space if you use
it for small files.  This is historical behaviour from when writing
uncompressed video to one-frame-per-file in realtime required a raid
array.

 This overloading of the semantics of posix_fallocate on XFS is one of
the major reasons GNU cp and mv don't preallocate, even though they
know exactly how big the destination file will eventually be.  Maybe
if XFS kept their aligning behaviour for preallocation done with
xfs-specific ioctls, but dropped it for fallocate, that would allow
everyone to use it when they start writing a file that will hit a
known size and isn't expected to grow.  I gather that would be a lot
of work, though, since XFS is really designed to allocate during
writeback, to put stuff written at the same time near each other.

 Anyway, just thought I'd throw in this background info on prealloc,
to save everyone the trouble of thinking of having cp(1) prealloc, and
then finding out why it doesn't.

 Prealloc is still extremely useful for files that get written slowly,
or especially not linear order.  (e.g. torrent downloads.)
