Return-Path: <SRS0=wC18=NL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93714C0044C
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C042080A
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 08:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C042080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJaReQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeJaReQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 Oct 2018 13:34:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8034F3082A32;
        Wed, 31 Oct 2018 08:37:08 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0D01714B;
        Wed, 31 Oct 2018 08:37:07 +0000 (UTC)
Date:   Wed, 31 Oct 2018 09:37:04 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: when logname is erased, re-enable reloads
Message-ID: <20181031083704.vkplbhwusyzzsn5w@ws.net.home>
References: <30ff9b68-4eab-5c42-22e6-1e84920862f0@suse.cz>
 <9c1f697acf819067a1f78795b0aec5b51caf4138.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1f697acf819067a1f78795b0aec5b51caf4138.camel@v3.sk>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 31 Oct 2018 08:37:08 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Oct 27, 2018 at 05:17:09PM +0200, Lubomir Rintel wrote:
> On Fri, 2018-10-26 at 15:02 +0200, Stanislav Brabec wrote:
> > When user starts to enter logname, 8b58ffdd blocks issue reloads.
> > Reloads remain blocked even if user deletes all typed characters.
> > 
> > Make things visually consistent: If no characters are entered,
> > re-enable reloads.
> > 
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> > Cc: Lubomir Rintel <lkundrak@v3.sk>
> > Cc: Karel Zak <kzak@redhat.com>
> 
> Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Applied. Thanks guys!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
