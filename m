Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbcCaJyf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Mar 2016 05:54:35 -0400
Date: Thu, 31 Mar 2016 11:54:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix possible NULL dereference in get_btrfs_fs_root()
Message-ID: <20160331095433.kt6skftq5agqrxje@ws.net.home>
References: <56FC3BE7.7040001@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56FC3BE7.7040001@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 30, 2016 at 10:49:43PM +0200, Stanislav Brabec wrote:
> set_fs_root() got it as upd->mountinfo being NULL from utab_new_entry(). That
> got it from mnt_update_set_fs(), that from mnt_context_prepare_update() (where
> it is cxt->update->mountinfo).
> 
> At least the constructor mnt_new_update() can create context with cxt->update
> being not NULL and cxt->update->mountinfo being NULL.
> 
> It is also possible to pass to mnt_context_prepare_update() with cxt->update not
> being NULL but cxt->update->mountinfo being NULL created by mnt_new_context(),
> e. g. from mnt_context_mount().

It's seems better to read mountinfo when really necessary than always.
I have applied something else:

https://github.com/karelzak/util-linux/commit/e9cd2e2bd9ec91a0b1050c4aa79555d142985924

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
