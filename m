Return-Path: <SRS0=BbzG=OD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB4CC43441
	for <util-linux@archiver.kernel.org>; Sat, 24 Nov 2018 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884AE2086B
	for <util-linux@archiver.kernel.org>; Sat, 24 Nov 2018 08:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884AE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeKXTC7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:02:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56305 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKXTC6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 24 Nov 2018 14:02:58 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so21304337itg.5
        for <util-linux@vger.kernel.org>; Sat, 24 Nov 2018 00:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bb4GvzJzqLI1eo67vhU2iWDBtV/t+4fiyDSHmWmyLzc=;
        b=MtXlZK+M3V++9fFL6xpjLaaI4YB8AF94r+GMAkwjZxk9CVIqg/IfDQ6On36GwrT7oV
         sKenoygrs0wlmNJjkG8Ax/2edShb9YbtcUGBwoHb1tD6c1toBhw9ozcxouyjr9MX3O1G
         nTTdNtqbcDtTev1CUBZbEnwJlEMfD64Tn4OWxMkbOjtFw+R70HXIJAuisXMDUtF9ffeG
         ZlPFTOqAomuNYFVyYHFki33YC7oYrQEOUVg9cFs0iFd3jjHWhNqBqn7no4t4TMS5iAmJ
         VzarCZSyX/kHytZTo0Ue8iyq8+wOOdlSdzjlW2g+XYiVMxaVbDgfXCAmjZ+xsnFIR01M
         XoVw==
X-Gm-Message-State: AA+aEWYcg24xrMhird4YFCeZaw8W4/QvCQ3mTAiUnheKMQHiUBtsnpf/
        /GXY4pOAbBmyoNAG1m2YjTzvcpaI3sRNBkNav9g=
X-Google-Smtp-Source: AFSGD/UzpH2oBjtTL1car5FIWSxttBT8MA82t7MO+TBqBeGUs7r8HqHHHAAEwAdsrc/6S5lzD9/XFZq4SyOTsKuZT9s=
X-Received: by 2002:a05:660c:10:: with SMTP id q16mr14589191itj.51.1543047318074;
 Sat, 24 Nov 2018 00:15:18 -0800 (PST)
MIME-Version: 1.0
References: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz> <20181122103907.vwjf6uprlxzthd7e@ws.net.home>
 <81e98f5c-7c5f-1c75-cd48-45b30b516eed@suse.cz>
In-Reply-To: <81e98f5c-7c5f-1c75-cd48-45b30b516eed@suse.cz>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Sat, 24 Nov 2018 08:15:06 +0000
Message-ID: <CAG27Bk2-r3E1Ae2g4VMqNAEDUWrksLrTDx-jcoYvpZtCZNM_Ww@mail.gmail.com>
Subject: Re: [PATCH] rfkill: Add systemd integration
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, 24 Nov 2018 at 02:25, Stanislav Brabec <sbrabec@suse.cz> wrote:
> Karel Zak wrote:
> > On Wed, Nov 21, 2018 at 09:04:37PM +0100, Stanislav Brabec wrote:
> >> Add rfkill-block@.service and rfkill-unblock@.service templates.
> >> These make rfkill integration to systemd easier.
> >>
> >> Files come from openSUSE rfkill package.
> >>
> >> Example:
> >> Use `systemctl {start,stop} rfkill-block@bluetooth` to block or unblock
> >> (disable or enable) the bluetooth device.
> >
> > OK, but why? ;-)
> >
> > Does anything within systemd depend on rfkill? I guess for humans is
> > more friendly to call "rfkill unblock bluetooth" than use systemctl.
>
> I am not sure about use case of the original author, but I guess
> that it can be useful for suspend target and automatic unblocking when
> using on demand services (e. g. bluetooth service called after
> rfkill-unblock@bluetooth).

systemd has service[1] to maintain RF kill switch state as requested across
reboots.  I think these rfkill-{block,unblock}@{target} files are
convenience services to change RF kill states with systemctl.  That said,
getting a clarification from Jochen would nice because otherwise we are
simply guessing.

[1] https://www.freedesktop.org/software/systemd/man/systemd-rfkill.service.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
