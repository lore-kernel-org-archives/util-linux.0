Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbcDRLQa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 07:16:30 -0400
Date: Mon, 18 Apr 2016 13:16:28 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m and mount propagation
Message-ID: <20160418111628.cj5bscuuxee2xfcg@ws.net.home>
References: <m3oaacfrn2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3oaacfrn2.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 18, 2016 at 05:26:25AM +0300, Yuriy M. Kaminskiy wrote:
> I think this issue should be at least documented. And, maybe, default
> `--propagation` should be changed to `slave`.

The reason why we use 'private' is that it's the kernel default for
years and it's what has been expected by users for long time before we
introduced --propagation and any unshare(1) default.

The current --propagation default unifies things and makes unshare(1) 
portable to distributions where root fs is mounted as 'shared' (e.g. 
systemd distros) and all this in backwardly compatible way for users
who have no clue about --propagation.

So, I don't think we want to change any default to corrupt scripts where
is no explicitly specified --propagation. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
