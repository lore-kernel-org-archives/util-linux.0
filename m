Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbaIPJS1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Sep 2014 05:18:27 -0400
Date: Tue, 16 Sep 2014 11:18:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Boris Egorov <egorov@linux.com>
Cc: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: fix cppcheck warnings
Message-ID: <20140916091817.GF7867@x2.net.home>
References: <20140914115745.GA20978@fatal.se>
 <1410798797-23769-1-git-send-email-egorov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410798797-23769-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 15, 2014 at 11:33:17PM +0700, Boris Egorov wrote:
>  sys-utils/lscpu-dmi.c | 2 +-
>  sys-utils/lscpu.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

 Good catch, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
