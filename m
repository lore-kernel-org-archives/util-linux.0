Return-Path: <SRS0=Nyt8=RV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486A6C43381
	for <util-linux@archiver.kernel.org>; Mon, 18 Mar 2019 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5022085A
	for <util-linux@archiver.kernel.org>; Mon, 18 Mar 2019 21:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCRVQj convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:16:39 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:36583 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbfCRVQj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Mar 2019 17:16:39 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 17:16:38 EDT
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 460794851C1;
        Mon, 18 Mar 2019 22:10:30 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Rick van Rein <rick@openfortress.nl>,
        =?ISO-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <asbjorn@asbjorn.st>
Subject: Re: script(1) plans
Date:   Mon, 18 Mar 2019 22:10:29 +0100
Message-ID: <2845909.CbUA7ZE4ZZ@merkaba>
In-Reply-To: <20190318125322.4obb27vwtxfuwuie@ws.net.home>
References: <20190318125322.4obb27vwtxfuwuie@ws.net.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel.

Karel Zak - 18.03.19, 13:53: 
> I'd like to improve script(1) to be more flexible and support more
> streams. The current version allow to log only output, but I'd like to
> add possibility to log input, signals and more details about the
> session.
> 
> The idea is to introduce a new timing file format; and use it in case
> a new features are requested by user on script(1) command line. The
> new format will be still based on text and easy to convert to the old
> version.
[…]
> The target release will be probably v2.35 and I'm going to start work
> on it ASAP (probably this or next week).
> 
> Comments & objections?

Epic. I am no expert regarding what would be good for "script" command, 
but I love the ideas you share here. They extend the possibilities of 
what can be done with the command quite a bit.

Seems finally time to include the script command somewhere in my Linux 
training slides. Like "watch", which I often show to participants I 
still have no slide for it. About time, I'd say.

THanks,
-- 
Martin


