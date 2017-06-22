Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 06/13] setarch: print usage error if no argument given
Date: Thu, 22 Jun 2017 10:44:58 +0200
Cc: util-linux@vger.kernel.org
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de> <1498099066-24235-7-git-send-email-sweet_f_a@gmx.de> <20170622083824.hqgqykwccfb7jmbb@ws.net.home>
In-Reply-To: <20170622083824.hqgqykwccfb7jmbb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706221044.59203.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 22 June 2017, Karel Zak wrote:
> On Thu, Jun 22, 2017 at 04:37:39AM +0200, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > This looks more likely as intended.
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  sys-utils/setarch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
> > index eb9cf21..6481eb2 100644
> > --- a/sys-utils/setarch.c
> > +++ b/sys-utils/setarch.c
> > @@ -301,7 +301,7 @@ int main(int argc, char *argv[])
> >  	textdomain(PACKAGE);
> >  	atexit(close_stdout);
> >
> > -	if (argc < 1)
> > +	if (argc < 2)
> >  		show_usage(_("Not enough arguments"));
>
> I don't think so.
>
> We use setarch by symlinks (i386, uname26 linux32 linux64, ...) and
> in this case it's executed without argument. The symlink name is good
> enough.
>
> The right solutions is to remove this entire if() block.

Maybe argc can be 0 when not invoked from a sane shell
https://stackoverflow.com/questions/2794150/when-can-argv0-have-null

Just skip this patch, I will update this on github later.


> Later in the code we have "no architecture argument specified".
>
>
>     Karel
