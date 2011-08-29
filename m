Return-Path: util-linux-owner@vger.kernel.org
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39988 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766Ab1H2OAo convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Aug 2011 10:00:44 -0400
Date: Mon, 29 Aug 2011 14:59:32 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.20
Message-ID: <20110829145932.5f63d9ee@lxorguk.ukuu.org.uk>
In-Reply-To: <CAFLxGvwXreixiYoj+SVoJuH+dLx8THw9cJJ2prEFpUxYTTUbAw@mail.gmail.com>
References: <20110829122344.GI1855@nb.net.home>
	<CAFLxGvwXreixiYoj+SVoJuH+dLx8THw9cJJ2prEFpUxYTTUbAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 29 Aug 2011 15:35:44 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> On Mon, Aug 29, 2011 at 2:23 PM, Karel Zak <kzak@redhat.com> wrote:
> > Util-linux 2.20 Release Notes
> > =============================
> >
> >  The ddate(1) command is not built by default (see --enable-ddate).
> >
> 
> This change will make the discordians very unhappy. ;-)

Yes it should be --disable-ddate to enable it....
