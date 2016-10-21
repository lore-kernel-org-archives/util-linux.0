Return-Path: andersk@mit.edu
Date: Fri, 21 Oct 2016 15:26:09 -0400 (EDT)
From: Anders Kaseorg <andersk@mit.edu>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] getopt: Terminate long_options even if add_long_options
 is never called
In-Reply-To: <20161021121256.urgiwqn564hqjquw@ws.net.home>
Message-ID: <alpine.DEB.2.10.1610211525500.43219@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1610191834080.52298@buzzword-bingo.mit.edu> <20161021121256.urgiwqn564hqjquw@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Fri, 21 Oct 2016, Karel Zak wrote:
> I have applied a little bit different solution
> https://github.com/karelzak/util-linux/commit/e1164591f7927402af8d73d340e75dbfeb06a288
> 
> now add_longopt(ctl, NULL, 0) always terminates the array.
> 
> Please, re-test it. Thanks!

Works for me.

Anders
