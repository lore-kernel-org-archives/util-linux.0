Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdBUJuO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Feb 2017 04:50:14 -0500
Date: Tue, 21 Feb 2017 10:50:12 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Message-ID: <20170221095012.txqxcblrqkmoxktw@ws.net.home>
References: <20170213220641.1395-1-kerolasa@iki.fi>
 <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
 <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 20, 2017 at 10:12:06PM +0000, Sami Kerola wrote:
> On 20 February 2017 at 12:14, Karel Zak <kzak@redhat.com> wrote:
> > Merged, but except:
> >
> > On Mon, Feb 13, 2017 at 10:06:34PM +0000, Sami Kerola wrote:
> >>   misc: unify function declarations [smatch scan]
> >
> > I agree that some unification would be nice, but don't like
> >
> >    static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
> >           void log_err(const char *fmt, ...);
> >
> > it would be better to keep all the attributes after declaration:
> >
> >    static void log_err(const char *fmt, ...)
> >                     __attribute__((__noreturn__))
> >                     __attribute__((__format__(printf, 1, 2)));
> >
> > it means new line for each attribute. IMHO it's more readable and you
> > don't have to search for the function name, etc.
> 
> Hi Karel,
> 
> That's fair enough, and truth is the patch did not fix many warnings so
> I am sure we can live with them.
> 
> What comes to moving attributes at end of the declaration that does
> not please smatch.
> 
> lib/exec_shell.c:33:1: error: attributes should be specified before
> the declarator in a function definition
>  void exec_shell(void)

Report it as smatch bug. It's pretty common that function attributes
are defined after declaration. CC: Dan.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
