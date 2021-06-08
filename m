Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BCC47082
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114C361182
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 14:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhFHOwc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233576AbhFHOwc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 8 Jun 2021 10:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623163838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1dCBmhorvBC9zxWDUuP91C57ypOWzlgBNx3SoBEIBQ=;
        b=crYM2gpj/YpPiMml8lpQP/iHag9ypVmympupaxiY0JXYtSu2ztQVbh6kpqJjIM6aWH6u+a
        /Q88r6N/RKV1EsBbfVuS+CetuNkok2yaVby/ZmFcldOSYKpl3Nd00G4hLGgsRMMee0UU1X
        rRyIgZ5hHusLsWxcQzTANDINgjhG43M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-i_L0JK6SP7KZWXhFH2Q6Gg-1; Tue, 08 Jun 2021 10:50:37 -0400
X-MC-Unique: i_L0JK6SP7KZWXhFH2Q6Gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED14A107ACE3;
        Tue,  8 Jun 2021 14:50:35 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BE1D18A77;
        Tue,  8 Jun 2021 14:50:35 +0000 (UTC)
Date:   Tue, 8 Jun 2021 16:50:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Missing getext dependency in v2.37
Message-ID: <20210608145032.6xzlt75thp64gpo6@ws.net.home>
References: <20210607162249.ez6dtms5xxansg26@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607162249.ez6dtms5xxansg26@e107158-lin.cambridge.arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 07, 2021 at 05:22:49PM +0100, Qais Yousef wrote:
> While building v2.37 I hit the following build error
> 
> 	: --update --no-wrap --previous --lang=ca ca.po util-linux.pot
> 	rm -f ca.gmo && : -c --statistics --verbose -o ca.gmo ca.po
> 	mv: cannot stat 't-ca.gmo': No such file or directory

The po/ stuff is not required for "make", it's usually necessary for
"make distcheck" or so. It seems better to keep (x)gettext binary
installation optional for normal purpose.

There is in ./configure output:

checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... no
checking for msgmerge... /usr/bin/msgmerge

but you're right that it would be nice to have something more verbose.
I'll add something to ./autogen.sh.

> Should configure fail when it detects gettext is missing?

There is difference between what we use as developers (from git repo)
and what get users by official tarball. The tarball already contains
compiled .(g)mo files. I guess, as end-user, you do not need to generate
anything in po/.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

