Return-Path: bensberg@justemail.net
Message-Id: <1406573448.201539.146573889.3D4D553B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140728111214.GI8533@x2.net.home>
References: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
 <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
 <1406390709.8686.145937949.0F0BF57C@webmail.messagingengine.com>
 <20140728111214.GI8533@x2.net.home>
Subject: Re: hwclock --compare segfaults when run as normal user
Date: Mon, 28 Jul 2014 20:50:48 +0200
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 28, 2014, at 13:12, Karel Zak wrote:
>  I have no way how to to test it, but can you try the patch below?
> [...]
>  
> +	if (ur->get_permissions())
> +		return EX_NOPERM;
> +

Yes, looks better now:

$ ./hwclock --compare
hwclock: unable to get I/O port access:  the iopl(3) call failed.: Operation not permitted
hwclock: Probably you need root privileges.

Benno

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free
