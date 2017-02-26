Return-Path: luc.vanoostenryck@gmail.com
Date: Sun, 26 Feb 2017 05:07:28 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Karel Zak <kzak@redhat.com>,
	util-linux <util-linux@vger.kernel.org>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Message-ID: <20170226040727.vjf6wdy7yiakppx5@macbook.local>
References: <20170213220641.1395-1-kerolasa@iki.fi>
 <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
 <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
 <20170221095012.txqxcblrqkmoxktw@ws.net.home>
 <20170223153049.GC4133@mwanda>
 <alpine.LNX.2.20.1702251653080.16457@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1702251653080.16457@imuri>
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 25, 2017 at 05:32:23PM +0000, Sami Kerola wrote:
> On Fri, 24 Feb 2017, Dan Carpenter wrote:
> text-utils/more.c:674:43: error: symbol 'end_it' redeclared with different 
> type (originally declared at text-utils/more.c:143) - different modifiers
> 
> that are caused by lack of function attributes in declaration, while 
> fuction has them.

Yes, this is a sparse's bug.
I hope I'll be able to look at it soon.

> See below simple source file that demonstrates how to triggers warning in 
> question. When I said was 'smatch' printed warnings it was cgcc that was 
> complaining , and therefore this is not really a 'smatch' problem at all. 
> Sorry about giving wrong impression.
> 
> When comparing gcc with clang gives very similar warning. Perhaps the 
> right way to go about this is to reorder attributes to be in front of 
> functions after all.


Luc Van Oostenryck
