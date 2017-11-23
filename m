Return-Path: yamato@redhat.com
Date: Fri, 24 Nov 2017 02:01:28 +0900 (JST)
Message-Id: <20171124.020128.28825211426388397.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20171122090613.ltcuaehwbum7apes@ws.net.home>
	<20171121111641.dt3vodjsuwwnna6g@ws.net.home>
References: <20171121111641.dt3vodjsuwwnna6g@ws.net.home>
	<20171121.203633.949035400852899096.yamato@redhat.com>
	<20171122090613.ltcuaehwbum7apes@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

Hi,

> I do not have any changes yet ;-) So, you can start, or if you're busy
> with something else I can do that.

It works:

# ./lsns --type=net
        NS TYPE NPROCS   PID USER     NETNSID NSFS           COMMAND
4026531993 net     405     1 root  unassigned                /usr/lib/systemd/systemd --switched-root --system --deserialize 25
4026532433 net       1  1515 rtkit unassigned                /usr/libexec/rtkit-daemon
4026532579 net       1 10432 root  unassigned /run/netns/QWE bash
                                              /tmp/RTY

> This feature should be probably disabled for --raw, maybe add --nowrap
> and in this case use "," as separator and remove SCOLS_FL_WRAP for the
> column in init_scols_table().

It seems that nsfs is still not so popular.
So I think enabling the column only when --type net is given, as
you suggested about netnsid.

I would like to make clarify what you meant.

If both --raw and -o NSFS are given, what I should do?
Hidden NSFS anyway? or Use ',' as separator instead of '\n'?

Masatake YAMATO
