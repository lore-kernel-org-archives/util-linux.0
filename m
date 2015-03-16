Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbCPLuQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 07:50:16 -0400
Date: Mon, 16 Mar 2015 12:50:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Rainer Gerhards <rgerhards@gmail.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] logger: tidy few indentation issues
Message-ID: <20150316115014.GK28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <1426424094-25451-2-git-send-email-kerolasa@iki.fi>
 <CAP-up9DHpM8Xye6y7LptG4bNUeW_Kx22R80Q6nAgv0v8kzi+VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP-up9DHpM8Xye6y7LptG4bNUeW_Kx22R80Q6nAgv0v8kzi+VQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 12:22:51PM +0100, Rainer Gerhards wrote:
> On Sun, Mar 15, 2015 at 1:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> 
> Quick question on this (especially for future work):
> 
> > @@ -387,29 +386,35 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
> >  #define NILVALUE "-"
> >  static void syslog_rfc5424_header(struct logger_ctl *const ctl)
> >  {
> > +       char *time;
> > +       char *hostname;
> > +       char *const app_name = ctl->tag;
> > +       char *procid;
> > +       char *const msgid = xstrdup(ctl->msgid ? ctl->msgid : NILVALUE);
> > +       char *structured_data;
> 
> Is it project policy to always define variables at the beginning of
> the function? I ask because I used to do that as well, before I got

 at beginning of the { block }, for example:

 if (foo) {
    char *foostr = strdup(whatever);

    do_foo(foostr);
    free(foostr);
 }

 is fine.

> Also on the idention: I assume indention via tabs with tabwidth 4. Is
> there a style document I an look at?

 If possible (e.g. new/refactored stuff) then we usually follow kernel:
 https://www.kernel.org/doc/Documentation/CodingStyle

 ... but there are many old utils where it's better to follow already
 used codding style than mix more styles together.

> Thanks and sorry for the extra effort.

 Ah, this is a real detail...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
