Return-Path: <SRS0=Hpyb=RA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640CC43381
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A09220842
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 13:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBYNJ3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:09:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYNJ3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 Feb 2019 08:09:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6388356F2;
        Mon, 25 Feb 2019 13:09:28 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6A35C226;
        Mon, 25 Feb 2019 13:09:27 +0000 (UTC)
Date:   Mon, 25 Feb 2019 14:09:25 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     util-linux@vger.kernel.org, Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] libfdisk: (dos) Use strtoul to parse the label-id
Message-ID: <20190225130925.geoao2uicu37yhqv@ws.net.home>
References: <20190222160412.26652-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222160412.26652-1-juergh@canonical.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 25 Feb 2019 13:09:28 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 22, 2019 at 05:04:12PM +0100, Juerg Haefliger wrote:
>  libfdisk/src/dos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
