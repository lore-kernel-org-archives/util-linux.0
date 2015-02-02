Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35016 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbbBBMhn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 07:37:43 -0500
Date: Mon, 2 Feb 2015 13:37:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Message-ID: <20150202123736.GN16162@ws.net.home>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
 <20150202121126.GL16162@ws.net.home>
 <20150202122923.GA3933@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150202122923.GA3933@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 02, 2015 at 08:29:23AM -0400, Peter Cordes wrote:
> On Mon, Feb 02, 2015 at 01:11:26PM +0100, Karel Zak wrote:
> > On Sun, Feb 01, 2015 at 03:02:06PM +0100, Benno Schulenberg wrote:
> > > [...cfdisk...]
> > > prompted for a partition size, would put the cursor at the start
> > > of the suggested value, and hitting any other key than Enter
> > > would erase this value. That is nice and desirable behaviour.
> > > Could that be restored?
> > 
> >  It would be better to implement full one line editor with support for
> >  all basic keys and with ability to insert and erase chars on
> >  arbitrary position with in the string... v2.27 :-)
> 
>  Maybe link with GNU readline, to avoid reinventing the wheel.

yep, and maybe for all fdisks, but it would be probably nice to have
it optional (--with-readline), and without readline keep it simple and
stupid.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
