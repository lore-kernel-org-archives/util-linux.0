Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A62C433DF
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 23:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDBC206D9
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 23:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFJX5Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgFJX5Y (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 19:57:24 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADBC03E96B
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 16:57:24 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05ANvMNM016528
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 23:57:22 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05ANvMNM016528
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05ANvMGW024400
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 23:57:22 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05ANvMC6024399
        for util-linux@vger.kernel.org; Wed, 10 Jun 2020 23:57:22 GMT
Date:   Wed, 10 Jun 2020 23:57:22 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: misc-utils/*: Fix some warnings from "mandoc -T lint"
Message-ID: <20200610235722.GA24368@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./misc-utils/cal.1:214:2: WARNING: skipping paragraph macro: br after sp
mandoc: ./misc-utils/cal.1:216:2: WARNING: skipping paragraph macro: br before sp
mandoc: ./misc-utils/cal.1:225:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./misc-utils/findfs.8:36:2: WARNING: skipping paragraph macro: br after sp
mandoc: ./misc-utils/findfs.8:38:2: WARNING: skipping paragraph macro: br before sp
mandoc: ./misc-utils/findfs.8:41:2: WARNING: skipping paragraph macro: br before sp
mandoc: ./misc-utils/findfs.8:44:2: WARNING: skipping paragraph macro: br before sp
mandoc: ./misc-utils/findfs.8:48:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./misc-utils/logger.1:118:15: STYLE: unterminated quoted argument
mandoc: ./misc-utils/logger.1:231:2: WARNING: skipping paragraph macro: IP empty

mandoc: ./misc-utils/look.1:116:2: STYLE: fill mode already disabled, skipping: nf

mandoc: ./misc-utils/hardlink.1:1:5: STYLE: lower case character in document title: TH hardlink
mandoc: ./misc-utils/hardlink.1:1:2: WARNING: missing date, using today's date: TH
mandoc: ./misc-utils/hardlink.1:9:2: WARNING: skipping paragraph macro: PP after SH
mandoc: ./misc-utils/hardlink.1:52:2: WARNING: skipping paragraph macro: PP after SH
mandoc: ./misc-utils/hardlink.1:65:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./misc-utils/rename.1:65:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./misc-utils/rename.1:65:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./misc-utils/rename.1:97:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./misc-utils/rename.1:107:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./misc-utils/rename.1:116:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./misc-utils/whereis.1:82:2: WARNING: line scope broken: IP breaks TP
mandoc: ./misc-utils/whereis.1:152:2: WARNING: skipping paragraph macro: PP empty

####

  There is no change in the ouput of "nroff" or "groff", except for

1) a very long line in "logger.1".

2) '-' changed to '\-' for a option in "logger.1".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 misc-utils/cal.1      |  3 ---
 misc-utils/findfs.8   |  5 -----
 misc-utils/hardlink.1 |  3 ---
 misc-utils/logger.1   | 11 ++++++-----
 misc-utils/look.1     |  2 +-
 misc-utils/rename.1   | 15 +++++++--------
 misc-utils/whereis.1  |  2 --
 7 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index ac606b355..2115e9af3 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -211,9 +211,7 @@ numbering is used, where the first Thursday is in week number 1.
 Implicit coloring can be disabled as follows:
 .RS
 
-.br
 .B touch /etc/terminal-colors.d/cal.disable
-.br
 
 .RE
 See
@@ -222,7 +220,6 @@ for more details about colorization configuration.
 .SH HISTORY
 A cal command appeared in Version 6 AT&T UNIX.
 .SH BUGS
-.PP
 The default
 .B cal
 output uses 3 September 1752 as the Gregorian calendar reform date.  The
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 26762f83d..59466c1b0 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -33,19 +33,14 @@ The complete overview about filesystems and partitions you can get for example
 by
 .RS
 
-.br
 .B lsblk \-\-fs
-.br
 
 .B partx --show <disk>
-.br
 
 .B blkid
-.br
 
 .RE
 
-.PP
 .SH EXIT STATUS
 .RS
 .PD 0
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index cb23ab190..de26d34b7 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -6,7 +6,6 @@ hardlink \- Consolidate duplicate files via hardlinks
 [options]
 .RI [ directory ...]
 .SH DESCRIPTION
-.PP
 This manual page documents \fBhardlink\fR, a
 program which consolidates duplicate files in one or more directories
 using hardlinks.
@@ -49,7 +48,6 @@ Display help text and exit.
 .BR \-V , " \-\-version"
 Display version information and exit.
 .SH BUGS
-.PP
 \fBhardlink\fR assumes that its target directory trees do not change from under
 it.  If a directory tree does change, this may result in \fBhardlink\fR
 accessing files and/or directories outside of the intended directory tree.
@@ -62,7 +60,6 @@ other characters. That prior behavior can be achieved by specifying
 .br
 \-x '^(\\.in\\.|\\.[^.]{6}$)'
 .SH AUTHORS
-.PP
 \fBhardlink\fR was written by Jakub Jelinek <jakub@redhat.com> and later modified by
 Ruediger Meier <ruediger.meier@ga-group.nl> and Karel Zak <kzak@redhat.com> for util-linux.
 .PP
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 3cf6b0b1e..448311d03 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -115,7 +115,7 @@ To include newlines in MESSAGE, specify MESSAGE several times.  This is
 handled as a special case, other fields will be stored as an array in
 the journal if they appear multiple times.
 .TP
-.BR \-\-msgid " \fImsgid
+.BI \-\-msgid " msgid"
 Sets the RFC5424 MSGID field.  Note that the space character is not permitted
 inside of \fImsgid\fR.  This option is only used if \fB\-\-rfc5424\fR is
 specified as well; otherwise, it is silently ignored.
@@ -225,12 +225,13 @@ than once for the same element.  Note that the quotation marks around
 .IP
 produces:
 .IP
-.nf
+.\".nf
+.\" this long line gets cut of in the output of "troff", and wraps
+.\" in "nroff"
 \fB  <13>1 2015-10-01T14:07:59.168662+02:00 ws kzak - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="218616"][zoo@123 tiger="hungry" zebra="running"][manager@123 onMeeting="yes"] this is message
-.fi
-.IP
+.\".fi
 .TP
-.BR \-S , " -\-size " \fIsize
+.BR \-S , " \-\-size " \fIsize
 Sets the maximum permitted message size to \fIsize\fR.  The default
 is 1KiB characters, which is the limit traditionally used and specified
 in RFC 3164.  With RFC 5424, this limit has become flexible.  A good assumption
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 4367fa5eb..2de4f8d99 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -113,7 +113,7 @@ utility appeared in Version 7 AT&T Unix.
 .nf
 sort \-d /etc/passwd \-o /tmp/look.dict
 look \-t: root:foobar /tmp/look.dict
-.nf
+.fi
 .RE
 .SH SEE ALSO
 .BR grep (1),
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 701bc4f18..6b69ffc9f 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -57,12 +57,11 @@ short) in canonical mode, where the line is buffered by the tty and you press
 ENTER to validate the user input.  If you put your tty in cbreak mode however,
 rename requires only a single key press to answer the prompt.  To set cbreak
 mode, run for example:
-.RS
 .PP
+.RS
 .nf
 sh \-c 'stty \-icanon min 1; "$0" "$@"; stty icanon' rename \-i from to files
 .fi
-.PP
 .RE
 .SH EXIT STATUS
 .RS
@@ -88,33 +87,33 @@ unanticipated error occurred
 Given the files
 .IR foo1 ", ..., " foo9 ", " foo10 ", ..., " foo278 ,
 the commands
-.RS
 .PP
+.RS
 .nf
 rename foo foo00 foo?
 rename foo foo0 foo??
 .fi
-.PP
 .RE
+.PP
 will turn them into
 .IR foo001 ", ..., " foo009 ", " foo010 ", ..., " foo278 .
 And
-.RS
 .PP
+.RS
 .nf
 rename .htm .html *.htm
 .fi
-.PP
 .RE
+.PP
 will fix the extension of your html files.
 Provide an empty string for shortening:
-.RS
 .PP
+.RS
 .nf
 rename '_with_long_name' '' file_with_long_name.*
 .fi
-.PP
 .RE
+.PP
 will remove the substring in the filenames.
 .SH SEE ALSO
 .BR mv (1)
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 1b8c3be7c..08e351cec 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -79,7 +79,6 @@ searches for "ls" man pages in all default paths, but for "cal" in
 the /usr/share/man/man1 directory only.
 
 .SH OPTIONS
-.TP
 .IP \fB\-b\fP
 Search for binaries.
 .IP \fB\-m\fP
@@ -149,7 +148,6 @@ and
 .B \-S
 are displayed with
 .BR \-l .
-.PP
 .SH ENVIRONMENT
 .IP WHEREIS_DEBUG=all
 enables debug output.
-- 
2.26.2
