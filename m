Return-Path: util-linux-owner@vger.kernel.org
Received: from nm24.bullet.mail.sp2.yahoo.com ([98.139.91.94]:25809 "HELO
	nm24.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756885Ab2APVyp (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jan 2012 16:54:45 -0500
Message-ID: <4F149CA0.6040100@yahoo.com.ar>
Date: Mon, 16 Jan 2012 18:54:40 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: fdisk: off-by-one issue in (n)new command
References: <4F0E167A.9090205@yahoo.com.ar> <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com>
In-Reply-To: <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/16/2012 06:38 PM, Francesco Cosoleto wrote:
> 2012/1/12 Gerardo Exequiel Pozzi<vmlinuz386@yahoo.com.ar>:
>> I think I found two related bugs, steps to reproduce will be more clear than
>> a description:
>> It is present in stable 2.20.1 and using latest git snapshot, and using any
>> device/file as disk, using here a loop dev with a backing file of 256MiB
>> just for example.
> Fixed. Thank you for the report.
>
> http://git.kernel.org/?p=utils/util-linux/util-linux.git;a=commit;h=0c381880282b9365aaf9e8457c69750c12c4d9b2
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Thank you!

I will test it in few hours ;)

-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

