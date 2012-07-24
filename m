Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:51435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2GXKc3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Jul 2012 06:32:29 -0400
Message-ID: <500E79B9.9030701@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 12:32:25 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: dave@gnu.org, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
References: <1342976704.2863.13.camel@offbook> <500E6F49.60406@bernhard-voelker.de> <20120724095617.GD2086@foxbat.suse.cz>
In-Reply-To: <20120724095617.GD2086@foxbat.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/24/2012 11:56 AM, Petr Uzel wrote:
> On Tue, Jul 24, 2012 at 11:47:53AM +0200, Bernhard Voelker wrote:
>>
>>
>> On 07/22/2012 07:05 PM, Davidlohr Bueso wrote:
>>> --- a/fdisks/fdisksunlabel.c
>>> +++ b/fdisks/fdisksunlabel.c
>>> @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
>>>  
>>>  	init();
>>>  	fdisk_mbr_zeroize(cxt);
>>> +	fdisk_label_change(cxt, "sun");
>>>  
>>

>>
>> Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
>> strings here? 
> 
> What's the problem with these strings? I think these are well
> recognized with clear meaning. What alternative do you propose?

Sorry, I should've proposed this already in my first mail:

-	fdisk_label_change(cxt, "sun");
+	fdisk_label_change(cxt, sun_label.name);

It's already defined ;-)

Have a nice day,
Berny

