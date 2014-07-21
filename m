Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23948 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbaGUIKM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 04:10:12 -0400
Date: Mon, 21 Jul 2014 10:10:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Davidlohr Bueso <davidlohr@hp.com>,
        Timofey Titovets <nefelim4ag@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [RFC] Zram handle util
Message-ID: <20140721081003.GC17373@x2.net.home>
References: <53CAAAB6.6020607@gmail.com>
 <1405888608.11927.11.camel@buesod1.americas.hpqcorp.net>
 <20140721075721.GC8180@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140721075721.GC8180@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 21, 2014 at 07:57:21AM +0000, Minchan Kim wrote:
> First of all, Thanks for your effor, Timofey!
> 
> Adding such userspace tool in kernel src directory doesn't make sense.
> If we wanted it, there are tons of user tools in kernel src directory
> so IMHO, util-linux is better place.

 I don't think that regular (non-debugging, non-development) userspace utils 
 belong to the kernel tree...

 Please, see the howtos recommended by Sami and send a patch(es) with
 the code and a man page. It (util-linux specific details) does not
 have to be perfect, the important is to have correctly implemented
 zram specific things.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
