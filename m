Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758867Ab2FUIo6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jun 2012 04:44:58 -0400
Date: Thu, 21 Jun 2012 10:44:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Cong Wang <amwang@redhat.com>
Cc: util-linux@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [Patch] lib/mangle.c: fix a memory leak in the test case
Message-ID: <20120621084456.GA17085@x2.net.home>
References: <1340181725-5382-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340181725-5382-1-git-send-email-amwang@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 20, 2012 at 04:42:05PM +0800, Cong Wang wrote:
> From: Cong Wang <xiyou.wangcong@gmail.com>
> 
> Marek reported there is a memory leak in lib/mangle.c
> 
>   CC       mangle.o
> mangle.c:160:9: warning: Memory is never released; potential leak of memory pointed to by 'ss'

 We usually ignore free-before-exit, but test programs are exception.
 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
