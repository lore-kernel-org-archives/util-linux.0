Return-Path: dave@gnu.org
Subject: Re: non-recursive build system
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120612151819.GE23991@x2.net.home>
References: <20120612100340.GB23991@x2.net.home>
	 <1339505836.17574.6.camel@offworld>  <20120612151819.GE23991@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jun 2012 21:26:57 +0200
Message-ID: <1339529217.3034.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-06-12 at 17:18 +0200, Karel Zak wrote:
> On Tue, Jun 12, 2012 at 02:57:16PM +0200, Davidlohr Bueso wrote:
> > On Tue, 2012-06-12 at 12:03 +0200, Karel Zak wrote:
> > >  * numbers (make -j)
> > > 
> > >              recursive | non-recursive
> > >              ----------+--------------
> > >     2 cores: 14.5 sec  | 13.2 sec
> > >    16 cores:  9.5 sec  |  4.3 sec
> > > 
> > >    (... more CPU cores means more fun;-)
> > 
> > Nice, are these real cores or HT?
> 
>  real cores, the machine with 16 cores was AMD from RH lab
> 
>  Unfortunately I have no such machine at home. Any HW sponsor around? :-))
> 
> > >        - rename fdisk/ to fdisks/
> > 
> > fdisk-utils?
> 
>  The ideal solution is to have libfdisk/ and then we can add small
>  fdisk.c, sfdisk.c and cfdisk.c files to disk-utils/. (See mount.c and
>  libmount/.)

well yes, that's where we're headed :)

> 
> 
