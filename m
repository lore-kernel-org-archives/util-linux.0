Return-Path: <SRS0=0AAi=S2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25731C10F11
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CD620878
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDXJgX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfDXJgX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Apr 2019 05:36:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07587C057F3D;
        Wed, 24 Apr 2019 09:36:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 412E160851;
        Wed, 24 Apr 2019 09:36:22 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:36:19 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lslogins: Fix discrepancies of SYS_UID_MIN
Message-ID: <20190424093619.vap25vwc5ycr6blr@ws.net.home>
References: <65c908ef-6c16-0b24-c169-0448b3bd3aaa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c908ef-6c16-0b24-c169-0448b3bd3aaa@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 24 Apr 2019 09:36:23 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 24, 2019 at 06:03:21AM +0200, Stanislav Brabec wrote:
>  login-utils/lslogins.1 | 6 +++---
>  login-utils/lslogins.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied (manually, patch has been malformed by your email client),
thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
