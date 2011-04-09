Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44930 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1DIISS convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 9 Apr 2011 04:18:18 -0400
Received: by gyd10 with SMTP id 10so1688126gyd.19
        for <util-linux@vger.kernel.org>; Sat, 09 Apr 2011 01:18:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1301355571.2073.1.camel@offworld>
References: <1301243396-26240-1-git-send-email-dolmen@cpan.org>
 <1301243396-26240-2-git-send-email-dolmen@cpan.org> <1301355571.2073.1.camel@offworld>
From: =?ISO-8859-1?Q?Olivier_Mengu=E9?= <dolmen@cpan.org>
Date: Sat, 9 Apr 2011 10:17:58 +0200
Message-ID: <BANLkTikG9pi0ER0jPvZDGWRxWu9Kg1+jAQ@mail.gmail.com>
Subject: Re: [PATCH] getopt: [getopt.c] add static qualifiers
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I've noticed my patch has been committed in
0a626987e244b6fa30c18cfa86d12cd80b3977e8.
Thanks.

Le 29 mars 2011 01:39, Davidlohr Bueso <dave@gnu.org> a écrit :
>
> On Sun, 2011-03-27 at 18:29 +0200, Olivier Mengué wrote:
> > -void *our_malloc(size_t size);
> > -void *our_realloc(void *ptr, size_t size);
>
> It would be nice to use our xalloc lib for stuff like this.

Working on a patch for that.
However, note that xalloc error messages are not localized contrary to
the current implementation.

> > -void print_help(void)
> > +static void print_help(void)
>
> Lately we've been standardizing this kind of things too.

A real cleanup of this function would require to also merge the
multiple fputs() calls. This would have impact on localization.
What is the policy on changes having impact on localization? (Please,
add the answer to README.devel too).

Olivier.
