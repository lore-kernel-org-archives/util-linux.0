Return-Path: util-linux-owner@vger.kernel.org
Received: from drutsystem.com ([80.72.38.138]:3482 "EHLO drutsystem.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaBCKxE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Feb 2014 05:53:04 -0500
Message-ID: <52EF6FEC.4000207@ziu.info>
Date: Mon, 03 Feb 2014 11:31:08 +0100
From: Michal Soltys <soltys@ziu.info>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org,
        =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        Karel Zak <kzak@redhat.com>
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home> <52EA5E6F.6040203@ubuntu.com> <52EA66CC.9070107@archlinux.org> <52EA6DBA.6000903@ubuntu.com>
In-Reply-To: <52EA6DBA.6000903@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-01-30 16:20, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 1/30/2014 9:50 AM, Thomas Bächler wrote:
>> At least mkinitcpio now generates a fresh "initrd" to return to
>> during system shutdown instead of keeping around the actual
>> initrd.
>
> I see, so at shutdown the initramfs is re-loaded into a tmpfs that is
> then pivot_root()ed to?  And at boot time, pivot_root is not used?
>

Initially when initramfs prepares /run and stuff (and switchroot moves 
it to real root), workable "minisystem" is kept under /run/initramfs (or 
similar).

On shutdown, /run/initramfs is bind-mounted to itself, which makes it 
pivotable, with old root say available at /oldroot. Now your aim is to 
cleanly unmount old root. In case of classic non-systemd, you would need:

- telinit u (graceful re-exec of init)
- mdmon --takeover (if you have non-native raid handled by md, to 
gracefully reexec the daemon)
- etc.

This allows to close all open files on real root (things are usually 
tried in loop, with attempts to stop stuff like lvm, md, ...) and 
finally unmount old root.

Of course there is also a question - why bother doing all this, when 
simple ro remount before halt has been working fine for decades (and 
still works) ....

Dracut (and others) /could/ be doing even more clever thing (hmm, maybe 
I should review certain old patches of mine) - during boot it could 
prepare mini-root on tmpfs before (some copying, some symlinks and/or 
PATH stuff) starting everything - then move actual tmpfs with living 
root to real root. The small advantage of that is, that you can at any 
moment chroot to such miniroot and do some maintenance on e.g. 
boot-critical storage daemon that lacks ability to reexecute itself 
gracefully.

Another interesting use for pivot_root() call - when paired with mount 
namespaces - is ability to provide stronger chroot jails.

So the call itself is still pretty useful. It hasn't beed used during 
boot anymore for years, but other possibilities emerged for it =)

