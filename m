Return-Path: <SRS0=v0ph=QN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C500CC282C2
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F655217F9
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfBFKzb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:55:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFKza (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Feb 2019 05:55:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D42C11B7A;
        Wed,  6 Feb 2019 10:55:30 +0000 (UTC)
Received: from ws.net.home (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AB7762FA3;
        Wed,  6 Feb 2019 10:55:29 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:55:27 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] refactor mnt_fstype_is_pseudofs()?
Message-ID: <20190206105416.aivihlrfsrq35uhr@ws.net.home>
References: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
 <20190204140301.6oqezi7p26y2rewe@ws.net.home>
 <a554dead-2f2a-e1a1-b271-09e328028e41@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a554dead-2f2a-e1a1-b271-09e328028e41@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Feb 2019 10:55:30 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 05, 2019 at 11:19:18PM +0100, Stanislav Brabec wrote:
> Dne 04. 02. 19 v 15:03 Karel Zak napsal(a):
> > On Fri, Feb 01, 2019 at 12:07:12AM +0100, Stanislav Brabec wrote:
> >> The same problem affects other pseudo file systems not listed in mnt_fstype_is_pseudofs():
> >> # mount | grep encfs
> >> encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
> >> # mkdir encfs
> >> # mount | grep encfs
> >> /root/encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
> >> ^^^^^^^^^^^
> >>
> >> Debugging shows two reasons why it happens:
> >> 1) encfs is not listed in mnt_fstype_is_pseudofs()
> >> 2) mnt_resolve_path() calls canonicalize_path_and_cache() on the kernel output, which makes only a little sense
> > 
> > Where? It should be easy to check by mnt_fs_is_kernel().
> 
> I just found that the check is incomplete and the same problem also affects ALL network file systems, listed or not listed in mnt_fstype_is_netfs():

So we need mnt_fstype_is_netfs() there :-) or keep it without the canonicalization.

The canonicalization is only necessary if you do not use libmount/mount(8)
to mount the filesystem. This is probably very unusual use case...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
