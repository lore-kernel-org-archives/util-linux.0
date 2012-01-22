Return-Path: util-linux-owner@vger.kernel.org
Received: from nm25.bullet.mail.sp2.yahoo.com ([98.139.91.95]:31007 "HELO
	nm25.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750848Ab2AVBhW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 21 Jan 2012 20:37:22 -0500
Message-ID: <4F1B684E.9030501@yahoo.com.ar>
Date: Sat, 21 Jan 2012 22:37:18 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: fdisk: off-by-one issue in (n)new command
References: <4F0E167A.9090205@yahoo.com.ar> <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com> <4F149CA0.6040100@yahoo.com.ar> <4F14A512.2030904@yahoo.com.ar> <20120117100756.GA12310@x2.net.home> <4F158BD6.1020006@yahoo.com.ar> <CAMFXF52Crx7NSWWNSxgw-4FAyhQp7P5y50n7YBmRB+8PCvQwpg@mail.gmail.com>
In-Reply-To: <CAMFXF52Crx7NSWWNSxgw-4FAyhQp7P5y50n7YBmRB+8PCvQwpg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/20/2012 11:21 AM, Francesco Cosoleto wrote:
> I wonder whether this is a preferred behavior:
>
> Partition number (1-4, default 1): 5
> Value 5 out of range, used 4.
> First sector (2048-16383, default 2048): 1024
> Value 1024 out of range, used 2048.
> Last sector, +sectors or +size{K,M,G} (2048-16383, default 16383): +8M
> Value 18432 out of range, used 16383.
> Partition 4 of type Linux and of size 7 MiB is set
>
> Francesco
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Sounds good for me.

-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

