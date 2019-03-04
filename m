Return-Path: <SRS0=c2jh=RH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A976C43381
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F520663
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCDKj5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:39:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfCDKj5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Mar 2019 05:39:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A826D56F1;
        Mon,  4 Mar 2019 10:39:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F32BD5D978;
        Mon,  4 Mar 2019 10:39:55 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:39:53 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/2] agetty: Fix input of non-ASCII characters in
 get_logname()
Message-ID: <20190304103953.2hzro2fuqluszarg@ws.net.home>
References: <76fefdb8-0c24-338e-c0ef-9a5b707d1e0a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76fefdb8-0c24-338e-c0ef-9a5b707d1e0a@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 04 Mar 2019 10:39:57 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 27, 2019 at 11:22:19PM +0100, Stanislav Brabec wrote:
>  term-utils/agetty.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
