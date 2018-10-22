Return-Path: <SRS0=rDr2=NC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94751C67863
	for <util-linux@archiver.kernel.org>; Mon, 22 Oct 2018 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B2120658
	for <util-linux@archiver.kernel.org>; Mon, 22 Oct 2018 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJVRkx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:40:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeJVRkx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Oct 2018 13:40:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D8E13082125;
        Mon, 22 Oct 2018 09:23:12 +0000 (UTC)
Received: from ws.net.home (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 147115C22D;
        Mon, 22 Oct 2018 09:23:10 +0000 (UTC)
Date:   Mon, 22 Oct 2018 11:23:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
Message-ID: <20181022092308.elz37l65mciouoce@ws.net.home>
References: <20181016064149.2698-1-lkundrak@v3.sk>
 <20181016074053.dea6ydle26y37uva@ws.net.home>
 <52ebddaca50ed8d5f498bdf56b02ae4640af369a.camel@v3.sk>
 <cc6f95bb-6dc6-cb34-fb7e-505da29e61f1@suse.cz>
 <0d9d07b6b3f45e069fefa4e9e008822a3aa7a135.camel@v3.sk>
 <b7a4fca3-6ee1-f81d-7db1-0c069cd4e56b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a4fca3-6ee1-f81d-7db1-0c069cd4e56b@suse.cz>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 22 Oct 2018 09:23:12 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 19, 2018 at 10:08:17PM +0200, Stanislav Brabec wrote:
> This code implements both echo and Backspace processing!

 :-) I guess it's the original serial line code...

> Note that the patch works even with less aggressive
> +		tp->c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK | ECHOKE);
> I am not sure whether setting c_lflag to 0 is completely safe.

"It's aggressive" was my first feeling from the patch -- but it seems
there is nothing else in lflags relevant for Linux and agetty and for
serial line we do the same.

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

Thanks guys! I have applied the patch to master branch -- it's not
invasive patch ant it seems important enough for v2.33.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
