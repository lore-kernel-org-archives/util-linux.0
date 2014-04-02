Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54630 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030670AbaDBXZK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:25:10 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32NP8A2023342
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:25:08 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32NP8Q5023341
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:25:08 GMT
Date: Wed, 2 Apr 2014 23:25:08 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] fdformat(8): Some minor change to the manual
Message-ID: <20140402232507.GA23319@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/fdformat.8
Tags: patch

  Changes:

  \- changed to - (code "hyphen-minus", rendered with the glyph hyphen
in troff) if it is a part of a compound name.  A minus is not used in
words.  People using UTF-8 and copy-and-pase can(?) (may?) use "info",
"man --ascii" or the command "man" should have an option to display the
- in names of options with the code (character name) "hyphen-minus"
(u002D) instead of "u2010" (code (character) name "hyphen")

  Patch:

--- fdformat.8	2013-10-15 10:50:43.000000000 +0000
+++ fdformat.8.new	2014-04-01 20:20:56.000000000 +0000
@@ -45,7 +45,7 @@ autodetected earlier.  In this case, use
 to load the disk parameters.
 .SH OPTIONS
 .TP
-\fB\-n\fR, \fB\-\-no\-verify\fR
+\fB\-n\fR, \fB\-\-no-verify\fR
 Skip the verification that is normally performed after the formatting.
 .TP
 \fB\-V\fR, \fB\-\-version\fR

-- 
Bjarni I. Gislason
