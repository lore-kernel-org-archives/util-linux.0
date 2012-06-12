Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2FLPSY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 11:18:24 -0400
Date: Tue, 12 Jun 2012 17:18:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: non-recursive build system
Message-ID: <20120612151819.GE23991@x2.net.home>
References: <20120612100340.GB23991@x2.net.home>
 <1339505836.17574.6.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339505836.17574.6.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2012 at 02:57:16PM +0200, Davidlohr Bueso wrote:
> On Tue, 2012-06-12 at 12:03 +0200, Karel Zak wrote:
> >  * numbers (make -j)
> > 
> >              recursive | non-recursive
> >              ----------+--------------
> >     2 cores: 14.5 sec  | 13.2 sec
> >    16 cores:  9.5 sec  |  4.3 sec
> > 
> >    (... more CPU cores means more fun;-)
> 
> Nice, are these real cores or HT?

 real cores, the machine with 16 cores was AMD from RH lab

 Unfortunately I have no such machine at home. Any HW sponsor around? :-))

> >        - rename fdisk/ to fdisks/
> 
> fdisk-utils?

 The ideal solution is to have libfdisk/ and then we can add small
 fdisk.c, sfdisk.c and cfdisk.c files to disk-utils/. (See mount.c and
 libmount/.)


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
