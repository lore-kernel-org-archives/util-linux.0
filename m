Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: build-sys: minor issues
Date: Mon, 2 Jun 2014 13:05:08 +0200
Cc: util-linux@vger.kernel.org
References: <201406020056.17074.sweet_f_a@gmx.de> <201406020233.39094.sweet_f_a@gmx.de> <20140602094826.GN9000@x2.net.home>
In-Reply-To: <20140602094826.GN9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406021305.08682.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Karel Zak wrote:
> On Mon, Jun 02, 2014 at 02:33:38AM +0200, Ruediger Meier wrote:
> > On Monday 02 June 2014, Ruediger Meier wrote:
> > > I have two minor issues with our build-sys:
> >
> > Another issue:
> >
> > 3. --enable-gtk-doc does not work in out-of-tree build:
>
>  I'll try to fix it (it worked time ago if I good remember). Frankly,
>  the way how is gtk-doc designed to work with autotools sucks...

Thanks.

>  BTW, our TODO:
>
>    * use something better than gtk-doc for libmount and libblkid
> (doxyden?)
>
>   ;-)

So maybe we could re-think the point below when doxygen epoch will come.

> > BTW maybe we could consider about adding these docs to dist tarball
> > to not bother users with gtk-doc deps?
>
>  Hmm... not sure, I guess the number of people who care about libs
>  docs is pretty small and for mainstream distros is the dependence on
>  gtk-doc no issue.

I know it's debatable. Just in ideal world the lib interfaces (and docs) 
are fixed for a certain release and do not depend on build host. This 
is shown more clearly if you distribute the fixed documentations along 
with the sources. It's like projects with help2man-man pages often 
distribute these man pages too.

Another minor advantage is that users would be able to compare the docs 
across serveral util-linux versions without need to build all the docs. 
(Might be difficult if an old util-linux build-sys does not work 
anymore on recent host).

cu,
Rudi
