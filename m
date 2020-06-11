Return-Path: <SRS0=K2/4=7Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36FC433DF
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 00:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE2206A4
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 00:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgFKASr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgFKASr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 20:18:47 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5913C08C5C1
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 17:18:46 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05B0IiuK017506
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 00:18:44 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05B0IiuK017506
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05B0IiR5025450
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 00:18:44 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05B0IiMX025449
        for util-linux@vger.kernel.org; Thu, 11 Jun 2020 00:18:44 GMT
Date:   Thu, 11 Jun 2020 00:18:44 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: schedutils/*: Fix some warnings from "mandoc -T lint"
Message-ID: <20200611001844.GA25404@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./schedutils/chrt.1:37:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./schedutils/ionice.1:120:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./schedutils/taskset.1:36:2: WARNING: skipping paragraph macro: PP after SH

####

  There is no change in the ouput from "nroff" and "groff".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 schedutils/chrt.1    | 1 -
 schedutils/ionice.1  | 1 -
 schedutils/taskset.1 | 1 -
 3 files changed, 3 deletions(-)

diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 83e57070c..0d9a225c3 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -34,7 +34,6 @@ chrt \- manipulate the real-time attributes of a process
 .B \-p
 .RI [ priority ]\  pid
 .SH DESCRIPTION
-.PP
 .B chrt
 sets or retrieves the real-time scheduling attributes of an existing \fIpid\fR,
 or runs \fIcommand\fR with the given attributes.
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 72dbae6af..bbb6b7e95 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -117,7 +117,6 @@ Display version information and exit.
 Linux supports I/O scheduling priorities and classes since 2.6.13 with the CFQ
 I/O scheduler.
 .SH EXAMPLES
-.LP
 .TP 7
 # \fBionice\fP \-c 3 \-p 89
 .TP 7
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 7fdc50898..71e7874e1 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -33,7 +33,6 @@ taskset \- set or retrieve a process's CPU affinity
 .B \-p
 .RI [ mask ]\  pid
 .SH DESCRIPTION
-.PP
 .B taskset
 is used to set or retrieve the CPU affinity of a running process given its
 \fIpid\fR, or to launch a new \fIcommand\fR with a given CPU affinity.
-- 
2.26.2
