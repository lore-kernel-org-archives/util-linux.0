Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E362C433E6
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68CE64E07
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 09:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBOJSG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Feb 2021 04:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230158AbhBOJSE (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Feb 2021 04:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613380597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oPzlSnlc/Yl9CnAVmDndmmGkx/G1fkQ0OuLq8VBd204=;
        b=jLNyvu2CL+CoRyY4411rFQ9CYOvqo/b8vsuW4K6BLHGjnDgxLgaEWlDB3e633rdQR/xBDk
        MekaZRnNae4uorcQlu64hbjP37Io9x+/XLgUI27dvbcwr+fyln2sznTx/OHBjozi0A0vUG
        IOONn01mnYKyyfkncmoeYfdD+0QhNKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-C-hh21A4NUyMUyQIjNfsog-1; Mon, 15 Feb 2021 04:16:32 -0500
X-MC-Unique: C-hh21A4NUyMUyQIjNfsog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8023A192CC40;
        Mon, 15 Feb 2021 09:16:30 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1645447F;
        Mon, 15 Feb 2021 09:16:29 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:16:25 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
Subject: Re: Suggested changes to util-linux for FHS compliance.
Message-ID: <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 12, 2021 at 11:04:59AM -0600, Bruce Dubbs wrote:
> I don't recall if this has come up before, but I suggest a couple of changes
> to the default util-linux build configuuration:
> 
> 1. Change the default ADJTIME_PATH to be /var/lib/hwclock/adjtime

Good idea. I'll do that.

> 2. Change the references to /var/run to just /run or at least add a
> configure option --runstatedir=<path>.

The current default is /run if --localstatedir is NONE or /var, see
configure.ac:

 # default for old versions without $runstatedir
 AS_IF([test x"$runstatedir" = x], [runstatedir='${localstatedir}/run'])
 
 # our default if $localstatedir unchanged
 AS_CASE([$localstatedir:$runstatedir],
  [NONE:'${localstatedir}/run' | /var:'${localstatedir}/run' | NONE:'/run' ],
    [runstatedir=/run; AC_MSG_NOTICE([  --runstatedir defaults to /run])]
 )
 
 AC_SUBST([runstatedir])


Try it without an option:

        $ ./configure
        ...
        configure: Default --exec-prefix detected.
        configure:   --bindir defaults to /bin
        configure:   --sbindir defaults to /sbin
        configure:   --libdir defaults to /lib64
        configure:   --runstatedir defaults to /run

the @runstatedir@ should be available since autoconf 2.70
https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
but not sure about the option.

For example for Fedora we use:

        ./configure --build=x86_64-redhat-linux-gnu \
        --host=x86_64-redhat-linux-gnu --program-prefix= \
        --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr \
        --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc \
        --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 \
        --libexecdir=/usr/libexec --localstatedir=/var \
        --sharedstatedir=/var/lib --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --with-systemdsystemunitdir=/usr/lib/systemd/system \
        --disable-silent-rules --disable-bfs --disable-pg --enable-chfn-chsh  \
        --enable-usrdir-path --enable-write --enable-raw --enable-hardlink \
        --with-python=3 --with-systemd --with-udev --with-selinux --with-audit \
        --with-utempter --disable-makeinstall-chown


and it also defaults to /run because of --localstatedir=/var

> Currently this change can be manually made by setting an environment
> variable, runstatedir=/run when running configure, but is undocumented.

The current default should be already good enough for usual use-cases :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

