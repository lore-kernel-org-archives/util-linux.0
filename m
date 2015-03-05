Return-Path: sergey.senozhatsky@gmail.com
Date: Thu, 5 Mar 2015 21:03:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Timofey Titovets <nefelim4ag@gmail.com>, Karel Zak <kzak@redhat.com>,
        Sami Kerola <kerolasa@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jerome Marchand <jmarchan@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] make automatic device_id generation possible
Message-ID: <20150305120351.GB623@swordfish>
References: <1425478601-19141-1-git-send-email-sergey.senozhatsky@gmail.com>
 <20150305001954.GA9563@blaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150305001954.GA9563@blaptop>
List-ID: <util-linux.vger.kernel.org>

Cc Sami Kerola, Timofey Titovets, Karel Zak, util-linux
(don't have Jóhann B. Guðmundsson's email). also published on google+.

On (03/05/15 09:20), Minchan Kim wrote:
> > Make zram-contol/zram_add interface easier to use. Extend it to support
> > read and write operations.
> > 
> > Write operation remains the same:
> > 
> > 	echo X > /sys/class/zram-control/zram_add
> > 
> > will add /dev/zramX (or return error).
> > 
> > 
> > Read operation is treated as 'pick up available device_id, add new
> > device and return device_id'.
> > 
> > Example:
> > 	 cat /sys/class/zram-control/zram_add
> > 	2
> > 	 cat /sys/class/zram-control/zram_add
> > 	3
> 
> Thanks for handling my concern quickly and sorry for not sending
> active feedback in realtime. Maybe I should turn on CONFIG_PREEMPT
> in my brain.
> 
> I'm not against but I want to know why we should support
> user-defined device id. What usecase do you have in mind?
> 
> Could we support automatic id support only at this moment?
> Then, if some user complains about that in future, we could turn
> on user-defined device id easily and we could know the usecase.
> 
> In summary, I want to support only "cat /sys/class/zram-control/zram_add"
> unless you have feasible usecase.
> 
> What do you think about it?

Hello guys,

call for opinions.

we currently discuss on-demand device creation/removal (you can find
mail thread here https://lkml.org/lkml/2015/3/4/1414) and we want to hear
some opinions.

to add a new device, zram implements two modes (schematically):

-- forced mode

which is "add device /dev/zram<id>".
user must provide new device id. here we expect user to ensure that devide_id
uniqueness and to handle errors if it's not. (zram will return -EEXIST if
device_id is already in use).

I can think of... a build server with tons of users and /dev/zram$(id -u)
devices being created for every user during login (and destroyed during
logout). so users don't pressure hdd, they have zram devices to play with,
these devices have predictable names, which also makes admin's life a bit
easier -- he can find out device user by simply checking its name (to
remove abandoned devices, for example. anyway). there might be other more
or less real life use-cases.

usage example:
        echo `id -u` > /sys/class/zram-control/zram_add


-- automatic mode

which is 
"pick device_id automatically, add device /dev/zram<id>,
and return <id> back to user".

usage example:
        cat /sys/class/zram-control/zram_add
        7
        cat /sys/class/zram-control/zram_add
        8


we tend to ditch `forced' mode and leave `automatic' mode only. before we
do that we'd like to see how many guys will be pissed off and... basically,
if 'forced' mode is of any actual use.


so the question is: should there be two modes or one is just enough?

	-ss
