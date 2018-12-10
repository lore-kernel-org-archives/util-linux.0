Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE6C04EB8
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20AB20855
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 12:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20AB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLJMx3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeLJMx2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Dec 2018 07:53:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6FA3308FBAC;
        Mon, 10 Dec 2018 12:53:28 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0B760C5C;
        Mon, 10 Dec 2018 12:53:27 +0000 (UTC)
Date:   Mon, 10 Dec 2018 13:53:25 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux <util-linux@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH] rfkill: Add systemd integration
Message-ID: <20181210125325.hwngj6l646cfwt2f@ws.net.home>
References: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
 <20181122103907.vwjf6uprlxzthd7e@ws.net.home>
 <81e98f5c-7c5f-1c75-cd48-45b30b516eed@suse.cz>
 <CAG27Bk2-r3E1Ae2g4VMqNAEDUWrksLrTDx-jcoYvpZtCZNM_Ww@mail.gmail.com>
 <0ce3309a-009a-7c00-3a2c-e4917b894f8c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce3309a-009a-7c00-3a2c-e4917b894f8c@suse.cz>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 10 Dec 2018 12:53:28 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 27, 2018 at 07:16:04PM +0100, Stanislav Brabec wrote:
> Sami Kerola wrote:
> That said,
> > getting a clarification from Jochen would nice because otherwise we are
> > simply guessing.
> 
> Jochen Keil already left SUSE and I have no contact e-mail to him.
> 
> But I got complain that it is missing after migration of rfkill to util-linux:
> https://bugzilla.opensuse.org/show_bug.cgi?id=1092820

 It seems the best would be to ask upstream systemd guys. Maybe it's
 really Suse specific and maybe it's something we can support for more
 distros. I don't know.

 All thread:
 https://lore.kernel.org/util-linux/0ce3309a-009a-7c00-3a2c-e4917b894f8c@suse.cz/T/#m221ad50b88792236c10c507f9163b57761c254a7

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
