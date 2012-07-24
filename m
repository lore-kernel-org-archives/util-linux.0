Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:41435 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751847Ab2GXKjL (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 06:39:11 -0400
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <500E79B9.9030701@bernhard-voelker.de>
References: <1342976704.2863.13.camel@offbook>
	 <500E6F49.60406@bernhard-voelker.de> <20120724095617.GD2086@foxbat.suse.cz>
	 <500E79B9.9030701@bernhard-voelker.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 12:39:07 +0200
Message-ID: <1343126347.2686.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-24 at 12:32 +0200, Bernhard Voelker wrote:
> 
> On 07/24/2012 11:56 AM, Petr Uzel wrote:
> > On Tue, Jul 24, 2012 at 11:47:53AM +0200, Bernhard Voelker wrote:
> >>
> >>
> >> On 07/22/2012 07:05 PM, Davidlohr Bueso wrote:
> >>> --- a/fdisks/fdisksunlabel.c
> >>> +++ b/fdisks/fdisksunlabel.c
> >>> @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
> >>>  
> >>>  	init();
> >>>  	fdisk_mbr_zeroize(cxt);
> >>> +	fdisk_label_change(cxt, "sun");
> >>>  
> >>
> 
> >>
> >> Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
> >> strings here? 
> > 
> > What's the problem with these strings? I think these are well
> > recognized with clear meaning. What alternative do you propose?
> 
> Sorry, I should've proposed this already in my first mail:
> 
> -	fdisk_label_change(cxt, "sun");
> +	fdisk_label_change(cxt, sun_label.name);
> 

I'm planning on adding the disklabel type (numeric) to the context
structure in a near future, so we'd then have two ways of identifying
labels. I really do not see much difference between numbers and strings
- this is not a performance critical program.

Thanks,
Davidlohr

> It's already defined ;-)
> 
> Have a nice day,
> Berny
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


