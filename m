Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Fri, 19 Dec 2014 09:26:55 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/10] ipcs: fix two data type errors
 [AddressSanitizer]
In-Reply-To: <20141208122102.GF19904@x2.net.home>
Message-ID: <alpine.LNX.2.03.1412190924490.8955@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-11-git-send-email-kerolasa@iki.fi> <20141208122102.GF19904@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Mon, 8 Dec 2014, Karel Zak wrote:

> ipc_shm_get_limits() is also broken
>
> The function shmctl() has to be always called with "struct shmid_ds"
> and then cast to linux specific shmid_info struct.
>
> It would be nice to check that all the shm/sem/msgctl functions are
> really called with proper arguments.
>
> (Or we can define any union and use it as buffer to make sure that
>  the argument is large enough.)

How about doing further corrections later?

> BTW, horrible API (or I need more coffee to understand this art).

Mostly because of I share the view above. Getting ipc api usage right is 
not quite as easy task as one might hope.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
