Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab2ISKGl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Sep 2012 06:06:41 -0400
Date: Wed, 19 Sep 2012 12:06:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Amit <amit.uttam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Return status of mnt_context_mount when helper is used
Message-ID: <20120919100638.GC9602@x2.net.home>
References: <loom.20120919T005618-428@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120919T005618-428@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 18, 2012 at 11:08:16PM +0000, Amit wrote:
> Hello,
> 
> When trying to mount samba shares using *mnt_context_mount*, the
> *mount.cifs* helper is called and used. This allows for automatic
> resolving of hostnames.
> 
> However, if the hostname is not valid and the resolve fails,
> the call *mnt_context_mount* is still successful. Using
> *mnt_init_debug*, the mount.cifs helper returns an error code but this
> is not propagated to the status of mnt_context_mount or
> mnt_context_get_status.

docs:

 * mnt_context_get_status:
 * @cxt: mount context
 *
 * Global libmount status.
 *
 * The real exit code of the mount.type helper has to be tested
 * by  mnt_context_get_helper_status(). The mnt_context_get_status()
 * only inform that exec() has been successful.

> This has been tried with util-linux 2.20.1 and the latest util-linux
> from git (as of today).
> 
> Is there a way to check the return status of the helper?
> 
> START TRACE
> 
> mount error: could not resolve address for pmanalo-pc2: Unknown error
> libmount:      CXT: [0x811010]: /sbin/mount.cifs executed [status=1]
> libmount:      CXT: [0x811010]: don't update: external helper
> mount_cifs: mnt_context_mount return code = 0 status = 1
> mount_cifs: error:
> libmount:      CXT: [0x811010]: <---- reset [status=1] ---->
> libmount:    CACHE: [0x811350]: free
> libmount:      CXT: [0x811010]: <---- free


 See sys-utils/mount.c: mk_exit_code()

   if (mnt_context_helper_executed(cxt))
      mnt_context_get_helper_status(cxt);

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
