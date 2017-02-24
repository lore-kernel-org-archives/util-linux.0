Return-Path: dan.carpenter@oracle.com
Date: Fri, 24 Feb 2017 03:37:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Message-ID: <20170223153049.GC4133@mwanda>
References: <20170213220641.1395-1-kerolasa@iki.fi>
 <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
 <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
 <20170221095012.txqxcblrqkmoxktw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221095012.txqxcblrqkmoxktw@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 21, 2017 at 10:50:12AM +0100, Karel Zak wrote:
> On Mon, Feb 20, 2017 at 10:12:06PM +0000, Sami Kerola wrote:
> > On 20 February 2017 at 12:14, Karel Zak <kzak@redhat.com> wrote:
> > > Merged, but except:
> > >
> > > On Mon, Feb 13, 2017 at 10:06:34PM +0000, Sami Kerola wrote:
> > >>   misc: unify function declarations [smatch scan]
> > >
> > > I agree that some unification would be nice, but don't like
> > >
> > >    static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
> > >           void log_err(const char *fmt, ...);
> > >
> > > it would be better to keep all the attributes after declaration:
> > >
> > >    static void log_err(const char *fmt, ...)
> > >                     __attribute__((__noreturn__))
> > >                     __attribute__((__format__(printf, 1, 2)));
> > >
> > > it means new line for each attribute. IMHO it's more readable and you
> > > don't have to search for the function name, etc.
> > 
> > Hi Karel,
> > 
> > That's fair enough, and truth is the patch did not fix many warnings so
> > I am sure we can live with them.
> > 
> > What comes to moving attributes at end of the declaration that does
> > not please smatch.
> > 
> > lib/exec_shell.c:33:1: error: attributes should be specified before
> > the declarator in a function definition
> >  void exec_shell(void)
> 
> Report it as smatch bug. It's pretty common that function attributes
> are defined after declaration. CC: Dan.
> 

This is a Sparse warning, not a Smatch warning.  It shouldn't show up
when you do a `make checksmatch` so I'm confused by that.  Anyway,
could you email linux-sparse@vger.kernel.org?

regards,
dan carpenter
