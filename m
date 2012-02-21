Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34249 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab2BUUT1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Feb 2012 15:19:27 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4A79E914CD
	for <util-linux@vger.kernel.org>; Tue, 21 Feb 2012 21:19:26 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] docs: trivial documentation fixes and improvements
Date: Tue, 21 Feb 2012 21:19:25 +0100
Message-Id: <1329855565-20542-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Documentation/00-about-docs.txt        |    2 +-
 Documentation/deprecated.txt           |    2 +-
 Documentation/fdisk.txt                |    6 +++---
 Documentation/getopt.txt               |    6 +++---
 Documentation/howto-build-sys.txt      |    2 +-
 Documentation/howto-debug.txt          |   12 ++++++------
 Documentation/howto-man-page.txt       |    6 +++---
 Documentation/howto-usage-function.txt |   22 +++++++++++-----------
 Documentation/release-schedule.txt     |    6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/00-about-docs.txt b/Documentation/00-about-docs.txt
index 650e420..b95ae44 100644
--- a/Documentation/00-about-docs.txt
+++ b/Documentation/00-about-docs.txt
@@ -1,7 +1,7 @@
 What is here
 ------------
 
-The util-linux contains suplementary textual material, such as
+The util-linux contains supplementary textual material, such as
 readme files, release notes, licenses and so on. Common to these
 files is that they contain information for contributors but
 should not end up to end user installation.
diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 7c6b0d3..cbed7de 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -26,7 +26,7 @@ Why:	useless for kernel >= 2.6.9
 What:	arch(1) command
 Why:	deprecated in favor of uname(1) or arch(1) from coreutils
 
-	The arch(1) has been added (during 2.13 development cycle) to coreutuls
+	The arch(1) has been added (during 2.13 development cycle) to coreutils
 	where it will be maintained as an alias for uname(1) command.
 
 ----------------------------
diff --git a/Documentation/fdisk.txt b/Documentation/fdisk.txt
index 3ea4d44..a480ac5 100644
--- a/Documentation/fdisk.txt
+++ b/Documentation/fdisk.txt
@@ -24,7 +24,7 @@ called "platters", which rotate about a central axis.  Devices called
 "heads" move to specified places on the disk surface to read or write
 information.  There is usually one head on each side of every platter,
 and all these heads are attached to a comb-like controller arm which
-moves all of them at the same time, either closer to the centre of the
+moves all of them at the same time, either closer to the center of the
 disk, or closer to the outer edge.
 
 Suppose the arm is in one position, putting an area of the disk
@@ -117,7 +117,7 @@ on your disk.  If you set aside a partition for some purpose, it is not
 easy to change its size: you must backup all the data from the partition,
 whether to floppies, to another partition, to another hard disk, or
 somewhere else; then you must edit the table which describes this
-partition, so changing its size; then you must reboot and initialise
+partition, so changing its size; then you must reboot and initialize
 the new partition, formatting it, for example, under DOS, or running
 `mkfs' under Linux; finally you can copy all the data back.  It is
 possible, if you have several partitions, to copy data back and forth
@@ -388,7 +388,7 @@ specify the size of a partition in megabytes, kilobytes, or in the
 current units (cylinders or sectors).  A plus sign `+' indicates that
 your answer is a size rather than a boundary, and the suffix `m' or `k'
 (upper or lower case) indicates that the size is not given in units of
-sectors or cyliners, but in megabytes or kilobytes respectively.  Thus
+sectors or cylinders, but in megabytes or kilobytes respectively.  Thus
 possible answers to the last cylinder request above are
 
 700
diff --git a/Documentation/getopt.txt b/Documentation/getopt.txt
index 8258e88..e6764fe 100644
--- a/Documentation/getopt.txt
+++ b/Documentation/getopt.txt
@@ -23,9 +23,9 @@ It is fully compatible with other getopt(1) implementations.
 
 COPYING
 
-This program comes under the GNU general public licence version 2. See the 
+This program comes under the GNU general public license version 2. See the
 file COPYING included in this package. Note that though you may freely
-copy it, it is copyright (c) 1997-2005 by Frodo Looijaard 
+copy it, it is copyright (c) 1997-2005 by Frodo Looijaard
 <frodo@frodo.looijaard.name>.
-Files in the gnu directory are from glibc-2.0.4: copyright (C) 1987, 88, 
+Files in the gnu directory are from glibc-2.0.4: copyright (C) 1987, 88,
 89, 90, 91, 92, 93, 94, 95, 96, 97 Free Software Foundation, Inc.
diff --git a/Documentation/howto-build-sys.txt b/Documentation/howto-build-sys.txt
index 7565c45..1e77436 100644
--- a/Documentation/howto-build-sys.txt
+++ b/Documentation/howto-build-sys.txt
@@ -3,7 +3,7 @@ util-linux build system
 
  - all util-linux specific autoconf macros use UL_ prefix
 
- - utils in Makedile.am files are enabled/disabled according to BUILD_<NAME>
+ - utils in Makefile.am files are enabled/disabled according to BUILD_<NAME>
    conditions (AM_CONDITIONAL), for example:
 
 	if BUILD_HWCLOCK
diff --git a/Documentation/howto-debug.txt b/Documentation/howto-debug.txt
index 99e2755..ca7346f 100644
--- a/Documentation/howto-debug.txt
+++ b/Documentation/howto-debug.txt
@@ -42,19 +42,19 @@ The libmount & libblkid
 -----------------------
 
 Both of the libraries can be debugged by setting an environment variable
-consistig a number. The number will be used as a bit mask, so the more 1 the
-greater the debugging level. Seach for `DEBUG' from files
+consisting of a number. The number will be used as a bit mask, so the more 1 the
+higher the debugging level. Search for `DEBUG' from files
 
 	libblkid/src/blkidP.h
 	libmount/src/mountP.h
 
-to see what the different bit mean. At the time of writing this the following
+to see what the different bits mean. At the time of writing this the following
 enabled full debug.
 
 	export LIBBLKID_DEBUG=0xffff
 	export LIBMOUNT_DEBUG=0xffff
 
-The libblkid reads by default /etc/blkid.conf which can be overriden by the
+The libblkid reads by default /etc/blkid.conf which can be overridden by the
 environment variable BLKID_CONF. See manual libblkid/libblkid.3 for details
 about the configuration file.
 
@@ -62,9 +62,9 @@ Block device information is normally kept in a cache file (see blkid man page
 for more information about the cache file location) that can be overridden by
 the environment variable BLKID_FILE.
 
-To libmount uses three paths, which can be override by using environment
+To libmount uses three paths, which can be overridden by using environment
 variables. Notice that these environment variables are ignored for non-root
-users
+users.
 
 	env variable		if not set defaults to
 	LIBMOUNT_FSTAB		/etc/fstab
diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index db25c3d..c217962 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -37,7 +37,7 @@ Tell in description an
 .I argument
 is optional, and what happens when is or is not given.  Notice that
 .I argument
-is not abreviated, like in usage function.  Assuming usage function would
+is not abbreviated, like in usage function.  Assuming usage function would
 define argument to be
 .IR num ,
 the manual page should say
@@ -83,12 +83,12 @@ When in the source a new sentence begins somewhere midline, it should use a
 double space before its initial letter.  This is done because groff uses double
 spaces last sentence ends to end of line, and next begins from new line.
 Unless double spaces are used in middle of of line the spacing style is
-inconsistant.
+inconsistent.
 .SH ENVIRONMENT
 Tell which environment variables affect, and how, to execution of the command.
 .TP
 .B EXAMPLE_PATH
-Configuratio file path.  Notice that a well-known environment variables such as
+Configuration file path.  Notice that a well-known environment variables such as
 .B HOME
 does not need explanation.
 .SH FILES
diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 18ee3de..70116b2 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -1,7 +1,7 @@
 Well-known options
 ------------------
 
-Following options are well-known, and they should not be used to any
+Following options are well-known, and they should not be used for any
 other purpose.
 
  -h, --help     display usage and exit
@@ -17,12 +17,12 @@ options resulting to a usage print out due getopt failure.
 How usage is supposed to look
 -----------------------------
 
-The usage output begins with empty followed by `Usage:', and on next line
-there synopsis begins. Synopsis, and all other lines which vary, are
-intended by one space (0x40).
+The usage output begins with empty line followed by `Usage:' and synopsis
+beginning on the next line. Synopsis and all other lines which vary are
+indented by one space (0x40).
 
-The synopsis line tells how to execute the command. Some times you may
-need multiple synopsis lines, this documented separately under Synopsis
+The synopsis line describes how to execute the command. Sometimes you may
+need multiple synopsis lines, this is documented separately under Synopsis
 title.
 
 Notations; Diamond brackets markup an argument. Anything optional is
@@ -31,11 +31,11 @@ optional option arguments. In the later case `=' character in front of
 the option argument, because one has to use it. Square brackets with
 three dots inside mean unlimited repetition of previous.
 
-Short option is always wrote first followed by long option. Options are
-separated with comma and one space. Lonely short or long option does not
+Short option are always written first followed by long option. Options are
+separated with comma and one space. Lonely short or long option do not
 affect where writing of the option begins.
 
-Bellow, in between snips, is an example of how the usage output should
+Below, in between snips, is an example of how the usage output should
 look like.
 
 -- snip
@@ -75,7 +75,7 @@ Option description should not exceed width of 80 characters. If you need
 longer description use multiple lines and indentation.
 
 The description begins from the point of longest option plus two spaces.
-In case adding a new option will would cause a description re-indentation
+In case adding a new option would cause a description re-indentation
 need it either has to be done, or the new option should begin description
 from next line. Usually the later is better. The --help and --version
 will not follow this rule, since they are defined as constants to ease
@@ -121,7 +121,7 @@ synopsis lines.
  ionice [options] -p <pid> [...]
  ionice [options] <command> [<args>] [...]
 
-Notice that the synopsis not meant to be repetition of options segment.
+Notice that the synopsis is not meant to be repetition of options segment.
 The fundamental difference in execution is a bit difficult to define
 other than usually command author, package maintainer or patch submitter
 will know when it should be done that way.
diff --git a/Documentation/release-schedule.txt b/Documentation/release-schedule.txt
index 7e069db..6bdc2a9 100644
--- a/Documentation/release-schedule.txt
+++ b/Documentation/release-schedule.txt
@@ -4,7 +4,7 @@ Release schedule
 The util-linux uses <major>.<minor>.<maint> version numbering.
 Since the major version is pretty much fixed the release means an
 upgrade of minor number. Minor version is update roughly twice
-per year. Easiet way to estimate when next version will occur is
+per year. Easiest way to estimate when next version will occur is
 to see time stamp of previous release.
 
 Before a release there are few release candidates, which will be
@@ -16,8 +16,8 @@ restricted. Usually there are two release candidates.
   rc1	 1-2 weeks	bug fixes only
   rc2	 1-2 weeks	translations, fatal/trivial bug fixes
 
-The lengty time, usually about five months, after the release can
-be considered as merge window.
+The period between a release and next release candidate can be considered as
+merge window.
 
 Release criteria
 ----------------
-- 
1.7.7

