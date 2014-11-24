Return-Path: util-linux-owner@vger.kernel.org
Received: from app1b.xlhost.de ([84.200.252.162]:34865 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbaKXUEE convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 15:04:04 -0500
Message-ID: <54738F2D.8000909@5t9.de>
Date: Mon, 24 Nov 2014 21:03:57 +0100
From: Lutz Vieweg <lvml@5t9.de>
MIME-Version: 1.0
To: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org
CC: util-linux@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org> <m4nrjt$ghs$1@ger.gmane.org> <alpine.LFD.2.00.1411241259280.10657@localhost.localdomain> <5473873E.1070101@5t9.de> <54738A6A.40906@fastmail.fm>
In-Reply-To: <54738A6A.40906@fastmail.fm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/24/2014 08:43 PM, Bernd Schubert wrote:
>> Then there's another idea: The device is a SATA SSD, but attached
>> to a SAS2 expander chip on the backplane of the server (LSI SAS2X28)
>> which in turn is connected to a LSI SAS HBA 9207-4i4e.
>> could maybe, just maybe, the TRIM command be modified wrongly
>> on its way through these / their respective drivers?
>
> Yeah, it is a known issue with LSI firmware.
>
> http://osdir.com/ml/dm-devel/2013-09/msg00126.html

I must admit that I have difficulties understanding what this
email thread is ultimately telling: Does it mean LSI firmware
actually tampers with TRIM commands such that they would discard
other ranges than those intended? (In which case using TRIM
over any such LSI device would be very dangerous.)
Or does is mean the capabilities of some SSDs to discard data
are mis-reported? And if so, in the sense that the kernel might
not be able to discard data at all, or in the sense that data
is discarded, but the kernel sends additional commands that the
device cannot understand?

After all, if it's just an annoying error message that I can
ignore, I wouldn't mind. But if TRIM via LSI means "data loss",
I would of course have to take measures against this...

Regards,

Lutz Vieweg



