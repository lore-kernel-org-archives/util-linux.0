Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:47486 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaDUAcP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Apr 2014 20:32:15 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 3/4] sfdisk.8: Improve the typesetting of the manual
Date: Mon, 21 Apr 2014 00:30:26 +0000
Message-Id: <1398040227-14535-3-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  FIXME
  Units KB, MB, GB, etc. are ambiguous (not necessarily used here)
  Prefixes kilo, mega, giga, etc. are ambiguous with the unit byte (ditto)

  Change ' \- ' to ' \(en ' (an en-dash), if it is a dash (pause,
separation)

  Change ' - ' to ' \(en ' (an en-dash), if it is a dash (pause,
separation)

  Change '\-' to '-' (code "hyphen-minus", rendered with the glyph
hyphen in troff), if it is a part of a compound name.
  A minus is not used in words.  People using UTF-8 and copy-and-paste
can(?) (may?) use "info", "man --ascii" or the command "man" should
have an option to display the '-' ("hyphen-minus") in names of options
with the code (character name) "hyphen-minus" (u002D) instead of
"u2010" (code (character) name "hyphen").

  Change '-' to '\-', if it indicates an option

  Protect a full stop (.), that begins or ends a string, with \&

  Correct space between sentences to two space characters (or begin
each sentence on a new line).

  Change '--' to '\-\-', if it indicates an option

  Add \~ (no-break space) around '|' (means "or")

  Change ' -- ' to ' \(en ' (an en-dash), if it is a dash (pause,
separation)

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/sfdisk.8 | 102 +++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 62d0ed0..894cfe4 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -18,7 +18,7 @@ sfdisk \- partition table manipulator for Linux
 .SH DESCRIPTION
 .B sfdisk
 has four (main) uses: list the size of a partition, list the partitions
-on a device, check the partitions on a device, and \- very dangerous \-
+on a device, check the partitions on a device, and \(en very dangerous \(en
 repartition a device.
 
 .B sfdisk
@@ -127,7 +127,7 @@ from a shell script.  When
 determines that its standard input is a terminal, it will be
 conversational; otherwise it will abort on any error.
 .LP
-BE EXTREMELY CAREFUL - ONE TYPING MISTAKE AND ALL YOUR DATA IS LOST
+BE EXTREMELY CAREFUL \(en ONE TYPING MISTAKE AND ALL YOUR DATA IS LOST
 .LP
 As a precaution, one can save the sectors changed by
 .BR sfdisk :
@@ -173,16 +173,16 @@ Display version information and exit.
 .BR \-h ", " \-\-help
 Display help text and exit.
 .TP
-.BR \-T ", " \-\-list\-types
+.BR \-T ", " \-\-list-types
 Print the recognized types (system Id's).
 .TP
-.BR \-s ", " \-\-show\-size
+.BR \-s ", " \-\-show-size
 List the size of a partition.
 .TP
-.BR \-g ", " \-\-show\-geometry
+.BR \-g ", " \-\-show-geometry
 List the kernel's idea of the geometry of the indicated block device(s).
 .TP
-.BR \-G ", " \-\-show\-pt\-geometry
+.BR \-G ", " \-\-show-pt-geometry
 List the geometry of the indicated block devices guessed by looking at
 the partition table.
 .TP
@@ -195,7 +195,7 @@ to \fBsfdisk\fR.  For example,
 .br
 .nf
 .if t .ft CW
-    % sfdisk -d /dev/hda > hda.out
+    % sfdisk \-d /dev/hda > hda.out
     % sfdisk /dev/hda < hda.out
 .if t .ft R
 .fi
@@ -206,7 +206,7 @@ fdisk creates.
 Test whether partitions seem correct.  (See the third invocation type above.)
 .TP
 .BR \-i ", " \-\-increment
-Number cylinders etc. starting from 1 instead of 0.
+Number cylinders etc.\& starting from 1 instead of 0.
 .TP
 .BI \-N " number"
 Change only the single partition indicated.  For example:
@@ -217,7 +217,7 @@ Change only the single partition indicated.  For example:
 .if t .ft R
 .fi
 will make the fifth partition on /dev/hdb bootable (`active')
-and change nothing else. (Probably this fifth partition
+and change nothing else.  (Probably this fifth partition
 is called /dev/hdb5, but you are free to call it something else,
 like `/my_equipment/disks/2/5' or so).
 .TP
@@ -230,7 +230,7 @@ for the device specified as command argument.  For example:
 .IP
 .nf
 .if t .ft CW
-    % sfdisk --activate /dev/sda
+    % sfdisk \-\-activate /dev/sda
 .fi
 .IP
 When a device name is given as option argument, the partitions specified
@@ -241,7 +241,7 @@ to be bootable, while 2 and 3 are cleared:
 .IP
 .nf
 .if t .ft CW
-    % sfdisk --activate=/dev/sda 1 4
+    % sfdisk \-\-activate=/dev/sda 1 4
 .fi
 .IP
 If only a single partition needs to be activated, then the partition number
@@ -249,7 +249,7 @@ must be given as option argument, and the device as command argument.  For examp
 .IP
 .nf
 .if t .ft CW
-    % sfdisk --activate=1 /dev/sda
+    % sfdisk \-\-activate=1 /dev/sda
 .fi
 .IP
 The activate option is turned by default on when the program's invocation name is
@@ -259,14 +259,14 @@ The activate option is turned by default on when the program's invocation name i
 If no \fIId\fR argument given: print the partition Id of the indicated
 partition.  If an \fIId\fR argument is present: change the type (Id) of
 the indicated partition to the given value.
-This option has two longer forms, \fB\-\-print\-id\fR and \fB\-\-change\-id\fR.
+This option has two longer forms, \fB\-\-print-id\fR and \fB\-\-change-id\fR.
 For example:
 .br
 .nf
 .if t .ft CW
-    % sfdisk --print-id /dev/hdb 5
+    % sfdisk \-\-print-id /dev/hdb 5
     6
-    % sfdisk --change-id /dev/hdb 5 83
+    % sfdisk \-\-change-id /dev/hdb 5 83
     OK
 .if t .ft R
 .fi
@@ -276,10 +276,12 @@ first reports that /dev/hdb5 has Id 6, and then changes that into 83.
 Interpret the input and show the output in the units specified by
 .IR letter .
 This \fIletter\fR can be one of S, C, B or M, meaning Sectors, Cylinders,
+.\" FIXME:  The unit "megabyte" is ambiguous.  Use "mebibyte" if "mega"
+.\" does not mean 10^6.  Otherwise add "(mega = 10^6)" after it.
 Blocks and Megabytes, respectively.  The default is
 cylinders, at least when the geometry is known.
 .TP
-.BR \-x ", " \-\-show\-extended
+.BR \-x ", " \-\-show-extended
 Also list non-primary extended partitions on output,
 and expect descriptors for them on input.
 .TP
@@ -304,7 +306,7 @@ Do not complain about things irrelevant for Linux.
 .BR \-D ", " \-\-DOS
 For DOS-compatibility: waste a little space.
 (More precisely: if a partition cannot contain sector 0,
-e.g. because that is the MBR of the device, or contains
+e.g.\& because that is the MBR of the device, or contains
 the partition table of an extended partition, then
 .B sfdisk
 would make it start the next sector.  However, when this
@@ -315,7 +317,7 @@ Certain Disk Managers and boot loaders (such as OSBS, but not
 LILO or the OS/2 Boot Manager) also live in this empty space,
 so maybe you want this option if you use one.
 .TP
-.BR \-E ", " \-\-DOS\-extended
+.BR \-E ", " \-\-DOS-extended
 Take the starting sector numbers of "inner" extended partitions
 to be relative to the starting cylinder boundary of the outer one
 (like some versions of DOS do), rather than relative to the actual
@@ -332,14 +334,14 @@ output.
 .IP
 .nf
 .if t .ft CW
-    % sfdisk --list-types | grep Hidden
+    % sfdisk \-\-list-types | grep Hidden
 .fi
 .IP
 Notice that the
 .B Hidden NTFS WinRE
 (Windows Recovery Environment) does not have non-hidden equivalent.
 .TP
-.BR \-\-IBM ", " \-\-leave\-last
+.BR \-\-IBM ", " \-\-leave-last
 Certain IBM diagnostic programs assume that they can use the
 last cylinder on a device for disk-testing purposes.  If you think
 you might ever run such programs, use this option to tell
@@ -359,23 +361,23 @@ If the kernel complains (`device busy for revalidation (usage = 2)')
 then something still uses the device, and you still have to unmount
 some file system, or say swapoff to some swap partition.
 .TP
-.B \-\-no\-reread
+.B \-\-no-reread
 When starting a repartitioning of a block device, \fBsfdisk\fR checks that this device
 is not mounted, or in use as a swap device, and refuses to continue
 if it is.  This option suppresses the test.  (On the other hand, the \fB\-f\fR
 option would force \fBsfdisk\fR to continue even when this test fails.)
 .TP
-.B \-\-in\-order
+.B \-\-in-order
 Partitions are in order.  See also warning section.
 .TP
-.B \-\-not\-in\-order
+.B \-\-not-in-order
 Partitions are not in order.  See also warning section.
 .TP
-.B \-\-inside\-outer
+.B \-\-inside-outer
 All logical partitions are inside outermost extended.  See also warning
 section and chaining.
 .TP
-.B \-\-not\-inside\-outer
+.B \-\-not-inside-outer
 Some, or none, of the logical partitions are not inside outermost
 extended.  See also warning section and chaining.
 .TP
@@ -413,7 +415,7 @@ Reserved option that does nothing currently.
 
 .SH THEORY
 Block 0 of a block device (the Master Boot Record) contains among
-other things four partition descriptors. The partitions
+other things four partition descriptors.  The partitions
 described here are called
 .I primary
 partitions.
@@ -434,13 +436,17 @@ struct partition {
 .fi
 .LP
 The two hsc fields indicate head, sector and cylinder of the
-begin and the end of the partition. Since each hsc field only
+begin and the end of the partition.  Since each hsc field only
 takes 3 bytes, only 24 bits are available, which does not
-suffice for big block devices (say > 8GB). In fact, due to the wasteful
+.\" FIXME
+.\" The unit "GB" is ambiguous.  Use "GiB" if "G" does not mean
+.\" 10^9.  Otherwise add "(G = 10^9)" after it.
+suffice for big block devices (say > 8\ GB).  In fact, due to the wasteful
 representation (that uses a byte for the number of heads, which
-is typically 16), problems already start with 0.5GB.
+.\" FIXME GB (see 4 lines earlier)
+is typically 16), problems already start with 0.5\ GB.
 However Linux does not use these fields, and problems can arise
-only at boot time, before Linux has been started. For more
+only at boot time, before Linux has been started.  For more
 details, see the
 .B lilo
 documentation.
@@ -448,12 +454,12 @@ documentation.
 Each partition has a type, its `Id', and if this type is 5 or f
 .IR "" "(`" "extended partition" "')"
 the starting sector of the partition
-again contains 4 partition descriptors. MSDOS only uses the
+again contains 4 partition descriptors.  MSDOS only uses the
 first two of these: the first one an actual data partition,
 and the second one again an extended partition (or empty).
 In this way one gets a chain of extended partitions.
 Other operating systems have slightly different conventions.
-Linux also accepts type 85 as equivalent to 5 and f - this can be
+Linux also accepts type 85 as equivalent to 5 and f \(en this can be
 useful if one wants to have extended partitions under Linux past
 the 1024 cylinder boundary, without DOS FDISK hanging.
 (If there is no good reason, you should just use 5, which is
@@ -465,8 +471,8 @@ Often, one cannot boot from logical partitions (because the
 process of finding them is more involved than just looking
 at the MBR).
 Note that of an extended partition only the Id and the start
-are used. There are various conventions about what to write
-in the other fields. One should not try to use extended partitions
+are used.  There are various conventions about what to write
+in the other fields.  One should not try to use extended partitions
 for data storage or swap.
 
 .SH "INPUT FORMAT"
@@ -483,19 +489,19 @@ followed by whitespace; initial and trailing whitespace is ignored.
 Numbers can be octal, decimal or hexadecimal, decimal is default.
 When a field is absent or empty, a default value is used.
 .LP
-The <c,h,s> parts can (and probably should) be omitted -
+The <c,h,s> parts can (and probably should) be omitted \(en
 .B sfdisk
 computes them from <start> and <size> and the block device geometry
 as given by the kernel or specified using the \-H, \-S, \-C flags.
 .LP
 Bootable is specified as [*|\-], with as default not-bootable.
-(The value of this field is irrelevant for Linux - when Linux
-runs it has been booted already - but might play a role for
+(The value of this field is irrelevant for Linux \(en when Linux
+runs it has been booted already \(en but might play a role for
 certain boot loaders and for other operating systems.
 For example, when there are several primary DOS partitions,
 DOS assigns C: to the first among these that is bootable.)
 .LP
-Id is given in hex, without the 0x prefix, or is [E|S|L|X], where
+Id is given in hex, without the 0x prefix, or is [E\~|\~S\~|\~L\~|\~X], where
 L (LINUX_NATIVE (83)) is the default, S is LINUX_SWAP (82), E
 is EXTENDED_PARTITION (5), and X is LINUX_EXTENDED (85).
 .LP
@@ -511,7 +517,7 @@ But when the \-N option (change a single partition only) is given,
 the default for each field is its previous value.
 .LP
 A '+' can be specified instead of a number for size, which means
-as much as possible. This is useful with the \-N option.
+as much as possible.  This is useful with the \-N option.
 .SH EXAMPLE
 The command
 .RS
@@ -547,13 +553,13 @@ EOF
 .RE
 will partition /dev/hdb into two Linux partitions of 3 and 60
 cylinders, a swap space of 19 cylinders, and an extended partition
-covering the rest. Inside the extended partition there are four
+covering the rest.  Inside the extended partition there are four
 Linux logical partitions, three of 130 cylinders and one
 covering the rest.
 
 With the \-x option, the number of input lines must be a multiple of 4:
 you have to list the two empty partitions that you never want
-using two blank lines. Without the \-x option, you give one line
+using two blank lines.  Without the \-x option, you give one line
 for the partitions inside a extended partition, instead of four,
 and terminate with end-of-file (^D).
 (And
@@ -572,7 +578,7 @@ sector of the data area of the partition, and treats this information
 as more reliable than the information in the partition table.  DOS
 FORMAT expects DOS FDISK to clear the first 512 bytes of the data area
 of a partition whenever a size change occurs.  DOS FORMAT will look at
-this extra information even if the /U flag is given -- we consider
+this extra information even if the /U flag is given \(en we consider
 this a bug in DOS FORMAT and DOS FDISK.
 .LP
 The bottom line is that if you use sfdisk to change the size of a
@@ -606,16 +612,16 @@ start of the next partition.  Mind you, as long as I keep a little
 free device space after any DRDOS partition, I don't have any other
 problems with the two coexisting on the one drive.'
 
-A. V. Le Blanc writes in README.efdisk: `Dr. DOS 5.0 and 6.0 has been
+A.\& V.\& Le Blanc writes in README.efdisk: `Dr.\& DOS 5.0 and 6.0 has been
 reported to have problems cooperating with Linux, and with this version
 of efdisk in particular.  This efdisk sets the system type
-to hexadecimal 81.  Dr. DOS seems to confuse
-this with hexadecimal 1, a DOS code.  If you use Dr. DOS, use the
+to hexadecimal 81.  Dr.\& DOS seems to confuse
+this with hexadecimal 1, a DOS code.  If you use Dr.\& DOS, use the
 efdisk command 't' to change the system code of any Linux partitions
 to some number less than hexadecimal 80; I suggest 41 and 42 for
 the moment.'
 
-A. V. Le Blanc writes in his README.fdisk: `DR-DOS 5.0 and 6.0
+A.\& V.\& Le Blanc writes in his README.fdisk: `DR-DOS 5.0 and 6.0
 are reported to have difficulties with partition ID codes of 80 or more.
 The Linux `fdisk' used to set the system type
 of new partitions to hexadecimal 81.  DR-DOS seems to confuse this with
@@ -626,8 +632,8 @@ partitions to some number less than hexadecimal 80; I suggest 42 and 43
 for the moment.'
 
 In fact, it seems that only 4 bits are significant for the DRDOS FDISK,
-so that for example 11 and 21 are listed as DOS 2.0. However, DRDOS
-itself seems to use the full byte. I have not been able to reproduce
+so that for example 11 and 21 are listed as DOS 2.0.  However, DRDOS
+itself seems to use the full byte.  I have not been able to reproduce
 any corruption with DRDOS or its fdisk.
 
 .SH BUGS
-- 
1.9.0

