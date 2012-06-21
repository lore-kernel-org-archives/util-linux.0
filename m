Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758876Ab2FUInS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jun 2012 04:43:18 -0400
Date: Thu, 21 Jun 2012 10:43:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Cong Wang <amwang@redhat.com>
Cc: util-linux@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [Patch] lib/sysfs.c: check if cxt->dir_path is NULL in
 sysfs_readlink()
Message-ID: <20120621084315.GA16949@x2.net.home>
References: <1340181120-3457-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340181120-3457-1-git-send-email-amwang@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 20, 2012 at 04:32:00PM +0800, Cong Wang wrote:
> cxt->dir_path could be NULL, for example, when sysfs_init() fails,
> check this before calling readlink()/readlink_at().

 Applied, thanks.

 I have also added warn_unused_result attribute to sysfs_init() to
 make sure that cxt is everywhere initialized.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
