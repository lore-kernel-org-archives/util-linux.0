Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbaHHI01 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Aug 2014 04:26:27 -0400
Date: Fri, 8 Aug 2014 10:26:22 +0200
From: Karel Zak <kzak@redhat.com>
To: "Linda A. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Generic, per-fs and per-dev defaults in fstab?
Message-ID: <20140808082622.GB17719@x2.net.home>
References: <53E2B34F.6080601@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E2B34F.6080601@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 06, 2014 at 03:59:27PM -0700, Linda A. Walsh wrote:
> Split this off from previous note (different subject, though
> forgot to change previous subject line fully! *arg*).
> 
> 
> As another matter of being user friendly, why can't specify a defaults
> line for all mounts with the option of per-type defaults taking precedence:
> 
> default   *     defaults     defaults,x-'"mostly for completeness"'
> default   xfs   defaults     logbsize=256k,largeio,nodiratime
> /dev/sdf  xfs   defaults     su=64k,sw=256k
> ...
> -------------
> 
> fs-type specific mounts would be applied after global
> defaults, and in the 3rd line, what I am trying

Well, the problem is that fstab is de-facto standard. If you want to
change semantic than you have to fix all programs that follow fstab
setting. The file is no private mount(8) config file.

The old idea is to use per-filesystem config files where you can
specify default mount options. We use this concept for NFS. But again,
such setting is invisible for many utils etc.

IMHO the best is the extN way. It means to store the default setting to 
filesystem superblock, see 

 # tune2fs -l /dev/sda4 | grep 'Default mount options'
 Default mount options:    user_xattr acl

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
