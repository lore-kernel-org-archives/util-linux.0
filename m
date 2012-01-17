Return-Path: util-linux-owner@vger.kernel.org
Received: from nm9-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.196]:20153 "HELO
	nm9-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754395Ab2AQOzW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jan 2012 09:55:22 -0500
Message-ID: <4F158BD6.1020006@yahoo.com.ar>
Date: Tue, 17 Jan 2012 11:55:18 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: fdisk: off-by-one issue in (n)new command
References: <4F0E167A.9090205@yahoo.com.ar> <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com> <4F149CA0.6040100@yahoo.com.ar> <4F14A512.2030904@yahoo.com.ar> <20120117100756.GA12310@x2.net.home>
In-Reply-To: <20120117100756.GA12310@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/17/2012 07:07 AM, Karel Zak wrote:
> On Mon, Jan 16, 2012 at 07:30:42PM -0300, Gerardo Exequiel Pozzi wrote:
>> Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): +255M
>> Value out of range.
>   The size of the device is 268435456 bytes,
>
>   +255M is relative to the begin of the partition, it means
>
>      (2048 * 512) + (255 * 1024 * 1024) = 268435456 bytes
Right.
>
>   but the begin of the last sector (in bytes) is
>
>      268435456 - 512 = 268434944 bytes (LBA sector 524287)
>
>   Right?
Right.

 From [2048, 524287] (all inclusive), so

(524287 - 2048 + 1) * 512 = 522240  and 522240 * 512 / 2**20 = 255

Indeed, when you say, for example, these sizes: p1 = +55M, p2 = +100M, 
and now try to set +100M to p3, is not posible, so accept the default 
value, and you can see that the size is equal to p2, that is right.
So the issue appears when last sector is specified in +sectors or 
+size(K|M|G), only


-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

