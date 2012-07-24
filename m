Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:65137 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab2GXKrs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Jul 2012 06:47:48 -0400
Message-ID: <500E7D51.8070402@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 12:47:45 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Davidlohr Bueso <dave@gnu.org>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
References: <1342976704.2863.13.camel@offbook> <500E6F49.60406@bernhard-voelker.de> <20120724095617.GD2086@foxbat.suse.cz> <500E79B9.9030701@bernhard-voelker.de> <1343126347.2686.4.camel@offbook> <20120724104249.GF2086@foxbat.suse.cz>
In-Reply-To: <20120724104249.GF2086@foxbat.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/24/2012 12:42 PM, Petr Uzel wrote:
> On Tue, Jul 24, 2012 at 12:39:07PM +0200, Davidlohr Bueso wrote:
>>>>> Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
>>>>> strings here? 
>>>>
>>>> What's the problem with these strings? I think these are well
>>>> recognized with clear meaning. What alternative do you propose?
>>>
>>> Sorry, I should've proposed this already in my first mail:
>>>
>>> -	fdisk_label_change(cxt, "sun");
>>> +	fdisk_label_change(cxt, sun_label.name);
>  
> Ah, right. Deduplicating the strings makes sense, IMO.
> 
>> I'm planning on adding the disklabel type (numeric) to the context
>> structure in a near future, so we'd then have two ways of identifying
>> labels. I really do not see much difference between numbers and strings
>> - this is not a performance critical program.
> 
> The concern here is not speed, but maintainability ;)

Right ... and to save a bit size of the binary (well, not too much
in this case) ;-)

Have a nice day,
Berny
