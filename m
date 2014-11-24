Return-Path: linux-fsdevel-owner@vger.kernel.org
Message-ID: <54738A6A.40906@fastmail.fm>
Date: Mon, 24 Nov 2014 20:43:38 +0100
From: Bernd Schubert <bernd.schubert@fastmail.fm>
MIME-Version: 1.0
To: Lutz Vieweg <lvml@5t9.de>, linux-fsdevel@vger.kernel.org
CC: util-linux@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org> <m4nrjt$ghs$1@ger.gmane.org> <alpine.LFD.2.00.1411241259280.10657@localhost.localdomain> <5473873E.1070101@5t9.de>
In-Reply-To: <5473873E.1070101@5t9.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> Then there's another idea: The device is a SATA SSD, but attached
> to a SAS2 expander chip on the backplane of the server (LSI SAS2X28)
> which in turn is connected to a LSI SAS HBA 9207-4i4e.
> could maybe, just maybe, the TRIM command be modified wrongly
> on its way through these / their respective drivers?
> 

Yeah, it is a known issue with LSI firmware.

http://osdir.com/ml/dm-devel/2013-09/msg00126.html

Last time I checked (FWv19?) it was still not fixed.


Cheers,
Bernd
