Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab1HVIRA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 04:17:00 -0400
Date: Mon, 22 Aug 2011 10:16:54 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: man-pages and usage() howto
Message-ID: <20110822081654.GH699@nb.net.home>
References: <20110815141948.GH2038@nb.net.home> <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com> <1313485424.19019.140258130122469@webmail.messagingengine.com> <20110816104652.GA14535@nb.net.home> <CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com> <1313831405.14363.140258131741205@webmail.messagingengine.com> <CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 20, 2011 at 09:08:08PM +0200, Sami Kerola wrote:
> On Sat, Aug 20, 2011 at 11:10, Benno Schulenberg <bensberg@justemail.net> wrote:
> > On Wed, 17 Aug 2011 15:07 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> >> On Tue, Aug 16, 2011 at 12:39, Karel Zak <kzak@redhat.com> wrote:
> >>>  It would be also nice to sync man pages with usage() format.
> >
> > Do you mean that you want to use "--option <argument>" also in the
> > man pages, Karel?  Or do we stick there to italics for arguments?
> > (Which translates to underlining on terminals.)

 I mean that we need to use the lowercase for the arguments in usage()
 as well as in man pages.

> IMHO the following looks quite ok, and not too different to
> usage().
> 
> .TP
> \fB\-n\fR, \fB\-\-no\-argument\fR
> This option does not use argument.
> .TP
> \fB\-o\fR, \fB\-\-optional\fR[=<\fIarg\fR>]
> This option uses optional argument.
> .TP
> \fB\-r\fR, \fB\-\-required\fR <\fIarg\fR>
> This option requires an argument.
> 
> Comments?

 I have no strong opinion about it. Benno is probably right that
 italics for the arguments is enough. 

 We already use option arguments without diamond brackets in our man
 pages, so let's continue with this convention to minimize number of
 changes in the man pages ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
