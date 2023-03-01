Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DEC678D4
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCAUJA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAUI7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 15:08:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FB30F8
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 12:08:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7CC3F21A9C;
        Wed,  1 Mar 2023 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677701336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEF7dfDSlXGn5++6IGJY31meD6rs/duwjOmrkrZL5uk=;
        b=UfgFw+tQ+zMz4oU9cAoQmLu8GLA+DehLw/qqv/23VWYJ277rEfA8DSqH5OfEj85ZgkbeGY
        hWJeORQDCeWc66oKPAse02j61J4lBnWcXGHnx7wDwz7h/2qRgxTq7kWRM044Qp0wj9BzST
        mpdxi52MvOeWn7pq80mrs0GWl9gEF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677701336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEF7dfDSlXGn5++6IGJY31meD6rs/duwjOmrkrZL5uk=;
        b=f16ot5FhshP1TiibN0iMmNxGEl8KRe3WPq2PLVuuCDfn7v6mn1Bl0LuGpIPgziiXMa6l+F
        EWvm5MhYA05whMBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F47B2C141;
        Wed,  1 Mar 2023 20:08:56 +0000 (UTC)
Date:   Wed, 1 Mar 2023 21:08:54 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <20230301200854.GD19419@kitsune.suse.cz>
References: <20230301140957.21604-1-msuchanek@suse.de>
 <20230301141747.jpbvk4aieq3pdehh@zeha.at>
 <20230301142604.GA19419@kitsune.suse.cz>
 <Y/+CNZZwhbH/rGbX@mit.edu>
 <20230301171759.GB19419@kitsune.suse.cz>
 <Y/+b+LlvuaDD4i4k@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/+b+LlvuaDD4i4k@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 01:39:52PM -0500, Theodore Ts'o wrote:
> On Wed, Mar 01, 2023 at 06:17:59PM +0100, Michal Suchánek wrote:
> > > Using a random number generator for clock can help, but it's only 13
> > > bits, so it's certainly not fool-proof.  Given that using a time-based
> > > UUID leaks the MAC address of your ethernet port as well as when the
> > > UUID was generated (which can be interesting when you're curious say,
> > > when a Libreoffice doc was created), in general best practice is to
> > > use the random UUID type, especially given that modern Linux systems
> > > all have the getrandom(2) system call.  That gives you 58 bits of
> > > entropy in the UUID, so that's probably the better way to go.
> > 
> > That explains why I don't have a clock.txt file. I did not go out of my
> > way to generate time-based uuids.
> 
> Note that the only reason why you might be trying to generate a huge
> number of time-based UUID is if you are running a database (cough,

Thanks for the very detailed explanation.

I suppose the default is fine for most users then, and makes it
reasonably safe to use time basedd uuids for users of systems like
Raspberry Pi which exhibit weird time jumps, likely due to lack of RTC
battery.

uuidd is provided for people who want to generate large quantities of
UUIDs.

When somebody *really* wants and it improves their use case they can
mount tmpfs on /var/lib/libuuid/

Might be nice to write down in the uuid_generate man page if this is
coming up repeatedly.

Thanks

Michal
