Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:53210 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753548AbaGPVJy (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 17:09:54 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: bring four more man pages closer to standard formatting
Date: Wed, 16 Jul 2014 23:09:50 +0200
Message-Id: <1405544990-3438-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In the IPC man pages strictly adhere to the memory, queue, semaphore
order, to reduce disorientation.  And for 'ipcmk', the arguments for
-M and -S and -p are not optional.  Add --version for 'mountpoint'.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ipcmk.1      |   39 ++++++++++++++++++++-------------------
 sys-utils/ipcrm.1      |   16 ++++++++--------
 sys-utils/ipcs.1       |   26 ++++++++++++++------------
 sys-utils/mountpoint.1 |   37 +++++++++++++++++++++++--------------
 4 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index 0bac9a0..f79a717 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -1,41 +1,42 @@
 .\" Copyright 2008 Hayden A. James (hayden.james@gmail.com)
 .\" May be distributed under the GNU General Public License
-.TH IPCMK "1" "September 2011" "util-linux" "User Commands"
+.TH IPCMK "1" "July 2014" "util-linux" "User Commands"
 .SH "NAME"
-ipcmk \- create various ipc resources
+ipcmk \- make various IPC resources
 .SH "SYNOPSIS"
 .B ipcmk
-<resource options>
-[additional options]
+[options]
 .SH "DESCRIPTION"
 .B ipcmk
-allows you to create shared memory segments, message queues or semaphore arrays.
-.SH "RESOURCE OPTIONS"
+allows you to create shared memory segments, message queues,
+and semaphore arrays.
+.SH "OPTIONS"
 .TP
-Resources may be specified as follows:
+Resources can be specified with these options:
 .TP
-\fB\-M\fR, \fB\-\-shmem\fR [\fIsize\fR]
-Shared memory segment of
+.BR \-M , " \-\-shmem \fIsize\fR"
+Create a shared memory segment of
 .I size
 bytes.
 .TP
-\fB\-S\fR, \fB\-\-semaphore\fR [\fInumber\fR]
-Semaphore array with
+.BR \-Q , " \-\-queue"
+Create a message queue.
+.TP
+.BR \-S , " \-\-semaphore \fInumber\fR"
+Create a semaphore array with
 .I number
 of elements.
+.PP
+Other options are:
 .TP
-\fB\-Q\fR, \fB\-\-queue\fR
-Message queue.
-.SH "ADDITIONAL OPTIONS"
-.TP
-\fB\-p\fR, \fB\-\-mode\fR [\fImode\fR]
+.BR \-p , " \-\-mode \fImode\fR"
 Access permissions for the resource.  Default is 0644.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help text and exit.
-.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
 .PP
 .SH "SEE ALSO"
 .BR ipcrm (1),
diff --git a/sys-utils/ipcrm.1 b/sys-utils/ipcrm.1
index 51ccd48..bdec3b8 100644
--- a/sys-utils/ipcrm.1
+++ b/sys-utils/ipcrm.1
@@ -1,14 +1,14 @@
 .\" Copyright 2002 Andre C. Mazzone (linuxdev@karagee.com)
 .\" May be distributed under the GNU General Public License
-.TH IPCRM "1" "September 2011" "util-linux" "User Commands"
+.TH IPCRM "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
-ipcrm \- remove a message queue, semaphore set or shared memory id
+ipcrm \- remove certain IPC resources
 .SH SYNOPSIS
 .B ipcrm
-.RI [ options ]
-.br
+[options]
+.sp
 .B ipcrm
-.RB { shm | msg | sem } 
+.RB { shm | msg | sem }
 .IR id ...
 .SH DESCRIPTION
 .B ipcrm
@@ -74,15 +74,15 @@ objects.  Some programs create these resources at startup and may not have
 any code to deal with an unexpected disappearance.
 .LP
 The details of the removes are described in
-.BR msgctl (2),
 .BR shmctl (2),
+.BR msgctl (2),
 and
 .BR semctl (2).
-The identifiers and keys may be found by using
+The identifiers and keys can be found by using
 .BR ipcs (1).
 .SH NOTES
 In its first Linux implementation, \fBipcrm\fR used the deprecated syntax
-shown in the
+shown in the second line of the
 .BR SYNOPSIS .
 Functionality present in other *nix implementations of \fBipcrm\fR has since
 been added, namely the ability to delete resources by key (not just
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 453ce5c..6c92580 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -1,24 +1,26 @@
 .\" Copyright 1993 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be distributed under the GNU General Public License
-.TH IPCS "1" "January 2013" "util-linux" "User Commands"
+.TH IPCS "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
-ipcs \- provide information on IPC facilities
+ipcs \- show information on IPC facilities
 .SH SYNOPSIS
 .B ipcs
-.RB [ resource\-option "] [" output\-format ]
-.br
-.B ipcs
-.RB [ resource\-option ]
-.BI \-i " id"
+[options]
 .SH DESCRIPTION
 .B ipcs
-provides information on the inter-process communication facilities
+shows information on the inter-process communication facilities
 for which the calling process has read access.
+By default it shows information about all three resources:
+shared memory segments, message queues, and semaphore arrays.
 .SH OPTIONS
 .TP
 \fB\-i\fR, \fB\-\-id\fR \fIid\fR
-Print details only on the resource identified by
+Show full details on just the one resource element identified by
 .IR id .
+This option needs to be combined with one of the three resource options:
+.BR \-m ,
+.BR \-q " or"
+.BR \-s .
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
@@ -27,12 +29,12 @@ Display help text and exit.
 Display version information and exit.
 .SS "Resource options"
 .TP
-\fB\-q\fR, \fB\-\-queues\fR
-Write information about active message queues.
-.TP
 \fB\-m\fR, \fB\-\-shmems\fR
 Write information about active shared memory segments.
 .TP
+\fB\-q\fR, \fB\-\-queues\fR
+Write information about active message queues.
+.TP
 \fB\-s\fR, \fB\-\-semaphores\fR
 Write information about active semaphore sets.
 .TP
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index 6874624..29c153c 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -1,29 +1,38 @@
 .\" -*- nroff -*-
-.TH MOUNTPOINT 1 "June 2011" "util-linux" "User Commands"
+.TH MOUNTPOINT 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 mountpoint \- see if a directory is a mountpoint
 .SH SYNOPSIS
 .B mountpoint
-.RB [ \-q ]
-.RB [ \-d ]
+.RB [ \-d | \-q ]
 .I directory
-
+.sp
 .B mountpoint
-.RB \-x
+.B \-x
 .I device
 
 .SH DESCRIPTION
 .B mountpoint
-checks if the directory is mentioned in the /proc/self/mountinfo file.
+checks whether the given
+.I directory
+is mentioned in the /proc/self/mountinfo file.
 .SH OPTIONS
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
-.IP "\fB\-q, \-\-quiet\fP"
+.TP
+.BR \-d , " \-\-fs\-devno"
+Show the major/minor numbers of the device that is mounted on the given
+directory.
+.TP
+.BR \-q , " \-\-quiet"
 Be quiet - don't print anything.
-.IP "\fB\-d, \-\-fs\-devno\fP"
-Print major/minor device number of the filesystem on stdout.
-.IP "\fB\-x, \-\-devno\fP"
-Print major/minor device number of the blockdevice on stdout.
+.TP
+.BR \-x , " \-\-devno"
+Show the major/minor numbers of the given blockdevice on standard output.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH EXIT STATUS
 Zero if the directory is a mountpoint, non-zero if not.
 .SH AUTHOR
@@ -36,7 +45,7 @@ enables debug output.
 .PP
 The util-linux
 .B mountpoint
-implementation was written from scratch for libmount. The original version
+implementation was written from scratch for libmount.  The original version
 for sysvinit suite was written by Miquel van Smoorenburg.
 
 .SH SEE ALSO
-- 
1.7.0.4

