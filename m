Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235AbaDHHs4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:56 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387muHU011372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:56 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTn004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:55 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/10] utmpdump: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:44 +0200
Message-Id: <1396943329-22347-6-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/utmpdump.1 | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 7069159..7a7442a 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -2,13 +2,13 @@
 .\" Copyright (C) 2010 Michael Krapp
 .\"
 .\" This program is free software; you can redistribute it and/or modify
-.\" it under the terms of the GNU General Public License as published by 
+.\" it under the terms of the GNU General Public License as published by
 .\" the Free Software Foundation; either version 2 of the License, or
 .\" (at your option) any later version.
 .\"
 .\" This program is distributed in the hope that it will be useful,
 .\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
 .\" You should have received a copy of the GNU General Public License
@@ -25,16 +25,16 @@ utmpdump [\-frohV] [ filename ]
 is a simple program to dump UTMP and WTMP files in raw format, so they
 can be examined.
 .B utmpdump
-eads from stdin unless a 
+reads from stdin unless a
 .I filename
 is passed.
 .SH OPTIONS
 .IP "\fB\-f\fR, \fB\-\-follow\fP"
 Output appended data as the file grows.
 .IP "\fB\-r\fR, \fB\-\-reverse\fP
-Undump, write back edited login information into utmp or wtmp files.
+Undump, write back edited login information into the utmp or wtmp files.
 .IP "\fB\-o\fR, \fB\-\-output\fP \fIfile\fR
-Write command output to file instead of standard output.
+Write command output to \fIfile\fR instead of standard output.
 .IP "\fB\-h\fR, \fB\-\-help\fP"
 Display help text and exit.
 .IP "\fB\-V\fR, \fB\-\-version\fP"
@@ -42,25 +42,25 @@ Display version information and exit.
 .SH NOTES
 .B utmpdump
 can be useful in cases of corrupted utmp or wtmp entries.  It can dump
-out utmp/wtmp to an ASCII file, then that file can be edited to remove
+out utmp/wtmp to an ASCII file, whic can then be edited to remove
 bogus entries and reintegrated, using
-.PP 
+.PP
 .RS
 utmpdump -r < ascii_file > wtmp
 .RE
 .PP
-but be warned as
+but be warned, as
 .B utmpdump
-was written for debugging purpose only.
+was written for debugging purposes only.
 .SH BUGS
 You may
 .B not
-use the option
+use the
 .B \-r
-as the format for the utmp/wtmp files strongly depends on the input
+option, as the format for the utmp/wtmp files strongly depends on the input
 format.  This tool was
 .B not
-written for normal use but for debugging.
+written for normal use, but for debugging only.
 .SH AUTHOR
 Michael Krapp
 .SH "SEE ALSO"
-- 
1.8.5.1

