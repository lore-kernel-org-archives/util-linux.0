Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953AbbJIK4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Oct 2015 06:56:17 -0400
Date: Fri, 9 Oct 2015 12:56:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] partx: introduce INIT_BLGPG macro
Message-ID: <20151009105615.GB2356@ws.net.home>
References: <1444153856-14210-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444153856-14210-1-git-send-email-kuleshovmail@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 06, 2015 at 11:50:56PM +0600, Alexander Kuleshov wrote:
> The disk-utils/partx.h provides three functions:
> partx_{del,add,resize}_partition() that contain almost the same code
> - initialization of the blkpg_partition and blkpg_ioctl_arg structs.

Good point,

> Let's provide INIT_PKG macro that will do all work to prevent code
> duplication.

but I don't like the implementation :-)

> +#define INIT_BLKPG(ioctl_arg, action, partno, start, size) do {	\
> +	struct blkpg_partition p;		\

It's bad manner to hide any struct declaration within a macro if you
expect a valid reference to the struct outside the macro scope. My
solution (already in git tree):

#define INIT_BLKPG_PARTITION(_partno, _start, _size) {	\
		.pno    = (_partno),			\
		.start  = (_start) << 9,		\
		.length = (_size) << 9,			\
		.devname[0] = 0,			\
		.volname[0] = 0				\
}

#define INIT_BLKPG_ARG(_action, _part) {		\
		.op      = (_action),			\
		.flags   = 0,				\
		.datalen = sizeof(*(_part)),		\
		.data = (_part)				\
}


static inline int partx_add_partition(int fd, int partno,
			uint64_t start, uint64_t size)
{
	struct blkpg_partition p = INIT_BLKPG_PARTITION(partno, start, size);
	struct blkpg_ioctl_arg a = INIT_BLKPG_ARG(BLKPG_ADD_PARTITION, &p);

	return ioctl(fd, BLKPG, &a);
}


IMHO it's more readable and it does not hide struct blkpg_partition.


Hmm.. .devname[0] = 0 and .volname[0] = 0 initialization is unnecessary,
unspecified struct members should be automatically zeroized.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
