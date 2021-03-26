Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35438C433C1
	for <util-linux@archiver.kernel.org>; Fri, 26 Mar 2021 10:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2661A10
	for <util-linux@archiver.kernel.org>; Fri, 26 Mar 2021 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZKZw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhCZKZ0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 26 Mar 2021 06:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616754325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLCzJLof9i3lRsGX1fh3jfugGO1vPXIULv1+t49SFdU=;
        b=aLQw47DoCRNzAEKhhPw+S2Ld17Nn4aunoLdD3QA3oItaTxZ6K1Gn1/2XXyWlkE7XjRmKmH
        tE+aKidT9xOQCUQ4bCeI/HZxqULpTR1BGemPim8tcm7dkzlRShW4/yRgQatojz88MQPFn2
        if+pIMCz+yrCX/riGG7CERRxdl578Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-MVR1C2BiNJ2eMgCwJSsZsg-1; Fri, 26 Mar 2021 06:25:22 -0400
X-MC-Unique: MVR1C2BiNJ2eMgCwJSsZsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E782C180FCA5;
        Fri, 26 Mar 2021 10:25:21 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 422C219705;
        Fri, 26 Mar 2021 10:25:21 +0000 (UTC)
Date:   Fri, 26 Mar 2021 11:25:18 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Help needed with man page conversions to asciidoc?
Message-ID: <20210326102518.ex4t7kj6chswe7du@ws.net.home>
References: <karelzak/util-linux/issues/1257@github.com>
 <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home>
 <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
 <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
 <20210323092705.uaa2oas3ux5s3er7@ws.net.home>
 <CAHi0vA_FL744Lap_GqkrhPPf_wK0BW2Ed_R2FVwQ+L_A4AJdHg@mail.gmail.com>
 <CAHi0vA-OcifUioLiUXSg9UmaMNUzfLhwg+tfm0hFnXYipOq0DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA-OcifUioLiUXSg9UmaMNUzfLhwg+tfm0hFnXYipOq0DQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 24, 2021 at 08:37:35PM +0100, Mario Blättermann wrote:
> I found the problem, at least partially. A backslash was missing in
> Makefile.am, and now "make gen-man" creates *roff man pages, as
> expected. However, it stops here:

OK.

>   GEN      sys-utils/swapoff.8
> asciidoctor: FAILED: input file ./sys-utils/swapoff.8.adoc is missing
> make: *** [Makefile:15942: sys-utils/swapoff.8] Fehler 1
> 
> But I'm wondering why it doesn't complain about the other symlinks in
> libuuid etc, and it didn't stop until the sys-utils directory has been
> reached.

It seems asciidoctor generates also the man page links (see below for
more details). It's safe to remove the man page link files from the
tree at all.

The issue is that we have the link pages in the dist_man_MANS=
and 'make' tries to verify the link file *before* the  original 
man page. It means  

  dist_man_MANS += sys-utils/swapon.8 sys-utils/swapoff.8

is no problem, but:

  dist_man_MANS += sys-utils/swapoff.8 sys-utils/swapon.8

ends with error ;-)

I'll send you pull request to your topic/asciidoc do fix this (and
some others minor) issue.

 Karel



 $ git checkout -f
 $ make clean
 $ git status 
On branch ad
nothing to commit, working tree clean

make the man page (V=1 for verbose output):

 $  make libuuid/man/uuid_generate.3 V=1
 /usr/bin/mkdir -p $(dirname libuuid/man/uuid_generate.3)
 srcdir=''; \
	test -f ./libuuid/man/uuid_generate.3.adoc || srcdir=./; \
	/usr/bin/asciidoctor -b manpage -a 'VERSION=2.36.689-bdda0' -a 'ADJTIME_PATH=/etc/adjtime' ${srcdir}libuuid/man/uuid_generate.3.adoc

now see that asciidoctor also updated the uuid_generate_*.3 man pages:

 $ git diff
diff --git a/libuuid/man/uuid_generate_random.3 b/libuuid/man/uuid_generate_random.3
index 8405486e9..1e51c4e6e 100644
--- a/libuuid/man/uuid_generate_random.3
+++ b/libuuid/man/uuid_generate_random.3
@@ -1 +1 @@
-.so man3/uuid_generate.3
+.so uuid_generate.3
\ No newline at end of file
diff --git a/libuuid/man/uuid_generate_time.3 b/libuuid/man/uuid_generate_time.3
index 8405486e9..1e51c4e6e 100644
--- a/libuuid/man/uuid_generate_time.3
+++ b/libuuid/man/uuid_generate_time.3
@@ -1 +1 @@
-.so man3/uuid_generate.3
+.so uuid_generate.3
\ No newline at end of file
diff --git a/libuuid/man/uuid_generate_time_safe.3 b/libuuid/man/uuid_generate_time_safe.3
index 8405486e9..1e51c4e6e 100644
--- a/libuuid/man/uuid_generate_time_safe.3
+++ b/libuuid/man/uuid_generate_time_safe.3
@@ -1 +1 @@
-.so man3/uuid_generate.3
+.so uuid_generate.3
\ No newline at end of file

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

