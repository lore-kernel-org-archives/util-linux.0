Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f178.google.com ([209.85.216.178]:41894 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaA2P3Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jan 2014 10:29:24 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so2977277qcx.9
        for <util-linux@vger.kernel.org>; Wed, 29 Jan 2014 07:29:24 -0800 (PST)
Date: Wed, 29 Jan 2014 10:29:21 -0500
From: Dave Reisner <d@falconindy.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
Message-ID: <20140129152921.GD905@rampage>
References: <52E91888.4080601@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E91888.4080601@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 29, 2014 at 10:04:40AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I could have sworn that the pivot_root syscall was considered a
> fragile dirty hack that needed to die in a fire, and everyone switched
> to run-init years ago.  Am I misremembering things or does anyone know
> what I'm talking about?

pivot_root is still useful. It's used by systemd on shutdown to allow
the system to return to an initramfs where the root filesystem can be
unmounted and disassembled (e.g. close crypto mappings). Both dracut and
mkinitcpio provide support for this.

I'm not familiar with run-init but, glancing at the code, it looks like
it does the same job of util-linux's switch_root.

d
