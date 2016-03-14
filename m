Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964849AbcCNM00 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 08:26:26 -0400
Date: Mon, 14 Mar 2016 13:26:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Matthias Brugger <mbrugger@suse.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "tests: start script/race test only when
 --force specified""
Message-ID: <20160314122621.3ru2o4doxbb7b57w@ws.net.home>
References: <1457455978-8530-1-git-send-email-mbrugger@suse.com>
 <20160309104340.axpsgrvhf2o3llkh@ws.net.home>
 <201603141249.40485.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603141249.40485.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 12:49:40PM +0100, Ruediger Meier wrote:
> On Wednesday 09 March 2016, Karel Zak wrote:
> > On Tue, Mar 08, 2016 at 05:52:58PM +0100, Matthias Brugger wrote:
> > > +# Don't execute this test by default, --force required
> > > +TS_OPTIONAL="yes"
> >
> >  I have marked the test by
> >
> >     TS_KNOWN_FAIL="yes
> >
> >  it seems better than disable the test.
> 
> While we are at it, IMO we should finally disable libmount/lock too 
> (TS_OPTIONAL).

Done. It's probably to aggressive...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
