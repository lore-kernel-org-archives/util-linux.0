Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09969C43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D481A20675
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbeLQJrP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732240AbeLQJrB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 04:47:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A137792A6F
        for <util-linux@vger.kernel.org>; Mon, 17 Dec 2018 09:47:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ACC75C1B5;
        Mon, 17 Dec 2018 09:47:00 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:46:57 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: stratis: correct byte order
Message-ID: <20181217094657.3v6zsk2nkw3ue7o5@ws.net.home>
References: <20181213150328.23129-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213150328.23129-1-tasleson@redhat.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Dec 2018 09:47:01 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 13, 2018 at 09:03:28AM -0600, Tony Asleson wrote:
>  libblkid/src/superblocks/stratis.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
