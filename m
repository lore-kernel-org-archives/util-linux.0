Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:60585 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752042Ab2DPKOB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 06:14:01 -0400
Subject: RE: [PATCH 5/8] sfdisk: fix silly mbyte typo
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C0D@MCHP058A.global-ad.net>
References: <1334569484.2552.14.camel@offbook>
	 <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C0D@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 12:13:57 +0200
Message-ID: <1334571237.2552.18.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-04-16 at 11:53 +0200, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> 
> > Subject: [PATCH 5/8] sfdisk: fix silly mbyte typo
> > 
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > 
> > ---
> >  fdisk/sfdisk.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> > index 8bd27da..f81a7fa 100644
> > --- a/fdisk/sfdisk.c
> > +++ b/fdisk/sfdisk.c
> > @@ -930,7 +930,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
> >  	printf(_("   Device Boot   Start       End    #blocks   Id  System\n"));
> >  	break;
> >      case F_MEGABYTE:
> > -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> > +	printf(_("Units = megabytes of 1048576 bytes, blocks of 1024 bytes"
> >  		 ", counting from %d\n\n"), increment);
> >  	printf(_("   Device Boot Start   End    MiB    #blocks   Id  System\n"));
> >  	break;
> > -- 
> > 1.7.4.1
> 
> not silly:
> http://en.wikipedia.org/wiki/Mebibyte

hehe, silly me then.

> 
> Have a nice day,
> Berny
> 


