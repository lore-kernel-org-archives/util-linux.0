Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab1DKKhw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Apr 2011 06:37:52 -0400
Date: Mon, 11 Apr 2011 12:37:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Olivier =?utf-8?Q?Mengu=C3=A9?= <dolmen@cpan.org>
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] getopt: [getopt.c] add static qualifiers
Message-ID: <20110411103742.GA1719@nb.net.home>
References: <1301243396-26240-1-git-send-email-dolmen@cpan.org> <1301243396-26240-2-git-send-email-dolmen@cpan.org> <1301355571.2073.1.camel@offworld> <BANLkTikG9pi0ER0jPvZDGWRxWu9Kg1+jAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BANLkTikG9pi0ER0jPvZDGWRxWu9Kg1+jAQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 09, 2011 at 10:17:58AM +0200, Olivier Mengué wrote:
> I've noticed my patch has been committed in
> 0a626987e244b6fa30c18cfa86d12cd80b3977e8.
> Thanks.
> 
> Le 29 mars 2011 01:39, Davidlohr Bueso <dave@gnu.org> a écrit :
> >
> > On Sun, 2011-03-27 at 18:29 +0200, Olivier Mengué wrote:
> > > -void *our_malloc(size_t size);
> > > -void *our_realloc(void *ptr, size_t size);
> >
> > It would be nice to use our xalloc lib for stuff like this.
> 
> Working on a patch for that.
> However, note that xalloc error messages are not localized contrary to
> the current implementation.

Hmm.. it should be probably fixed.

> > > -void print_help(void)
> > > +static void print_help(void)
> >
> > Lately we've been standardizing this kind of things too.
> 
> A real cleanup of this function would require to also merge the
> multiple fputs() calls. This would have impact on localization.
> What is the policy on changes having impact on localization? (Please,
> add the answer to README.devel too).

Don't care about localization, the strings will be translated before
release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
