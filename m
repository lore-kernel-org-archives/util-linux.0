Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487BC43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CF42087A
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CF42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeKLUbn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeKLUbm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Nov 2018 15:31:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF15E3082E5F;
        Mon, 12 Nov 2018 10:39:03 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF2F95D9D6;
        Mon, 12 Nov 2018 10:39:02 +0000 (UTC)
Date:   Mon, 12 Nov 2018 11:39:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33
Message-ID: <20181112103900.csy772f52hz6glej@ws.net.home>
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
 <20181106123402.cy52t2ql4yvfqme6@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106123402.cy52t2ql4yvfqme6@function>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 12 Nov 2018 10:39:04 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 06, 2018 at 01:34:02PM +0100, Samuel Thibault wrote:
> --- util-linux-2.33.orig/term-utils/agetty.c
> +++ util-linux-2.33/term-utils/agetty.c

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
