Return-Path: <SRS0=4JBC=Q5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237EC43381
	for <util-linux@archiver.kernel.org>; Fri, 22 Feb 2019 10:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF9E20645
	for <util-linux@archiver.kernel.org>; Fri, 22 Feb 2019 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVK0L (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:26:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBVK0L (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 Feb 2019 05:26:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D958787642;
        Fri, 22 Feb 2019 10:26:10 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F8D92C8D0;
        Fri, 22 Feb 2019 10:26:09 +0000 (UTC)
Date:   Fri, 22 Feb 2019 11:26:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] mount: Do not call mnt_pretty_path() on net file systems.
Message-ID: <20190222102607.y6hfrxjacbpxtru3@ws.net.home>
References: <8a0a088e-2ed7-9233-438a-6fb04f08046f@suse.cz>
 <eddb321e-eb27-f08a-2b8b-4856eedfdc03@suse.cz>
 <20190206105847.gumbcel24gvc5zmn@ws.net.home>
 <05bb1dd3-016d-9166-3e73-29bbc307907c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bb1dd3-016d-9166-3e73-29bbc307907c@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 22 Feb 2019 10:26:10 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 19, 2019 at 04:50:26PM +0100, Stanislav Brabec wrote:
> Dne 06. 02. 19 v 11:58 Karel Zak napsal(a):
> > On Wed, Feb 06, 2019 at 12:07:54AM +0100, Stanislav Brabec wrote:
> >>  sys-utils/mount.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Applied, thanks!
> > 
> > Please, send also updates for the mnt_fstype_is_pseudofs().
> > 
> 
> I started to inspect file systems available in SUSE, and I found
> that there is an another category of file systems: File systems that
> have a source (so they are not pseudo file systems), but information
> provided by the kernel is not sufficient to check whether a
> particular source is already mounted.
> 
> Some of them are completely undetectable (both source and FS type
> provide generic information only), some are detectable by source,
> but not by FS type, some are detectable by FS type, but source match
> cannot be used.
> 
> For these file systems, mount(8) cannot guarantee that the correct
> volume is mounted. Only some guesses are possible.

The question is how critical is it for us... maybe all we need is to
document mount(8) limitations for these cases.

> Maybe it should warn about it, or it should refuse such file systems in the fstab.
> 
> 
> Examples of undetectable FUSE file systems:
> 
> xdg-document-portal is completely undetectable; it can be ran once per UID
> /dev/fuse on /run/user/10027/doc type fuse (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
> 376 536 0:65 / /run/user/10027/doc rw,nosuid,nodev,relatime - fuse /dev/fuse rw,user_id=10027,group_id=100

No subtype ? How FUSE driver redirects it to the right code?

> 
> curlftpfs undetectable by type, detectable by source
> curlftpfs#ftp://ftp.suse.com/ on /home/sbrabec/T type fuse (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
> 544 510 0:47 / /sys/fs/fuse/connections rw,relatime master:282 - fusectl fusectl rw

 "subtype#" is deprecated; I guess fuse.curlftpfs has to work ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
