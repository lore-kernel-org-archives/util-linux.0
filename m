Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63716 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaJGMNY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 08:13:24 -0400
Message-ID: <5433D8DD.3090505@gmx.com>
Date: Tue, 07 Oct 2014 08:13:17 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?No=E9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing
 clock
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com> <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
In-Reply-To: <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/07/2014 07:52 AM, Noé RUBINSTEIN wrote:
> Hi,
> 
>> I just submitted a patch on 14-09-27 that adds this functionality
>> without creating a new state file.
> 
> Nice! I guess this is the patchset:
> <http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/9918>
> 
> However I am not sure how those patches adds the functionality I am
> looking for. Can you explain how you would use hwclock to get and set
> the time without a write access to the hardware clock?

Sure, hwclock already has the ability to track the offset between the 
Hardware Clock and the System Clock(which presumably is the 'correct' time).
With my patch, hctosys will include the offset when setting the System 
Clock. Which is the functionality you want, right?





> 
> Regards,
> NoÃ©.
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
