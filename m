Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab2ASXRX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Jan 2012 18:17:23 -0500
Date: Fri, 20 Jan 2012 00:17:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount (new): Using -a, exits with 64.
Message-ID: <20120119231721.GC6482@x2.net.home>
References: <4F188277.7090100@yahoo.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F188277.7090100@yahoo.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 19, 2012 at 05:52:07PM -0300, Gerardo Exequiel Pozzi wrote:
> Using new mount, when run with -a and some mounting is performed, mount
> retuns 64 instead of 0.

Ah.. I know that umount exit codes and error messages are not ready,
but I forgot to check mount -a, so thanks. I will add this to my TODO
list for -rc2.

> # mkdir /mnt/coco
> # echo "coco /mnt/coco tmpfs defaults 0 0" >> /etc/fstab
> # mount -a ; echo $?
> 64

Anyway, this seems correct, man mount:

    64     some mount succeeded

this used by mount -a.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
