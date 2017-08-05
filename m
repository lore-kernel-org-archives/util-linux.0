Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sat, 5 Aug 2017 17:34:09 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 9/9] agetty: fix invalid usage crash
In-Reply-To: <20170801094212.72yitooyxbnq6o4j@ws.net.home>
Message-ID: <alpine.LNX.2.20.1708051733400.4995@imuri>
References: <20170731195508.11661-1-kerolasa@iki.fi> <20170731195508.11661-10-kerolasa@iki.fi> <20170801094212.72yitooyxbnq6o4j@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 1 Aug 2017, Karel Zak wrote:

> On Mon, Jul 31, 2017 at 08:55:08PM +0100, Sami Kerola wrote:
> > @@ -812,7 +813,8 @@ static void parse_args(int argc, char **argv, struct options *op)
> >  		parse_speeds(op, argv[optind++]);
> >  		if (argc < optind + 1) {
> >  			log_warn(_("not enough arguments"));
> > -			warn(_("not enough arguments"));
> > +			warnx(_("not enough arguments"));
> > +			exit(EXIT_FAILURE);
> 
> what about:
> 
>             errx(EXIT_FAILURE, _("not enough arguments"));

That is better. Updates in my 2017wk30 branch.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
