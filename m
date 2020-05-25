Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49361C433E0
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214FC2073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl9CThEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbgEYM7Z (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgEYM7Z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:59:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29309C061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i16so14957125edv.1
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMFb7A3DhKCNF3EFuT/V0IbYe1PqcnhweLcl9Nd7S9Q=;
        b=Gl9CThEg2bhRUTFIajcx5gBnkkGgpeUhvmVhm9Vp7C5LIJIWAappkCSyCaikzmhbJ0
         ln3cbWyumtaXfeUySVlh352n1QH7DylH5ZGfa1nxcOnRFchcE7eaIVRA9bj4LDx5SvG7
         qk2pfKSR9YbCI0tiDOA7vW+S2J9hA0AXrz6UxDRmzE4duawsLYfa8LyRxy/SvtynVmd4
         xetRo3sYVkls6SIxfihoSw1Ud8e/CKiI74J3P2uwRLL7keR8gp2dA89MPCUNZLne2TW4
         +I3EYiBIpZq5CXw7V68Euu0vUu3+ns6ujYFZgHnL5ddYiRJy6FOi4HaHVChlVGOVtHTG
         KWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMFb7A3DhKCNF3EFuT/V0IbYe1PqcnhweLcl9Nd7S9Q=;
        b=AaPYBz9LeHoz74DYJ9lvsB2hFXQebimYqmPpHiZ4jBa9n8cxsXCcVC1kakni1W6bnd
         ek2/YDaaXckvFL4DL1kYCYovhAW29IEFy7UjjPB2oIdC1ohzLWr2F5bb8kQl+S6A60qA
         7sytDKCZ7eWqa2xRWuMoJJ0ej/fQMkHO8LyGtKQrnSnO9sOIjttgIB1OghaS6SFCZ1EO
         i3+CqkQ8OSgUVE9aVWRum2KS5EgUuD7ByZUFLdzRYMktMG/SlHvAGY0Eudy6uWW6fUbo
         1XCwdguxiRvTbCeKEckambrnPe6lb/OFbI6qpcP5Kisnsf3Wxq43cthpYNVwYXuTMPeo
         cKSg==
X-Gm-Message-State: AOAM530j7cpkq5s+mf4OedmRcTyn908UQiIGb/fOj4qRhl+ic+2PTf+t
        v085xYEny688Z9iT3y6c1FwHRwESz3M=
X-Google-Smtp-Source: ABdhPJyToEATqZmDPRHwdgSgswNvBg001fT75eoW4whEru/dzPumstZGuMiwY2yxPrPqGZOYRXhbeA==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr14720729edt.166.1590411563813;
        Mon, 25 May 2020 05:59:23 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b14sm15709719edx.93.2020.05.25.05.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:59:23 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/5] Manual pages: kill.1: various language, spelling, and formatting fixes
Date:   Mon, 25 May 2020 14:59:08 +0200
Message-Id: <20200525125912.43748-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

These seem all "obviously correct", so I'm rolling them up into
one patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 misc-utils/kill.1 | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 6fd50036d..1c12f8a14 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -34,7 +34,9 @@ then the KILL signal may be used; be aware that the latter signal
 cannot be caught, and so does not give the target process the opportunity
 to perform any clean-up before terminating.
 .PP
-Most modern shells have a builtin kill command, with a usage rather similar to
+Most modern shells have a builtin
+.B kill
+command, with a usage rather similar to
 that of the command described here.  The
 .BR \-\-all ,
 .BR \-\-pid ", and"
@@ -49,7 +51,7 @@ The list of processes to be signaled can be a mixture of names and PIDs.
 .I pid
 Each
 .I pid
-can be one of four things:
+can be expressed in one of the following ways:
 .RS
 .TP
 .I n
@@ -87,7 +89,7 @@ The signal to send.  It may be given as a name or a number.
 \fB\-l\fR, \fB\-\-list\fR [\fInumber\fR]
 Print a list of signal names, or convert the given signal number to a name.
 The signals can be found in
-.I /usr/\:include/\:linux/\:signal.h
+.IR /usr/\:include/\:linux/\:signal.h .
 .TP
 \fB\-L\fR, \fB\-\-table\fR
 Similar to \fB\-l\fR, but it will print signal names and their corresponding
@@ -102,10 +104,12 @@ Only print the process ID (PID) of the named processes, do not send any
 signals.
 .TP
 \fB\-\-verbose\fR
-Print PID(s) that will be signaled with kill along with the signal.
+Print PID(s) that will be signaled with
+.B kill
+along with the signal.
 .TP
 \fB\-q\fR, \fB\-\-queue\fR \fIvalue\fR
-Use
+Send the signal using
 .BR sigqueue (3)
 rather than
 .BR kill (2).
@@ -132,7 +136,7 @@ to wait for a period defined in
 before sending follow-up
 .I signal
 to process.
-This feature is implemented by PID file-descriptor and guaranties that
+This feature is implemented by PID file-descriptor and guarantees that
 follow-up signals are sent to the same process or not sent if the process no
 more exist.  Note that the operating system may re-use PIDs and implement the
 same feature in a shell by kill and sleep commands sequence may introduce a
@@ -182,11 +186,14 @@ and the description of
 in
 .BR clone (2).
 .P
-Various shells have provide an internal kill implementation that is
+Various shells provide a builtin
+.B kill
+command that is
 preferred in relation to the
 .BR kill (1)
-executable described by this manual.  Easiest way to ensure one is executing
-the executable is to use full path when calling the command, for example:
+executable described by this manual.
+The easiest way to ensure one is executing the command described in this page
+is to use the full path when calling the command, for example:
 .B "/bin/kill \-\-version"
 .SH AUTHORS
 .MT svalente@mit.edu
-- 
2.26.2

