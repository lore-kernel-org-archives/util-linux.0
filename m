Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbdF2ISW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 04:18:22 -0400
Date: Thu, 29 Jun 2017 10:18:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] misc: standardize USAGE_COLUMNS
Message-ID: <20170629081818.inahxuym5tfjtf4l@ws.net.home>
References: <1621510c-227f-325b-7867-c305f738174a@gmx.com>
 <201706290227.35921.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706290227.35921.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 02:27:35AM +0200, Ruediger Meier wrote:
> On Thursday 29 June 2017 at 00:44, you wrote:
> 
> 
> > @@ -101,7 +101,7 @@ static void __attribute__((__noreturn__)) 
> usage(void)
> >         fputs(USAGE_OPTIONS, stdout);
> >         fputs(_(" -J, --json             use JSON output format\n"), 
> stdout);
> >         fputs(_(" -n, --noheadings       don't print headings\n"), 
> stdout);
> > -       fputs(_(" -o, --output <list>    define which output columns 
> to use\n"), stdout);
> > +       fputs(_(" -o, --output <list>    columns to display (see 
> Columns:)\n"), stdout);
> >         fputs(_(" -r, --raw              use the raw output 
> format\n"), stdout);
> 
> 
> That's not bad but the standard is IMO to use capital letters
> for everthing which is explained below.
> 
> This avoids sometimes even the need to explicitly write extra
> terms like "see Columns", see:
> 
> Options:
>  -n, --noheadings       don't print headings
>  -o, --output COLUMNS   columns to display

I don't like it, we use <list> as information about format. I don't
want to replace <foo> with FOO everywhere. IMHO <foo> is more readable
and it's something we decided years ago.

What about:

   -o, --output <list>    COLUMNS to display (see below)

I like "COLUMNS" and "(see below)" as a way how to redirect reader to 
the right place.

> Available output COLUMNS:

I think "COLUMNS:" as suggested by William is good enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
