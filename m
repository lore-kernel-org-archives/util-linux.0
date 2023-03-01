Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C31C7EE2F
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 17:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCARSE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 12:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCARSE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 12:18:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9537AA6
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 09:18:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 056C321AB0;
        Wed,  1 Mar 2023 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677691081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vTF/UIjElEu2giULsFzFGZnciKx2nmwJtMdvdSK2KI=;
        b=AOfFaAF9s4knt8nDcZo2SNNhv2oEgMKcohMlQLLsxpGMG+i5x1zCWTWyyX5Ta1LPi5KMbM
        Lc2SVXejYCPvGdRWBZx61LJVfhm/r4IR+/Nm1KGeYPggOIfewlFwR2X0fp4GRf5u7Huv6m
        Cgny5eF/8swltPrwaEWJ+XQAk0OVCG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677691081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vTF/UIjElEu2giULsFzFGZnciKx2nmwJtMdvdSK2KI=;
        b=rjSCce6ZuyliuC7hykHIE9NCMMkVsjXy5WTmF4pvC58SSen/gDMES4HcXKcwrHG0kVlENH
        vNQnXIQ3x1H0XwCw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C7E622C142;
        Wed,  1 Mar 2023 17:18:00 +0000 (UTC)
Date:   Wed, 1 Mar 2023 18:17:59 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <20230301171759.GB19419@kitsune.suse.cz>
References: <20230301140957.21604-1-msuchanek@suse.de>
 <20230301141747.jpbvk4aieq3pdehh@zeha.at>
 <20230301142604.GA19419@kitsune.suse.cz>
 <Y/+CNZZwhbH/rGbX@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/+CNZZwhbH/rGbX@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 11:49:57AM -0500, Theodore Ts'o wrote:
> On Wed, Mar 01, 2023 at 03:26:04PM +0100, Michal Suchánek wrote:
> > > Last time I asked about this file on this mailing list, I was
> > > informed that clock.txt is supposed to survive reboots.
> > > Moving it to /run (or any other tmpfs) would break this.
> > 
> > What's so valuable in it that it needs to survive?
> > 
> > I don't have it at all.
> > 
> > Also the code seems to re-synchronize with the real time clock from time
> > to time which makes the content relevant only for limited periods of
> > time.
> 
> The concern is if the system time goes backwards, this could result in
> a duplicative UUID being returned.  This was especially a concern for
> systems that were dual-booting with Windows, where Windows set the
> real-time clock to localtime, and Linux set the real-time clock to
> GMT, and so the real time clock on those systems had a tendency to
> bound around a *lot*.
> 
> Using a random number generator for clock can help, but it's only 13
> bits, so it's certainly not fool-proof.  Given that using a time-based
> UUID leaks the MAC address of your ethernet port as well as when the
> UUID was generated (which can be interesting when you're curious say,
> when a Libreoffice doc was created), in general best practice is to
> use the random UUID type, especially given that modern Linux systems
> all have the getrandom(2) system call.  That gives you 58 bits of
> entropy in the UUID, so that's probably the better way to go.

That explains why I don't have a clock.txt file. I did not go out of my
way to generate time-based uuids.

Thanks

Michal
