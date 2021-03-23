Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F9C433C1
	for <util-linux@archiver.kernel.org>; Tue, 23 Mar 2021 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACDF6146D
	for <util-linux@archiver.kernel.org>; Tue, 23 Mar 2021 09:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCWJ12 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhCWJ1U (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Mar 2021 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616491639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+C2xOQL8DfoWluLrgN/2ckJyYnFN+vNEJhjHGkya77Y=;
        b=BLyegIkeh8MNg7tHfXh9kOkkiGxzhWehNlFpT9Y9Sh3S/8uTC63DwVtSM0pB+AyhmSZ/y4
        6Ip4hqiYJLHEHly+71NJ3TSyIDMbIe22/veDFpT7lLN7ztl9U5VZ6yLkfdUs/ZwWfIOR3a
        7c1AZ+8gvJk1n1tmzIPEEVJb5gE5T8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-FaqWIaKTOfCd9nTx7zwtog-1; Tue, 23 Mar 2021 05:27:09 -0400
X-MC-Unique: FaqWIaKTOfCd9nTx7zwtog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDE0881282;
        Tue, 23 Mar 2021 09:27:08 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB1E83805;
        Tue, 23 Mar 2021 09:27:07 +0000 (UTC)
Date:   Tue, 23 Mar 2021 10:27:05 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Help needed with man page conversions to asciidoc?
Message-ID: <20210323092705.uaa2oas3ux5s3er7@ws.net.home>
References: <karelzak/util-linux/issues/1257@github.com>
 <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home>
 <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
 <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Mar 20, 2021 at 06:46:24PM +0100, Mario Blättermann wrote:
> Just found another problem: After applying the Makefile patches [1]
> and running "autogen.sh" and "configure", the command »make gen-man«
> fails:
> 
> [mariob@t450 util-linux-mariobl]$ make gen-man
> Makefile:15938: warning: overriding recipe for target 'misc-utils/uuidd.8'
> Makefile:15927: warning: ignoring old recipe for target 'misc-utils/uuidd.8'
> Makefile:15938: warning: overriding recipe for target 'misc-utils/getopt.1'
> Makefile:15927: warning: ignoring old recipe for target 'misc-utils/getopt.1'
>  GEN      lib/terminal-colors.d.5
> /bin/sh: line 3: lib/terminal-colors.d.5.adoc: Permission denied
> make: *** [Makefile:15940: lib/terminal-colors.d.5] Error 126

It sounds like $asciidoc_man_cmd is empty. This is my mistake.

> [1] https://github.com/mariobl/util-linux/commit/34455501de74c405b56daa438ee3e839e92fbc17

You also need to define $ASCIIDOCTOR variable in ./configure.ac.
Please add the patch below. I have probably forgot it in my
suggestion.

 Karel


diff --git a/configure.ac b/configure.ac
index 7f59604bd..946222676 100644
--- a/configure.ac
+++ b/configure.ac
@@ -232,6 +232,7 @@ PKG_INSTALLDIR(['${usrlib_execdir}/pkgconfig'])
 
 GTK_DOC_CHECK([1.10])
 AC_PATH_PROG([XSLTPROC], [xsltproc])
+AC_PATH_PROG([ASCIIDOCTOR], [asciidoctor])
 
 linux_os=no
 bsd_os=no


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

