Return-Path: <SRS0=K2/4=7Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4710C433DF
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94897206A4
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 02:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFKCS1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgFKCS1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 22:18:27 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88544C08C5C1
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 19:18:26 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05B2IKk9023298
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 02:18:20 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05B2IKk9023298
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05B2IKED030987
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 02:18:20 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05B2IKWv030986
        for util-linux@vger.kernel.org; Thu, 11 Jun 2020 02:18:20 GMT
Date:   Thu, 11 Jun 2020 02:18:20 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: text-utils/*: fix some warnings from "mandoc -T lint"
Message-ID: <20200611021820.GA30948@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./text-utils/column.1:58:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./text-utils/column.1:63:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./text-utils/column.1:119:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./text-utils/column.1:171:1: WARNING: skipping paragraph macro: sp after PP
mandoc: ./text-utils/column.1:170:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./text-utils/hexdump.1:206:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./text-utils/hexdump.1:356:2: STYLE: fill mode already disabled, skipping: nf
mandoc: ./text-utils/hexdump.1:359:2: STYLE: fill mode already disabled, skipping: nf
mandoc: ./text-utils/hexdump.1:362:2: STYLE: fill mode already disabled, skipping: nf
mandoc: ./text-utils/hexdump.1:366:2: STYLE: fill mode already disabled, skipping: nf
mandoc: ./text-utils/hexdump.1:369:2: STYLE: fill mode already disabled, skipping: nf

####

  There are no changes in the output from "nroff" and "groff", except
for a reformat of a paragraph caused by "fill-mode".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 text-utils/column.1  | 5 -----
 text-utils/hexdump.1 | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 634c1be84..4c2de1cc5 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -55,12 +55,10 @@ possible to modify by \fB\-\-table-*\fP options.  Use this mode if not sure.
 .PP
 Input is taken from \fIfile\fR, or otherwise from standard input.  Empty lines
 are ignored and all invalid multibyte sequences are encoded by \\x<hex> convention.
-.PP
 .SH OPTIONS
 The argument \fIcolumns\fP for \fB\-\-table-*\fP options is comma separated
 list of the column names as defined by \fB\-\-table-columns\fP or it's column
 number in order as specified by input. It's possible to mix names and numbers.
-.PP
 .IP "\fB\-J, \-\-json\fP"
 Use JSON output format to print the table, the option
 \fB\-\-table\-columns\fP is required and the option \fB\-\-table\-name\fP is recommended.
@@ -116,7 +114,6 @@ other anomalies in child and parent relation are silently ignored.
 Specify column with line ID to create child-parent relation.
 .IP "\fB\-p, \-\-tree\-parent\fP \fIcolumn\fP"
 Specify column with parent ID to create child-parent relation.
-.PP
 .IP "\fB\-x, \-\-fillrows\fP"
 Fill rows before filling columns.
 .IP "\fB\-V\fR, \fB\-\-version\fR"
@@ -167,8 +164,6 @@ Print fstab and hide unnamed columns:
 .EX
 \fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE \-\-table-hide \-\fR
 .EE
-.PP
-
 .PP
 Print a tree:
 .EX
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index abf1b8370..eb7713ce6 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -203,7 +203,6 @@ NULL
 \ev
 .PD
 .RE
-.PP
 .SS Conversion strings
 The
 .B hexdump
@@ -353,20 +352,20 @@ Display the input in perusal format:
    "%06.6_ao "  12/1 "%3_u "
    "\et\et" "%_p "
    "\en"
-.nf
+.fi
 .PP
 Implement the \-x option:
 .nf
    "%07.7_Ax\en"
    "%07.7_ax  " 8/2 "%04x " "\en"
-.nf
+.fi
 .PP
 MBR Boot Signature example: Highlight the addresses cyan and the bytes at
 offsets 510 and 511 green if their value is 0xAA55, red otherwise.
 .nf
    "%07.7_Ax_L[cyan]\en"
    "%07.7_ax_L[cyan]  " 8/2 "   %04x_L[green:0xAA55@510-511,!red:0xAA55@510-511] " "\en"
-.nf
+.fi
 .SH COLORS
 Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/hexdump.disable\fR.
 
-- 
2.26.2
