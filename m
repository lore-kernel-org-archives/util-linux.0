Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775EC433EF
	for <util-linux@archiver.kernel.org>; Wed, 16 Feb 2022 08:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiBPIlA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:41:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBPIk7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Feb 2022 03:40:59 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 00:40:47 PST
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21E1D179B
        for <util-linux@vger.kernel.org>; Wed, 16 Feb 2022 00:40:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A94985C02FD;
        Wed, 16 Feb 2022 03:34:03 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Wed, 16 Feb 2022 03:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wesleyac.com; h=
        cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; bh=J
        5Pn8nUWTPufCJMcXIhdcyBkAn4gkTMCsdqc5+cFJeU=; b=ioY0748wZ43CNrXdZ
        NR3U9fa3dXY1oKb2sGw3RGnkZ8SdceuSAaYNylahAavCIbWyVVeLk1YM4GNI8UVL
        SMBMXcxY1/ZLpCRfxuYn5izmy6MUNR7/P6uHFBjT0nhiNty3r4JrYbt3at10CUFS
        xT06NrP9rf++I+Nscg+sblf8df5lvgd6ZO187C7ERDG12DDSH02+BWWWozmbgsmt
        H9cVOC+7NINpgsFpBqNdsw/55skPgIF9xt8Jro8bgKksL3pNLO+dWpqzHwPvy9MD
        gklqlQjL5iSMsPo0GrH0198bvcG2DoYmnbtCabmRQND/hjvBOKMYvmzvgxkWeQuM
        BI1TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=J5Pn8nUWTPufCJMcXIhdcyBkAn4gkTMCsdqc5+cFJ
        eU=; b=h/3PQ7qh0MnhHq5R+1QyfYZTgG4oYAk+cKweINy+nyVXdl6IPrXSfmEJz
        ACebuXQL7g+gZuwIyXJszSClXptTdqsKuM9Yi5B/jd+cQbKvvmGEXGDtlDM+HABs
        OS2wo19QDM9JjXOIPaECzUMY2JApCmBYV31Rog1JXLMqsT4OxA8p781bRJ1divxq
        N8ALmJaPg/k0uL+lLtmelUWgbHIvIG9lMfv02XW5S06LjzCyVkwhTnuhx3PonVfF
        hNyGKz8pAL2+etvMc5VZc9DphA3lOYm8tUTcjo7MqEu0p+2Fp3FD2omT4JQ5VsLD
        tjWw/dTGxrpTcDIHexk4TfkUgMtDg==
X-ME-Sender: <xms:-7YMYi4RVFyQ9pPN20phbhwzNXCPsPfTAcBxQNTwBIJU7QOnbLeNbg>
    <xme:-7YMYr7AmNl1yTOnLJxkaDYQZRde68zS9rTlHftVQonDeuvTWfWE8cTlwob3m5kPE
    OzMDEC9_4zwhOOWPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfhggvshhlvgihucetphhtvghkrghrqdevrghsshgvlhhsfdcu
    oehmvgesfigvshhlvgihrggtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfejvdfhue
    egheevudfgiedvfeekheeifeeghefguddtffehheegheeiheejteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesfigvshhlvgihrggtrd
    gtohhm
X-ME-Proxy: <xmx:-7YMYhcdvU0iAr1ktpMZg0ROQ8welj80x7doXydaXB1vnEqwib8dAQ>
    <xmx:-7YMYvJ4vwmaLGZ7HA_ymvEyEwaWUnEDqWQGlNHzdZN6v0_5OuX-lg>
    <xmx:-7YMYmKvi8RjqaBqqzWGJQCiKLIMnxY3nc7xM3CKdGQ7ypHUUfmsaQ>
    <xmx:-7YMYlkNoTnZpUUjlvrBTXmdBFEaAbfjpC8BQ3xbPV32DJpbcz4BHw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A03324A0074; Wed, 16 Feb 2022 03:34:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4776-gd3673c9443-fm-20220215.001-gd3673c94
Mime-Version: 1.0
Message-Id: <130eb608-f5c6-44c8-999a-6e56e4c05d9a@www.fastmail.com>
Date:   Wed, 16 Feb 2022 16:33:43 +0800
From:   "Wesley Aptekar-Cassels" <me@wesleyac.com>
To:     util-linux@vger.kernel.org
Subject: dmesg feature request: timestamps relative to current time
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi all,

When I use dmesg, I'm often annoyed that there isn't a good way to tell how
long ago a specific log line was from. The only accurate way to do so that I've
found is to look at /proc/uptime and compare that value to the log line I care
about. The ctime and iso options could be useful, but as the manpage points
out, they are inaccurate in the case of suspend/resume, and I'd still have to
do math in my head to see how long ago something was, even if it's easier to do
the conversion than with the default style of timestamp.

I'd like to see a value for the --time-format option that prints timestamps as
values in seconds relative to the time dmesg was executed. This would allow
people to quickly see how long ago a relevant event happened. I'm not sure
whether it would make more sense to conceive of times in the past as being
negative or positive, but one or the other would need to be selected (one might
see both in the case of --follow).

Is this a feature people would be open to adding? I'm happy to write a patch if
so, but wanted to check here first to see if it's something that'd be likely to
be accepted.

Thanks,

:w
