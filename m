Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84497C43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9EB20684
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9EB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbeKVVCY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbeKVVCY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEA4F30BAC51;
        Thu, 22 Nov 2018 10:23:36 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1992860FD9;
        Thu, 22 Nov 2018 10:23:35 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:23:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC/PATCH] Add hardening settings to fstrim.service
Message-ID: <20181122102333.whxolnpdfzghyd3f@ws.net.home>
References: <20181112204843.21641-1-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112204843.21641-1-andreas@fatal.se>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 22 Nov 2018 10:23:36 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 12, 2018 at 09:48:43PM +0100, Andreas Henriksson wrote:
> --- a/sys-utils/fstrim.service.in
> +++ b/sys-utils/fstrim.service.in

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
