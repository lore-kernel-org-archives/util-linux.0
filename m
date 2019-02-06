Return-Path: <SRS0=v0ph=QN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C5C169C4
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B22204EC
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBFK6v (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:58:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfBFK6v (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Feb 2019 05:58:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A429810F81;
        Wed,  6 Feb 2019 10:58:51 +0000 (UTC)
Received: from ws.net.home (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD4D260464;
        Wed,  6 Feb 2019 10:58:50 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:58:47 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] mount: Do not call mnt_pretty_path() on net file systems.
Message-ID: <20190206105847.gumbcel24gvc5zmn@ws.net.home>
References: <8a0a088e-2ed7-9233-438a-6fb04f08046f@suse.cz>
 <eddb321e-eb27-f08a-2b8b-4856eedfdc03@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddb321e-eb27-f08a-2b8b-4856eedfdc03@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 06 Feb 2019 10:58:51 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 06, 2019 at 12:07:54AM +0100, Stanislav Brabec wrote:
>  sys-utils/mount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

Please, send also updates for the mnt_fstype_is_pseudofs().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
