Return-Path: <SRS0=LbFG=PS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E25C43387
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E38206B6
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 11:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfAJL1p (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:27:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfAJL1p (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 Jan 2019 06:27:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DE92C049589;
        Thu, 10 Jan 2019 11:27:45 +0000 (UTC)
Received: from ws.net.home (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB11E451B;
        Thu, 10 Jan 2019 11:27:44 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:27:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] su-common.c: prefer /etc/default/su over login.defs
Message-ID: <20190110112742.rwlop4l5ohfcg36i@ws.net.home>
References: <4163e3c3-9814-232e-2d73-b7751f38d360@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163e3c3-9814-232e-2d73-b7751f38d360@suse.cz>
User-Agent: NeoMutt/20180716-1022-6b9065-dirty
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 10 Jan 2019 11:27:45 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 10, 2019 at 01:28:53AM +0100, Stanislav Brabec wrote:
>  login-utils/su-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
