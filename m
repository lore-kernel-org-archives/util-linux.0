Return-Path: <SRS0=WmqB=6L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F4C54FD0
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BAD206A4
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 09:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuijRkkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgD0Jd5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgD0Jd4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Apr 2020 05:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587980035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zn0wPeVCP0NBxPWIGTSQRNcSa3R0qR/32wP4gVjYEJI=;
        b=VuijRkkACIj2BfIA+AWw4muKhVjYZyXOX/66os77gQkhZXlx9YfBSWd7HM+l0QqNczNbRG
        hpVKQW1GhTnpn+OaeMKX3xP+5jChV8QW/utqBGE+hGw6aaHIaVk8kxAFaPJjf5Zwh9xufk
        y98J1jFgpPAbuyraPDpXaTU0bRyrk28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-OyDqYVlYOaWJKELkygNFwA-1; Mon, 27 Apr 2020 05:33:52 -0400
X-MC-Unique: OyDqYVlYOaWJKELkygNFwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFB9980B70C;
        Mon, 27 Apr 2020 09:33:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77D5A60638;
        Mon, 27 Apr 2020 09:33:49 +0000 (UTC)
Date:   Mon, 27 Apr 2020 11:33:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     michael-dev <michael-dev@fami-braun.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix PID namespace persistence
Message-ID: <20200427093346.tcoujcasylusejfq@ws.net.home>
References: <20200415211653.5455-1-michael-dev@fami-braun.de>
 <87o8rrdulx.fsf@x220.int.ebiederm.org>
 <9379f1f3b13b33e3a80b7cb4a58de8b8@fami-braun.de>
 <CAHO5Pa0OkdnTYRkzEsCV0=kAJZXDaSnVriEUAq3Zt-6csP3wFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHO5Pa0OkdnTYRkzEsCV0=kAJZXDaSnVriEUAq3Zt-6csP3wFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 24, 2020 at 11:21:15AM +0200, Michael Kerrisk wrote:
> On Sun, Apr 19, 2020 at 1:06 AM michael-dev <michael-dev@fami-braun.de> wrote:
> >
> > Am 16.04.2020 22:49, schrieb ebiederm@xmission.com:
> > > Why all of the extra code motion and change?
> > >
> > > Your description sounds like only the first hunk is necessary.  Did
> > > something else get mixed into this change?  Or are all of the hunks
> > > necessary?
> >
> > Because after unsharing, pid_for_children is a dangling symlink.
> > So if (forkit) needs to be before /* wait for bind_ns_files_from_child()
> > */.
> > Moving this results in an overlapping use of the pid variable, so that
> > gets renamed.
> > Additionally, we cannot wait for the forkit child (bash) to exit before
> > triggering and waiting for the bind-mounting child to bind-mount the
> > persistent namespace. So forking and waiting for the forkit child (bash)
> > needs to become splitted.
> 
> @Michael: I confim theproblem, and thanks for this fix.
> 
> @Zak: an analogous fix is required for time namespaces.

OK, I'll play with it later this week. Sorry for the delay, I'm busy
with other things.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

