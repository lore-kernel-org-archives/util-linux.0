Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC959C43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CC220831
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CC220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbeKVUpM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:45:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbeKVUpM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 15:45:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E0E1307D860;
        Thu, 22 Nov 2018 10:06:27 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 526205D763;
        Thu, 22 Nov 2018 10:06:25 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:06:23 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <casantos@datacom.com.br>
Cc:     util-linux <util-linux@vger.kernel.org>
Subject: Re: Build failure for SPARC after commit 1db8bf937
Message-ID: <20181122100623.wzib44y3owxp4wxm@ws.net.home>
References: <228628908.3067721.1542823294457.JavaMail.zimbra@datacom.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228628908.3067721.1542823294457.JavaMail.zimbra@datacom.com.br>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 22 Nov 2018 10:06:27 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 21, 2018 at 04:01:34PM -0200, Carlos Santos wrote:
> There is still a call to the now-defunct set_arch function in
> sys-utils/setarch.c:
> 
> 313 #if defined(__sparc64__) || defined(__sparc__)
> 314         if (strcmp(arch, "sparc32bash") == 0) {
> 315             if (set_arch(arch, 0L, 0))
> 316                 err(EXIT_FAILURE, _("Failed to set personality to %s"), arch);
> 317             execl("/bin/bash", "", NULL);
> 318             errexec("/bin/bash");
> 319         }
> 320 #endif

Ah, should be fixed now. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
