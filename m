Return-Path: util-linux-owner@vger.kernel.org
Received: from sender153-mail.zoho.com ([74.201.84.153]:22147 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbK0RTZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Nov 2015 12:19:25 -0500
Message-ID: <56589098.1080209@zoho.com>
Date: Fri, 27 Nov 2015 18:19:20 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Evgenii Sovetkin <e.sovetkin@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: bug in the cal
References: <20151127142227.GA28400@bigbear.stochastik.rwth-aachen.de>
In-Reply-To: <20151127142227.GA28400@bigbear.stochastik.rwth-aachen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27/11/15 15:22, Evgenii Sovetkin wrote:
> Hello everyone,
>
> just noticed a funny behaviour of the cal program...
>
> % cal -n2
> Produces calendar for November and December.
>
> % cal -n3
> Produces calendar for October, November and December.
>
> % cal -n4
> Produces calendar for November, December, January and February.
>
> I don't think it is the expected output. The version of cal is from
> util-linux 2.27.

Thanks for your report, Evgenii.

The man page says:
>        -n , --months number
>               Display number of months, starting from the month containing the date.

So the problem is that
 > cal -n 3
 > cal --months 3

is acting as
 > cal -3


Maybe the command line parser is getting a bit confused.

