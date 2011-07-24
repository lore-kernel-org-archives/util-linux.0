Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:52970 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1GXT5Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 24 Jul 2011 15:57:16 -0400
Date: Sun, 24 Jul 2011 15:57:13 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Daniel Drake <dsd@laptop.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Can't remount loopback ext4 without /etc/mtab
Message-ID: <20110724195713.GH3469@thunk.org>
References: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 24, 2011 at 07:09:47PM +0100, Daniel Drake wrote:
> 
> When the error occurs, dmesg says:
> [ 5495.860391] EXT4-fs (loop0): Unrecognized mount option "seclabel"
> or missing value
> 
> Here is the corresponding entry from /proc/mounts:
> /dev/loop0 /home/dsd/tmpdisk/mountpt ext4
> rw,seclabel,relatime,barrier=1,data=ordered 0 0
> 
> Is this a util-linux bug? Or an ext4 issue?

Or a selinux thing; "seclabel" seems to be SELinux's fault:

% git grep LABELSUPP_STR
security/selinux/hooks.c:       {Opt_labelsupport, LABELSUPP_STR},
security/selinux/hooks.c:                       seq_puts(m, LABELSUPP_STR);
security/selinux/hooks.c:               match_prefix(LABELSUPP_STR, sizeof(LABEL
security/selinux/include/security.h:#define LABELSUPP_STR "seclabel"

Personally, I find my life has been much happier since I gave up on
SELinux as being too complicated to be secure.

						- Ted
