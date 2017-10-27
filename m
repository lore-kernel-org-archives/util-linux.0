Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.headstrong.de ([81.7.4.112]:44638 "EHLO mail.headstrong.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751987AbdJ0SOL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 27 Oct 2017 14:14:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.headstrong.de (Postfix) with ESMTP id 285761C001F4
        for <util-linux@vger.kernel.org>; Fri, 27 Oct 2017 20:07:24 +0200 (CEST)
Received: from mail.headstrong.de ([127.0.0.1])
        by localhost (mail.headstrong.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g26VyIesZ6lQ for <util-linux@vger.kernel.org>;
        Fri, 27 Oct 2017 20:07:08 +0200 (CEST)
To: util-linux@vger.kernel.org
From: Ximin Luo <infinity0@pwned.gg>
Subject: Bug: for mount namespaces inside a chroot, unshare works but nsenter
 doesn't
Message-ID: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
Date: Fri, 27 Oct 2017 18:07:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(Please keep me on CC, I'm not subscribed)

When unsharing persistent mount namespaces, unshare+nsenter does not seem to
work properly when run from inside a chroot session. However, unshare by itself
works.

As a workaround for the unshare+nsenter case, one can run `nsenter --mount=<ns>
chroot <real/path/to/chroot> command args`. The `--root` option to `nsenter`
sounds like it should work, but it does not - see below for details.

Is this a bug? I'm trying to write code to work regardless of whether it's run
inside a chroot, so it would be nice not to have to pass arguments to
`nsenter(1)` that are specific to chroots, like `chroot <real/path/to/chroot>`.
It's also a bit counterintuitive to have to re-enter the chroot again.

Also, these extra steps are not needed with `unshare(1)`, which works fine by
itself. It's solely re-entering the namespace that seems to be problematic.

I'm using util-linux 2.30.2-0.1 on Debian. I don't believe it's a problem
specific to Debian, because everything works when using `unshare(1)` by itself,
as stated.

(I haven't tried running this inside a chroot-inside-a-chroot.)

Details:

# Below is all run inside a "schroot" session, which is a Debian tool for making chroot use more convenient.
# I used the instructions here (https://wiki.debian.org/sbuild#Create_the_chroot) to create one.

## Preparation for the tests

# Enter the chroot
$ sudo schroot -c unstable-amd64-sbuild
# Set up a private-bind file to hold a handle to our new namespace, as documented in the man page of unshare(1)
(unstable-amd64-sbuild)root@localhost:/tmp# touch ns-mnt; mount --bind --make-private ns-mnt ns-mnt
# Set up our test script
(unstable-amd64-sbuild)root@localhost:/tmp# script='mount; ls /; ls -l /proc/$$/ns/mnt; mount -B /dev/null /etc/hosts; echo hosts:; cat /etc/hosts'

## Case 1: unshare(1) with no special options or commands, everything works as expected

(unstable-amd64-sbuild)root@localhost:/tmp# unshare --mount=ns-mnt sh -ec "$script"
unstable-amd64-sbuild on / type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
proc on /proc type proc (rw,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
[.. etc. other mappings in my chroot ..]
unstable-amd64-sbuild on /tmp/ns-mnt type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
lrwxrwxrwx 1 root root 0 Oct 27 17:35 /proc/31691/ns/mnt -> 'mnt:[4026532398]'
hosts:
[.. empty hosts (inside the namespace) ..]
# we are now back outside the namespace
# if we cat /etc/hosts (both inside and outside the chroot), we see the original

## now we try to re-enter the namespace.

## Case 2: nsenter(1) with no extra options or commands, doesn't work:

(unstable-amd64-sbuild)root@localhost:/tmp# nsenter --mount=ns-mnt sh -ec "$script"
[.. mappings for my host system, outside the chroot ..]
bin  boot  dev	etc  home  initrd.img  initrd.img.old  lib  lib32  lib64  libx32  lost+found  media  mnt  opt  proc  root  run	sbin  selinux  srv  sys  tmp  usr  var	vmlinuz  vmlinuz.old
[.. aka the / on my host filesystem outside the chroot ..]
lrwxrwxrwx 1 root root 0 Oct 27 19:36 /proc/32434/ns/mnt -> 'mnt:[4026532398]'
[.. correct namespace ..]
hosts:
[.. empty hosts (inside the namespace) ..]
# if we cat /etc/hosts outside the namespace, it's non-empty inside the chroot but EMPTY outside the chroot.
# whoops, because we ran mount -B on the original non-chrooted / filesystem. findmnt says:
└─/etc/hosts                          udev[/null]                        devtmpfs    rw,nosuid,relatime,size=8181852k,nr_inodes=2045463,mode=755
# we unmount it before proceeding

## Case 3: nsenter(1) with --root, partially works but not really:

(unstable-amd64-sbuild)root@localhost:/tmp# nsenter --root=/ --mount=ns-mnt sh -ec "$script"
[.. i.e. mount(1) gives empty output ..]
bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
[.. at least the root is inside the chroot ..]
lrwxrwxrwx 1 root root 0 Oct 27 17:37 /proc/878/ns/mnt -> 'mnt:[4026532398]'
[.. correct namespace ..]
mount: /etc/hosts: wrong fs type, bad option, bad superblock on /dev/null, missing codepage or helper program, or other error.
[.. mount operations fail, but the namespace is correct ..]
[.. if you analyse this case a bit more, you find that /proc/$$/{mounts,mountinfo,mountstats} are all empty ..]
# exit code 32
# outside the namespace, /etc/hosts is still non-empty, both inside and outside the chroot

## Case 4: nsenter(1) with explicit chroot(1) call, everything works as expected, again:

(unstable-amd64-sbuild)root@localhost:/tmp# nsenter --mount=ns-mnt chroot /run/schroot/mount/<<SESSIONID>> sh -ec 'mount && ls /'
unstable-amd64-sbuild on / type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
proc on /proc type proc (rw,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
[.. etc. other mappings in my chroot ..]
unstable-amd64-sbuild on /tmp/ns-mnt type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
[.. great, we got our mounts back! ..]
bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
lrwxrwxrwx 1 root root 0 Oct 27 17:39 /proc/2025/ns/mnt -> 'mnt:[4026532398]'
[.. correct namespace ..]
hosts:
[.. empty hosts, as desired ..]
# outside the namespace, /etc/hosts is still non-empty, both inside and outside the chroot

-- 
GPG: ed25519/56034877E1F87C35
GPG: rsa4096/1318EFAC5FBBDBCE
https://github.com/infinity0/pubkeys.git
