Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F224C433E0
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451052065E
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 13:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGXNCg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:02:36 -0400
Received: from mail.namespace.at ([213.208.148.235]:39682 "EHLO
        mail.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNCg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 09:02:36 -0400
Date:   Fri, 24 Jul 2020 15:02:33 +0200
From:   Chris Hofstaedtler <zeha@debian.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: fix expected test output on alpha
Message-ID: <20200724130232.7ucelewuopeytqhf@percival.namespace.at>
References: <20200724003509.19927-1-zeha@debian.org>
 <20200724071646.7xrf7esfrvf3ab4u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724071646.7xrf7esfrvf3ab4u@ws.net.home>
User-Agent: NeoMutt/20180716
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* Karel Zak <kzak@redhat.com> [200724 09:17]:
> On Fri, Jul 24, 2020 at 12:35:09AM +0000, Chris Hofstaedtler wrote:
> >  tests/expected/fdisk/bsd_0_64_alpha.LE | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied, thanks.
> 
> It would be nice to report Debian tests' issues during -rc1 or -rc2.
> It's a little bit annoying to have such bug report one day after
> release ;-)

Yeah, sorry about that. I was busy with all sorts of other stuff
unfortunately :-(

Chris
 
