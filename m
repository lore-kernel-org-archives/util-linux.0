Return-Path: wkevils@gmail.com
MIME-Version: 1.0
In-Reply-To: <52EF6FEC.4000207@ziu.info>
References: <52E91888.4080601@ubuntu.com>
	<20140130081651.GE22884@x2.net.home>
	<52EA5E6F.6040203@ubuntu.com>
	<52EA66CC.9070107@archlinux.org>
	<52EA6DBA.6000903@ubuntu.com>
	<52EF6FEC.4000207@ziu.info>
Date: Mon, 3 Feb 2014 13:10:20 +0200
Message-ID: <CAGXs5wXsiwYnK89x=z2Zw_y5WpN00O1b=Nrv7UEnibLF-6i-WQ@mail.gmail.com>
Subject: Re: pivot_root depreciated?
From: Kevin Wilson <wkevils@gmail.com>
To: Michal Soltys <soltys@ziu.info>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org,
        =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

Hi all,
The pivot_root() system call is also used by the LXC project (LinuX Contain=
ers);
This project is gaining very high popularity recently especially due
to the Docker container engine;

see:
https://github.com/lxc/lxc/blob/master/src/lxc/conf.c#L1067

http://linuxcontainers.org/

Regards,
Kevin

On Mon, Feb 3, 2014 at 12:31 PM, Michal Soltys <soltys@ziu.info> wrote:
> On 2014-01-30 16:20, Phillip Susi wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 1/30/2014 9:50 AM, Thomas B=E4chler wrote:
>>>
>>> At least mkinitcpio now generates a fresh "initrd" to return to
>>> during system shutdown instead of keeping around the actual
>>> initrd.
>>
>>
>> I see, so at shutdown the initramfs is re-loaded into a tmpfs that is
>> then pivot_root()ed to?  And at boot time, pivot_root is not used?
>>
>
> Initially when initramfs prepares /run and stuff (and switchroot moves it=
 to
> real root), workable "minisystem" is kept under /run/initramfs (or simila=
r).
>
> On shutdown, /run/initramfs is bind-mounted to itself, which makes it
> pivotable, with old root say available at /oldroot. Now your aim is to
> cleanly unmount old root. In case of classic non-systemd, you would need:
>
> - telinit u (graceful re-exec of init)
> - mdmon --takeover (if you have non-native raid handled by md, to gracefu=
lly
> reexec the daemon)
> - etc.
>
> This allows to close all open files on real root (things are usually trie=
d
> in loop, with attempts to stop stuff like lvm, md, ...) and finally unmou=
nt
> old root.
>
> Of course there is also a question - why bother doing all this, when simp=
le
> ro remount before halt has been working fine for decades (and still works=
)
> ....
>
> Dracut (and others) /could/ be doing even more clever thing (hmm, maybe I
> should review certain old patches of mine) - during boot it could prepare
> mini-root on tmpfs before (some copying, some symlinks and/or PATH stuff)
> starting everything - then move actual tmpfs with living root to real roo=
t.
> The small advantage of that is, that you can at any moment chroot to such
> miniroot and do some maintenance on e.g. boot-critical storage daemon tha=
t
> lacks ability to reexecute itself gracefully.
>
> Another interesting use for pivot_root() call - when paired with mount
> namespaces - is ability to provide stronger chroot jails.
>
> So the call itself is still pretty useful. It hasn't beed used during boo=
t
> anymore for years, but other possibilities emerged for it =3D)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
