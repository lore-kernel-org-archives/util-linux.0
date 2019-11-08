Return-Path: <SRS0=EUsd=ZA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B8DC5DF60
	for <util-linux@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35807206BA
	for <util-linux@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIAu9TVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHLIt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:08:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbfKHLIt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 8 Nov 2019 06:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573211328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCfY3iYA/lDZz8/3yj+HDW6/1i49DZFBgFEb43IMKfM=;
        b=CIAu9TVRc62RcEbOAREN17b6XJnrrG6WGYzjcW5q55OdgA3krxpIMcDCnL2xeXmSwRemNK
        g+RfzJdbh+OsA/PLXJ/k4t3WDJ2KWHGFMmza3bKNNcx90A30sd8hzSOsGs+ZiCNPSy+MUx
        uU0sOKG3S0bhHfKCp+IYP3mxvnjuWyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-gYES1PE8MKCvJ92cLdoNRg-1; Fri, 08 Nov 2019 06:08:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D79A51005500;
        Fri,  8 Nov 2019 11:08:45 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B8F60BE1;
        Fri,  8 Nov 2019 11:08:44 +0000 (UTC)
Date:   Fri, 8 Nov 2019 12:08:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stephane Chazelas <stephane.chazelas@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [bug] renice not POSIX compliant
Message-ID: <20191108110842.qe6vv5votmcud2f2@10.255.255.10>
References: <20190914135537.yps2umfx2nsynyii@chaz.gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190914135537.yps2umfx2nsynyii@chaz.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gYES1PE8MKCvJ92cLdoNRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

(sorry for delay)

On Sat, Sep 14, 2019 at 02:55:37PM +0100, Stephane Chazelas wrote:
> util-linux added "-n" in 2009 for POSIX compliance (see
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=
=3D7cfbafda9c484a8cadefc47ee115086e803d9391),
> but the "-n" is just ignored. Since 2010, the --help message
> does say that -n/--priority takes an "increment"
> (https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?i=
d=3D296351b0f112c821bffbe8ce7aa35d716251051d)
> but that's not what happens in practice (it still sets the
> niceness to the value specified).

I have fixed the --help and removed "increment".

> Also, a POSIX renice utility is meant to parse the options the
> usual (getopt(3)) way. In particular,
>=20
> renice -gn 1 -- 123
>=20
> Is meant to increase the niceness of pgid 123 by 1, but fails in
> util-linux renice.
>=20
> $ renice -gn 1 -- "$$"
> renice: invalid priorty '-gn'
> Try 'renice --help' for more information.
>=20
> -p, -g, -u are meant to specify how *all* operands are to be
> interpreted, they are not options that take arguments.

well, this is --help stupidity, man page is better. Fixed.

> renice +1 123
> renice +1 123 -u me
>=20
> are unspecified by POSIX, so it's fine for util-linux to handle
> the BSD way, but
>=20
> renice -n 1 -u me -p 123
>=20
> Is meant to increase the niceness of users "me", "-p" and "123".
>=20
> Also, calling it "--priority" is quite misleading as the
> niceness is rather the opposite of priority. GNU "nice" uses
> "--adjustment" as the long-option equivalent of "-n" (note that
> FreeBSD also calls it "priority" though)..
>=20
> IMO, the best way to handle it would be to do a BSD-style
> parsing when the first argument matches the [-+]?\d+ RE, and do
> a POSIX getopt_long parsing otherwise with:

hmm... but it will introduce regression as -n is interpreted as
absolute number now, no increment. And at first glance at Google you
can see that -n is in almost all how-to articles ;-(

I think we need to keep -n in the game for BSD-style too.

> Change the (POSIX style) options to:
>=20
>   -n/--adjustment <num>: niceness increment

>   -v/--value (deprecated: --priority) <num>: exact niceness value
>   -g/--pgrp (no arg): interpret operands as gids.
>   -u/--user (no arg): interpret operands as user names/ids
>   -p/-pid (no arg): interpret operands as pids.
>   --help/--version...
>=20
> And keep the
>=20
> renice niceness [[-p/--pid] pid ...] [[-g/--pgrp] pgid ...] [[-u/--user] =
user ...]
>=20
> usage for backward compatibility and BSD compatibility.

What about:

  renice [-n] [+-]<prio> [[-p/--pid] pid ...] [[-g/--pgrp] pgid ...] [[-u/-=
-user] user ...]

and keep <prio> is absolute number if without +/-; and as relative
if prefixed with + or - ?

It means people who use=20

  renice -n 10 [-p ... -g ... -u ... ]

will not see any regression, and people who use

  renice -n +2 [-p ... -g ... -u ... ]

will see that it work as expected :-)


For POSIX-like getopt_long() way, how does it support more arguments?
For example in BSD way you can use:

    renice 10 -p 1 -p 2 -p 3

to apply 10 for processes 1, 2 and 3. How you can write it in POSIX way?

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

