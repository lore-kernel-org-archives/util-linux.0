Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:62615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2HFI2e (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 04:28:34 -0400
Date: Mon, 6 Aug 2012 10:28:32 +0200 (CEST)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: kerolasa@gmail.com, Sami Kerola <kerolasa@iki.fi>
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <1829782354.1276693.1344241712777.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <CAG27Bk157so8J93EfTCQ1YBjXBUtYVVLcgpKg4eJdN6o77cN3A@mail.gmail.com>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi> <1344065620-17480-6-git-send-email-kerolasa@iki.fi> <1407718255.1271532.1344233652072.JavaMail.open-xchange@email.1und1.de> <CAG27Bk157so8J93EfTCQ1YBjXBUtYVVLcgpKg4eJdN6o77cN3A@mail.gmail.com>
Subject: Re: [PATCH 5/5] vipw: make vim writebackup mode work
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On August 6, 2012 at 9:30 AM Sami Kerola <kerolasa@iki.fi> wrote:

> On Mon, Aug 6, 2012 at 8:14 AM, Bernhard Voelker
> <mail@bernhard-voelker.de> wrote:

> Hi Berny,
>
> Yes, I did mention file exchange should probably warn.  When I
> added the warning it looked like noise, and I could not get
> message right.
>
> > We're talking about the intermediate file (in /tmp), but as it's
> > name is visible e.g. in ps listings, I'd recommend to be cautious
> > about it.
>
> The temporary file in vipw case is created to /etc/ and moved in
> place within directory.  Earlier /tmp/ was used, but it resulted
> to non-atomic move and rename(2) complaining about device
> boundary.  See following commit for details.

yes, /etc right.

> I am assuming /etc/ is not normally writable for users, so the
> security problem should be mostly theoretical.  That said perhaps
> a message such as
>
> vipw: intermediate /etc/vipw.XXXXX file change
>
> might be appropriate, if it is explained in vipw(8).  Or is it
> simply noise no-one cares?

Right, /etc is quite safe. Therefore, as vipw is deprecated anyway,
I'd say your patch is okay.

Have a nice day,
Berny

